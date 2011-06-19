From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 08/20] remote-curl: accept empty line as terminator
Date: Sun, 19 Jun 2011 17:42:16 -0500
Message-ID: <20110619224216.GF23893@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:42:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQhH-0003PL-OP
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab1FSWmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:42:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50958 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1FSWmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:42:22 -0400
Received: by iyb12 with SMTP id 12so1514298iyb.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZHijty3v5umI038XZwK93FaP45oAfFjGkFCjMPPN9RE=;
        b=P5gd3nu+jtL4MpX9Yvr5EWnWClxnmvuZEYQ8TBI9eO3JdlVutDwop2J6xWitZoJioz
         yhKyEo+/oJWEX29xC1yvnWhL7GQkUHGBPZYMKsI7jG70ENDd2V5ZraG9jF5zo6cmMEMF
         SzULZE4k00K+qkKK81U0ueNYlAzBJVdwLkFG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gtaJaSNfZ4cYBfZk60g2+svaBlkT58z+6fiGbza/UsZ/mtALryiRlKO6bQ0JZzAk6t
         c/V/ie7zKe8L2cGKAJHB6k4QF8vN4ZpYxy/x2j8Z2vLFYGnY4py6ohI4f8gpWFU/nblQ
         jFrSz5r9hgarunny4tzJeu/r/2riKWkY5ZLMk=
Received: by 10.231.63.82 with SMTP id a18mr4385472ibi.130.1308523341306;
        Sun, 19 Jun 2011 15:42:21 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id e23sm1744805ibe.6.2011.06.19.15.42.19
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 15:42:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176036>

Sverre Rabbelier wrote:

> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -857,6 +857,8 @@ int main(int argc, const char **argv)
>  	do {
>  		if (strbuf_getline(&buf, stdin, '\n') == EOF)
>  			break;
> +		if (buf.len == 0)
> +			break;

Thanks.  I wonder if that first "if" should be something like

	if (strbuf_getline(&buf, stdin, '\n') == EOF) {
		if (ferror(stdin))
			fprintf(stderr, "Error reading command stream\n");
		else
			fprintf(stderr, "Unexpected end of command stream\n");
		return 1;
	}

to catch I/O errors (e.g., the transport-helper exiting early).
