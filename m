From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: RCS keyword expansion
Date: Sat, 13 Oct 2007 04:08:59 +0900
Message-ID: <470FC64B.8010707@gmail.com>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk> <Pine.LNX.4.64.0710112144380.4174@racer.site> <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 21:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgPtU-0002G4-HM
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 21:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbXJLTJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 15:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbXJLTJr
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 15:09:47 -0400
Received: from main.gmane.org ([80.91.229.2]:47275 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647AbXJLTJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 15:09:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IgPsy-0004ac-Ap
	for git@vger.kernel.org; Fri, 12 Oct 2007 19:09:24 +0000
Received: from 221x115x75x108.ap221.ftth.ucom.ne.jp ([221.115.75.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 19:09:24 +0000
Received: from salikh by 221x115x75x108.ap221.ftth.ucom.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 19:09:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 221x115x75x108.ap221.ftth.ucom.ne.jp
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
In-Reply-To: <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60702>

Peter Karlsson wrote:
> But that's not what I want. Then my build procedure would need to do a
> "git status", or whatever you use to get the last commit information
> about a file, on each file that is changed and is to be installed. It
> would be a lot easier if that was done already on checkout through some
> kind of hook.

For what it's worth, I've made a small exercise on git scripting 
(which I'm total newbie in), and tried to use filter mechanism
(smudge/clean) for solving the problem Peter stated.

Fundamental problems of this approach were discussed in full
on the mailing list, however, as I understand Peter's situation,
they do not apply, as the web site workspace is 'checkout-only',
and no actual work (commits) are made there. 
Thus, it will not cause any merge problems etc.

Anyway, smudge/clean does not give the immediate solution to the problem
because of smaller technical shortcomings:
* smudge filter is not passed a name of file being checked out, 
  so it is not possible to exactly find the commit identifier.
  However, this is alleviated by the fact that 'smudge' is only being run
  for the changed files, so the last commit *is* the needed one.

* smudge filter is not passed a commit identifier. This is a bit more serious,
  as this information is nowhere to get from otherwise. I tried to use 'HEAD'
  value, but apparently it is not yet updated at the moment 'smudge' is being
  run, so the files end up with the date of the "previous" commit rather than
  the commit being checked out. "Previous" means the commit that was checked
  out before. The problem gets worse if different branch is checkout out,
  as the files get the timestamp of a previous branch.

AFAIR, lack of information in smudge filter was intentional, to discourage
this particular use of smudge/clean mechanism. However, I think this can be
reconsidered given the Peter's use case: "checkout-only" workspace for immediate
publishing to webserver. Alternatively, anyone interested in this use case
could implement additional smudge arguments as a site-local patch.

And then, there are small annoyances, which seems to be inevitable:
* if you change 'clean' filter and check out earlier revision, it will be
  reported as having modifications (due to changed 'clean' definition).

Below is what I ended up with:

.gitattributes:
* filter=date

.git/config:
[filter "date"]
        smudge = .git/smudge
        clean = .git/clean

.git/clean:
#!/usr/bin/perl -p
s#\$Date[^\$]*\$#\$Date\$#;

.git/smudge:
#!/usr/bin/perl

use POSIX qw(strftime);
$branch = `git-symbolic-ref HEAD`; chomp($branch);
$rev = `git-rev-list -n 1 $branch`; chomp($rev);
open REV, "git show --pretty=raw $rev|";
$time = time; # default to current time
while (<REV>) {
    if (/^committer.* (\d+) [\-+]\d*$/) {
        $time = $1;
    }
}
close REV;

$date = strftime "%Y-%m-%d %H:%M:%S", localtime($time);
while (<>) {
    s#\$Date[^\$]*\$#\$Date: $date\$#;
    print;
}
