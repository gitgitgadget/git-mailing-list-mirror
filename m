From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v6 3/3] git-remote-ext
Date: Fri, 8 Oct 2010 17:02:20 -0500
Message-ID: <20101008220220.GA15214@burratino>
References: <1286571713-7755-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286571713-7755-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Oct 09 00:05:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4L4M-0006Ad-U2
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 00:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab0JHWFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 18:05:34 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43933 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003Ab0JHWFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 18:05:33 -0400
Received: by gxk9 with SMTP id 9so482630gxk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ur41KWYXmaKJxXNBxuTrjH2fcG9DEkGX/Tv5AdFOgtE=;
        b=QWgRj9HejNVJZB8bTQKk76XoRQfVwz/jOhOxzmp6Rq1ABfj/043IfGjp8ytTQEtAIK
         qAC8YMYHeEHd6qZWLr+F1h/6n9MxfrpNgXZfINLv7Xzv8dS0GBnEW3Z8SEoPIv7AcRAF
         K2BuXxO0k/oSVOVNzWxAHDxTTdbvt4jt71iDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hUCQ8kDfyyy2mosvpN9T+xMsQRQy50p7ZHItkNSsrNeXufL0tkndRSissaOC2NNQGr
         GXSuZHGOwaWd6F77Kwq/2TmuENWNdLce2OBSak0xowxBVQRT3Hb48yYrxtuxl7Qzx8wS
         Cv3IKpn4/WIr/Z7yU8lwjplKklm+NSg9WNjmI=
Received: by 10.151.85.14 with SMTP id n14mr3784073ybl.44.1286575532790;
        Fri, 08 Oct 2010 15:05:32 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm384979ybk.15.2010.10.08.15.05.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 15:05:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286571713-7755-4-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158546>

Ilari Liusvaara wrote:

> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

Just a few random nits.

> +++ b/builtin/remote-ext.c
> @@ -0,0 +1,243 @@
[...]
[...]
> +			default:
> +				die("Bad remote-ext placeholder '\\%c'.",
> +					str[rpos]);

Should be "Bad remote-ext placeholder '%%%c'.", I think.

> +static const char **parse_argv(const char *arg, const char *service)
> +{
> +	int arguments = 0;
> +	int i;
> +	char **ret;
> +	char *(temparray[MAXARGUMENTS + 1]);

Would be more idiomatic to leave out the parentheses.

> +
> +	while (*arg) {
> +		char *ret;

Would be clearer without shadowing.  Maybe

		char *expanded;

[...]
> +	ret = xcalloc(arguments + 1, sizeof(char *));
> +	for (i = 0; i < arguments; i++)
> +		ret[i] = temparray[i];
> +
> +	return (const char **)ret;

Maybe


	ret = xmalloc(...
	for (...

	ret[arguments] = NULL;
	return ret;

(to avoid clearing memory that is about to be overwritten) or even

	ret = xmalloc(...
	memcpy(ret, temparray, arguments * sizeof(*ret));
	ret[arguments] = NULL;
	return ret;

(to emphasize the copy) would make sense?

Why is ret of type char ** and then cast away rather than being
const char ** in the first place?

> +static int command_loop(const char *child)
> +{
> +	char buffer[MAXCOMMAND];
> +
> +	while (1) {
> +		if (!fgets(buffer, MAXCOMMAND - 1, stdin))
> +			exit(0);

Won't this exit(0) for I/O errors?

> +		/* Strip end of line characters. */
> +		while (isspace((unsigned char)buffer[strlen(buffer) - 1]))
> +			buffer[strlen(buffer) - 1] = 0;

This is wasteful: strlen() has to look for the null byte three times
just to strip a \r\n from the end.  See remote-fd for an example of
how to avoid that overhead.
