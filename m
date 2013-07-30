From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] config: --get-urlmatch
Date: Mon, 29 Jul 2013 17:37:16 -0700
Message-ID: <20130730003716.GA13114@sigill.intra.peff.net>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
 <1375138150-19520-1-git-send-email-gitster@pobox.com>
 <1375138150-19520-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 02:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3xwL-0004mp-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 02:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3G3AhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 20:37:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab3G3AhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 20:37:19 -0400
Received: (qmail 30602 invoked by uid 102); 30 Jul 2013 00:37:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Jul 2013 19:37:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Jul 2013 17:37:16 -0700
Content-Disposition: inline
In-Reply-To: <1375138150-19520-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231339>

On Mon, Jul 29, 2013 at 03:49:10PM -0700, Junio C Hamano wrote:

> "git config --get-urlmatch $section[.$variable] $url" is a way to
> learn what the configured value for $section.$variable is for the
> given URL, using the logic introduced by the http.<url>.config
> topic.

That interface looks good to me. It matches the --get-all/--get-regexp
options of git-config. It does not quite match --get-color, which is
really a type (like --bool or --int), but I think --get-color is the odd
one out there.

> This can still be further refactored to remove code from http_options()
> in http.c, I think.

Yeah, that would be the ultimate goal. I think you would just need to
keep the same string_list there, with one urlmatch_item per key that we
care about.

> ---
>  builtin/config.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++

It seems like some of the logic here should be reusable for http.c.
Should it be in config.c instead?

> +struct urlmatch_collect {
> +	struct string_list vars;
> +	struct url_info url;
> +	const char *section;
> +	const char *key;
> +};
> +
> +struct urlmatch_item {
> +	size_t max_matched_len;
> +	char user_matched;
> +	char value_is_null;
> +	struct strbuf value;
> +};

I think you ultimately want such a string_list for matching arbitrary
numbers of keys, but do you need it for the git-config case?

You will always be matching collect->key, so you will only ever insert a
single item into the collect->vars list. IOW, this could be:

  struct urlmatch_collect {
    struct url_info url;
    const char *section;
    const char *key;
    struct urlmatch_item match;
  };

I don't mind if it is more complicated than this single-case needs to be
if the code is also being used to http.c, but I haven't seen that yet
(and this code would not used as-is, as you would want to call the
function with many potential collect->key values, but without
re-normalizing the URL over and over).

And of course, it needs docs and tests. :) The latter can probably come
by converting some of the test-url-normalize tests to just use
git-config instead.

-Peff
