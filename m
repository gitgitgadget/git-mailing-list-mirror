From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] clean: new option --exclude-from
Date: Mon, 7 Dec 2015 15:56:19 -0500
Message-ID: <20151207205619.GE30203@sigill.intra.peff.net>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
 <1449413906-23256-1-git-send-email-rouzier@gmail.com>
 <1449413906-23256-2-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62pe-00075y-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbbLGU4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:56:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:38507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932744AbbLGU4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:56:22 -0500
Received: (qmail 16791 invoked by uid 102); 7 Dec 2015 20:56:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 14:56:22 -0600
Received: (qmail 23320 invoked by uid 107); 7 Dec 2015 20:56:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:56:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 15:56:19 -0500
Content-Disposition: inline
In-Reply-To: <1449413906-23256-2-git-send-email-rouzier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282122>

On Sun, Dec 06, 2015 at 09:58:26AM -0500, James wrote:

> +test_expect_success 'git clean -e --exclude-from' '
> +	rm -fr repo &&
> +	mkdir repo &&
> +	cd repo &&
> +	git init &&
> +	touch known 1 2 3 &&
> +	git add known &&
> +	echo 1 >> .git/clean-exclude &&
> +	git clean -f -e 2 --exclude-from=.git/clean-exclude &&
> +	test_path_is_file 1 &&
> +	test_path_is_file 2 &&
> +	test_path_is_missing 3 &&
> +	test_path_is_file known
> +'

This checks that we exclude the union of the "-e" and "--exclude-from"
parameters. What happens if one excludes a path and the other negates
the exclusion? How is the precedence handled? Is it based on order on
the command-line, or something else?

I do not have much of a preference myself, but it probably makes sense
to document and test it.

> +test_expect_success 'git clean --exclude-from --exclude-from' '
> +	rm -fr repo &&
> +	mkdir repo &&
> +	git init &&
> +	touch known 1 2 3 &&
> +	git add known &&
> +	cat >.git/clean-exclude1 <<-\EOF &&
> +	1
> +	EOF
> +	cat >.git/clean-exclude2 <<-\EOF &&
> +	2
> +	EOF
> +	git clean -f --exclude-from=.git/clean-exclude1 --exclude-from=.git/clean-exclude2 &&
> +	test_path_is_file 1 &&
> +	test_path_is_file 2 &&
> +	test_path_is_missing 3 &&
> +	test_path_is_file known
> +'

Ditto here (as the same "type", the only precedence that would make any
sense is command-line order here).

> +test_expect_success 'git clean --exclude-from=BADFILE' '
> +	rm -fr repo &&
> +	mkdir repo &&
> +	cd repo &&
> +	git init &&
> +	test_expect_code 128 git clean -f --exclude-from=.git/clean-exclude-not-there
> +'

Do you actually care about the 128 here, or is just "it should exit with
failure"? If the latter, we usually use test_must_fail.

-Peff
