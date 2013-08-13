From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] contacts: reduce git-blame invocations
Date: Tue, 13 Aug 2013 14:10:47 -0700
Message-ID: <7veh9xwb3c.fsf@alter.siamese.dyndns.org>
References: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
	<1376084396-53617-4-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 23:11:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Lrl-0003Gs-6H
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 23:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab3HMVKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 17:10:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab3HMVKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 17:10:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D60C3858A;
	Tue, 13 Aug 2013 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ccK5blCl2WQQL2uz3BQ1HBOuGoo=; b=mOKJyv
	DyI0u/7YG66zK0XRNS/4KjAXy/lqQ77d8VeW6DW4Ixfif3Pl4DM+S7uxCqnivJ5W
	cV/1BlBEMufwyYgS7rXf3+058UIPqeoPmaX3OSplFMQSRAsWJhk5jY+TXDwcgwxy
	y90d1NaJRZVoPypQ/q9yxTG+GiZOhZYHlIW2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xp9VVTYmdO+fxlbderKYe9f2UwdM1TcX
	HtouLqfpi+o2wVuinsONr5+kTyJJKh23Ap9NiCOb3/iK3nO9TgR+5P507iDlKhH1
	dsf6iMWaUiS5GTUl/1126QbzuhquplmZxba7l5HYzPSV1imw2UWLoiyjms7TKHbS
	u6cGiB1Ow7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D31DE38588;
	Tue, 13 Aug 2013 21:10:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A3A538575;
	Tue, 13 Aug 2013 21:10:49 +0000 (UTC)
In-Reply-To: <1376084396-53617-4-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 9 Aug 2013 17:39:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D44B1CEC-045C-11E3-AEB0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232248>

Eric Sunshine <sunshine@sunshineco.com> writes:

> git-contacts invokes git-blame once for each patch hunk it encounters.
> No attempt is made to consolidate invocations for multiple hunks
> referencing the same file at the same revision. This can become
> expensive quickly.
>
> Reduce the number of git-blame invocations by taking advantage of the
> ability to specify multiple -L ranges for a single invocation.
>
> Without this patch, on a randomly chosen range of commits:
>
>   % time git-contacts 25fba78d36be6297^..23c339c0f262aad2 >/dev/null
>   real  0m6.142s
>   user  0m5.429s
>   sys   0m0.356s
>
> With this patch:
>
>   % time git-contacts 25fba78d36be6297^..23c339c0f262aad2 >/dev/null
>   real  0m2.285s
>   user  0m2.093s
>   sys   0m0.165s
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

Nice.  Will queue.


> ---
>  contrib/contacts/git-contacts | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> index b4d3526..fb6429b 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -59,9 +59,11 @@ sub import_commits {
>  }
>  
>  sub get_blame {
> -	my ($commits, $source, $start, $len, $from) = @_;
> +	my ($commits, $source, $from, $ranges) = @_;
> +	return unless @$ranges;
>  	open my $f, '-|',
> -		qw(git blame --porcelain -C), '-L', "$start,+$len",
> +		qw(git blame --porcelain -C),
> +		map({"-L$_->[0],+$_->[1]"} @$ranges),
>  		'--since', $since, "$from^", '--', $source or die;
>  	while (<$f>) {
>  		if (/^([0-9a-f]{40}) \d+ \d+ \d+$/) {
> @@ -78,10 +80,7 @@ sub blame_sources {
>  	my ($sources, $commits) = @_;
>  	for my $s (keys %$sources) {
>  		for my $id (keys %{$sources->{$s}}) {
> -			for my $range (@{$sources->{$s}{$id}}) {
> -				get_blame($commits, $s,
> -					  $range->[0], $range->[1], $id);
> -			}
> +			get_blame($commits, $s, $id, $sources->{$s}{$id});
>  		}
>  	}
>  }
