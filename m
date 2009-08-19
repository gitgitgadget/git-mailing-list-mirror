From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Tue, 18 Aug 2009 23:18:44 -0700
Message-ID: <7vhbw41g3f.fsf@alter.siamese.dyndns.org>
References: <1250628954.114121983@192.168.1.201>
 <20090818211812.GL8147@facebook.com>
 <7vk5103chi.fsf@alter.siamese.dyndns.org>
 <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Adam Simpkins <simpkins@facebook.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 08:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdeVu-0001lJ-Lh
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 08:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbZHSGS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 02:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbZHSGS5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 02:18:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZHSGS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 02:18:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 791192F225;
	Wed, 19 Aug 2009 02:18:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y5byzNtmKLrRfjQexB8t3xoTSEw=; b=fcjepT
	tqG5iFYf5xpwx0LIMa8x1wQV+bwO9N7upq1Y2NMZ0h82XuYUTqvtTlBooC7z1KVq
	UNrGeeTb9DWBlQLGrRrlhOWBkiMCll1F9yis/qD+p6lp50Us1cIvqgoHQcdre95c
	HaoLyZquzKQsPNhmIBcFMkLQhJIixyu6Zbr7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XlvADR8Ut6eheJkLXy1HmoW+vyxniHzq
	ycQBhRZ9MAfsjI9LLTupyzQzYOJdYxQXlGaYl52kk68wgpDtKtpk9nMLzG9wtGIe
	jhUZPRZhClx6Wpamtvpzm7dms8cRvJxZXYtxUGXWkwO6gepdgVyDLe2JFfjdb6ll
	4lX07/H2FSI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 499E92F224;
	Wed, 19 Aug 2009 02:18:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1ECD2F223; Wed, 19 Aug 2009
 02:18:45 -0400 (EDT)
In-Reply-To: <20090819023433.GP8147@facebook.com> (Adam Simpkins's message of
 "Tue\, 18 Aug 2009 19\:34\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 293616CC-8C88-11DE-86F8-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126506>

Adam Simpkins <simpkins@facebook.com> writes:

> -enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
> +enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit)
>  {
>  	if (commit->object.flags & SHOWN)
>  		return commit_ignore;
> @@ -1692,12 +1692,21 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>  			if (!commit->parents || !commit->parents->next)
>  				return commit_ignore;
>  		}
> -		if (want_ancestry(revs) && rewrite_parents(revs, commit) < 0)
> -			return commit_error;
>  	}
>  	return commit_show;
>  }
>  
> +enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
> +{
> +	enum commit_action action = get_commit_action(revs, commit);
> +
> +	if (action == commit_show && revs->prune && revs->dense && want_ancestry(revs)) {
> +		if (rewrite_parents(revs, commit) < 0)
> +			return commit_error;
> +	}
> +	return action;
> +}

When simplify_commit() logic (now called get_comit_action()) decides to
show this commit because revs->show_all was specified, we did not rewrite
its parents, but now we will?
