From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Mar 2015 18:19:10 +0100
Message-ID: <20150316171909.GA8618@hank>
References: <20150316142026.GJ7847@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:19:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXYfm-0003bB-DH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 18:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbbCPRTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 13:19:15 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:35226 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbbCPRTN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 13:19:13 -0400
Received: by webcq43 with SMTP id cq43so43317246web.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R4xcUTs9ijfoKflk7HxbpxZrla5H2BU2w4pMjYJUfUU=;
        b=KfK+AhcZYk+A4crP6rJXXpaPmIepBo+/KQCJO2Wn00cLvhEMEeZs0I5KKDVvkmX7eH
         hgJ/hNoyqbrKwaAazmswoG+2vSBdNLzItSWaoSnKNJPg4ZhddyBFvYr+M4b/PunaqzUQ
         KvlZV+3hCYwBN81EBMpQaQYS3kl8A0d2fU/TbVnec7IsadqR7cNTpB5feFRDXBVcJA8/
         tbHuoX0hZC6xxR20ix4Nn3Z04qwVyQxxy5mSJwt/oJy/EY73ooozqMhweFuly55zdpMd
         bgOvdGrGVLO0U1kBoRm2MH0OHUZIvtI4dM4dqSdI0zZCgSLBbI4i53dvMOxJ7EaXGj7c
         5VYA==
X-Received: by 10.180.76.4 with SMTP id g4mr166234855wiw.43.1426526352000;
        Mon, 16 Mar 2015 10:19:12 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id gj16sm16187490wic.24.2015.03.16.10.19.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2015 10:19:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150316142026.GJ7847@inner.h.apk.li>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265578>

Hi,

On 03/16, Andreas Krey wrote:
> get_ref_cache used a linear list, which obviously is O(n^2).
> Use a fixed bucket hash which just takes a factor of 100000
> (~ 317^2) out of the n^2 - which is enough.
>
> Signed-off-by: Andreas Krey <a.krey@gmx.de>
> ---
>
> This brings 'git clean -ndx' times down from 17 minutes
> to 11 seconds on one of our workspaces (which accumulated
> a lot of ignored directories). Actuallly using adaptive
> hashing or other structures seems overkill.
>
>  refs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index e23542b..8198d9e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -982,6 +982,8 @@ struct packed_ref_cache {
>  	struct stat_validity validity;
>  };
>
> +#define REF_CACHE_HASH 317
> +
>  /*
>   * Future: need to be in "struct repository"
>   * when doing a full libification.
> @@ -996,7 +998,7 @@ static struct ref_cache {
>  	 * is initialized correctly.
>  	 */
>  	char name[1];
> -} ref_cache, *submodule_ref_caches;
> +} ref_cache, *submodule_ref_caches[REF_CACHE_HASH];
>
>  /* Lock used for the main packed-refs file: */
>  static struct lock_file packlock;
> @@ -1065,18 +1067,19 @@ static struct ref_cache *create_ref_cache(const char *submodule)
>   */
>  static struct ref_cache *get_ref_cache(const char *submodule)
>  {
> -	struct ref_cache *refs;
> +	struct ref_cache *refs, **bucketp;
> +	bucketp = submodule_ref_caches + strhash(submodule) % REF_CACHE_HASH;
>

This breaks the test-suite for me, in the cases where submodule is
NULL.  How about something like this on top?

diff --git a/refs.c b/refs.c
index 8198d9e..311faf2 100644
--- a/refs.c
+++ b/refs.c
@@ -1068,7 +1068,9 @@ static struct ref_cache *create_ref_cache(const char *submodule)
 static struct ref_cache *get_ref_cache(const char *submodule)
 {
        struct ref_cache *refs, **bucketp;
-       bucketp = submodule_ref_caches + strhash(submodule) % REF_CACHE_HASH;
+       bucketp = submodule_ref_caches;
+       if (submodule)
+               bucketp += strhash(submodule) % REF_CACHE_HASH;

        if (!submodule || !*submodule)
                return &ref_cache;

>  	if (!submodule || !*submodule)
>  		return &ref_cache;
>
> -	for (refs = submodule_ref_caches; refs; refs = refs->next)
> +	for (refs = *bucketp; refs; refs = refs->next)
>  		if (!strcmp(submodule, refs->name))
>  			return refs;
>
>  	refs = create_ref_cache(submodule);
> -	refs->next = submodule_ref_caches;
> -	submodule_ref_caches = refs;
> +	refs->next = *bucketp;
> +	*bucketp = refs;
>  	return refs;
>  }
>
> --
> 2.3.2.223.g7a9409c
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
