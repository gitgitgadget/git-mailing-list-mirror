From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Sat, 01 Mar 2014 22:34:30 +0100
Message-ID: <53125266.8040007@kdbg.org>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Faiz Kothari <faiz.off93@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Mar 01 22:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJrYb-0001rA-LA
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 22:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbaCAVet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 16:34:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:56181 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753205AbaCAVes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 16:34:48 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id E5234CE0BD
	for <git@vger.kernel.org>; Sat,  1 Mar 2014 22:34:46 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9CF10130050;
	Sat,  1 Mar 2014 22:34:32 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C76AA19F3DF;
	Sat,  1 Mar 2014 22:34:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243111>

Am 01.03.2014 12:21, schrieb Faiz Kothari:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
> Implemented write_or_die.c:strbuf_write_or_die() and used in relevant places
> to substitute write_or_die(). I spotted other places where strbuf can be used
> in place of buf[MAX_PATH] but that would require a change in prototype of a 
> lot of functions and functions calling them and so on....
> I'll look for more places where strbuf can be used safely.

You haven't given a justifiction of the change (why is this change good?)

> diff --git a/write_or_die.c b/write_or_die.c
> index b50f99a..5fb309b 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "strbuf.h"

I think you have the layering backwards here: strbuf_write_or_die should
be part of the (higher-level) strbuf API, and not an extension of the
low-level write_or_die function.

>  
>  static void check_pipe(int err)
>  {
> @@ -64,6 +65,14 @@ void write_or_die(int fd, const void *buf, size_t count)
>  	}
>  }
>  
> +void strbuf_write_or_die(int fd, const struct strbuf *sbuf)

And when you make the function a strbuf API, the prototype should be

void strbuf_write_or_die(const struct strbuf *sbuf, int fd)

as in "hey, strbuf object, write your content to this file descriptor!"

> +{
> +	if(write_in_full(fd, sbuf->buf, sbuf->len) < 0){
> +		check_pipe(errno);
> +		die_errno("write error");
> +	}
> +}
> +
>  int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
>  {
>  	if (write_in_full(fd, buf, count) < 0) {
> 

-- Hannes
