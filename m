From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/8] name-hash: allow dir hashing even when !ignore_case
Date: Tue, 09 Sep 2014 10:49:44 -0700
Message-ID: <xmqq8ulslm4n.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<4d43fca586637dcb02b2b19c8d8a6dcfe368e059.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:49:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRPYD-00081c-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 19:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbaIIRts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 13:49:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61367 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbaIIRtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 13:49:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E76E03827F;
	Tue,  9 Sep 2014 13:49:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lwgn4FC2T7US42A1m6tVP+XXmEg=; b=sSl5Ky
	hYLUo77usEL63O3uTM2mQkvlBt0VkFzyG6HjWjcQllx6X8thsI7UyCOsEaAPbGC5
	TQpcsGURkYjBmorQ1Ccl+KGYmWxtwB5soaeW6IZBGgB416IsNai1kXQqfBV54Em7
	+FDSMlQ801uMuw9qWdAt1nMEyHjLIAHejiwVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2UrvpttUlc9bpOqitnGT2egvfV/34ki
	c4J16Tcsg50jBYOnbzYD1AzjXAtfBpmzpbTCn4xYhqXju8jLwxMs3VVkqS/6Oi4K
	PUmmVpbMwGIy8YU3CCPRhfaNf1omcGb86DyC8DIhaBOQrKl1yEH5DVXvCS9+s4DM
	ig85pfWKD3I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEB9D3827E;
	Tue,  9 Sep 2014 13:49:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E27B3827D;
	Tue,  9 Sep 2014 13:49:46 -0400 (EDT)
In-Reply-To: <4d43fca586637dcb02b2b19c8d8a6dcfe368e059.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AFF77C06-3849-11E4-A4E5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256698>

Thomas Rast <tr@thomasrast.ch> writes:

> The directory hash (for fast checks if the index already has a
> directory) was only used in ignore_case mode and so depended on that
> flag.
>
> Make it generally available on request.
>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
>  cache.h     |  2 ++
>  name-hash.c | 13 ++++++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 4d5b76c..c54b2e1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -306,6 +306,7 @@ struct index_state {
>  	struct split_index *split_index;
>  	struct cache_time timestamp;
>  	unsigned name_hash_initialized : 1,
> +		 has_dir_hash : 1,
>  		 initialized : 1;
>  	struct hashmap name_hash;
>  	struct hashmap dir_hash;
> @@ -315,6 +316,7 @@ struct index_state {
>  extern struct index_state the_index;
>  
>  /* Name hashing */
> +extern void init_name_hash(struct index_state *istate, int force_dir_hash);
>  extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
>  extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
>  extern void free_name_hash(struct index_state *istate);
> diff --git a/name-hash.c b/name-hash.c
> index 702cd05..22e3ec6 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -106,7 +106,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>  	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
>  	hashmap_add(&istate->name_hash, ce);
>  
> -	if (ignore_case)
> +	if (istate->has_dir_hash)
>  		add_dir_entry(istate, ce);

This smells more like needs_dir_hash than has_dir_hash to me.  For
ignore-case, we need dir_hash to make sure we do not end up adding
two entries that cannot be represented on the filesystem.
