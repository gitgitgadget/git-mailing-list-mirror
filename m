From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 2/3] make USE_NSEC work as expected
Date: Fri, 20 Feb 2009 00:35:35 -0800
Message-ID: <7vab8hfqug.fsf@gitster.siamese.dyndns.org>
References: <cover.1235071656.git.barvik@broadpark.no>
 <24cefa55a62e2c898f9bd75ff7a6fe8e70836cf0.1235071656.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:37:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQsn-0006da-1k
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbZBTIfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbZBTIfn
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:35:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbZBTIfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:35:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 15B5A2B880;
	Fri, 20 Feb 2009 03:35:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3DB842B871; Fri,
 20 Feb 2009 03:35:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 74E2920E-FF29-11DD-8684-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110818>

Kjetil Barvik <barvik@broadpark.no> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 940ec76..ca4bec2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -67,8 +67,15 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>   */
>  void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>  {
> -	ce->ce_ctime = st->st_ctime;
> -	ce->ce_mtime = st->st_mtime;
> +	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
> +	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
> +#ifdef USE_NSEC
> +	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
> +	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
> +#else
> +	ce->ce_ctime.nsec = 0;
> +	ce->ce_mtime.nsec = 0;
> +#endif

How does this affect a use case where the same index file used with two 
instances of git (one compiled with and another without USE_NSEC)?

> @@ -232,8 +246,16 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
>  {
>  	return (!S_ISGITLINK(ce->ce_mode) &&
> -		istate->timestamp &&
> -		((unsigned int)istate->timestamp) <= ce->ce_mtime);
> +		istate->timestamp.sec &&
> +#ifdef USE_NSEC
> +		 /* nanosecond timestamped files can also be racy! */

Amusing ;-)

> diff --git a/unpack-trees.c b/unpack-trees.c
> index e547282..44714cc 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -380,8 +380,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  
>  	memset(&o->result, 0, sizeof(o->result));
>  	o->result.initialized = 1;
> -	if (o->src_index)
> -		o->result.timestamp = o->src_index->timestamp;
> +	if (o->src_index) {
> +		o->result.timestamp.sec = o->src_index->timestamp.sec;
> +#ifdef USE_NSEC
> +		o->result.timestamp.nsec = o->src_index->timestamp.nsec;
> +#endif
> +	}

Do we need this hunk?
