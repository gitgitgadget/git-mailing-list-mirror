X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 01:01:09 +0100
Message-ID: <200612170101.09615.Josef.Weidendorfer@gmx.de>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <20061216230108.GE12411@admingilde.org> <200612170015.24162.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:01:36 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <200612170015.24162.jnareb@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34660>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjTA-0004Nl-GV for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422880AbWLQABW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWLQABW
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:01:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57291 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1422880AbWLQABV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 19:01:21 -0500
Received: (qmail invoked by alias); 17 Dec 2006 00:01:19 -0000
Received: from p5496AE8F.dip0.t-ipconnect.de (EHLO noname) [84.150.174.143]
 by mail.gmx.net (mp017) with SMTP; 17 Dec 2006 01:01:19 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sunday 17 December 2006 00:15, Jakub Narebski wrote:
> Hi!
> 
> Martin Waitz wrote:
> > On Sat, Dec 16, 2006 at 07:45:11PM +0100, Jakub Narebski wrote:
> >>
> >> Or .gitlink file, if we decide to implement it (as lightweight checkout and
> >> support for submodules which one can easily move/rename).
> > 
> > I still don't get the advantage of a .gitlink file over an ordinary
> > repository with alternates or a symlink.
> 
> Moving or renaming the directory with a submodule. With alternates,
> when you rename or move directory with a submodule, you have to add
> alternate for new place / new name, or alter existing alternate.
> With symlinks you risk broken symlinks.

Yes.

IMHO it simply is added flexibility to allow a checkout to be separate from
the .git/ directory, same as explicitly setting $GIT_DIR would do.
So this .gitlink file is on the one hand one kind of convenience for users
which want to keep their repository separate, yet do not want to specify
$GIT_DIR all the time in front of git commands.
The .gitlink file simply makes the linkage to the separate repository
persistent.

In the scope of submodules, you get the benefit that you can not lose
submodule repositories by doing a "rm -rf *" (or similar, e.g. deleting
dirs with submodules in it) in the supermodule checkout. Actually, the
latter is a valid action: delete a submodule in the next commit;
when going back at an earlier commit, the submodule should be there again.
So IMHO you allow far more possibilities by separating GITDIR from the
checkout of submodules.

However. I think that this .gitlink file proposal can be seen as kind
of independent from submodule support at first; it should be easy to
make this work together later on. E.g. submodule root directories
can be easily detected when they have a .gitlink file (instead of
.git/ directory), and so on.

This said, I started implementing it, but do not have anything useful
to show yet.
Some issues:
* Probably, it is better to go with a _file_ .git instead of a file
.gitlink, as this way, the user is forced to either go with the
git repository in _directory_ .git/ or external linkage with
the _file_ ".git".
* Even when a .gitlink file is detected, we should honor a
$GIT_DIR environment variable set by the user. Unfortunately, $GIT_DIR
also can be set by porcelain commands to specify "this command only
works in the toplevel directory of a git checkout", i.e. these
porcelain commands set GIT_DIR to ".git". IMHO this is a hack, and
we explicitly should tell the plumbing about these need e.g. via another
environment variable (or a option) without implicitly forcing it by
setting $GIT_DIR. 
* In the way to make the .gitlink file as flexible as
possible (and to use it for lightweight checkouts), it really should
support $GIT_HEAD_FILE, which would replace "HEAD" with the content
of $GIT_HEAD_FILE. E.g. with GIT_HEAD_FILE=MYHEAD, the command
"git log HEAD" really should internally work as "git log MYHEAD"
(ie. use the .git/MYHEAD file instead). It is arguable whether the
usage of "ORIG_HEAD" by the user or in porcelain should map to file
"ORIG_MYHEAD". Probably not. However, changing this in all places
is some work, and I assume that therefore nobody has ever implemented
$GIT_HEAD_FILE - which IMHO really would be useful by itself. 

