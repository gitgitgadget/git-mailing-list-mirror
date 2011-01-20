From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Sanity-ckeck config variable names
Date: Thu, 20 Jan 2011 18:22:32 -0500
Message-ID: <20110120232232.GA9442@sigill.intra.peff.net>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141112.GD8034@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 21 00:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg3pw-00048p-Tu
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 00:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab1ATXWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 18:22:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39727 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950Ab1ATXWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 18:22:35 -0500
Received: (qmail 14717 invoked by uid 111); 20 Jan 2011 23:22:34 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 20 Jan 2011 23:22:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 18:22:32 -0500
Content-Disposition: inline
In-Reply-To: <20110119141112.GD8034@fm.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165344>

On Wed, Jan 19, 2011 at 03:11:12PM +0100, Libor Pechacek wrote:

> Sanity-ckeck config variable names when adding and retrieving them.
> 
> As a side effect code duplication between git_config_set_multivar and get_value
> (in builtin/config.c) was removed and the common functionality was placed in
> git_config_parse_key.

I think this is a good goal, but a few nits:

> +/* Auxiliary function to sanity-check and split the key into the section
> + * identifier and variable name.
> + *
> + * Returns 0 on success, 1 when there is an invalid character in the key and 2
> + * if there is no section name in the key.

Please switch these to -1 and -2, as we generally use negative integers
to indicate errors in library-ish function. I know you were just copying
git_config_set_multivar's error codes, but it is designed to return
straight to exit(), which makes it an exception.

Other than that, the code looks OK to me. However, it does cause
t1300.85 to fail. The problem is that the test is using these bogus
names to check that "git -c" works. While it does technically work now
to say "git -c foo=bar config foo" (which your patch breaks), I don't
think that is a useful behavior in the real world, since no actual
config options exist without a section name. So yes, you can "git -c" a
non-sectioned variable, but why would you want to?

So I think it probably makes sense to squash this in:

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index d0e5546..3e79c37 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -876,11 +876,10 @@ test_expect_success 'check split_cmdline return' "
 	"
 
 test_expect_success 'git -c "key=value" support' '
-	test "z$(git -c name=value config name)" = zvalue &&
 	test "z$(git -c core.name=value config core.name)" = zvalue &&
-	test "z$(git -c CamelCase=value config camelcase)" = zvalue &&
-	test "z$(git -c flag config --bool flag)" = ztrue &&
-	test_must_fail git -c core.name=value config name
+	test "z$(git -c foo.CamelCase=value config foo.camelcase)" = zvalue &&
+	test "z$(git -c foo.flag config --bool foo.flag)" = ztrue &&
+	test_must_fail git -c name=value config core.name
 '
 
 test_done

and a note to the commit message like:

  This breaks a test in t1300 which used invalid section-less keys in
  the tests for "git -c". However, allowing such names there was
  useless, since there was no way to set them via config file, and no
  part of git actually tried to use section-less keys. This patch
  updates the test to use more realistic examples.

-Peff
