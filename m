From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 22:19:05 +0200
Message-ID: <46B4DF39.2070506@lsrfire.ath.cx>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 22:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHQ5n-0007xr-Hk
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759925AbXHDUTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 16:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbXHDUTQ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:19:16 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:55634
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbXHDUTP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 16:19:15 -0400
Received: from [10.0.1.201] (p508EBCE0.dip.t-dialin.net [80.142.188.224])
	by neapel230.server4you.de (Postfix) with ESMTP id 2C66D8B008;
	Sat,  4 Aug 2007 22:19:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46B4A2B0.9080208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54902>

Mark Levedahl schrieb:
> git>git bisect good
> 6490a3383f1d0d96c122069e510ef1af1d019fbb is first bad commit

I've started a bisect run myself and ended up at a different commit,
viz. e90fdc39b6903502192b2dd11e5503cea721a1ad ("Clean up work-tree
handling").  Hmm.  I guess this candidate has a greater chance of
actually being the culprit than yours. ;-)

I can't offer a fix, but I think I've captured install-doc-quick.sh's
problem in a test script (see below).  It fails with e90fdc3 (and
master) but succeeds with e90fdc3^.

Apparently checkout-index (and ls-files, but this is not used by the
install script) can now be confused by running it from inside an
untracked directory.

Johannes, does this help you in finding out what's going on here?

Ren=E9


diff --git a/dev/null b/t/t1502-untracked.sh
new file mode 100755
index 0000000..3fbdb02
--- /dev/null
+++ b/t/t1502-untracked.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description=3D'accessing the index from an untracked directory'
+. ./test-lib.sh
+
+pwd=3D$(pwd)
+GIT_DIR=3D$pwd/.git
+export GIT_DIR
+
+test_expect_success 'setup' '
+	git init &&
+	echo some file content >some_file &&
+	git add some_file &&
+	git commit -m "added a file" some_file &&
+	mkdir untracked
+'
+
+test_expect_success 'test read-tree from an untracked directory' '
+	(                GIT_INDEX_FILE=3D$pwd/idx-a git read-tree HEAD) &&
+	(cd untracked && GIT_INDEX_FILE=3D$pwd/idx-b git read-tree HEAD) &&
+	git diff --binary idx-a idx-b
+'
+
+test_expect_success 'test checkout-index from an untracked directory' =
'
+	(                git checkout-index -a --prefix=3D$pwd/a/) &&
+	(cd untracked && git checkout-index -a --prefix=3D$pwd/b/) &&
+	git diff a/ b/
+'
+
+test_expect_success 'test ls-files from an untracked directory' '
+	(                git ls-files) >ls-files-a &&
+	(cd untracked && git ls-files) >ls-files-b &&
+	git diff ls-files-a ls-files-b
+'
+
+test_done
