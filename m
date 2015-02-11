From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: add show_err flag to git_config_parse_key()
Date: Tue, 10 Feb 2015 19:27:54 -0500
Message-ID: <20150211002754.GC30561@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
 <20150206193313.GA4220@peff.net>
 <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
 <20150206203902.GB10857@peff.net>
 <54DA5FC1.9010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	git@vger.kernel.org
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:28:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLL9v-000292-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 01:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbbBKA16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 19:27:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:47530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbbBKA15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 19:27:57 -0500
Received: (qmail 14874 invoked by uid 102); 11 Feb 2015 00:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 18:27:57 -0600
Received: (qmail 11498 invoked by uid 107); 11 Feb 2015 00:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 19:27:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2015 19:27:54 -0500
Content-Disposition: inline
In-Reply-To: <54DA5FC1.9010707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263665>

On Wed, Feb 11, 2015 at 01:15:05AM +0530, Tanay Abhra wrote:

> I just saw your mail late in the night (I didn't had net for a week).
> This patch just squelches the error message, I will take a better
> look tomorrow morning.

Thanks, this is probably a good first step. We can worry about making
the config look actually _work_ as the next step (which does not even
have to happen right now; it is not like it hasn't been this way since
the very beginning of git).

Another option for this first step would be to actually make
git_config_parse_key permissive, rather than just squelching the error.
That is, to actually look up pager.under_score rather than silently
erroring out with an invalid key whenever we are reading (whereas on the
writing side, we _do_ want to make sure we enforce syntactic validity).
I doubt it matters, much, though.  Such a lookup would never succeed,
because the config file parser will also not allow it. So assuming the
syntactic rules here match what the config file parser does, they are at
worst redundant.

>  builtin/config.c |  2 +-
>  cache.h          |  2 +-
>  config.c         | 19 ++++++++++++-------
>  3 files changed, 14 insertions(+), 9 deletions(-)

Here's a test that can be squashed in:

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index da958a8..a28a2fd 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -447,4 +447,14 @@ test_expect_success TTY 'external command pagers override sub-commands' '
 	test_cmp expect actual
 '
 
+test_expect_success 'command with underscores does not complain' '
+	write_script git-under_score <<-\EOF &&
+	echo ok
+	EOF
+	git --exec-path=. under_score >actual 2>&1 &&
+	echo ok >expect &&
+	test_cmp expect actual
+'
+
+
 test_done

I was tempted to also add something like:

  test_expect_failure TTY 'command with underscores can override pager' '
	test_config pager.under_score "sed s/^/paged://" &&
	git --exec-path=. under_score >actual &&
	echo paged:ok >expect &&
	test_cmp expect actual
  '

but I am not sure it is worth adding the test, even as a placeholder.
Unless we are planning to relax the config syntax, the correct spelling
is more like "pager.under_score.command". It's probably better to just
add the test along with the code when we know what the final form will
look like.

-Peff
