From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Thu, 15 Oct 2015 05:35:01 +0200
Message-ID: <561F1EE5.5070300@web.de>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmZK4-00077A-1q
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 05:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbbJODfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 23:35:13 -0400
Received: from mout.web.de ([212.227.17.11]:58135 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbbJODfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 23:35:12 -0400
Received: from [192.168.178.36] ([79.253.191.204]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MYO45-1a8NYb2XCL-00VAab; Thu, 15 Oct 2015 05:35:08
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
X-Provags-ID: V03:K0:J+NqOUBVXfglo/jTcsGMx8TL4W7+x+2ECphjcPingAy4NBy006q
 pSXF672tM9mai5vpWcGrXcIrS1IQKs1D98SR+oHQzd+PCJPUHUmbYwDa8EAW/UrebHNMIHO
 mgB5l6cxbnz0LAptagsrpMH30WbKyDAZlPU5Y4TMmfOVNIuDmKJ3MJMbu/c61WS4rVPqqzU
 HDBqqiB4OzKoV5eXxK7/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8zlXlSRyHNM=:LaI6A8SOLshYf6tczWZQYi
 K+x3NNvmImGeeg8VjFuIv/bzK+qDBIEyj9T2vUrveJlA4o8PSFXJvOnmBdexVdMOEn2ERUcON
 Pl3HlyaW694wrrVxG2e5Uwz9nZoJoQHS2CGkpbq8OkePoPK/TvvpNWnR4c5lgULX6014EuKAo
 bSx6TusLAqhtdbQ0NwqoBhZTZ1iCJZZdCVP8jx2kxltrmwvJA3cmjeKQrp9m7EcaUI72ek7Pz
 ZPjZ1sh/JwsFj2TeJjDBGFwzkBwISEBfrIAZ7c+6Pz6gFPCoPVHqMyd6xqNGsaia5ghgwHKbo
 iFi0Hmhv2E+bSOPN9LB+WvN0sUyAjbkOK0LF0AVvMW5hj6Yy0mmE2ivNXJtftSmJ7jqTq4nUY
 F1kr9QTZEUKMghSxj/ODRurllyqXL54TldDu1Gafz+ZQ0DPpdyJBZEPUZvy/HXvObprBfHWvO
 DDQBxMunL20ZFU4DcJBRHOoIfPgJtytrHDpyAGcihJTE7CeKX7EFcYWc5JmgPHbyARD9cNpVq
 dZcxpUt1bP1IyT3TJlhwvTMRg7uY/AuKyYzxQvdE01ulpxfsttvDrI8BNIKtAq/n61ztiavtQ
 qnI2zKG1YvE36geoPF9fV+FtTLRV3tPBvXge3k6+vRppGJj+wSQufb5xaublItZdb4HzkvN2l
 z4Kj8AY5oB4diYMDjfBeF2H0dyUVauKscrSPi79RS1U9FE793q+npnLTuMd1TjjEA9iJRkiif
 VOperRePipwDfSlmRZUjDRw+oW0hyB/22qFHuLs3DOZDBTnyw3m3dWyHKx6I3dWySV+T2UM1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279643>

Am 15.10.2015 um 00:07 schrieb David Turner:
> From: Keith McGuigan <kmcguigan@twitter.com>
>
> During merges, we would previously free entries that we no longer need
> in the destination index.  But those entries might also be stored in
> the dir_entry cache, and when a later call to add_to_index found them,
> they would be used after being freed.
>
> To prevent this, add a ref count for struct cache_entry.  Whenever
> a cache entry is added to a data structure, the ref count is incremented;
> when it is removed from the data structure, it is decremented.  When
> it hits zero, the cache_entry is freed.
>
> Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>
> Fix type of ref_count (from unsigned int to int).
>
>
>   cache.h        | 27 +++++++++++++++++++++++++++
>   name-hash.c    |  7 ++++++-
>   read-cache.c   |  6 +++++-
>   split-index.c  | 13 ++++++++-----
>   unpack-trees.c |  6 ++++--
>   5 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 752031e..7906026 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -149,6 +149,7 @@ struct stat_data {
>
>   struct cache_entry {
>   	struct hashmap_entry ent;
> +	int ref_count; /* count the number of refs to this in dir_hash */
>   	struct stat_data ce_stat_data;
>   	unsigned int ce_mode;
>   	unsigned int ce_flags;
> @@ -213,6 +214,32 @@ struct cache_entry {
>   struct pathspec;
>
>   /*
> + * Increment the cache_entry reference count.  Should be called
> + * whenever a pointer to a cache_entry is retained in a data structure,
> + * thus marking it as alive.
> + */
> +static inline void add_ce_ref(struct cache_entry *ce)
> +{
> +	assert(ce != NULL && ce->ref_count >= 0);
> +	ce->ref_count++;
> +}
> +
> +/*
> + * Decrement the cache_entry reference count.  Should be called whenever
> + * a pointer to a cache_entry is dropped.  Once the counter drops to 0
> + * the cache_entry memory will be safely freed.
> + */
> +static inline void drop_ce_ref(struct cache_entry *ce)
> +{
> +	if (ce != NULL) {
> +		assert(ce->ref_count >= 0);

Shouldn't this be "> 0" to prevent double frees?

> +		if (--ce->ref_count < 1) {
> +			free(ce);
> +		}
> +	}
> +}
