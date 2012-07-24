From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] test-lib.sh: unset XDG_CONFIG_HOME
Date: Tue, 24 Jul 2012 08:27:10 -0400
Message-ID: <20120724122710.GB12066@sigill.intra.peff.net>
References: <20120724115305.GA7328@sigill.intra.peff.net>
 <vpqpq7l8iss.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Witten <mfwitten@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SteCs-0007YY-Ef
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 14:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab2GXM1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 08:27:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60183 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab2GXM1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 08:27:12 -0400
Received: (qmail 16725 invoked by uid 107); 24 Jul 2012 12:27:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 08:27:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 08:27:10 -0400
Content-Disposition: inline
In-Reply-To: <vpqpq7l8iss.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202034>

On Tue, Jul 24, 2012 at 02:06:43PM +0200, Matthieu Moy wrote:

> Thanks (for the 3 patches, all of them look good).
> 
> the "unset XDG_CONFIG_HOME" part was already discussed here:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/201609
> 
> But Michael did not continue the thread. I think your solution (unset
> $XDG_CONFIG_HOME instead of setting it to $HOME/.config/git) is better.

Yeah, setting it to $HOME/.config/git is actively wrong; I agree with
the reasoning in that thread (which I did not read until just now).

> In the thread above, I also proposed checking that $XDG_CONFIG_HOME was
> taken into account, but for the "git config" part (while you test the
> attributes part).

Yeah, I see.

> I think it makes sense to add stg like this to your PATCH 3:

Agreed. And one for the exclude section, too, just for completeness.

Revised patch 3 is below.

-- >8 --
Subject: [PATCHv2 3/3] t1306: check that XDG_CONFIG_HOME works

This should override $HOME/.config, but we never actually
tested it.
---
 t/t1306-xdg-files.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 1569596..a62c3fb 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -38,6 +38,13 @@ test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''
 	test_cmp expected actual
 '
 
+test_expect_success '"$XDG_CONFIG_HOME overrides $HOME/.config/git' '
+	mkdir -p "$HOME"/xdg/git &&
+	echo "[user]name = in_xdg" >"$HOME"/xdg/git/config &&
+	echo in_xdg >expected &&
+	XDG_CONFIG_HOME="$HOME"/xdg git config --get-all user.name >actual &&
+	test_cmp expected actual
+'
 
 test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
 	>.gitconfig &&
@@ -80,6 +87,17 @@ test_expect_success 'Exclusion of a file in the XDG ignore file' '
 	test_must_fail git add to_be_excluded
 '
 
+test_expect_success '$XDG_CONFIG_HOME overrides $HOME/.config/ignore' '
+	mkdir -p "$HOME"/xdg/git &&
+	echo content >excluded_by_xdg_only &&
+	echo excluded_by_xdg_only >"$HOME"/xdg/git/ignore &&
+	test_when_finished "git read-tree --empty" &&
+	(XDG_CONFIG_HOME="$HOME/xdg" &&
+	 export XDG_CONFIG_HOME &&
+	 git add to_be_excluded &&
+	 test_must_fail git add excluded_by_xdg_only
+	)
+'
 
 test_expect_success 'Exclusion in both XDG and local ignore files' '
 	echo to_be_excluded >.gitignore &&
@@ -113,6 +131,14 @@ test_expect_success 'Checking XDG attributes when HOME is unset' '
 	test_cmp expected actual
 '
 
+test_expect_success '$XDG_CONFIG_HOME overrides $HOME/.config/attributes' '
+	mkdir -p "$HOME"/xdg/git &&
+	echo "f attr_f=xdg" >"$HOME"/xdg/git/attributes &&
+	echo "f: attr_f: xdg" >expected &&
+	XDG_CONFIG_HOME="$HOME/xdg" git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Checking attributes in both XDG and local attributes files' '
 	echo "f -attr_f" >.gitattributes &&
 	echo "f: attr_f: unset" >expected &&
