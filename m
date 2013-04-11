From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 5/5] Documentation: add caveats about I/O buffering for
 check-{attr,ignore}
Date: Thu, 11 Apr 2013 21:12:20 +0100
Message-ID: <20130411201219.GA21091@pacific.linksys.moosehall>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-5-git-send-email-git@adamspiers.org>
 <7vsj2xhrc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 22:12:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQNr9-00020t-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 22:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab3DKUMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 16:12:23 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:59783 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab3DKUMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 16:12:22 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 8DE3458EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 21:12:21 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vsj2xhrc7.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220923>

On Thu, Apr 11, 2013 at 11:09:28AM -0700, Junio C Hamano wrote:
> Reflowing of the text is very much unappreciated X-<.  

I very much appreciate the excellent job you do as maintainer; your
attention to detail results in an incredibly high quality project.
However I do occasionally find your communication style unnecessarily
abrasive.  Maybe that's just me.

> It took me five minutes to spot that you only added check-attr and
> check-ignore and forgot to adjust that "commit-oriented record" to
> an updated reality, where you now have commands that produce
> non-commit-oriented record to the output.

I am sorry for wasting five minutes of your time.  A non-reflowed
version is included inline below, and also at:

    https://github.com/aspiers/git/compare/master...git-annex-streaming

> It would have been far simpler to review if it were like this, don't
> you think?

It would have been slightly simpler, yes.  It did occur to me not to
re-flow it, but then one of the lines ended up noticeably shorter, and
as it was a short paragraph, I estimated that you would prefer it
re-flowed.  Clearly I was wrong - not the first time, and it won't be
the last either, since I'm just a flawed human being trying to do my
best in the time available.  The question then arises: how uneven does
a paragraph's right margin have to be in order to justify re-flowing?
I could not find any guidelines in SubmittingPatches or
CodingGuidelines regarding re-flowing of documentation.  With
hindsight, I can now see that it would have been better to skip it on
this occasion, or at least keep the re-flow as a separate commit.

So I apologise again for the mistake, but don't you think it would
have been far more pleasant if instead you'd worded your email
something like this?

    Thanks for the patches.  I notice that you unnecessarily re-flowed
    the latter half of the GIT_FLUSH paragraph; unfortunately this
    meant I had to spend a few extra minutes on the review and almost
    missed that "commit-oriented" is no longer applicable.  In future,
    please avoid re-flowing text where possible.

Fortunately I'm not the sensitive sort, but I imagine that there are
others in this community who might be discouraged from contributing
for fear of being on the receiving end of sentences which end with
phrases such as "[...] is very much unappreciated X-<."  Please don't
underestimate the human factor; common courtesy can make a big
difference.

Thanks,
Adam

-- >8 --
Subject: [PATCH v3 5/5] Documentation: add caveats about I/O buffering for
 check-{attr,ignore}

check-attr and check-ignore have the potential to deadlock callers
which do not read back the output in real-time.  For example, if a
caller writes N paths out and then reads N lines back in, it risks
becoming blocked on write() to check-*, and check-* is blocked on
write back to the caller.  Somebody has to buffer; the pipe buffers
provide some leeway, but they are limited.

Thanks to Peff for pointing this out:

    http://article.gmane.org/gmane.comp.version-control.git/220534

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/git-check-attr.txt   | 5 +++++
 Documentation/git-check-ignore.txt | 5 +++++
 Documentation/git.txt              | 7 ++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 5abdbaa..a7be80d 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -56,6 +56,11 @@ being queried and <info> can be either:
 'set';;		when the attribute is defined as true.
 <value>;;	when a value has been assigned to the attribute.
 
+Buffering happens as documented under the `GIT_FLUSH` option in
+linkgit:git[1].  The caller is responsible for avoiding deadlocks
+caused by overfilling an input buffer or reading from an empty output
+buffer.
+
 EXAMPLES
 --------
 
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 7e3cabc..8e1f7ab 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -81,6 +81,11 @@ not.  (Without this option, it would be impossible to tell whether the
 absence of output for a given file meant that it didn't match any
 pattern, or that the output hadn't been generated yet.)
 
+Buffering happens as documented under the `GIT_FLUSH` option in
+linkgit:git[1].  The caller is responsible for avoiding deadlocks
+caused by overfilling an input buffer or reading from an empty output
+buffer.
+
 EXIT STATUS
 -----------
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a875f2..3258f2c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -808,9 +808,10 @@ for further details.
 
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
-	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-	and 'git whatchanged' will force a flush of the output stream
-	after each commit-oriented record have been flushed.   If this
+	as 'git blame' (in incremental mode), 'git rev-list', 'git
+	log', 'git check-attr', 'git check-ignore', and 'git
+	whatchanged' will force a flush of the output stream
+	after each record has been flushed.  If this
 	variable is set to "0", the output of these commands will be done
 	using completely buffered I/O.   If this environment variable is
 	not set, Git will choose buffered or record-oriented flushing
-- 
1.8.2.1.347.gbef22ca
