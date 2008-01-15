From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Tue, 15 Jan 2008 21:39:00 +0100
Message-ID: <53A4FB98-25B5-4598-BED8-7D96AF5527F4@zib.de>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de> <12003528401309-git-send-email-prohaska@zib.de> <20080115102626.GE2963@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsYm-000465-Gr
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYAOUic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbYAOUic
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:38:32 -0500
Received: from mailer.zib.de ([130.73.108.11]:44459 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbYAOUib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:38:31 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0FKbvKV014722;
	Tue, 15 Jan 2008 21:37:57 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83608.pool.einsundeins.de [77.184.54.8])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0FKbu5U020922
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 15 Jan 2008 21:37:56 +0100 (MET)
In-Reply-To: <20080115102626.GE2963@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70556>


On Jan 15, 2008, at 11:26 AM, Dmitry Potapov wrote:

> On Tue, Jan 15, 2008 at 12:20:40AM +0100, Steffen Prohaska wrote:
>>
>> I looked briefly at the various places where convert_to_git() is
>> called.  I think that only the one code path through index_fd()
>> actually writes data to the repsitory.  Maybe someone else with
>> a better understanding of git's internals should confirm this.
>
> Your patch is certainly better than my quick hack for git-add,
> and perhaps you are right that the check should be done only
> when data are written, but it also means that there is no longer
> any warning when you are running git diff with the work tree,
> which would be useful, because it is what most users do before
> adding anything.

My first concern is to avoid data corruption.  But we should also
avoid to unnecessarily bother users with annoying warnings.  Thus
I thought that guarding only the code paths that modify data in
an irreversible way is sufficient and hence I only guarded the
code path that writes to the repository.  The underlying
assumption is that git checkout is the only way of destroying the
original data.  Unless you check out you still have the original
data and can copy them to a safe place.

However, there might be other ways by which git will modify the
files in the work tree.  And even commands that never touch the
local file system could be dangerous.  For example a user could
run git diff to create a patch, which is sent to someone else and
applied there.  The change is committed in the remote repository,
published, and pulled back to the local repository and eventually
this might result in the corruption we originally tried to avoid.

So perhaps we should guard _every_ code path that calls
convert_to_git() in an irreversible way; and only avoid printing
the same warning twice for a single run of git add.  This is
exactly what your "quick hack" does.

More in my reply to Junios mail ...


> However, my real concern is that it seems we have two different
> heuristics for binary -- one that is used inside of convert.c
> and the other one is buffer_is_binary() in xdiff-interface.c.
>
> So, I am running 'git diff' for some test file, and it says:
>
> diff --git a/foo b/foo
> index e965047..c102bdc 100644
> Binary files a/foo and b/foo differ
>
> okay, now I want to add this *binary* file, so I run 'git add':
>
> warning: Stripped CRLF from foo.
>
> I imagine a user saying: "What the hell! Why did this stupid Git
> strip CRLF from my _binary_ file?"
>
> And the current version of Git, which does not print CRLF warning,
> seems to be dangerous, because when 'git diff' told me that it is
> ca _binary_ file, I expect that Git will put it as *binary*. So,
> from the user's point of view, it looks like a bug.
>
> So, I suppose that at least we should make is_binary heuristic in
> convert.c more strict than those that is used by diff. Namely, if
> there is at least one NUL byte in the buffer, it should be treated
> as binary.

I think we should do this.

Perhaps we should also place a hint for future developers in
xdiff-interface.c, like the patch below.

	Steffen


diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4b8e5cc..baa3664 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -160,6 +160,10 @@ int read_mmfile(mmfile_t *ptr, const char  
*filename)
         return 0;
  }

+/* If you ever modify buffer_is_binary() you should check that  
is_binary()
+   in convert.c always uses a stricter heuristic.  That is all files  
that are
+   classified as binary here should also be classified as binary in  
convert.c.
+ */
  #define FIRST_FEW_BYTES 8000
  int buffer_is_binary(const char *ptr, unsigned long size)
  {
