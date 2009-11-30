From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 15:54:53 -0500
Message-ID: <20091130205453.GA20348@coredump.intra.peff.net>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <0OMCWm31DRbUGCfPIS6SSJn59HQIM9AKtSDgVSNdiSR99clfmJ3D-Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFDGv-0001Lm-6C
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 21:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbZK3Uyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 15:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbZK3Uyq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 15:54:46 -0500
Received: from peff.net ([208.65.91.99]:40514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbZK3Uyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 15:54:46 -0500
Received: (qmail 14244 invoked by uid 107); 30 Nov 2009 20:59:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Nov 2009 15:59:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Nov 2009 15:54:53 -0500
Content-Disposition: inline
In-Reply-To: <0OMCWm31DRbUGCfPIS6SSJn59HQIM9AKtSDgVSNdiSR99clfmJ3D-Q@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134139>

On Mon, Nov 30, 2009 at 12:07:40PM -0600, Brandon Casey wrote:

> Shouldn't this section be moved down below the sourcing of ../GIT-BUILD-OPTIONS
> on line 656 so that the value of NO_PYTHON will be available when running the
> test scripts directly?

Oops, good catch. I stupidly tested with "make NO_PYTHON=1 test" instead
of actually checking that GIT-BUILD-OPTIONS was propagating it
correctly.

> ps. There's something eerily familiar about this patch.

Hmmm. Yes, I didn't search before writing it, but you probably mean:

  http://article.gmane.org/gmane.comp.version-control.git/127172

But that is missing the NO-PYTHON bit in GIT-BUILD-OPTIONS (did you
forget it there, or was it part of some other patch that also didn't get
applied?).

Also, I am tempted to move the GIT-BUILD-OPTIONS invocation _up_. It
is about reading config and should probably come before we start doing
_anything_.

So maybe this instead:

-- >8 --
Subject: [PATCH] tests: handle NO_PYTHON setting

Without this, test-lib checks that the git_remote_helpers
directory has been built. However, if we are building
without python, we will not have done anything at all in
that directory, and test-lib's sanity check will fail.

We bump the inclusion of GIT-BUILD-OPTIONS further up in
test-lib; it contains configuration, and as such should be
read before we do any checks (and in this particular case,
we need its value to do our check properly).

Signed-off-by: Jeff King <peff@peff.net>
---
I moved the BUILD-OPTIONS thing to just above the beginning of the
"have you built anything" checks, but after all of the function
definitions. But perhaps it should simply go at the very top of the
script. After all, in the case of "make NO_PYTHON=1 test", those
variables will already be defined at the very beginning of the script.

 Makefile      |    1 +
 t/test-lib.sh |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 42744a4..443565e 100644
--- a/Makefile
+++ b/Makefile
@@ -1743,6 +1743,7 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
+	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a40520..2d523fe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -632,13 +632,15 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
+. ../GIT-BUILD-OPTIONS
+
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if test -z "$GIT_TEST_INSTALLED"
+if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
 then
 	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
 	export GITPYTHONLIB
@@ -653,8 +655,6 @@ if ! test -x ../test-chmtime; then
 	exit 1
 fi
 
-. ../GIT-BUILD-OPTIONS
-
 # Test repository
 test="trash directory.$(basename "$0" .sh)"
 test -n "$root" && test="$root/$test"
-- 
1.6.6.rc0.327.gd49b
