From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Tue, 03 Mar 2015 15:01:38 -0800
Message-ID: <xmqqegp5adnx.fsf@gitster.dls.corp.google.com>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSvow-0003pk-VH
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757681AbbCCXBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:01:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756031AbbCCXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:01:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CC543DA2C;
	Tue,  3 Mar 2015 18:01:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UaVppvghyYcLv8aOgi4lbW4pRFc=; b=IzT4gT
	u1EitJ2G54/gxn8TwdXCzy3OcgQxcl/BXWrlqCcprYTZRB/nRQMbLY/qWSLNMD7y
	FfG9fe44tMvYjy5WD/AgRddqwKYV4N8bDJG9cBAI0TMqyVlvVAuNTcmXVmoDUnlR
	SYE6vai8Yw3Pq4CRb/lB6tbz04yYE/nhbD2N4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cM4Y6FgZfapxMRxZpK6AZIkG89NKbr3G
	OhLrOdfHBy3qnSyOy49wLuz31YdZb7EP4Xf+4gU1ooD3sFSRzxqYvI8HfDxdfBLJ
	R6Edmsd81tZXuAmfUdmyWa4JoXQgQK3YHbdBIgzezJNv2BfVDHzVYsgxEWS15YY9
	wg5OiJ/V/aY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03FE43DA2B;
	Tue,  3 Mar 2015 18:01:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21DD73DA28;
	Tue,  3 Mar 2015 18:01:40 -0500 (EST)
In-Reply-To: <1425414299-24000-2-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 4 Mar 2015 04:24:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40865A74-C1F9-11E4-B99C-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264702>

Paul Tan <pyokagan@gmail.com> writes:

> Teach git-credential-store to read/write credentials from
> $XDG_CONFIG_HOME/git/credentials and ~/.git-credentials where
> appropriate:
>
> * get: call lookup_credential() on the XDG file first if it exists. If
>   the credential can't be found, call lookup_credential() on the HOME
>   file.
> * erase: Call remove_credential() on both the XDG file if it exists and
>   the HOME file if it exists.
> * store: If the XDG file exists, call store_credential() on the XDG file
>   and remove_credential() on the HOME file to prevent duplicates.
> * If "--file" is provided, use the file for all operations instead.
>
> In order to support the above, parse_credential_file() now returns 1 if
> it finds a matching credential, and 0 if it does not. Likewise,
> lookup_credential() returns 1 if it could find the credential, and 0 if
> it could not.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---

I agree with everything Matthieu said ;-)

> diff --git a/credential-store.c b/credential-store.c
> index 925d3f4..18b8897 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -6,7 +6,7 @@
>  
>  static struct lock_file credential_lock;
>  
> -static void parse_credential_file(const char *fn,
> +static int parse_credential_file(const char *fn,
>  				  struct credential *c,
>  				  void (*match_cb)(struct credential *),
>  				  void (*other_cb)(struct strbuf *))
> @@ -14,18 +14,20 @@ static void parse_credential_file(const char *fn,
>  	FILE *fh;
>  	struct strbuf line = STRBUF_INIT;
>  	struct credential entry = CREDENTIAL_INIT;
> +	int found_credential = 0;
>  
>  	fh = fopen(fn, "r");
>  	if (!fh) {
>  		if (errno != ENOENT)
>  			die_errno("unable to open %s", fn);
> -		return;
> +		return 0;

Returning found_credential here would be easier to read, no?  After
all, that is why you explicitly initialized it to 0 up there to say
"no we haven't found any yet".

> +	if (!strcmp(op, "get")) {
> +		if (file) {
> +			lookup_credential(file, &c);
> +		} else {
> +			if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
> +				ret = lookup_credential(xdg_file, &c);
> +			if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
> +				lookup_credential(home_file, &c);
> +		}
> +	} else if (!strcmp(op, "erase")) {
> +		if (file) {
> +			remove_credential(file, &c);
> +		} else {
> +			if (xdg_file && access(xdg_file, F_OK) == 0)
> +				remove_credential(xdg_file, &c);
> +			if (home_file && access(home_file, F_OK) == 0)
> +				remove_credential(home_file, &c);
> +		}
> +	} else if (!strcmp(op, "store")) {
> +		if (file) {
> +			store_credential(file, &c);
> +		} else if (xdg_file && access(xdg_file, F_OK) == 0) {
> +			store_credential(xdg_file, &c);
> +			if (home_file && access(home_file, F_OK) == 0 &&
> +			    c.protocol && (c.host || c.path) && c.username
> +			    && c.password)

If you have to chomp, do it like this instead:

> +			if (home_file && access(home_file, F_OK) == 0 &&
> +			    c.protocol && (c.host || c.path) &&
> +			    c.username && c.password)

It would make it more clear that the second line is about the URL
being accessed while the last line is about the user.

> +				remove_credential(home_file, &c);
> +		} else
> +			store_credential(home_file, &c);

The repetitiousness of the above three blocks looked somewhat
disturbing, but I guess you cannot avoid it because of the subtle
differences among these codepaths.  When "getting", you want to get
from only one place, and while not having an earlier candidate is
not an error, an existing but unreadable file deserves a warning.
When "erasing", you want to erase from everywhere.

I am not sure if I understand what you are doing in the store
codepath.  If your "get" will read from xdg (if available) without
looking at home anyway, why do you need to remove it from home?
Wouldn't the leftover be ignored anyway?
