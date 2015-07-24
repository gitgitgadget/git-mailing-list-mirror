From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/18] rerere: stop looping unnecessarily
Date: Fri, 24 Jul 2015 13:06:49 -0700
Message-ID: <xmqq380dmiau.fsf@gitster.dls.corp.google.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 22:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjFA-00033g-WE
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbbGXUGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:06:51 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35326 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbGXUGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:06:51 -0400
Received: by pabkd10 with SMTP id kd10so19152067pab.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Gq0XT2LIR0N49tXk/951PHUIzX2SKu0JnxbcqiuZQ6I=;
        b=yqzkB0I5O31dekG3nwYe1s05Pe4uG8n52qhztOPUc8iAdboc7ltIW6izFLzrk12r/q
         GAYdiEe9MZIFUNIbnmSDQuDm65HX5KtJMq6JHO18guiW9ryvqTRo730sBhcwFfgQWL9W
         bsGFWdKZJYbXshzWqE+p+3ktFjlIPCVRL2BM1e+yVPWnOvDGADiOY++Qg7VWoFpzX5V9
         9k0njt0JSXA6+Fz1ThI5K/+g+rF36oclKDTpC+73/m5EVhK9mhnstWEv6G+OKV1aR4ly
         8Abjj2Kbc9CgCg+obByWlIOePfmGgeyw7rR9MFA8AqeGl/7EosfZ9jaXt93Ruxil39nI
         FsAg==
X-Received: by 10.66.151.133 with SMTP id uq5mr34582117pab.7.1437768410807;
        Fri, 24 Jul 2015 13:06:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id q5sm16052429pde.56.2015.07.24.13.06.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:06:50 -0700 (PDT)
In-Reply-To: <1437171880-21590-8-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Fri, 17 Jul 2015 15:24:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274595>

Junio C Hamano <gitster@pobox.com> writes:

> handle_cache() loops 3 times starting from an index entry that is
> unmerged, while ignoring an entry for a path that is different from
> what we are looking for.
>
> As the index is sorted, once we see a different path, we know we saw
> all stages for the path we are interested in.  Just loop while we
> see the same path and then break, instead of continuing for 3 times.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  rerere.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 4c45f55..7b1419c 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -329,24 +329,21 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
>  		return -1;
>  	pos = -pos - 1;
>  
> -	for (i = 0; i < 3; i++) {
> +	while (pos < active_nr) {
>  		enum object_type type;
>  		unsigned long size;
> -		int j;
>  
> -		if (active_nr <= pos)
> -			break;
>  		ce = active_cache[pos++];
>  		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
> -			continue;
> -		j = ce_stage(ce) - 1;
> -		mmfile[j].ptr = read_sha1_file(ce->sha1, &type, &size);
> -		mmfile[j].size = size;
> +			break;
> +		i = ce_stage(ce) - 1;
> +		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
> +		mmfile[i].size = size;

If the conflicted index has multiple stage #1 entries, this will leak
what was previously read.  As the array is initialized to NULLs, perhaps


	i = ce_stage(ce) - 1;
        if (!mmfile[i].ptr) {
		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
                mmfile[i].size = size;
	}

should be sufficient.  This does change the semantics, in that we
used to use the last stage #1 entry as the common ancestor when
doing the plain-vanilla three-way merge, but with the leak fix, we
will use the first stage #1 entry.  But it does not change it in
any meaningful way---we are using only one of multiple stage #1
entries arbitrarily picked either way.

>  	}
> -	for (i = 0; i < 3; i++) {
> +	for (i = 0; i < 3; i++)
>  		if (!mmfile[i].ptr && !mmfile[i].size)
>  			mmfile[i].ptr = xstrdup("");
> -	}
> +
>  	/*
>  	 * NEEDSWORK: handle conflicts from merges with
>  	 * merge.renormalize set, too
