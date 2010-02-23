From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add-interactive: fix bogus diff header line ordering
Date: Mon, 22 Feb 2010 17:50:48 -0800
Message-ID: <7v7hq4n2iv.fsf@alter.siamese.dyndns.org>
References: <20100222103256.GA10557@coredump.intra.peff.net>
 <7vbpfg6h80.fsf@alter.siamese.dyndns.org>
 <20100223005645.GB3254@coredump.intra.peff.net>
 <20100223010544.GC3254@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 02:51:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjjvX-0001wS-CT
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 02:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0BWBvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 20:51:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0BWBu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 20:50:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5F39CB52;
	Mon, 22 Feb 2010 20:50:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EzeBrzl302jOdQKDwFksV+4OzxM=; b=j0V6iu
	l9ehsPv9ILsJ+a3FTuaUqoAyYhPkWSNjyhd5AlTNFsByM0ur78YhMR10dsyR2+q0
	P8y4ZtD9EQTXrnzdFlXhJ+GqVnXZRG4MBoe+lG81Ez0pYDpziHk98qeBHzcEbcXk
	Zrq1mXk+TAQsYR9MAuM7DG13W/xjrQoPNUuoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKgMpayND9AQJFMMJh/kvdCzK2Uv+kUT
	Lz3et13hyyfHXyAJuQDKW3qek7JiQIYjA0wJtKcCi4zyCc3XjnZ63IHhXYyKajVa
	gAPZgBqV+Yj6eVFt9UCCpUbrqDiwbsepJQk2TtU3/YR5nsSSWNCMwxhgporX2Mqm
	CCMpGqLPdRU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B499CB51;
	Mon, 22 Feb 2010 20:50:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B28069CB50; Mon, 22 Feb
 2010 20:50:50 -0500 (EST)
In-Reply-To: <20100223010544.GC3254@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 22 Feb 2010 20\:05\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1F14F96-201D-11DF-967F-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140763>

Jeff King <peff@peff.net> writes:

>> ...  Hmm. I am not sure we would even need to treat hunks
>> individually...the misplaced header lines should always be part of the
>> _first_ hunk.
>
> Like this.

Looks much better ;-).  Thanks.

>
>  git-add--interactive.perl |   24 +++++++++++++++++++++++-
>  t/t2016-checkout-patch.sh |    8 ++++++++
>  2 files changed, 31 insertions(+), 1 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index cd43c34..21f1330 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -957,6 +957,28 @@ sub coalesce_overlapping_hunks {
>  	return @out;
>  }
>  
> +sub reassemble_patch {
> +	my $head = shift;
> +	my @patch;
> +
> +	# Include everything in the header except the beginning of the diff.
> +	push @patch, (grep { !/^[-+]{3}/ } @$head);
> +
> +	# Then include any headers from the hunk lines, which must
> +	# come before any actual hunk.
> +	while (@_ && $_[0] !~ /^@/) {
> +		push @patch, shift;
> +	}
> +
> +	# Then begin the diff.
> +	push @patch, grep { /^[-+]{3}/ } @$head;
> +
> +	# And then the actual hunks.
> +	push @patch, @_;
> +
> +	return @patch;
> +}
> +
>  sub color_diff {
>  	return map {
>  		colored((/^@/  ? $fraginfo_color :
> @@ -1453,7 +1475,7 @@ sub patch_update_file {
>  
>  	if (@result) {
>  		my $fh;
> -		my @patch = (@{$head->{TEXT}}, @result);
> +		my @patch = reassemble_patch($head->{TEXT}, @result);
>  		my $apply_routine = $patch_mode_flavour{APPLY};
>  		&$apply_routine(@patch);
>  		refresh();
> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index 4d1c2e9..2144184 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -66,6 +66,14 @@ test_expect_success 'git checkout -p HEAD^' '
>  	verify_state dir/foo parent parent
>  '
>  
> +test_expect_success 'git checkout -p handles deletion' '
> +	set_state dir/foo work index &&
> +	rm dir/foo &&
> +	(echo n; echo y) | git checkout -p &&
> +	verify_saved_state bar &&
> +	verify_state dir/foo index index
> +'
> +
>  # The idea in the rest is that bar sorts first, so we always say 'y'
>  # first and if the path limiter fails it'll apply to bar instead of
>  # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
> -- 
> 1.7.0.207.g88f1
