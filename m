From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [regression] Re: [PATCHv2 10/15] drop length limitations on
 gecos-derived names and emails
Date: Thu, 24 Jan 2013 15:21:46 -0800
Message-ID: <20130124232146.GA17458@google.com>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231017.GJ10981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org,
	Mihai Rusu <dizzy@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:22:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyW7n-0003G9-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 00:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab3AXXV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 18:21:58 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:56606 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab3AXXVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 18:21:54 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so4473320dac.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+kDI6n5jpTdmBg4yIqI71qfCFsaP2SMKrIR5pdZQBLg=;
        b=i/n/en/lvgydJEzLEUPUDeySH5X7B6b6gYD6/kfXefdVczWgOPLFclr11crwrHyIU5
         GzM2aJd8ytTps9ajW8Xl/DBPC8YH3TgvGauIwr10waw+UlpsDf+xnntleHbN5FAAoQUq
         wtTjObKc63QQt07a1VPNI+7ojD9SPXsiiBT6auUxr87SR8DCFJ4fUfc/V1Q4/Pgn8nEB
         fBIEbGR8xFs58fpxrFJmMMu75pbC74I8sNnPPcoH2yz5wS/Bh9k5u3DWF07lgwuXj2dS
         bl4vYw48CEVcM3i60I7/aNpk7a8/imt+GrEhWEchiFd/iRmpBHv9qyJ6xuwmzX/Ywc1H
         ZDJQ==
X-Received: by 10.68.202.65 with SMTP id kg1mr9471809pbc.28.1359069714218;
        Thu, 24 Jan 2013 15:21:54 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id oc8sm14483729pbb.39.2013.01.24.15.21.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 15:21:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120521231017.GJ10981@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214470>

Hi Jeff,

Jeff King wrote:

> When we pull the user's name from the GECOS field of the
> passwd file (or generate an email address based on their
> username and hostname), we put the result into a
> static buffer.
[...]
> The conversion is mostly mechanical: replace string copies
> with strbuf equivalents, and access the strbuf.buf directly.
> There are a few exceptions:

This broke /etc/mailname handling.  Before:

	$ git var GIT_COMMITTER_IDENT
	Jonathan Nieder <jrn@mailname.example.com> 1359069165 -0800

After:

	$ git var GIT_COMMITTER_IDENT
	Jonathan Nieder <mailname.example.com> 1359069192 -0800

The cause:

[...]
> --- a/ident.c
> +++ b/ident.c
> @@ -19,42 +18,27 @@ int user_ident_explicitly_given;
[...]
> -static int add_mailname_host(char *buf, size_t len)
> +static int add_mailname_host(struct strbuf *buf)
>  {
>  	FILE *mailname;
>  
> @@ -65,7 +49,7 @@ static int add_mailname_host(char *buf, size_t len)
>  				strerror(errno));
>  		return -1;
>  	}
> -	if (!fgets(buf, len, mailname)) {
> +	if (strbuf_getline(buf, mailname, '\n') == EOF) {

This clears the strbuf.

How about something like this as a quick fix?

Reported-by: Mihai Rusu <dizzy@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/ident.c b/ident.c
index 73a06a1..cabd73f 100644
--- a/ident.c
+++ b/ident.c
@@ -41,6 +41,7 @@ static void copy_gecos(const struct passwd *w, struct strbuf *name)
 static int add_mailname_host(struct strbuf *buf)
 {
 	FILE *mailname;
+	struct strbuf mailnamebuf = STRBUF_INIT;
 
 	mailname = fopen("/etc/mailname", "r");
 	if (!mailname) {
@@ -49,14 +50,17 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_getline(buf, mailname, '\n') == EOF) {
+	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
+		strbuf_release(&mailnamebuf);
 		fclose(mailname);
 		return -1;
 	}
 	/* success! */
+	strbuf_addbuf(buf, &mailnamebuf);
+	strbuf_release(&mailnamebuf);
 	fclose(mailname);
 	return 0;
 }
