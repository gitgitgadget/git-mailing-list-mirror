From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Sun, 02 Jul 2006 16:49:12 -0700
Message-ID: <7vejx31sav.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<1151471040.4940.17.camel@dv>
	<7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
	<1151489103.28036.6.camel@dv> <20060702204906.GG29115@pasky.or.cz>
	<7v64if3d50.fsf@assigned-by-dhcp.cox.net>
	<20060702214931.GJ29115@pasky.or.cz>
	<7vveqf1v05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 01:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxBgk-0001OU-Uq
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 01:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWGBXtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWGBXtN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 19:49:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:6063 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbWGBXtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 19:49:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702234912.LVZY8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 19:49:12 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vveqf1v05.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 02 Jul 2006 15:50:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23136>

Junio C Hamano <junkio@cox.net> writes:

> Gaah.  You are right.
>
> PERL5LIB does not seem to just do a push (and that was I thought
> why unshift was a way to defeat it) but do something more evil.
> ...
> I thought we killed this showstopper and was hoping now the
> series is mergeable to "next" but apparently not yet X-<.
>
> Sigh....

Yuck; that means we would need to have something evil like this.

-- >8 --
Perly Git: make sure we do test the freshly built one.

We could BEGIN { push @INC, '@@INSTLIBDIR@@'; } but that is not
a good idea for normal execution.  The would prevent a
workaround for a user who is trying to override an old, faulty
Git.pm installed on the system path with a newer version
installed under $HOME/.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index 1b23fa1..a9805dd 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -5,7 +5,11 @@ #
 # Read .git/FETCH_HEAD and make a human readable merge message
 # by grouping branches and tags together to form a single line.
 
-BEGIN { unshift @INC, '@@INSTLIBDIR@@'; }
+BEGIN {
+	unless (exists $ENV{'RUNNING_GIT_TESTS'}) {
+		unshift @INC, '@@INSTLIBDIR@@';
+	}
+}
 use strict;
 use Git;
 use Error qw(:try);
diff --git a/git-mv.perl b/git-mv.perl
index a604896..5134b80 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -6,7 +6,11 @@ #
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.
 
-BEGIN { unshift @INC, '@@INSTLIBDIR@@'; }
+BEGIN {
+	unless (exists $ENV{'RUNNING_GIT_TESTS'}) {
+		unshift @INC, '@@INSTLIBDIR@@';
+	}
+}
 use warnings;
 use strict;
 use Getopt::Std;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index fba0c51..298c6ca 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -206,8 +206,9 @@ PYTHON=`sed -e '1{
 	PYTHONPATH=$(pwd)/../compat
 	export PYTHONPATH
 }
+RUNNING_GIT_TESTS=YesWeAre
 PERL5LIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
-export PERL5LIB
+export PERL5LIB RUNNING_GIT_TESTS
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
