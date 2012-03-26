From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] gitweb: refactor If-Modified-Since handling
Date: Mon, 26 Mar 2012 10:12:36 -0700
Message-ID: <7v8vinqoaj.fsf@alter.siamese.dyndns.org>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <m3sjh2ay6j.fsf@localhost.localdomain>
 <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
 <20120326111203.GC2951@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:12:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDTJ-0006Rf-SY
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054Ab2CZRMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:12:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667Ab2CZRMj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:12:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1FDD67C1;
	Mon, 26 Mar 2012 13:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0tCuf1RBuwPPsdj/FZqWcUDXsfY=; b=IXwV0QsWxxpWitSxurCZ
	tJxMjIkHUw6Eh7yGE5ypzWRAlD5egQIrIbc2+bG8XE3Tg7/Ti7hPHdGzy58at/pm
	45yaPpN+42basL1Vvt5YbREzya8fpaYOkAPJstTOw7yNunpSIjmBl4VgkW5Ie8N7
	4kGtNqhpvTgss7I/3S3PHk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=B4ewuOmXfMsgUFecJBQc53U6DGTQ9YisqSVdmTZb/KVBfY
	BDUShCj4OBIRvmEshcFcLoCkLY0qPYEQfM6aaIKM+jPKssbfYLZ3pORL8kMvmBlW
	eyk6lHdpieyDjCie8U2dUhfR8cavpOabNNwaGSPDNBWdOMoHUxfSvT0LUFmw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5FA667C0;
	Mon, 26 Mar 2012 13:12:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11D2B67BF; Mon, 26 Mar 2012
 13:12:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E34084B4-7766-11E1-82DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193930>

"W. Trevor King" <wking@drexel.edu> writes:

> +sub die_if_unmodified {
> +	my ($latest_epoch) = @_;
> +	our $cgi;
> +
> +	my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> +	if (defined $if_modified) {
> +		my $since;
> +		if (eval { require HTTP::Date; 1; }) {
> +			$since = HTTP::Date::str2time($if_modified);
> +		} elsif (eval { require Time::ParseDate; 1; }) {
> +			$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> +		}
> +		if (defined $since && $latest_epoch <= $since) {
> +			my %latest_date = parse_date($latest_epoch);
> +			print $cgi->header(
> +				-last_modified => $latest_date{'rfc2822'},
> +				-status => '304 Not Modified');
> +			goto DONE_GITWEB;
> +		}
> +	}
> +}

>  sub git_snapshot {
>  	my $format = $input_params{'snapshot_format'};
>  	if (!@snapshot_fmts) {
> @@ -7820,24 +7842,8 @@ sub git_feed {
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
>  		my $latest_epoch = $latest_commit{'committer_epoch'};
> +		die_if_unmodified($latest_epoch);
>  		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});

It might make more sense to call the helper *after* stuffing %latest_date
and pass the $latest_date{'rfc2822'} as parameter to the new helper
function, so that the helper function do not have to call parse_date().

The verb "die" everywhere else in the codebase of Git not just means an
immediate exit, but means an imediate _error_ exit.  The new helper
function is not about failure, but merely is an early return.  Perhaps
rename it to exit_if_unmodified_since() or something?

> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 31076ed..0e49f29 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -92,7 +92,7 @@ test_debug 'cat gitweb.output'
>  test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
>  	echo object > tag-object &&
>  	git add tag-object &&
> -	git commit -m "Object to be tagged" &&
> +	test_tick && git commit -m "Object to be tagged" &&
>  	git tag tagged-object `git hash-object tag-object` &&
>  	gitweb_run "p=.git;a=snapshot;h=tagged-object;sf=tgz" &&
>  	grep "400 - Object is not a tree-ish" gitweb.output
> @@ -112,6 +112,31 @@ test_expect_success 'snapshots: bad object id' '
>  '
>  test_debug 'cat gitweb.output'
>  
> +# ----------------------------------------------------------------------
> +# modification times (Last-Modified and If-Modified-Since)
> +
> +test_expect_success 'modification: feed last-modified' '
> +	gitweb_run "p=.git;a=atom;h=master" &&
> +	grep "Status: 200 OK" gitweb.output

Missing " &&" at the end (same in 3/3).

> +	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: feed if-modified-since (modified)' '
> +	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	gitweb_run "p=.git;a=atom;h=master" &&
> +	unset HTTP_IF_MODIFIED_SINCE &&
> +	grep "Status: 200 OK" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'modification: feed if-modified-since (unmodified)' '
> +	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	gitweb_run "p=.git;a=atom;h=master" &&
> +	unset HTTP_IF_MODIFIED_SINCE &&
> +	grep "Status: 304 Not Modified" gitweb.output
> +'
> +test_debug 'cat gitweb.headers'

Other than that, the patch looks cleanly done.

Thanks.
