From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add Android support
Date: Mon, 16 May 2011 14:11:22 -0700
Message-ID: <7vzkmmjqpx.fsf@alter.siamese.dyndns.org>
References: <D2F37FDB-20C2-401A-AA90-DB4A50C27123@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Mon May 16 23:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM54i-0005Iu-14
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 23:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab1EPVLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 17:11:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1EPVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 17:11:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D3FF474D;
	Mon, 16 May 2011 17:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j4BQ1bcdrNqmVRo3Z25bdUNMoyM=; b=l941HH
	oOXeV6cq1YBTyUMlhsESFN3+0F/SK9EIJ4jYjEdTQ6HGgsMKpMfUORlZHpjhdVC3
	KNCl9CS4VxqUIBQzAM01tMtXo341Ju9rXE/sHbpdD8b6cvVE9Fg3q8uZjWJ38hqf
	AlUzYVGLaSztTf/U1Ecmar/Ng4iv++Mb4Buvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dN9Sey1D7xRjAXm/R0jw3+iPL2zrgXXb
	1LlXATLZWzv2mLCVU8wlXRYv+A0Tq9NKU3+PKx9SW5g+bk2PCBXJcQGm16MNqZjD
	oHsFUaFo54p0HuAqxpCc/eMtYX0UizbOAMXfm8XHWrEvc0wXenHc70bvZwa0LPdm
	vZX5yA9/Qss=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05F5F474C;
	Mon, 16 May 2011 17:13:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A04C474B; Mon, 16 May 2011
 17:13:30 -0400 (EDT)
In-Reply-To: <D2F37FDB-20C2-401A-AA90-DB4A50C27123@gieschke.de> (Rafael
 Gieschke's message of "Mon, 16 May 2011 22:08:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B7BEE9A-8001-11E0-9D98-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173760>

Rafael Gieschke <rafael@gieschke.de> writes:

> diff --git a/connect.c b/connect.c
> index 57dc20c..15b285e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -632,7 +632,11 @@ char *git_getpass(const char *prompt)
>  	if (!askpass)
>  		askpass = getenv("SSH_ASKPASS");
>  	if (!askpass || !(*askpass)) {
> +		#ifndef NO_GETPASS
>  		char *result = getpass(prompt);
> +		#else
> +		char *result = NULL;
> +		#endif
>  		if (!result)
>  			die_errno("Could not read password");
>  		return result;
> diff --git a/ident.c b/ident.c
> index 1c4adb0..76fa786 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -20,7 +20,12 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
>  	 * with commas.  Also & stands for capitalized form of the login name.
>  	 */
>  
> -	for (len = 0, dst = name, src = w->pw_gecos; len < sz; src++) {
> +	#ifndef NO_PW_GECOS
> +	src = w->pw_gecos;
> +	#else
> +	src = "&";
> +	#endif
> +	for (len = 0, dst = name; len < sz; src++) {
>  		int ch = *src;
>  		if (ch != '&') {
>  			*dst++ = ch;

Please do not throw in conditional compilation in a codepath that is
otherwise generic.

Do something like this near the beginning of the file (or if they are
common, in an appropriate header):

        #ifdef NO_GETPASS
        #define getpass(ignored) NULL
        #endif

        #ifdef NO_PW_GECOS
        #define get_gecos(ignored) "&"
        #else
        #define get_gecos(struct_passwd) (struct_passwd->pw_gecos)
        #endif

That way, you do not have to change connect.c at all, and the code that
accesses gecos field would get a slight abstraction, i.e.

	for (len = 0, dst = name, src = get_gecos(w); len < sz; src++) {
		...

I however suspect that NO_GETPASS would be a useless thing in the longer
term. Wouldn't you rather wish to have a native Android UI that asks a
password and plug that implementation as a replacement for git_getpass()?

It might be worthwhile to study how mingw folks do this part before you
dive in and butcher this codepath in a way you may regret later.
