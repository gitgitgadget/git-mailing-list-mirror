From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] config: Add hashtable for config parsing &
 retrieval
Date: Tue, 17 Jun 2014 01:34:36 -0400
Message-ID: <20140617053436.GB29957@sigill.intra.peff.net>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
 <1402907232-24629-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 07:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwm2c-0005Ec-8w
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 07:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbaFQFei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 01:34:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:45797 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932510AbaFQFeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 01:34:37 -0400
Received: (qmail 10675 invoked by uid 102); 17 Jun 2014 05:34:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 00:34:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 01:34:36 -0400
Content-Disposition: inline
In-Reply-To: <1402907232-24629-3-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251843>

On Mon, Jun 16, 2014 at 01:27:12AM -0700, Tanay Abhra wrote:

> +static int config_cache_callback(const char *key, const char *value, void *unused)
> +{
> +	config_cache_set_value(key, value);
> +	return 0;
> +}

This gets the normalized key, which is good; you should be able to just
hash/lookup values without further munging as long as they, too, are
normalized (you may want to note that in the documentaiton for
config_cache_find_entry and friends).

The value may be a string value, or NULL if it is a true boolean. That
value gets passed to...

> +static int config_cache_set_value(const char *key, const char *value)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry *e;
> +
> +	config_cache = get_config_cache();
> +	e = config_cache_find_entry(key);
> +	if (!e) {
> +		e = xmalloc(sizeof(*e));
> +		hashmap_entry_init(e, strhash(key));
> +		e->key = xstrdup(key);
> +		string_list_init_dup(&e->value_list);
> +		string_list_append(&e->value_list, value);
> +		hashmap_add(config_cache, e);
> +	} else {
> +		string_list_append(&e->value_list, value);
> +	}
> +	return 0;
> +}

...this function, which then passes it to string_list_append. Which is
going to call xstrdup() on it, which will then segfault.

You need some mechanism to store entries that are NULL. It may be enough
to silently convert them into the string "true" inside the cached
storage. But there may be callers who treat NULL specially (e.g., a
tri-state true/false/auto that treats a bare boolean as "auto"); you'd
need to check.

The other alternative is to use something besides string_list that can
handle a NULL.  You may also need to give some thought to how such NULLs
would be handled by git_config_get_string() (since a NULL there also
means "not found").

-Peff
