From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: [WORKAROUND] parsecvs losing files
Date: Fri, 30 May 2008 11:08:14 +0100
Message-ID: <b2cdc9f30805300308x2620e34cqca5d55c82e337393@mail.gmail.com>
References: <b2cdc9f30805280750v3b92d115yf76f382e5c2fa418@mail.gmail.com>
	 <b2cdc9f30805280953l40ce9e37m1fb558e541ef89c3@mail.gmail.com>
	 <20080528170332.GB16996@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>, keithp@neko.keithp.com,
	"Alex Bennee" <kernel-hacker@bennee.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 12:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21Xo-00087M-G1
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 12:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYE3KIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 06:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYE3KIQ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 06:08:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:2108 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYE3KIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 06:08:15 -0400
Received: by rv-out-0506.google.com with SMTP id l9so4539029rvb.1
        for <git@vger.kernel.org>; Fri, 30 May 2008 03:08:14 -0700 (PDT)
Received: by 10.141.53.20 with SMTP id f20mr2879798rvk.128.1212142094172;
        Fri, 30 May 2008 03:08:14 -0700 (PDT)
Received: by 10.140.134.12 with HTTP; Fri, 30 May 2008 03:08:14 -0700 (PDT)
In-Reply-To: <20080528170332.GB16996@artemis.madism.org>
Content-Disposition: inline
X-Google-Sender-Auth: bdd45d1a4aa666e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83286>

On Wed, May 28, 2008 at 6:03 PM, Pierre Habouzit <madcoder@debian.org> wrote:
>  Sorry for the top posting but the git list isn't really the upstream
> for parsecvs. I'm now Cc-ing keithp who is the author :)

I shall keep CC'ing git@ for visibility if anyone else comes across this :-)

>
> On Wed, May 28, 2008 at 04:53:30PM +0000, Alex Bennee wrote:
>> On Wed, May 28, 2008 at 3:50 PM, Alex Bennee <kernel-hacker@bennee.com> wrote:
>> > Hi,
>> > <snip>
>> > Anyway today I noticed it had failed to import a sub-directory of the
>> > project (not a bit I usually build).
<snip>
>>
>> Well in answer to myself parsecvs does get confused. In an example
>> failed to import file:
>>
>> Load:                          third-party/libxml/runtest.c,v   8207 of 79070
>> /export/git/master.cvs/third-party/libxml/runtest.c,v spliced:
>>        1.1.1.1
>>        1.1
>> Sorted heads for /export/git/master.cvs/third-party/libxml/runtest.c,v
>>       master 1.1
>>       master > BRANCH-3-5-branch 1.1.1.1.0.2
>>       master > BRANCH-3-5-16-branch 1.1.1.1.0.4
>> building branches for /export/git/master.cvs/third-party/libxml/runtest.c,v
>> file sha1: b694d565caf10fedbc7566f2bf15b893c57d5a19
>> file sha1: b694d565caf10fedbc7566f2bf15b893c57d5a19
>> file has 2 revisions
>>
>> An lo, looking at the branches mentioned these missing files are
>> there. Trouble is the files should be in a number of branches, looking
>> at the ,v file in question:
<snip>
>>       BRANCH-3-3-20-red-e1-opt-branch:1.1.1.1
<snip>
>> I notice
>> looking at the log for some of the files that did make it that the CVS
>> revisions for all the branches have a .0.[something] suffix which the
>> missing branches in this case don't have.
<snip>

So I understand how this has happened. This particular module was
imported directly into the working branch at the time
(BRANCH-3-3-20-red-e1-opt-branch) where as other modules where
imported into the CVS HEAD and then branched into the current working
branch. As a result the branch tag didn't have the magic 0 in it.

We where able to work around the import failure by deleting the branch
tag from the module and then branching it again. The new branch tag
became:

BRANCH-3-3-20-red-e1-opt-branch:1.1.1.1.0.6

which parsecvs was able to correctly parse and assign to the correct
GIT branch on import. I'm guessing this is a corner case that could do
with better handling but in our case it was solved by tweaking our CVS
repository.

-- 
Alex, homepage: http://www.bennee.com/~alex/
