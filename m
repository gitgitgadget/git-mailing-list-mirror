From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Sun, 3 Apr 2016 00:40:55 -0400
Message-ID: <20160403044054.GB1519@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-3-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Sun Apr 03 06:41:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amZqR-0008OJ-6x
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 06:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbcDCEk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 00:40:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:43238 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751148AbcDCEk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 00:40:57 -0400
Received: (qmail 29878 invoked by uid 102); 3 Apr 2016 04:40:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:40:56 -0400
Received: (qmail 9139 invoked by uid 107); 3 Apr 2016 04:40:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:40:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 00:40:55 -0400
Content-Disposition: inline
In-Reply-To: <1459638975-17705-3-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290626>

On Sat, Apr 02, 2016 at 07:16:13PM -0400, santiago@nyu.edu wrote:

> The verify-tag command supports mutliple tag names as an argument.

s/mutliple/multiple/

> +test_expect_success GPG 'verify multiple tags' '
> +	git verify-tag -v --raw fourth-signed sixth-signed seventh-signed 2>actual 1> tagnames &&

Style: we don't put a space between ">" and the filename. Also, we
usually omit "1" when redirecting stdout.

> +		grep -c "GOODSIG" actual > count &&

Funny indentation here.

I wondered if we could use test_cmp instead of a counting grep here, but
this is looking at gpg spew, and we probably don't want to count on that
never changing.

I don't see us actually verifying that "count" is 3, though.

> +		! grep "BADSIG" actual &&

Makes sense...

> +		grep -E "tag\ .*" tagnames | uniq -u | wc - l | grep "3"

Do we need "grep -E" here? I don't see any extended regex in use. Is
there a reason to backslash-escape the space?

Your "wc -l" has an extra space, which means "read stdin, and then the
file 'l'". Which sort-of happens to work, except as you noticed, you
have to grep for "3" instead of matching it.

I think, though, that rather than counting we could just write what we
expect into a file and compare that. It makes it easier for somebody
reading the test to see what it is we're trying to do.

In fact, I suspect you could replace the "GOODSIG" check as well by
doing something like:

  # verifying 3 tags in one invocation should be exactly like
  # verifying the 3 separately
  tags="fourth-signed sixth-signed seventh-signed"
  for i in $tags; do
          git verify-tag -v --raw $i || return 1
  done >expect.stdout 2>expect.stderr &&
  git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr &&
  test_cmp expect.stdout actual.stdout &&
  test_cmp expect.stderr actual.stderr

but I didn't test it.

-Peff
