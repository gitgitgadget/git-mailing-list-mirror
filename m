From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 36/67] remote-ext: simplify git pkt-line generation
Date: Wed, 16 Sep 2015 13:18:03 -0700
Message-ID: <xmqqfv2ep18k.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915155210.GJ29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJ9i-0007VB-98
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbIPUSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:18:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32936 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbIPUSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:18:06 -0400
Received: by pacex6 with SMTP id ex6so218696944pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BQVzXLItNxfwN2c6L64wUsVKvR4CI3rhwC1xXlCrQU0=;
        b=NcjaYqZ0xAdQExBbm7JhBTg5V7/IC+vJQ2H9d0JmCUer8TcOLi5ZGq3Jr4SSQtEE5u
         tjKOrVsWF34yWmyBvKiAyZ15cdXo9vTM/X4NJFmf/rQRHBGQsUn367RFDB9Hou33Kbhn
         IaAYr2co0eBh2w00QNZxXf3Zh5k2M8aAYxGCM58jyrImc5lGpTyyEUVqGIe3R81oLNOS
         Dhx+fZGO+ybMkIT9Tp7S3t68VvgA+v625fQdqbM4r7nk6i3bHTnsrwu6AY9+f6v4bmJG
         0stWoksBcTZZDwPe3Z2tUSFI7/nM4j6zYKPWbyeHLfe6fdxtNe8MKayvhHR1a4HSwFT4
         22yQ==
X-Received: by 10.68.109.97 with SMTP id hr1mr62946786pbb.110.1442434685670;
        Wed, 16 Sep 2015 13:18:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id l16sm11875423pbq.22.2015.09.16.13.18.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 13:18:04 -0700 (PDT)
In-Reply-To: <20150915155210.GJ29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 11:52:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278059>

Jeff King <peff@peff.net> writes:

>  static void send_git_request(int stdin_fd, const char *serv, const char *repo,
>  	const char *vhost)
>  {
> -	size_t bufferspace;
> -	size_t wpos = 0;
> -	char *buffer;
> +	struct strbuf buffer = STRBUF_INIT;
>  
> -	/*
> -	 * Request needs 12 bytes extra if there is vhost (xxxx \0host=\0) and
> -	 * 6 bytes extra (xxxx \0) if there is no vhost.
> -	 */
> +	/* Generate packet with a dummy size header */
> +	strbuf_addf(&buffer, "0000%s %s%c", serv, repo, 0);
>  	if (vhost)
> -		bufferspace = strlen(serv) + strlen(repo) + strlen(vhost) + 12;
> -	else
> -		bufferspace = strlen(serv) + strlen(repo) + 6;
> +		strbuf_addf(&buffer, "host=%s%c", vhost, 0);
>  
> -	if (bufferspace > 0xFFFF)

> +	/* Now go back and fill in the size */
> +	if (buffer.len > 0xFFFF)
>  		die("Request too large to send");
> +	xsnprintf(buffer.buf, buffer.alloc, "%04x", (unsigned)buffer.len);

So we now write "0000something something\0host=something" into the buffer
and then try to overwrite the first four bytes?  Does this xsnprintf()
stop after writing the four hexadecimal, or does it clobber the first
byte of the payload (i.e. copy of serv[0]) by a NUL termination?

>  
> +	if (write_in_full(stdin_fd, buffer.buf, buffer.len) < 0)
>  		die_errno("Failed to send request");
>  
> +	strbuf_release(&buffer);
>  }
>  
>  static int run_child(const char *arg, const char *service)
