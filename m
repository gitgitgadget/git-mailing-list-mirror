From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 1/4] notes: don't leak memory in
 git_config_get_notes_strategy
Date: Fri, 1 Apr 2016 13:14:24 -0400
Message-ID: <20160401171424.GA20345@sigill.intra.peff.net>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
 <1459470946-16522-2-git-send-email-sbeller@google.com>
 <CAPig+cQ=83k-of=jP1r6bYqsYrUhiDKhR3_Bm-SfYndn+sL=Dg@mail.gmail.com>
 <xmqqh9fljojo.fsf@gitster.mtv.corp.google.com>
 <xmqq4mbljm76.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:14:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2eV-0007P9-Gk
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbcDARO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:14:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:42513 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751318AbcDARO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:14:27 -0400
Received: (qmail 10827 invoked by uid 102); 1 Apr 2016 17:14:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 13:14:26 -0400
Received: (qmail 27150 invoked by uid 107); 1 Apr 2016 17:14:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 13:14:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 13:14:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mbljm76.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290561>

On Fri, Apr 01, 2016 at 10:03:25AM -0700, Junio C Hamano wrote:

> -- >8 --
> From: Stefan Beller <sbeller@google.com>
> Date: Thu, 31 Mar 2016 11:04:03 -0700
> Subject: [PATCH] notes: don't leak memory in git_config_get_notes_strategy
> 
> This function asks for the value of a configuration and
> after using the value does not have to retain ownership
> of the value.  git_config_get_string_const() however is
> a function to get a copy of the value, but we forget to
> free it before we return.
> 
> Because we only need to peek the value without retaining
> a pointer to it, use git_config_get_value() to peek into
> the value cached in the config API layer.
> 
> As git_config_get_value() does not insist the value to be
> a string, we'd need to do the "nonbool" check ourselves.

Unfortunately, I don't think this is quite right. In the original, we
relied on git_config_get_string_const to notice a non-string value, at
which point it would die:

  $ git -c notes.mergeStrategy notes merge whatever
  error: Missing value for 'notes.mergeStrategy'
  fatal: unable to parse 'notes.mergeStrategy' from command-line config

But in your patch:

> @@ -743,8 +743,10 @@ static int git_config_get_notes_strategy(const char *key,
>  {
>  	const char *value;
>  
> -	if (git_config_get_string_const(key, &value))
> +	if (git_config_get_value(key, &value))
>  		return 1;
> +	if (!value)
> +		return config_error_nonbool(key);
>  	if (parse_notes_merge_strategy(value, strategy))
>  		git_die_config(key, "unknown notes merge strategy %s", value);

We just return an error from git_config_get_notes_strategy(). If this
were a callback to git_config(), that would be fine (as we would
auto-die then in the caller), but it's not. It is called directly for a
specific key. One of the callers treats a non-zero return as "we don't
have that variable", and the other ignores the return value completely.

So I think you'd want something more like:

  if (!value) {
	config_error_nonbool(key);
	git_die_config(key);
  }

That keeps the original message intact (though it is a bit verbose in
the first place).

This is why I wondered if the minor "do not allocate" tweak was worth
the trouble, when git_config_get_string() just handles this for us.

-Peff
