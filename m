From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/4] Introduce diff.submodule
Date: Thu, 15 Nov 2012 08:33:57 -0800
Message-ID: <20121115163356.GF6157@sigill.intra.peff.net>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
 <20121115162331.GD6157@sigill.intra.peff.net>
 <20121115162524.GE6157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2OO-0002Nk-95
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768405Ab2KOQeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:34:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768379Ab2KOQeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:34:01 -0500
Received: (qmail 17859 invoked by uid 107); 15 Nov 2012 16:34:49 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 11:34:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 08:33:57 -0800
Content-Disposition: inline
In-Reply-To: <20121115162524.GE6157@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209827>

On Thu, Nov 15, 2012 at 08:25:26AM -0800, Jeff King wrote:

> > Thanks, this version looks good to me.
> 
> Oh wait. I did not look closely enough. The point was to move the option
> parser _out_ of git_diff_ui_config into git_diff_basic_config, so that
> it only triggers for porcelain, not plumbing.

Oh no, I am having a muddled morning. It _is_ right. We want to move it
out of basic into ui. Sorry for the noise. I just woke up and am
thinking backwards.

It may be worth squashing this test into patch 3:

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index e401814..023439f 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -72,6 +72,21 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success 'diff.submodule does not affect plumbing' '
+	test_config diff.submodule log &&
+	git diff-index -p HEAD >actual &&
+	cat >expected <<-EOF &&
+	diff --git a/sm1 b/sm1
+	new file mode 160000
+	index 0000000..a2c4dab
+	--- /dev/null
+	+++ b/sm1
+	@@ -0,0 +1 @@
+	+Subproject commit $fullhead1
+	EOF
+	test_cmp expected actual
+'
+
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 

BTW, while writing the test, I noticed two minor nits with your tests:

  1. They can use test_config, which is simpler (you do not need to
     unset yourself after the test) and safer (the unset happens via
     test_when_finished, so it works even if the test fails).

  2. You can still indent expected output when using <<-.

I don't know if it is worth re-rolling for them.

-Peff
