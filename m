From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Sort projects with undefined ages last
Date: Tue, 11 Dec 2012 10:08:29 -0800
Message-ID: <7vhans8ns2.fsf@alter.siamese.dyndns.org>
References: <7vip8actz3.fsf@alter.siamese.dyndns.org>
 <1355223367-5894-1-git-send-email-mattjd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Daley <mattjd@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiUGD-0007aR-GO
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 19:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2LKSIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 13:08:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab2LKSId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 13:08:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D228A68D;
	Tue, 11 Dec 2012 13:08:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jSWjF8Nz5BcUKHdqhAnYZcoagOU=; b=ZhWQaT
	L3JXJQJDqvsY3PEkefyC0Iiwgj8JbDrrJ9d3tMxH/eKK3V2bBTV8OhUEzDsZGTt3
	ZF4QNbjUClxporcZH15sFAVPhogCrgzDmGxrLqjRie74ctfRvwn0aC0oZvox8BvN
	3G16a9XPOT9tx1jDquZZ2UKAkmUhKWCnfVZqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btZcw69BS9MKgmTwa0PrYvuqTyqcNRis
	XW86/vZC880osXgsyXSqHKH+QSPKDrtfSvLxgvNPpDhgYslde0NQxpcgulmm/koV
	BxuQrJBj62Su89t2ci4X+ujfn6gzvS0i4fpn1As3cr6plZRyOVDS48fVvYjwIZIa
	apyOUfemoeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 719A8A68B;
	Tue, 11 Dec 2012 13:08:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7EE6A68A; Tue, 11 Dec 2012
 13:08:31 -0500 (EST)
In-Reply-To: <1355223367-5894-1-git-send-email-mattjd@gmail.com> (Matthew
 Daley's message of "Tue, 11 Dec 2012 23:56:07 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C599CF8C-43BD-11E2-B125-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211291>

Matthew Daley <mattjd@gmail.com> writes:

> I thought about both of those variants as well. What about this:
>
> -- >8 --
> Subject: [PATCH] gitweb: Sort projects with undefined ages last
>
> Sorting gitweb's project list by age ('Last Change') currently shows
> projects with undefined ages at the head of the list. This gives a less
> useful result when there are a number of projects that are missing or
> otherwise faulty and one is trying to see what projects have been
> updated recently.
>
> Fix by sorting these projects with undefined ages at the bottom of the
> list when sorting by age.
>
> Signed-off-by: Matthew Daley <mattjd@gmail.com>
> ---

Looks sensible to me.  Thanks; will queue.

>  gitweb/gitweb.perl |   35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0f207f2..656b324 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5528,23 +5528,30 @@ sub fill_project_list_info {
>  
>  sub sort_projects_list {
>  	my ($projlist, $order) = @_;
> -	my @projects;
>  
> -	my %order_info = (
> -		project => { key => 'path', type => 'str' },
> -		descr => { key => 'descr_long', type => 'str' },
> -		owner => { key => 'owner', type => 'str' },
> -		age => { key => 'age', type => 'num' }
> -	);
> -	my $oi = $order_info{$order};
> -	return @$projlist unless defined $oi;
> -	if ($oi->{'type'} eq 'str') {
> -		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projlist;
> -	} else {
> -		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projlist;
> +	sub order_str {
> +		my $key = shift;
> +		return sub { $a->{$key} cmp $b->{$key} };
>  	}
>  
> -	return @projects;
> +	sub order_num_then_undef {
> +		my $key = shift;
> +		return sub {
> +			defined $a->{$key} ?
> +				(defined $b->{$key} ? $a->{$key} <=> $b->{$key} : -1) :
> +				(defined $b->{$key} ? 1 : 0)
> +		};
> +	}
> +
> +	my %orderings = (
> +		project => order_str('path'),
> +		descr => order_str('descr_long'),
> +		owner => order_str('owner'),
> +		age => order_num_then_undef('age'),
> +	);
> +
> +	my $ordering = $orderings{$order};
> +	return defined $ordering ? sort $ordering @$projlist : @$projlist;
>  }
>  
>  # returns a hash of categories, containing the list of project
