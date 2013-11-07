From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 14/14] read-cache.c: fix memory leaks caused by removed cache entries
Date: Thu, 07 Nov 2013 13:40:48 -0800
Message-ID: <xmqqppqbq49r.fsf@gitster.dls.corp.google.com>
References: <527BA483.6040803@gmail.com> <527BA76D.20101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 22:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXJv-00046F-OD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 22:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab3KGVkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 16:40:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab3KGVku (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 16:40:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36BE750656;
	Thu,  7 Nov 2013 16:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=UA2Zhek7/BTBjf/F+eTz45tFbgM=; b=erVsdS6fgIbAZ0EFmApy
	3Zs24ngV0xrmuFkV90NcjuKLpqvwvIK/Uu20u23/x18K1WLv0Y3hboz7gSF3qEXO
	vbAdcbj0xxDHJj/JQe3/mPaGj1IynhPeSSUs37l/k8tFRPBcIpBxFmd64qmswoIg
	NeDiWcGegWjJardcVXAyA7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xis6MxRQmjt0SLJa25vrJNCWQS3FFSUDgZceX4admyAlbv
	JxjV/VU7F4dYaP2Jbusxyuxzxa5IJcbu0hH3mIfop73SeRdhvtNFxscjzy0+QwyP
	ivTju0R8Ih1iuZUn9XukABzu58nPWBYRYDtY7d5yp7ljmBYvcP4b0VR41xNH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2550E50655;
	Thu,  7 Nov 2013 16:40:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5170C50654;
	Thu,  7 Nov 2013 16:40:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4485AD2A-47F5-11E3-84D6-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237432>

Karsten Blees <karsten.blees@gmail.com> writes:

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index b654d27..acd992d 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -559,6 +559,7 @@ static int do_reupdate(int ac, const char **av,
>  		const struct cache_entry *ce = active_cache[pos];
>  		struct cache_entry *old = NULL;
>  		int save_nr;
> +		const char *path;
>  
>  		if (ce_stage(ce) || !ce_path_match(ce, &pathspec))
>  			continue;
> @@ -575,7 +576,9 @@ static int do_reupdate(int ac, const char **av,
>  		 * or worse yet 'allow_replace', active_nr may decrease.
>  		 */
>  		save_nr = active_nr;
> -		update_one(ce->name);
> +		path = xstrdup(ce->name);
> +		update_one(path);
> +		free(path);
>  		if (save_nr != active_nr)
>  			goto redo;
>  	}

This also gets complaint from free() that does not want to free a
const pointer.  I'll fix it up locally to get it compile before
queuing it to 'pu'.

Thanks.
