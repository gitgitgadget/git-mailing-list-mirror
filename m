From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-reset HEAD --permissions-only
Date: Tue, 15 Mar 2011 20:06:19 -0500
Message-ID: <4D800D0B.2000307@gmail.com>
References: <illts0$c6q$1@dough.gmane.org> <20110315013223.GB31865@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 02:06:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzfC9-0001Z1-Ar
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 02:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1CPBGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 21:06:33 -0400
Received: from lo.gmane.org ([80.91.229.12]:57916 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab1CPBGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 21:06:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PzfC3-0001XX-D8
	for git@vger.kernel.org; Wed, 16 Mar 2011 02:06:31 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:06:31 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:06:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110315013223.GB31865@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169095>

On 3/14/2011 8:32 PM, Jeff King wrote:
> On Mon, Mar 14, 2011 at 03:29:51PM -0500, Neal Kreitzinger wrote:
>
>> Is there a way to only reset the file permissions of the
>> working-tree to match HEAD file permissions without resetting the
>> content of the files?
>
> Not directly, but you could munge a patch to do so and apply it in
> reverse. For example:
>
> git diff "$@" | perl -ne ' if (/^diff/) { $diff = $_ } elsif (/^old
> mode/) { print $diff, $_ } elsif (/^new mode/) { print $_ } ' | git
> apply -R
>
> Which seems a little more complicated than it needs to be, but we
> don't (AFAIK) have a way to say "show me only the mode changes from
> this diff in an applicable form". The closest would be "git diff
> --summary", but you cannot directly apply it (and I would hesitate to
> recommend parsing it).
>
> You could also use "git checkout -p", which is designed for exactly
> this sort of picking-apart of a patch, but it has no way to specify
> "say yes to all of the mode changes, no to everything else"; you have
> to manually approve each hunk. Which doesn't work if you have a lot
> of these files.
>
> I guess for mode changes, you don't care if you chmod something that
> is already fine. So yet another way to do it would be:
>
> git ls-files -sz | perl -0ne ' /100(\d+).*?\t(.*)/ or next; -e $2 or
> next; chmod(oct($1), $2) or die "chmod failed: $!"; '
>
You are right about git checkout -p because there are alot of code
changes to alot of files.  I haven't used git patches and I don't know 
perl.  However, your reasoning about the last example seems the most 
straight-forward so I used it.  I symptomatically validated my re-keying 
of the syntax as follows since TTBOMK I couldn't copy+paste your example 
due to whitespace:

git ls-files -sz | perl -0ne '/100(\d+).*?\t(.*)/
  or next; -e $2 or next; chmod(oct($1), $2) or die "chmod failed: $!";'

(0) repo contains bad modes in working tree only.
(1) make a copy of the repo (cp -rp repo repoX)
(2) add and commit (via superuser and git-commit --no-verify) the "bad" 
modes.
(3) make another copy of the repo (repoY)
(4) run your perl script on repoY working-tree
(5) git diff | grep "old mode" (shows no occurences)
(6) commit "good" modes.
(7) make repox "bad" modes branch a remote of repoy and fetched the bad 
modes commit (git remote add -t bad-mode-branch repo-X /opt/me/repoX).
(8) diffed the bad modes commit vs the good modes commit and saw that 
only the modes differed.

Thanks!

v/r,
neal
