From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] Improve gitweb search, and other things
Date: Tue, 26 Feb 2008 13:22:04 +0100
Message-ID: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 13:23:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyqO-000223-Lj
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbYBZMWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbYBZMWd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:22:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:13287 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYBZMW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:22:28 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1094884nfb.21
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 04:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=CuoMvXUpNkMb5TL1Xmo0+ht7BMpx+VYtXZEWrJy9F6c=;
        b=xkpz00Hn2KusUOST1yKFWIgCNNHh33C7GIMal/hL1vCbJf5W2ZuqTf3Vs14Io5d/jdwCEEXgORmcvF+v3B+j4lCI9NKhrywX3hA20q29yamfVGRoGrb4/M6IgABiFzxNu8JeR34hPNOBFcX/jXKLPowRTHtbXIqZ7asY7sElFIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jG3YhCuPvmdSqJBjQOVWH/AW1tmvOhy74upYxfRhQdbBTNFf+CpeJ6cuj7RM/dV4ErweSFIOYsqDY7gHLNMbk3kuvdcfUQgnuFBMH6BAHjOjThaWs7vuFUvlTkJLRAhAUUIz6VGPpuwxkpL36i2WOyqZFuvodyn8ZVBqu4uSv2Q=
Received: by 10.82.106.14 with SMTP id e14mr8710300buc.3.1204028547159;
        Tue, 26 Feb 2008 04:22:27 -0800 (PST)
Received: from localhost.localdomain ( [83.8.218.226])
        by mx.google.com with ESMTPS id z40sm10944210ikz.4.2008.02.26.04.22.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 04:22:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1QCM9qu018960;
	Tue, 26 Feb 2008 13:22:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1QCM9VG018959;
	Tue, 26 Feb 2008 13:22:09 +0100
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75130>

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/4] Add '--fixed-strings' option to "git log --grep" and friends
 [PATCH 2/4] gitweb: Change parse_commits signature to allow for
             multiple options
 [PATCH 3/4] gitweb: Simplify fixed string search
 [PATCH 4/4] gitweb: Clearly distinguish regexp / exact match searches

Description of series:
~~~~~~~~~~~~~~~~~~~~~~~
When testing earlier improvements to gitweb commit search (searching
commit messages), I have noticed that searching for "don't" didn't
find anything from gitweb, while 'git log --grep="don't"' returns
quite a number of commits.  After examination I have realized that it
was caused by the fact that 'quotemeta' in Perl quotes also "'"
(single quote character), and grep (which "git log --grep=<pattern>"
uses) doesn't do the unquoting for unnecessary quoted characters.

At first I have thought about implementing our own limited quoting
subroutine, quoteregexmeta() to quote only regular expression
meta-characters.  The "grep" search (using git-grep) by default uses
extended POSIX regexps, so there would be need also for
quoteextremeta() subroutine, unless gitweb would pass '-E' option to
"git log" when searching/limiting output.  This unfortunately needs
_three_ versions of search query: original search text, to be passed
for "next page" links, fill default/current value of search form text
(entry) field, and perhaps show in the page title; regexp quoted for
grep, to be passed to "git log --grep" and friends or "git grep";
regexp quoted for Perl (we can use quotemeta() here) for showing match
info (matched fragment).  It is a bit complicated and error prone. 
(Well, maybe all that is not really necessary...)

With git-grep search (tree search) and pickaxe search (diff search) it
is easy, as pickaxe search is by default fixed strings search, and
git-grep has -F / --fixed-strings option.  Option which 
"git log --grep=<pattern>" was lacking...

First commit in series adds then -F / --fixed-strings option for
searching commit messages by git-log / git-rev-list.  It was quite
easy to do, thanks to well written infrastructure.  This patch can
be seen as standalone patch (adding option for consistency), and I
have even send it as
  Message-Id: <200802241647.08871.jnareb@gmail.com>
But I have thought the chance of it being accepted would be better
if there were some use case for it.

Therefore next commits in series makes use of just introduced ability
to use --fixed-strings option to consider the limiting patterns to be
fixed strings.

For this we have to pass both --grep=$seachstring (or equivalent for
other commit message search searchtypes) and --fixed-strings option.
Therefore parse_commits() subroutine calling convention, which allowed
to pass optionally only single extra option had to be changed.

Meanwhile when looking at gitweb installed at http://repo.or.cz I seen
that it includes checkbox to switch between fixed strings search, and
regexp search.  (IIRC patch was send to git mailing list, and lost
somehow, not being resent enough for inclusion[*1*]).  The repo.or.cz
gitweb is based on 'next' branch of http://repo.or.cz/git/gitweb.git
fork of git.  This change also required more than one pattern limiting
option to be passed down to git-rev-list.

So I have then extracted this change, and put it as second commit in
this series.  This made it easy to implement fixed strings search in
gitweb not by quoting regexp meta-characters, but by using just
implemented --fixed-strings option.

Finally I have though "why not", and cherry-picked Petr "Pasky" Baudis
addition of fixed-strings/regexp search checkbox.  This made last,
fourth commit in this series.

[*1*] Petr "Pasky" Baudis is much less active on git mailing list lately.

Shortlog:
~~~~~~~~~
Jakub Narebski (3):
      Add '--fixed-strings' option to "git log --grep" and friends
      gitweb: Change parse_commits signature to allow for multiple options
      gitweb: Simplify fixed string search

Petr Baudis (1):
      gitweb: Clearly distinguish regexp / exact match searches

Diffstat:
~~~~~~~~~
 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    5 +++
 gitweb/gitweb.perl                 |   58 +++++++++++++++++++++++------------
 revision.c                         |   10 +++++-
 4 files changed, 53 insertions(+), 21 deletions(-)

-- 
1.5.4.2
