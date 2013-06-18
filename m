From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/13] bash prompt: fix here document indentation in
 interactive rebase test
Date: Tue, 18 Jun 2013 01:54:39 -0400
Message-ID: <20130618055439.GD5916@sigill.intra.peff.net>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
 <1371521826-3225-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 07:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoosR-00045d-GM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 07:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab3FRFyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 01:54:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:34391 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab3FRFyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 01:54:43 -0400
Received: (qmail 22344 invoked by uid 102); 18 Jun 2013 05:55:40 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 00:55:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 01:54:39 -0400
Content-Disposition: inline
In-Reply-To: <1371521826-3225-3-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228156>

On Tue, Jun 18, 2013 at 04:16:55AM +0200, SZEDER G=C3=A1bor wrote:

> -	echo "#!$SHELL_PATH" >fake_editor.sh &&
> -	cat >>fake_editor.sh <<\EOF &&
> -echo "exec echo" >"$1"
> -echo "edit $(git log -1 --format=3D"%h")" >>"$1"
> -echo "exec echo" >>"$1"
> -EOF
> +	cat >fake_editor.sh <<-EOF &&
> +		#!$SHELL_PATH
> +		echo "exec echo" >"\$1"
> +		echo "edit \$(git log -1 --format=3D"%h")" >>"\$1"
> +		echo "exec echo" >>"\$1"
> +	EOF

These days we the "write_script" helper, so I think you can write this
even nicer as:

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 9e51263..91da313 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -248,14 +248,12 @@ EOF
=20
 test_expect_success 'prompt - interactive rebase' '
 	printf " (b1|REBASE-i 2/3)" >expected
-	echo "#!$SHELL_PATH" >fake_editor.sh &&
-	cat >>fake_editor.sh <<\EOF &&
-echo "exec echo" >"$1"
-echo "edit $(git log -1 --format=3D"%h")" >>"$1"
-echo "exec echo" >>"$1"
-EOF
+	write_script fake_editor.sh <<-\EOF &&
+	echo "exec echo" >"$1"
+	echo "edit $(git log -1 --format=3D"%h")" >>"$1"
+	echo "exec echo" >>"$1"
+	EOF
 	test_when_finished "rm -f fake_editor.sh" &&
-	chmod a+x fake_editor.sh &&
 	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
 	git checkout b1 &&
 	test_when_finished "git checkout master" &&

-Peff
