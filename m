From: Jeff King <peff@peff.net>
Subject: Re: git status --ignored
Date: Thu, 2 Jun 2011 13:20:21 -0400
Message-ID: <20110602172021.GB2928@sigill.intra.peff.net>
References: <4DE712CE.20509@vpac.org>
 <7vr57cerxo.fsf@alter.siamese.dyndns.org>
 <20110602055449.GA28292@sigill.intra.peff.net>
 <7vk4d4dxn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Spiers <aspiers@vpac.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSBZM-0001DI-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 19:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab1FBRUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 13:20:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab1FBRUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 13:20:23 -0400
Received: (qmail 29914 invoked by uid 107); 2 Jun 2011 17:20:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 13:20:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 13:20:21 -0400
Content-Disposition: inline
In-Reply-To: <7vk4d4dxn1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174963>

On Thu, Jun 02, 2011 at 09:08:18AM -0700, Junio C Hamano wrote:

> +	cat >expect <<-\EOF &&
> +	 M dir1/modified
> +	A  dir2/added
> +	?? dir2/modified
> +	!! .gitignore
> +	!! dir1/untracked
> +	!! dir2/untracked
> +	!! expect
> +	!! output
> +	!! untracked
> +	EOF
> +	git status -s --ignored >output &&
> +	test_cmp expect output

Unfortunately this does not actually show the bug, as the short format
takes a different code path that was not broken.

I have mixed feelings about putting the whole long format in a test
vector, as all of the human-readable bits are supposed to be allowed to
change. And I know that tests are only partially about demonstrating a
particular bug, and more about codifying the behavior we want so future
changes don't break it. But it is nice to exercise that code path, and
it doesn't change all that much, so maybe it is worth doing. Squashable
patch below. Throw it out if you don't agree.

> +test_expect_success 'status with gitignore' '

It took me a minute to figure out what was different between the two
tests with the same title. Maybe calling them "status with gitignore
(untracked files present)" and "status with gitignore (no untracked
files)" would help future readers.

---
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index b47aad8..957c1e3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -115,6 +115,36 @@ test_expect_success 'status with gitignore' '
 	EOF
 	git status -s --ignored >output &&
 	test_cmp expect output
+
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	dir2/modified
+	# Ignored files:
+	#   (use "git add -f <file>..." to include in what will be committed)
+	#
+	#	.gitignore
+	#	dir1/untracked
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
+	git status --ignored >output &&
+	test_cmp expect output
 '
 
 test_expect_success 'status with gitignore' '
@@ -146,6 +176,33 @@ test_expect_success 'status with gitignore' '
 	EOF
 	git status -s --ignored >output &&
 	test_cmp expect output
+
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Ignored files:
+	#   (use "git add -f <file>..." to include in what will be committed)
+	#
+	#	.gitignore
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
+	git status --ignored >output &&
+	test_cmp expect output
 '
 
 rm -f .gitignore
