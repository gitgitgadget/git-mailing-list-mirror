From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Fix buffer overflow in config parser
Date: Thu, 9 Apr 2009 00:58:42 +0200
Message-ID: <200904090058.42751.markus.heidelberg@web.de>
References: <49DD21A0.3040505@intra2net.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 01:00:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrgkN-0003Lw-Qj
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 00:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbZDHW6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 18:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbZDHW6W
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 18:58:22 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59685 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbZDHW6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 18:58:22 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id C4EE1FF9340A;
	Thu,  9 Apr 2009 00:58:20 +0200 (CEST)
Received: from [89.59.73.185] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lrgiq-0003m8-00; Thu, 09 Apr 2009 00:58:20 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <49DD21A0.3040505@intra2net.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX198vP0YxCgool/BhFHHHea2cs1Xozkj9aP2BtQ+
	MXnB0Zt8gX2/TBrvyWwk2kuRCID4R4Ox73tvjiY8LxQ8Gaf8n1
	znVmt9hHF61cLj5zVD8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116129>

Thomas Jarosch, 09.04.2009:
> Hello together,
> 
> attached is a small patch to fix a buffer overflow in config.c.
> Patch is against git master's HEAD.
> 
> I didn't send this one inline as I wanted to
> preserve the 1024+ byte long line.

You could send the patch inline and attach the example config.

> diff --git a/config.c b/config.c
> index b76fe4c..a9c67e8 100644
> --- a/config.c
> +++ b/config.c
> @@ -72,7 +72,7 @@ static char *parse_value(void)
>                         }
>                 }
>                 if (space) {
> -                       if (len)
> +                       if (len && len < sizeof(value)-1)
>                                 value[len++] = ' ';
>                         space = 0;
>                 }

At the beginning of the for loop, there is already an overflow guard.

		if (len >= sizeof(value))
			return NULL;

It would probably be better to fix it at this place.

		if (len >= sizeof(value)-1)
			return NULL;

Markus
