From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 10:15:10 +0200
Message-ID: <E8851B12-AAA5-4B4D-9F28-C5AB5AEF0E57@zib.de>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de> <7vlkapjeir.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Carl Worth <cworth@cworth.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 10:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbtwC-0000Jw-0g
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 10:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbXI3INz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 04:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbXI3INz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 04:13:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:37475 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754346AbXI3INw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 04:13:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8U8DaUp020425;
	Sun, 30 Sep 2007 10:13:37 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db10737.pool.einsundeins.de [77.177.7.55])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8U8DYia009298
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 30 Sep 2007 10:13:35 +0200 (MEST)
In-Reply-To: <7vlkapjeir.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59528>


On Sep 30, 2007, at 12:25 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> - git push: prints updates of remote heads. A message about
>>   failing to update a remote head may get lost.
>
> Please do not remove the report of successful update, as people
> often say "git push" or "git push $there" without explicitly
> saying which refs to push.  When pushing out to publish, I say
> "git push ko" (to mean k.org) and I _want_ my positive feedback.

Yes but it's pretty technical.

A much simpler output could be easier to scan by a human

updating 'refs/heads/master' .. fast forward .. ok.
updating 'refs/heads/pu' .. forced non-fast forward .. ok.
updating 'refs/heads/next' ..
ERROR: 'refs/heads/next' not updating to non-fast forward
exit(1) here.

If we exit after the very first problem it can't get lost.
After fixing the issue you can just 'git push' again.


>> - git merge: the fact that a merge is a fast forward merge gets
>>   printed at the very top, followed by (often a lot of) diffstat.
>>   I know diffstat can help to judge if the merge did what you
>>   expected. But even more important is the fact that the merge
>>   was just a fast forward, which may get buried under lots of output.
>
> I do not think fast-forwardness is particularly interesting.  If
> you find fast-forwardness interesting, I suspect you would even
> want to know what _your_ change that were not in the other side
> of the merge, which is something that we do not even report
> right now.

I use it to advance a branch to a temporary integration branch.
At that point I expect that the merge is a fast forward. Here's
what I do.

    git checkout -b for/master master
    git merge branch-with-good-topics
    git branch -f scratch
    git push compileservers # pushes scratch for automatic builds

Now I wait for compiles to finish. Typically I continue not before
the next morning. If everything's ok I do.

    git checkout master
    git merge for/master
    git push

The last merge must be a fast forward. This is the only fact I'm
interested in. I could do 'git reset' or 'git branch -f' but then
I'd loose the check if it's a fast forward.

I don't merge directly to master to avoid any accidentally push.
I can also easily revert by just deleting 'for/master'.

Maybe there's a better workflow?


>> Maybe git should become more quiet, as other unix tools are, and
>> per default only report problems. Technical details and progress
>> could be requested explicitly by '--verbose' or similar.
>
> I'd agree with this sentiment in principle, and many of the
> things you propose to remove above fall into the "unnecessary
> clutter" category.  But some of the existing output fall into
> the "necessary info" category --- diffstart after merge

I agree. Could we print the note about fast forward _after_ the
diffstat? Maybe there are more useful oneline information that
could be output there.

> and report of successful remote ref updates are such things, so we
> should be careful not to go overboard.

But the output could be less technical and more human readable.

Also diffstat's output and "git push" are different. diffstats
change with the content of your repo. "git push" just succeeds
or fails. If is succeeds it updates remote refs according to your
configuration. There is no new information in the output beyond
success or failure [which is not quite true if you depend on
git push finding matching refs automatically -- I don't]. I don't
think the sha1's printed are needed by anyone. And if someone
needs them, he could call push with '--verbose'.

I asked about a '--dry-run' switch to "git push" some time ago,
which would only report what "git push" would do without actually
changing anything on the remote side. I'd use this to check what
I expect to do. Just in case I messed up my configuration. At the
time "git push" is actually pushing it's too late to fix a broken
configuration. I know '--dry-run' it's not trivial to implement
and I'll likely have no time to look into it.

	Steffen
