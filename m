From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 08:15:48 -0800
Message-ID: <7vvca6u47f.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lBv-000672-La
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3BEQPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:15:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351Ab3BEQPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:15:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5B5B48E;
	Tue,  5 Feb 2013 11:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EGVFF1VkDXdERwDLV++PTBle6u8=; b=J3O2Ge
	TKRkYfIXySPdCH92QHQ+CdaKMUd1uQYrgZIosDmIjDVc9PzPQ6fkkwjWAx+MacLG
	bf8Kqdd2OYiUEF3wXjrEAej2l7l7PrNpKps3GGbCixH/Iu+tBcVFgVrLwL9JIlsH
	dtndeoRghNvH7SrnHiTYdiLfSDfK8ZO/mQBco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKwIiDGoX67COHDlQ3kiTF8G08V9pzWg
	+iPRVd7nLsb8YVeKSrOOOD1zmWL4Bj9vp9fpjaKlzol9cuSFB83N6CeeAoMu1bk+
	xmWOt0uGmyk0gxx2Jtr3KXJ+nNHgZZnIOHLi9zAhjpJYtC4o72DQExd53X6rzBlh
	ucnG0L+epB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B18B48D;
	Tue,  5 Feb 2013 11:15:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56C25B48B; Tue,  5 Feb 2013
 11:15:50 -0500 (EST)
In-Reply-To: <87mwvjsqjc.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Mon, 04 Feb 2013 16:44:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EA069D6-6FAF-11E2-B77D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215513>

Ted Zlatanov <tzz@lifelogs.com> writes:

> +# build reverse token map
> +my %rmap;
> +foreach my $k (keys %{$options{tmap}}) {
> +	push @{$rmap{$options{tmap}->{$k}}}, $k;
> +}

Mental note: "$rmap{foo} -eq 'bar'" means that what Git calls 'bar'
is found as 'foo' in the netrc/authinfo file.  Keys in %rmap are
what we expect to read from the netrc/authinfo file.

> +# there are CPAN modules to do this better, but we want to avoid
> +# dependencies and generally, complex netrc-style files are rare
> +
> +if ($debug) {
> +	printf STDERR "searching for %s = %s\n", $_, $q{$_} || '(any value)'
> +		foreach sort keys %q;
> +}
> +
> +LINE: foreach my $line (@data) {
> +
> +	print STDERR "line [$line]\n" if $debug;
> +	my @tok;
> +	# gratefully stolen from Net::Netrc
> +	while (length $line &&
> +	       $line =~ s/^("((?:[^"]+|\\.)*)"|((?:[^\\\s]+|\\.)*))\s*//) {
> +		(my $tok = $+) =~ s/\\(.)/$1/g;
> +		push(@tok, $tok);
> +	}
> +
> +	# skip blank lines, comments, etc.
> +	next LINE unless scalar @tok;
> +
> +	my %tokens;
> +	my $num_port;
> +	while (@tok) {
> +		my ($k, $v) = (shift @tok, shift @tok);
> +		next unless defined $v;
> +		next unless exists $options{tmap}->{$k};
> +		$tokens{$options{tmap}->{$k}} = $v;
> +		$num_port = $v if $k eq 'port' && $v =~ m/^\d+$/;
> +	}

So you grabbed one line of input, split them into token pairs, and
built %tokens = ('key Git may want to see' => 'value read from file')
mapping.

> +	# for "host X port Y" where Y is an integer (captured by
> +	# $num_port above), set the host to "X:Y"
> +	$tokens{host} = join(':', $tokens{host}, $num_port)
> +		if defined $tokens{host} && defined $num_port;

What happens when 'host' does not exist?  netrc/authinfo should be a
stream of SP/HT/LF delimited tokens and 'machine' token (or
'default') begins a new entry, so it would mean the input file is
corrupt if we do not have $tokens{host} when we get here, I think.

Oh, another thing. 'default' is like 'machine' followed by any
machine name, so the above while loop that reads two tokens
pair-wise needs to be aware that 'default' is not followed by a
value.  I think the loop will fail to parse this:

        default       login anonymous    password me@home
        machine k.org login me           password mysecret

> +	foreach my $check (sort keys %q) {

Hmph, aren't you checking what you read a bit too early?  This is a
valid input:

        default       
                login anonymous
                password me@home
        machine k.org
                login me
                password mysecret

but does this loop gives mysecret back to me when asked for
host=k.org and user=me? 

> +		if (exists $tokens{$check} && defined $q{$check}) {
> +			print STDERR "comparing [$tokens{$check}] to [$q{$check}] in line [$line]\n" if $debug;
> +			next LINE unless $tokens{$check} eq $q{$check};
> +		}
> +		else {
> +			print STDERR "we could not find [$check] but it's OK\n" if $debug;
> +		}
> +	}

I would probably structure this part like this:

	%pending = ();
        split the whole input into tokens, regardless of lines;
        iterate over the tokens {
		peek the token
		if (it is not "default") {
			take (token, value) pair;
		} else {
			take "default" as token; value does not matter.
		}
                if (token is "default" or "machine") {
			# finished reading one entry and we are
                        # at the beginning of the next entry.
                        # see if this entry matches
			if (%pending is not empty &&
                            %pending matches %q) {
				found a match; use %pending;
			}
                        # done with that entry. now start a new one.
                        %pending = ();
		}
		$pending{token} = value;
	}
