From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/9] vcs-svn: implement perfect hash for node-prop keys
Date: Sat, 19 Mar 2011 03:51:38 -0500
Message-ID: <20110319085138.GB6706@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300518231-20008-4-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 09:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0rt7-0002zz-AT
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 09:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab1CSIvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 04:51:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61190 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab1CSIvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 04:51:51 -0400
Received: by iyb26 with SMTP id 26so4783603iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YcQWfdT/vVINEQ0fYjTe3P7ttsjvg9Tbosq8wWUKAog=;
        b=fPXjDLVpOvKgMwvgRmylL62q9bu2cG3kFY05ivi6l6wuNG/607T0TnX0nAubsa0uLI
         UISqc7GjABiUVMKq9xV2gZXEdMX0o3QWrNubpQ5GzA+tEAVMkDBIM40xnkyxBpGRraak
         9/I7G5Zr1DhZT60z75+ckflR7U8VRv2VMv1ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gF+75F/nfYaJAEsFGG1KkThy/NtTmO8oQ5fwzLZo8RfIdahQ5s7Gu9Qu73VMlKItyk
         v/B0eX7heKzfU+mwN3IDs7vFdDYZLZV1YX5NbaR6Z5fauWKczOKgVuKwnpWgXr5ZwuXP
         AvQwS/5nxr0MPq5p6Nu9YyLTbiq/KyE3BeRuQ=
Received: by 10.42.75.137 with SMTP id a9mr3127183ick.194.1300524710819;
        Sat, 19 Mar 2011 01:51:50 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id g4sm2439972ick.11.2011.03.19.01.51.45
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 01:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300518231-20008-4-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169416>

David Barr wrote:

>  vcs-svn/svndump.c |   50 ++++++++++++++++++++++++++++++++------------------
>  1 files changed, 32 insertions(+), 18 deletions(-)

Alas.  But it's probably worth it for the chance to get rid of
knowledge of how to intern strings.

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
[...]
> @@ -113,22 +107,38 @@ static void init_keys(void)
>  	keys.prop_delta = pool_intern("Prop-delta");
>  }
>  
> -static void handle_property(uint32_t key, const char *val, uint32_t len,
> +static void handle_property(const char *key, const char *val, uint32_t len,
>  				uint32_t *type_set)
>  {
> -	if (key == keys.svn_log) {
> +	const int key_len = strlen(key);
> +	switch (key_len) {
> +	case 7:
> +		if (memcmp(key, "svn:log", 7))
> +			break;

Crazy idea: to make it visible at a glance when the numbers are wrong,
one can do:

	switch (key_len + 1) {
	case sizeof("svn:log"):
		if (memcmp(key, "svn:log", strlen("svn:log")))
			break;

This only makes the redundancy more obvious, of course.  It could
be reduced a little with something like

 static int prefixcmp_len(const char *str, size_t str_len,
			  const char *prefix, size_t prefix_len)
 {
	if (prefix_len > str_len)
		return 1;
	return memcmp(str, prefix, prefix_len);
 }

but that's probably not worth the cognitive load.

[...]
> -	} else if (key == keys.svn_executable || key == keys.svn_special) {
> +		break;
> +	case 14:
> +		if (memcmp(key, "svn:executable", 14))
> +			break;
> +	case 11:
> +		if (key_len == 11 && memcmp(key, "svn:special", 11))
> +			break;

Maybe, to avoid an unnecessary /* fall through */:

	case sizeof("svn:executable"):
	case sizeof("svn:special"):
		if (key_len == strlen("svn:executable") &&
		    memcmp(key, "svn:executable", strlen(...)))
			break;
		if (key_len == strlen("svn:special") &&
		    memcmp(key, "svn:special", strlen("svn:special")))
			break;

>  		if (*type_set) {
[...]
> @@ -147,7 +157,7 @@ static void handle_property(uint32_t key, const char *val, uint32_t len,
>  
>  static void read_props(void)
>  {
> -	uint32_t key = ~0;
> +	char key[16] = {0};

Probably warrants a comment:

	/* the longest key we pay attention to is "<whatever>" */

>  	const char *t;
>  	/*
>  	 * NEEDSWORK: to support simple mode changes like
> @@ -175,16 +185,20 @@ static void read_props(void)
>  
>  		switch (type) {
>  		case 'K':
> -			key = pool_intern(val);
> -			continue;
>  		case 'D':
> -			key = pool_intern(val);
> +			if (len < sizeof(key))
> +				memcpy(key, val, len + 1);

What happens on I/O error, when val is NULL?  How about early EOF
or malformed input, when strlen(val) < len?

Some tests would also be a comfort.

I'm not so happy with the table of (at first glance) magic-seeming
numbers and the error handling looks a little tricky but aside from
those details this seems like a reasonable way to avoid some
complication without sacrificing speed.

Speaking of which, any hints for people who want to time this patch
(and other patches in the series)?

Thanks.
Jonathan
