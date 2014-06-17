From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] alias.c: Replace git_config with
 git_config_get_string
Date: Tue, 17 Jun 2014 17:14:23 -0400
Message-ID: <20140617211423.GB13848@sigill.intra.peff.net>
References: <1402910154-417-1-git-send-email-tanayabh@gmail.com>
 <20140617054357.GC29957@sigill.intra.peff.net>
 <53A08E37.1040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:21:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx0oI-0002VM-IW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbaFQVO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:14:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:46355 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964907AbaFQVOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:14:25 -0400
Received: (qmail 27931 invoked by uid 102); 17 Jun 2014 21:14:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 16:14:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 17:14:23 -0400
Content-Disposition: inline
In-Reply-To: <53A08E37.1040104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251952>

On Tue, Jun 17, 2014 at 11:51:35AM -0700, Tanay Abhra wrote:

> I have read your other two replies related to it. I suggest the following approach
> for git_config_get_string(), it will return,
> 
> 1. Return null if no value was found for the entered key.
> 
> 2. Empty string (""), returned for NULL values denoting boolean true in some cases.
>    I think it would be much better than converting NULL to "true" or something else
>    internally in the function.
>    We can easily handle such cases as the above with a strcmp like,
> 
> +	v = git_config_get_string(alias_key);
> +	if (!strcmp(v, ""))
> +		config_error_nonbool(alias_key);
> 
> What do you think about this approach?

Hmm. Then we can't distinguish between:

  [alias]
  foo

and

  [alias]
  foo =

I cannot think of a good reason to do the latter with aliases, but I
wonder if there are other config values for which "the empty string" is
a useful value.

I think I'd lean towards an interface which can actually express the
difference between "key not found" (1), "key present but no value" (2), and "key
present with some string" (3).

You could express (2) with a special pointer value, like:

  v = git_config_get_string(key);
  if (!v)
	return NULL; /* no key */
  else if (v == CONFIG_EMPTY_VALUE) {
	config_error_nonbool(key);
	return NULL;
  } else
	return xstrdup(v); /* actual value */

It's reasonably concise, but it's a little ugly that if you dereference
CONFIG_EMPTY_VALUE, you get random memory (on the other hand, we could
point it at 0x1, which would make it no different than NULL; you'd get a
segfault in either case).

Another option is to indicate (1) with a return value, and use a
separate parameter for the value. Like:

  if (git_config_get_string(key, &v) < 0)
	return NULL; /* no key */
  else if (!v) {
	config_error_nonbool(key); /* no value */
	return NULL;
  } else
	return xstrdup(v); /* actual value */

> Thanks for the suggestion, I was pulling my hair out due this bug for last two days.

You're welcome. This is exactly why we encourage students to get their
patches onto the list early for review. There is a lot of git expertise
available on the list. :)

-Peff
