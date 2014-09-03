From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short
 option name
Date: Wed, 3 Sep 2014 14:46:25 -0700
Message-ID: <20140903214624.GY18279@google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
 <1409753034-9459-3-git-send-email-johan@herland.net>
 <xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
 <xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
 <54077A3E.20703@web.de>
 <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPINv-00022I-75
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbaICVqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 17:46:31 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33261 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbaICVqa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 17:46:30 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so18533560pad.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+GHJno6mwMB2Ia/4/JHfWskN/L9XPnDAwNKfKUmLJOQ=;
        b=ISeYoH5VESSdF5Vh03v9m/SibmBrtbwvPgTnQdVayNQZqKwZ/flHkQhnp7lDOvz8qd
         0MmGksdSM6wp8qYKyL89cMLw+jJa7GE4FGTs1F75+/B2HYpkQgJ1yeyMTQWgNKZ6MzNy
         PERxUpRecIPNb8Et4SzlIMLT+0wR22zyU1e0SI+tuzmHweZzM0kszg5xo/qrn/GAmsUM
         PTp/72lnRGhsYgGOGx0xhMgmEDmwuPbgner/e6PM+9dBbVzYveFQ0JuIXWFx8S2DHsg7
         DjFrc9HnXuBzaEXd5CizYC+4lY8J/jm7zs0WcPpuADYhCp1WHQ7prBIWx6sjoP5TddgR
         uZaA==
X-Received: by 10.70.37.67 with SMTP id w3mr137496pdj.107.1409780787876;
        Wed, 03 Sep 2014 14:46:27 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id fk10sm20058756pab.29.2014.09.03.14.46.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 14:46:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256419>

Junio C Hamano wrote:

> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -345,12 +345,27 @@ static void check_typos(const char *arg, const struct option *options)
>  static void parse_options_check(const struct option *opts)
>  {
>  	int err = 0;
> +	char short_opts[128];
> +
> +	memset(short_opts, '\0', sizeof(short_opts));
>  
>  	for (; opts->type != OPTION_END; opts++) {
>  		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
>  		    (opts->flags & PARSE_OPT_OPTARG))
>  			err |= optbug(opts, "uses incompatible flags "
>  					"LASTARG_DEFAULT and OPTARG");
> +		if (opts->short_name) {
> +			struct strbuf errmsg = STRBUF_INIT;
> +			if (opts->short_name < ' ' || 0x7F <= opts->short_name)
> +				strbuf_addf(&errmsg, "invalid short name (0x%02x)",
> +					    opts->short_name);
> +			else if (short_opts[opts->short_name]++)

What happens on platforms with a signed char?

With the following squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/parse-options.c w/parse-options.c
index f7f153a..4cc3f3e 100644
--- i/parse-options.c
+++ w/parse-options.c
@@ -361,7 +361,7 @@ static void parse_options_check(const struct option *opts)
 			if (opts->short_name < ' ' || 0x7F <= opts->short_name)
 				strbuf_addf(&errmsg, "invalid short name (0x%02x)",
 					    opts->short_name);
-			else if (short_opts[opts->short_name]++)
+			else if (short_opts[(unsigned char) opts->short_name]++)
 				strbuf_addf(&errmsg, "short name %c already used",
 					    opts->short_name);
 			if (errmsg.len)
