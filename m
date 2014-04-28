From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or
 CURLDIR
Date: Mon, 28 Apr 2014 13:05:51 -0700
Message-ID: <20140428200550.GO9218@google.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com, gitster@pobox.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeroM-0006Tp-OE
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbaD1UFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:05:55 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50092 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbaD1UFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:05:54 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so1152767pdj.10
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zHbOfCkqUWO9+8Ip/faIVIAHJz4/dGDOQi+b0WW2lpE=;
        b=Efe+vBeuTnaY4w2+8+MwdwurZMvt4m29YfeOQwqhHnN9Gb/zgzVeqiZ9eu9oNMBqbg
         xFJ06//xZ74niGzdthmubHnqSZAflaZVyeE6xU0ipZtOd9ED66QoRuMTzrdb/stQllac
         YDjBpoynxiN4ODT6PypAbknJ3YODBIMDfKU5mIwT3Mg6IexZxmNUGlOb7C9K9OwW8Z4D
         ottNrI6oqmQCCcDlO13+hjPGDioK00vzftl1H7UeMoQR+Q3rxgS2Z1iID9P84Ck3ZvbO
         D8PUoWgnTbjmFda079oXdU+ZXn/fs4DiMuvPGN2i3jKmpcSxGVdiwxBsvxL1zxgRzqMc
         BXxA==
X-Received: by 10.66.144.102 with SMTP id sl6mr27294506pab.96.1398715553893;
        Mon, 28 Apr 2014 13:05:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g6sm96688304pat.2.2014.04.28.13.05.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 13:05:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398714653-1050-1-git-send-email-dborowitz@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247436>

Dave Borowitz wrote:

> Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
> to curl-config being missing), use the old behavior of falling back to
> -lcurl.
> ---
>  Makefile | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)

Sign-off?

[...]
> +++ b/Makefile
> @@ -35,7 +35,9 @@ all::
>  # transports (neither smart nor dumb).
>  #
>  # Define CURL_CONFIG to the path to a curl-config binary other than the
> -# default 'curl-config'.
> +# default 'curl-config'. If CURL_CONFIG is unset or points to a binary that
> +# is not found, defaults to the CURLDIR behavior, or if CURLDIR is not set,
> +# uses -lcurl with no additional library detection.

I'm having a little trouble parsing this but don't have any better
suggestion.

[...]
> @@ -1127,9 +1129,27 @@ ifdef NO_CURL
>  	REMOTE_CURL_NAMES =
>  else
>  	ifdef CURLDIR
> -		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
> -		BASIC_CFLAGS += -I$(CURLDIR)/include
> -		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +		CURL_LIBCURL=

Tiny nit: elsewhere the makefile seems to prefer having a space before
the '='.

If I explicitly set CURL_LIBCURL to the empty string and CURLDIR was
set then my setting will still override the setting below and the
behavior is unchanged from before this patch --- good.

If I explicitly set CURL_LIBCURL to empty and CURLDIR was unset then
that used to produce an error so it was an invalid configuration and
couldn't regress.

So this should be safe --- good.

> +	else
> +		CURL_CONFIG ?= curl-config

Not about this patch, but the above '?=' should probably be plain '='
for consistency with the rest of the makefile's behavior wrt envvars.

[...]
> -				$(error libcurl not detected; try setting CURLDIR)
> +                                $(error libcurl not detected or not compiled with static support)

Whitespace damage.

Except for the whitespace issues,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
