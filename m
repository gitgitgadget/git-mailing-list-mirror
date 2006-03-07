From: Yann Dirson <ydirson@altern.org>
Subject: git-svn, tree moves, and --no-stop-on-copy
Date: Tue, 7 Mar 2006 23:08:37 +0100
Message-ID: <20060307220837.GB27397@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 07 23:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGkie-0001Uq-L6
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 23:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWCGWbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 17:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWCGWbt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 17:31:49 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:19176 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750719AbWCGWbt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 17:31:49 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id CCA291F044;
	Tue,  7 Mar 2006 23:01:49 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FGkMA-00043F-Dn; Tue, 07 Mar 2006 23:08:38 +0100
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17354>

It looks that the --no-stop-on-copy flag has been dropped by error
during the "options cleanup" commit a couple of days ago.  This
trivial patch appears at first sight to address the problem:

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 3c860e4..91a0d3b 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -36,7 +36,9 @@ my %fc_opts = ( 'no-ignore-externals' =>
                'authors-file|A=s' => \$_authors );
 my %cmd = (
        fetch => [ \&fetch, "Download new revisions from SVN",
-                       { 'revision|r=s' => \$_revision, %fc_opts } ],
+                       { 'revision|r=s' => \$_revision,
+                         'no-stop-on-copy' => \$_no_stop_copy,
+                         %fc_opts } ],
        init => [ \&init, "Initialize and fetch (import)", { } ],
        commit => [ \&commit, "Commit git revisions to SVN",
                        {       'stdin|' => \$_stdin,

But then, "git-svn fetch" fails when trying to deal with the renaming:

$ git-svn.perl init https://svn.sourceforge.net/svnroot/ufoai/ufoai/trunk/src
$ git-svn.perl fetch --no-stop-on-copy
[...]
Updated to revision 163.
r163 = 68da9a01b2d5a2372262ada33a401e03aef41e97
svn: REPORT request failed on '/svnroot/ufoai/!svn/vcc/default'
svn: Cannot replace a directory from within
256 at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 812
        main::sys('svn', 'up', '--ignore-externals', '-r166') called at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 243
        main::fetch() called at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 83

The impacted revision in svn is:

------------------------------------------------------------------------
r166 | ydirson | 2006-03-02 01:36:55 +0100 (Thu, 02 Mar 2006) | 1 line
Changed paths:
   D /trunk
   A /ufoai/trunk (from /trunk:165)

Adding an ufoai toplevel module
------------------------------------------------------------------------

Obviously "svn update" does not like it at all.

"svn switch --relocate" does not seem to be of any help.  Switching
manually .git/git-svn/tree/ to the new repository location does not
help either, since I must obviously update to r166 in that case, and
then a further "git-svn fetch" fails because it does not find
.git/git-svn/revs/166 aleady imported.

Any idea as to how to get the work done ?
I could surely import in another branch not using --no-stop-on-copy,
and then use a graft, but if we could make it work in a more
streamlined manner, it would surely be useful.


Before I find out in the doc about --no-stop-on-copy, I did a coupld
of experimentation.  Among them, was using a peg-revision in the URL
passed to "git-svn init":

$ GIT_SVN_ID=git-oldsvn git-svn init https://svn.sourceforge.net/svnroot/ufoai/trunk/src@165

That succeeds, but then "git-svn fetch" will fail with:

svn: REPORT request failed on '/svnroot/ufoai/!svn/bc/190/trunk/src@165'
svn: '/svnroot/ufoai/!svn/bc/190/trunk/src@165' path not found
256 at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 783
        main::svn_log_raw('https://svn.sourceforge.net/svnroot/ufoai/trunk/src@165', '-r0:HEAD', '--stop-on-copy') called at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 219
        main::fetch() called at /export/work/yann/git/git/contrib/git-svn/git-svn.perl line 81


Maybe git-svn could also be guarded against peg-revisions on init
command-line, since that appears to confuse it quite a bit :)


Additionally, it may be worth poiting out in the doc at least one
valid use of the --no-stop-on-copy flag that is friendly to the user's
sanity: when the svn repository has undergone a reorg, such that the
URL passed to "init" indeed moved - at least, when/if it is made to
work :)

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
