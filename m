From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: gpg signature status indication for commits
Date: Fri, 28 Mar 2014 10:47:06 -0700
Message-ID: <xmqqfvm2b4h1.fsf@gitster.dls.corp.google.com>
References: <1396000130-10322-1-git-send-email-v.kartashov@npo-echelon.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org,
	Victor Kartashov <victor.kartashov@gmail.com>
To: Victor Kartashov <v.kartashov@npo-echelon.ru>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTas8-0006x2-Pi
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbaC1RrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:47:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbaC1RrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:47:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E2278BCE;
	Fri, 28 Mar 2014 13:47:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fhULKblWF0hwU0mgEpNc4TWdPsU=; b=wQwFtH
	u1Ulz/4+IVsNRBfqOCcIE7hvb6HslTEUhYps2ZIrWJJ5AGAKFyUVwYpWlBFZIOoB
	iS0w9hVmNvtVEcnqx2LPFPz0A1xUG3b/0ILK+4zUFBRY0blOlZvocSGnVzSMoPxk
	N7KJKV/UgRS8iVCdPIWyKmtVwpeH+qIM0/mrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DcSnoaZm0lDQJK43QuCGkWvs0ho/mpVU
	piDgzZqsLESC2cUmR9WcCqjGTNq6wRFwDtnhwAJePbDsJ0TpMppSE1dahaiksccw
	HrWHG4158fmgeNw+Wspb++nXhM26PnHddKDoPp4CKxyoSEMf7D7iHNueY7b6ieRf
	BO5Dr+MYF6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7038378BCD;
	Fri, 28 Mar 2014 13:47:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D54578BCB;
	Fri, 28 Mar 2014 13:47:07 -0400 (EDT)
In-Reply-To: <1396000130-10322-1-git-send-email-v.kartashov@npo-echelon.ru>
	(Victor Kartashov's message of "Fri, 28 Mar 2014 13:48:50 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB1C9BC4-B6A0-11E3-A163-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245405>

Victor Kartashov <v.kartashov@npo-echelon.ru> writes:

> show gpg signature (if any) for commit message in gitweb
> in case of valid signature highlight it with green
> in case of invalid signature highlight it with red

If that is a single sentence, please write it as such:

   Show gpg signature (if any) for commit message in gitweb in case of
   valid signature highlight it with green in case of invalid signature
   highlight it with red.

But that is almost unparsable ;-)

   Teach gitweb to show GPG signature verification status when
   showing a commit that is signed.  Highlight in green or red to
   differentiate valid and invalid signatures.

or something?

Is it a good idea to do this unconditionally in all repositories?

> Signed-off-by: Victor Kartashov <victor.kartashov@gmail.com>
> ---
>  gitweb/gitweb.perl       | 36 +++++++++++++++++++++++++++++-------
>  gitweb/static/gitweb.css | 11 +++++++++++
>  2 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 79057b7..ccde90f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3430,8 +3430,9 @@ sub parse_commit_text {
>  	my ($commit_text, $withparents) = @_;
>  	my @commit_lines = split '\n', $commit_text;
>  	my %co;
> +	my @signature = ();
>  
> -	pop @commit_lines; # Remove '\0'
> +	pop @commit_lines if ($commit_lines[-1] =~ "\0"); # Remove '\0'

This comment, which only says what it intends to do without saying
why it wants to do so, does not explain why this is a good change.

Does the code even know if $commit_lines[-1] is a non-empty string?
Is it safe to assume if $commit_lines[-1] has a NUL anywhere, it is
always the last line that ends the record, which is not part of the
commit log message?

I am assuming that this $commit_text is read from "log -z" (or
"rev-list -z") output and split at NUL boundary, but if that is the
case, it might be cleaner to remove the trailing NUL from $commit_text
before even attempting to split it into an array at LFs, but that is
an unrelated tangent.

A bigger question is why does the incoming data sometimes ends with
NUL that must be stripped out, and sometimes does not?  I see that
you are updating the data producer in the later part of the patch;
wouldn't it be saner if you have the data producer produce the input
to this function in a way that is consistent with the current code,
i.e. always terminate the output with a NUL?

> @@ -3469,6 +3470,9 @@ sub parse_commit_text {
>  				$co{'committer_name'} = $co{'committer'};
>  			}
>  		}
> +		elsif ($line =~ /^gpg: /) {

I think Eric already pointed out the style issue on this line.

> @@ -3508,6 +3512,10 @@ sub parse_commit_text {
>  	foreach my $line (@commit_lines) {
>  		$line =~ s/^    //;
>  	}
> +	push(@commit_lines, "") if scalar @signature;
> +	foreach my $sig (@signature) {
> +		push(@commit_lines, $sig);
> +	}

Hmm, is it different from doing:

	push @commit_lines, @signature;

in some way?

> @@ -4571,7 +4579,21 @@ sub git_print_log {
>  	# print log
>  	my $skip_blank_line = 0;
>  	foreach my $line (@$log) {
> -		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
> +		if ($line =~ m/^gpg:(.)+Good(.)+/) {
> +			if (! $opts{'-remove_signoff'}) {

Sorry, but I fail to see what the "remove-signoff" option has to do
with this new feature.  The interaction needs to be explained in the
log message.

> +				print "<span class=\"good_sign\">" . esc_html($line) . "</span><br/>\n";
> +				$skip_blank_line = 1;
> +			}
> +			next;
> +		}
> +		elsif ($line =~ m/^gpg:(.)+BAD(.)+/) {
> +			if (! $opts{'-remove_signoff'}) {
> +				print "<span class=\"bad_sign\">" . esc_html($line) . "</span><br/>\n";
> +				$skip_blank_line = 1;
> +			}
> +			next;
> +		}
> +		elsif ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
>  			if (! $opts{'-remove_signoff'}) {
>  				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
>  				$skip_blank_line = 1;
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 3212601..e99e223 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -136,6 +136,17 @@ span.signoff {
>  	color: #888888;
>  }
>  
> +span.good_sign {
> +	font-weight: bold;
> +	background-color: #aaffaa;
> +}
> +
> +span.bad_sign {
> +	font-weight: bold;
> +	background-color: #880000;
> +	color: #ffffff
> +}
> +
>  div.log_link {
>  	padding: 0px 8px;
>  	font-size: 70%;
