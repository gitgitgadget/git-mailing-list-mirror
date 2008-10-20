From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Mon, 20 Oct 2008 12:36:11 +0200
Message-ID: <48FC5F1B.1050608@op5.se>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 20 17:09:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krs8d-0008NI-Iy
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 12:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbYJTKgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 06:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYJTKgP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 06:36:15 -0400
Received: from mail.op5.se ([193.201.96.20]:35733 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbYJTKgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 06:36:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A82A324B0001;
	Mon, 20 Oct 2008 12:29:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.855
X-Spam-Level: 
X-Spam-Status: No, score=-3.855 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.544, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqQLUTpTjDf2; Mon, 20 Oct 2008 12:29:39 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 42BB11B800B2;
	Mon, 20 Oct 2008 12:29:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98672>

Leo Razoumov wrote:
> When source git repository has extension ".git" like in "MyRepo.git"
> "git fetch" will drop ".git" extension and refer to it as "MyRepo".
> 
> Example:
> 
> sh$ git fetch -v ../MyRepo.git master
> From ../MyRepo
>  * branch            master     -> FETCH_HEAD
> 
> sh$ cat .git/FETCH_HEAD
> 6eb10bd105f2ef7f64c595100c0a850c5b3cfeb9           branch 'master' of ../MyRepo
> 
> Please, note that "git fetch" writes "../MyRepo" instead of "../MyRepo.git"
> 
> My workflow makes it convenient to have two distinct repositories
> (1) "MyRepo"      => where I work daily (WIP)
> (2) "MyRepo.git" => --bare repository accessible to others. "MyRepo"
> pushes ready changes to "MyRepo.git"
> Dropping ".git" extension causes confusion between these two quite
> similarly named repositories.
> 
> This problem can be easily solved by the patch below that removes the
> code that strips off ".git" extension.
> 
> --Leo--
> 
> ----8<-------------------
> 
>  builtin-fetch--tool.c |    2 --
>  builtin-fetch.c       |    2 --
>  2 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> index 7460ab7..5d0b95f 100644
> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -160,8 +160,6 @@ static int append_fetch_head(FILE *fp,
>  	for (i = remote_len - 1; remote[i] == '/' && 0 <= i; i--)
>  		;
>  	remote_len = i + 1;
> -	if (4 < i && !strncmp(".git", remote + i - 3, 4))
> -		remote_len = i - 3;
> 
>  	note_len = 0;
>  	if (*what) {
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index ee93d3a..28123a5 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -348,8 +348,6 @@ static int store_updated_refs(const char *url,
> const char *remote_name,
>  		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
>  			;
>  		url_len = i + 1;
> -		if (4 < i && !strncmp(".git", url + i - 3, 4))
> -			url_len = i - 3;
> 

Will this still play nicely with

   git clone foo.git

?

Otherwise, please also fix the fallout from this patch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
