From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 22:01:53 +0200
Message-ID: <81b0412b0808281301m29830c20l3e16432ea8aef45d@mail.gmail.com>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
	 <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, davidk@lysator.liu.se,
	"Andreas Ericsson" <ae@op5.se>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYni6-0000NE-H6
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbYH1UB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbYH1UB4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:01:56 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:64206 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbYH1UBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:01:55 -0400
Received: by yx-out-2324.google.com with SMTP id 8so298527yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Cn3cQVhjH6YH1K4FgEIF9IMcaeRyKw+RntuNE/cYLRo=;
        b=czGsdUk0FDNzpi7SR0HI5ANBk58KnvmgQFxR67sUI+lgaiwXyv6i+RvwkKgbo19Cdb
         HJdK6RZIJcS67Aas/Q9Q+lr5Fr+ibmgETxqyoaiEx9ZsYqSGRkt8Zn4U8DhgjB3bQFZg
         bYXUxvLgmlpYJ/Z9E5yBVXqiVV+mC4tBy0nbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YSSa4JKuNlkrAKVf9XZ9c9LCgTFZMvpvIOz0zUffPKzTpWrVSAGq1hsyPacWOR9otp
         YpCiGN1aEGzXFRWgqYTJ4LOOEbfU/QBXEADvp+nK+ov02tCX5MObfUly1oK+sf1Kg2/W
         T+S1mfulpcz25u2ddN8K+FCe9LP+fHMhk975c=
Received: by 10.115.32.1 with SMTP id k1mr1943661waj.107.1219953713725;
        Thu, 28 Aug 2008 13:01:53 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 13:01:53 -0700 (PDT)
In-Reply-To: <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94128>

2008/8/19 Brandon Casey <casey@nrlssc.navy.mil>:
>  static int simple_length(const char *match)
>  {
> -       const char special[256] = {
> -               [0] = 1, ['?'] = 1,
> -               ['\\'] = 1, ['*'] = 1,
> -               ['['] = 1
> -       };
> +       char special[256] = { 1, };
>        int len = -1;
>
> +       special['?'] = 1;
> +       special['\\'] = 1;
> +       special['*'] = 1;
> +       special['['] = 1;

For just these 5 values it is likely more effective to just use
a conditional statement (less stack requested, less likely
some stupid compiler tries to optimize it wrongly).
And just as readable.

diff --git a/dir.c b/dir.c
index 92452eb..1cf5985 100644
--- a/dir.c
+++ b/dir.c
@@ -680,17 +680,12 @@ static int cmp_name(const void *p1, const void *p2)
  */
 static int simple_length(const char *match)
 {
-	const char special[256] = {
-		[0] = 1, ['?'] = 1,
-		['\\'] = 1, ['*'] = 1,
-		['['] = 1
-	};
 	int len = -1;

 	for (;;) {
 		unsigned char c = *match++;
 		len++;
-		if (special[c])
+		if (!c || '?' == c || '\\' == c || '*' == c || '[' == c)
 			return len;
 	}
 }
