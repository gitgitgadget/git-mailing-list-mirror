From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 09 Jun 2008 16:23:07 +0200
Message-ID: <484D3CCB.1000508@viscovery.net>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 16:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5iIR-0004oH-2W
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 16:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760994AbYFIOXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 10:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbYFIOXN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 10:23:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16109 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbYFIOXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 10:23:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K5iH5-0002r8-8w; Mon, 09 Jun 2008 16:23:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0DDDA6C4; Mon,  9 Jun 2008 16:23:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84387>

Lea Wiemann schrieb:
> Previously, cat-file --batch / --batch-check would silently exit if it
> was passed a non-existent SHA1 on stdin.  Now it prints "<SHA1>
> missing" as in all other cases (and as advertised in the
> documentation).

Makes sense!

> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index f8b3160..112b9db 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -168,8 +168,11 @@ static int batch_one_object(const char *obj_name, int print_contents)
>  	else
>  		type = sha1_object_info(sha1, &size);
>  
> -	if (type <= 0)
> -		return 1;
> +	if (type <= 0) {
> +		printf("%s missing\n", obj_name);
> +		fflush(stdout);
> +		return 0;
> +	}

With this change an invalid name and a non-existing SHA1 are treated as
"missing". But an empty name is still an error, which we don't see here
because it's outside the hunk's context: It is the first thing that the
function checks, and there it exits with return 1. Why is this case still
special?

-- Hannes
