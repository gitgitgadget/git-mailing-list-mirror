From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 13:21:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901211319010.3586@pacific.mpi-cbg.de>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <7vskndgi3c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 13:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPc6J-0004qw-C0
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 13:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764109AbZAUMVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 07:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764021AbZAUMVG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 07:21:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:36257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757575AbZAUMVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 07:21:05 -0500
Received: (qmail invoked by alias); 21 Jan 2009 12:20:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 21 Jan 2009 13:20:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HwslcRklH5n0Q4A14DAwsb0IoP6sq6DNYK+UwSc
	+sqi2r5cfQ9VCz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vskndgi3c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106600>

Hi,

On Wed, 21 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This patch adds the ability to use valgrind's memcheck tool to
> > diagnose memory problems in git while running the test scripts....
> 
> Hmmm, why do I haf to suffer with these new warnings from the tests?
> 
>   $ sh t2012-checkout-last.sh --valgrind -v -i
>   warning: templates not found /git/git.git/t/valgrind/bin/templates/blt/
>   Initialized empty Git repository in /git/git.git/t/trash directory.t2012-checkout-last/.git/
>   mv: cannot stat `.git/hooks': No such file or directory
>   * expecting success:
>           echo hello >world &&
> 
> Am I using the patch incorrectly somehow?

Nope, I overlooked that GIT_EXEC_PATH was used by test-lib also to 
determine the location of the templates.  Will squash this in (which 
makes a function out of the symlink business, and also fixes the error 
that git-gui/ was tested if it is a script; "head" complained that it is 
not a file):

-- snipsnap --
 t/test-lib.sh |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f031905..6acc6e0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -487,6 +487,14 @@ then
 	PATH=$TEST_DIRECTORY/..:$PATH
 	GIT_EXEC_PATH=$TEST_DIRECTORY/..
 else
+	make_symlink () {
+		test -h "$2" &&
+		test "$1" = "$(readlink "$2")" || {
+			rm -f "$2" &&
+			ln -s "$1" "$2"
+		}
+	}
+
 	# override all git executables in PATH and TEST_DIRECTORY/..
 	GIT_VALGRIND=$TEST_DIRECTORY/valgrind/bin
 	mkdir -p "$GIT_VALGRIND"
@@ -498,12 +506,13 @@ else
 		while read file
 		do
 			# handle only executables
-			test -x "$file" && test ! -d "$file" || continue
+			test -x "$file" || continue
 
 			base=$(basename "$file")
 			symlink_target=$TEST_DIRECTORY/../$base
 			# do not override scripts
 			if test -x "$symlink_target" &&
+			    test ! -d "$symlink_target" &&
 			    test "#!" != "$(head -c 2 < "$symlink_target")"
 			then
 				symlink_target=../valgrind.sh
@@ -513,19 +522,16 @@ else
 				symlink_target=../unprocessed-script
 			esac
 			# create the link, or replace it if it is out of date
-			if test ! -h "$GIT_VALGRIND"/"$base" ||
-			    test "$symlink_target" != \
-					"$(readlink "$GIT_VALGRIND"/"$base")"
-			then
-				rm -f "$GIT_VALGRIND"/"$base" || exit
-				ln -s "$symlink_target" "$GIT_VALGRIND"/"$base"
-			fi
+			make_symlink "$symlink_target" "$GIT_VALGRIND/$base" ||
+			exit
 		done
 	done
 	IFS=$OLDIFS
 	PATH=$GIT_VALGRIND:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND
 	export GIT_VALGRIND
+
+	make_symlink ../../../templates "$GIT_VALGRIND"/templates || exit
 fi
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
-- 
1.6.1.442.g38a50
