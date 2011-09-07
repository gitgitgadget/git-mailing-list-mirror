From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH v2 1/5] sha1_file cleanup: remove redundant variable check
Date: Wed, 7 Sep 2011 18:24:46 +0800
Message-ID: <4E67466E.9060100@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com> <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com> <7vaaaha9p2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:29:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Lvu-0001be-0c
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1IGR3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:29:00 -0400
Received: from mail.windriver.com ([147.11.1.11]:63192 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab1IGR26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:28:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p87AOVT8003889
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 7 Sep 2011 03:24:31 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 7 Sep
 2011 03:24:31 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vaaaha9p2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180879>

Junio C Hamano wrote:
> Wang Hui <Hui.Wang@windriver.com> writes:
>
>   
>> From: Hui Wang <Hui.Wang@windriver.com>
>>
>> This variable check is always true, so it is redundant and need to be
>> removed.
>>
>> We can't remove the init value for this variable, since removing
>> it will introduce building warning:
>> 'base_len' may be used uninitialized in this function.
>>     
>
> If we are into cleaning things up, we should instead notice and say "yuck"
> to the repeated "is entry is absolute and relative base is given" check.
>
> Wouldn't something like this makes things easier to follow and also avoids
> the "when does the path normalized and made absolute" issue?
>
> Completely untested and I may have off-by-one errors and such, but I think
> you would get the idea...
>
>   
Yes, i got the idea, and some errors are pointed out below. I will 
prepare a V3 patch basing on it.
>  sha1_file.c |   29 ++++++++++++-----------------
>  1 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index e002056..26aa3be 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -248,27 +248,22 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
>  	const char *objdir = get_object_directory();
>  	struct alternate_object_database *ent;
>  	struct alternate_object_database *alt;
> -	/* 43 = 40-byte + 2 '/' + terminating NUL */
> -	int pfxlen = len;
> -	int entlen = pfxlen + 43;
> -	int base_len = -1;
> +	int pfxlen, entlen;
> +	struct strbuf pathbuf = STRBUF_INIT;
>  
>  	if (!is_absolute_path(entry) && relative_base) {
> -		/* Relative alt-odb */
> -		if (base_len < 0)
> -			base_len = strlen(relative_base) + 1;
> -		entlen += base_len;
> -		pfxlen += base_len;
> +		strbuf_addstr(&pathbuf, relative_base);
>   
s/relative_base/real_path(relative_base)/ is better, since 
normalize_path_copy is not good at handle relative path. e.g. ". 
./objects/../../test2/objects" will be normalized to "objects"
> +		strbuf_addch(&pathbuf, '/');
>  	}
> -	ent = xmalloc(sizeof(*ent) + entlen);
> +	strbuf_add(&pathbuf, entry, len);
> +	normalize_path_copy(pathbuf.buf, pathbuf.buf);
>   
if pathbuf.buf[strlen(pathbuf.buf)] is '/', remove it. this can avoid to 
get a wrong result when comparing "/a/b" with "/a/b/".
> +	strbuf_setlen(&pathbuf, strlen(pathbuf.buf));
>   
above line can be removed, since we will release pathbuf soon.

>  
> -	if (!is_absolute_path(entry) && relative_base) {
> -		memcpy(ent->base, relative_base, base_len - 1);
> -		ent->base[base_len - 1] = '/';
> -		memcpy(ent->base + base_len, entry, len);
> -	}
> -	else
> -		memcpy(ent->base, entry, pfxlen);
> +	pfxlen = pathbuf.len;
> +	entlen = pfxlen + 43; /* '/' + 2 hex + '/' + 38 hex + NUL */
> +	ent = xmalloc(sizeof(*ent) + entlen);
> +	memcpy(ent->base, pathbuf.buf, pfxlen);
> +	strbuf_release(&pathbuf);
>  
>  	ent->name = ent->base + pfxlen + 1;
>  	ent->base[pfxlen + 3] = '/';
>
>   
