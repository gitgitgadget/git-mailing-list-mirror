From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 14:52:00 -0500
Message-ID: <20160118195159.GD1009@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:52:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFqT-0005f9-7m
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301AbcARTwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:52:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:55599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754270AbcARTwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:52:03 -0500
Received: (qmail 31267 invoked by uid 102); 18 Jan 2016 19:52:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:52:02 -0500
Received: (qmail 13127 invoked by uid 107); 18 Jan 2016 19:52:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:52:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 14:52:00 -0500
Content-Disposition: inline
In-Reply-To: <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284308>

On Mon, Jan 18, 2016 at 05:57:18PM +0100, Thomas Gummerer wrote:

> While there, replace a literal tab in the format string with \t to make
> it more obvious to the reader.

Heh, I didn't notice in the first review that you actually inherited
that from the original. Definitely worth doing, IMHO.

> @@ -101,7 +104,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			continue;
>  		if (!tail_match(pattern, ref->name))
>  			continue;
> -		printf("%s	%s\n", oid_to_hex(&ref->old_oid), ref->name);
> +		if (symrefs && ref->symref)
> +			printf("ref: %s\t%s\n", ref->symref, ref->name);
> +		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
>  		status = 0; /* we found something */

Yeah, this looks like the right logic to me.

> +test_expect_success 'ls-remote --symrefs' '
> +	cat >expect <<-EOF &&

Please use "<<-\EOF" here (and in the test below) to prevent
interpolation. It's not wrong in your case, but it's easier for a reader
(or somebody who later modifies the test) to not have to wonder what you
were expecting to be expanded. So as a general style, we quote our
here-doc markers.

> +	ref: refs/heads/master	HEAD
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
> +	EOF
> +	git ls-remote --symrefs >actual &&
> +	test_cmp expect actual
> +'

This test covers "symrefs, along with everything". And this one:

> +test_expect_success 'ls-remote with filtered symrefs' '
> +	cat >expect <<-EOF &&
> +	ref: refs/heads/master	HEAD
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
> +	EOF
> +	git ls-remote --symrefs . HEAD >actual &&
> +	test_cmp expect actual
> +'

covers symrefs plus a refname filter. It would be nice to also test that
"git ls-remote --symrefs --heads" shows "refs/heads/foo" as a symref.
But that cannot work with the current code, because upload-pack only
tells us about the symref HEAD, and not any others.

This may change in the future, though. I'm not sure if it's worth
squashing in the expect_failure test below. The "negative" one below
that does tell us something, though it is somewhat redundant (it does
catch the "always show symrefs" logic from your original version, but
it seems unlikely that would pop up as a regression).

---
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 3edbc9e..92fc7e9 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -176,7 +176,7 @@ test_expect_success 'ls-remote --symrefs' '
 	test_cmp expect actual
 '
 
-test_expect_success 'ls-remote with filtered symrefs' '
+test_expect_success 'ls-remote with filtered symrefs (refname)' '
 	cat >expect <<-EOF &&
 	ref: refs/heads/master	HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
@@ -185,4 +185,27 @@ test_expect_success 'ls-remote with filtered symrefs' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'ls-remote with filtered symrefs (--heads)' '
+	git symbolic-ref refs/heads/foo refs/tags/mark &&
+	cat >expect <<-\EOF &&
+	ref: refs/heads/bar	refs/tags/mark
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	EOF
+	git ls-remote --symrefs --heads . >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --symrefs omits filtered-out matches' '
+	cat >expect <<-\EOF &&
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	EOF
+	git ls-remote --symrefs --heads . >actual &&
+	test_cmp expect actual &&
+	git ls-remote --symrefs . "refs/heads/*" >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
