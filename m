From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] rerere: fix overeager gc
Date: Wed, 14 Jul 2010 20:33:17 +0200
Message-ID: <20100714183317.GI15270@neumann>
References: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
	<1278978124-3035-2-git-send-email-szeder@ira.uka.de>
	<7v630k6wpg.fsf@alter.siamese.dyndns.org>
	<20100714121925.GG15270@neumann>
	<7v1vb6yqve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 20:36:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ6oS-0000rS-OA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 20:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab0GNSf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 14:35:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60329 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab0GNSfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 14:35:55 -0400
Received: from [127.0.1.1] (p5B130AB3.dip0.t-ipconnect.de [91.19.10.179])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MJ0Dl-1OXC1U3fUv-002eui; Wed, 14 Jul 2010 20:33:18 +0200
Content-Disposition: inline
In-Reply-To: <7v1vb6yqve.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:PnoLRF+m2Uy7KwScIeb9xvzr7Q/nTOvLPwcFJQtazeg
 xOQG39CWMlu5oqIQJe8yv3CancCXEl07YbJ2zfUlN9Q2EqEdtt
 kzf8kop6Et+uXsyQgk+CNicmQbubp6QDe0ORd4QPEOFMjkhTVG
 fhxD9mIWqKjDm7Kx2f/vcstNQ5Mvjzo2gZBFxEFkGSwHs8GrL8
 6MUq3TH/lNwUOghWHvQog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151026>

On Wed, Jul 14, 2010 at 09:23:17AM -0700, Junio C Hamano wrote:
> I wonder if swapping the order of things to check may make it easier to
> read, though.  If it was used, we want to compare gc.rerereresolved with
> that timestamp, and otherwise we want to compare gc.rerereunresolved with
> the timestamp of the creation.  I.e. something like this...

That's even better.


>  builtin/rerere.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/rerere.c b/builtin/rerere.c
> index 7e45afe..6d1b580 100644
> --- a/builtin/rerere.c
> +++ b/builtin/rerere.c
> @@ -59,16 +59,16 @@ static void garbage_collect(struct string_list *rr)
>  	while ((e = readdir(dir))) {
>  		if (is_dot_or_dotdot(e->d_name))
>  			continue;
> -		then = rerere_created_at(e->d_name);
> -		if (!then)
> -			continue;
> -		if (has_rerere_resolution(e->d_name)) {
> -			then = rerere_last_used_at(e->d_name);
> +
> +		then = rerere_last_used_at(e->d_name);
> +		if (then) {
> +			cutoff = cutoff_resolve;
> +		} else {
> +			then = rerere_created_at(e->d_name);
>  			if (!then)
>  				continue;
> -			cutoff = cutoff_resolve;
> -		} else
>  			cutoff = cutoff_noresolve;
> +		}
>  		if (then < now - cutoff * 86400)
>  			string_list_append(e->d_name, &to_remove);
>  	}
> 
> 
