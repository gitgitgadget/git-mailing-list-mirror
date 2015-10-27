From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/9] submodule-config: "goto" removal in parse_config()
Date: Tue, 27 Oct 2015 14:26:45 -0700
Message-ID: <20151027212645.GF7881@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
 <1445969753-418-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBld-00058C-6V
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbbJ0V0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 17:26:49 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34314 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbbJ0V0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:26:48 -0400
Received: by padhk11 with SMTP id hk11so233816737pad.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4ZAQevC2gwLq/wK9T15N6ldK1L+5RuQATxWpQKDnO7o=;
        b=EzuOku6GnVYo3WVLSvZMlYeitG5/llwEe4RjZVTaMpU9SsKwZ4anTqpNshV44wXt0f
         k1+DNyVLxWSkftCwW627NIVyavT4xMF4WK7NMYGyFv8xgnkMbgYNf9r4vCYz4Fbn1YfR
         M3xraQSjoRFp/KOppZlaRe+MrAQeX547W0PH/cc9GlZsbpy3lmtZm18Z9F9HCzeWmenC
         YGnNooXe2YBgh+aklKGTByWErZu9WiQj56P1iXxQYL1xOh2S7zQt/S0b16REuj5H9y+U
         BFW+cWyCGbeIls7X2LeLEBES5h8bZqMYK1AUT+Ki0HJV+lFovX9hznAi75IMoS6H/O4p
         MVPA==
X-Received: by 10.68.130.1 with SMTP id oa1mr12964676pbb.134.1445981208424;
        Tue, 27 Oct 2015 14:26:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8971:92ad:1b34:b61b])
        by smtp.gmail.com with ESMTPSA id bs3sm41318330pbd.89.2015.10.27.14.26.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 14:26:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445969753-418-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280301>

Hi,

Stefan Beller wrote:

> Subject: submodule-config: "goto" removal in parse_config()
>
> Many components in if/else if/... cascade jumped to a shared
> clean-up with "goto release_return", but we can restructure the
> function a bit and make them disappear,

Not having read the patch yet, the above makes me suspect this is
going to make the code worse.  A 'goto' for exception handling can
be a clean way to ensure everything allocated gets released, and
restructuring to avoid that can end up making the code more error
prone and harder to read.

In other words, the "goto" removal should be a side effect and not
the motivation.

>                                         which reduces the line count
> as well.  Also reformat overlong lines and poorly indented ones
> while at it.

These sound like good things.  Hopefully this will make the code
structure easier to understand, too.

> The order of rules to verify the value for "ignore" used to be to
> complain on multiple values first and then complain to boolean, but
> swap the order to match how the values for "path" and "url" are
> verified.

I don't understand this.  Hopefully the patch will make it clearer.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 74 +++++++++++++++++++++---------------------------------
>  1 file changed, 29 insertions(+), 45 deletions(-)

What patch does this apply against?  A similar patch appears to
already be part of "master".

[...]
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -257,78 +257,62 @@ static int parse_config(const char *var, const char *value, void *data)
>  	if (!name_and_item_from_var(var, &name, &item))
>  		return 0;
>  
> -	submodule = lookup_or_create_by_name(me->cache, me->gitmodules_sha1,
> -			name.buf);
> +	submodule = lookup_or_create_by_name(me->cache,
> +					     me->gitmodules_sha1,
> +					     name.buf);

Ok.

>  	if (!strcmp(item.buf, "path")) {
> -		struct strbuf path = STRBUF_INIT;
> -		if (!value) {
> +		if (!value)
>  			ret = config_error_nonbool(var);
> -			goto release_return;
> -		}

In the preimage, I can see at this line already that nothing more is going to
happen in this case.  In the postimage, I need to scroll down to find that
everything else is "else"s.

More generally, the patch seems to be about changing from a code structure
of

	if (condition) {
		handle it;
		goto done;
	}
	if (other condition) {
		handle it;
		goto done;
	}
	handle misc;
	goto done;

to

	if (condition) {
		handle it;
	} else if (other condition) {
		handle it;
	} else {
		handle misc;
	}

In this example the postimage is concise and simple enough that it's
probably worth it, but it is not obvious in the general case that this
is always a good thing to do.

Now that I see the patch is already merged, I don't think it needs
tweaks.  Just a little concerned about the possibility of people
judging from the commit message and emulating the pattern in the rest
of git.

Thanks and hope that helps,
Jonathan
