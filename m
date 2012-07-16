From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] git-remote-mediawiki: get rid of O(N^2) loop
Date: Mon, 16 Jul 2012 11:19:47 -0700
Message-ID: <7v394r36ws.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342440053-3058-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqptm-0001nb-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab2GPSTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:19:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab2GPSTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:19:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39C058B0F;
	Mon, 16 Jul 2012 14:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MpDA5mNuc07k7iS8++sqqFlwwok=; b=nWpL4C
	z/cC8vvkL4/dR3iJJ26ZTSIAvWvzbWpF1e3Jxzq1yVTWCobw8KowCX13NoxEhjSC
	MpNoy84SMtDh3AEvLeuHxP2xxYtc/R+reqdguD41cnnJnk39zGIp3jySvtmmZ03x
	gK0wlp7rHZ7/WKxQWp7py4yrMxvOXnYtjuZ4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIiJABESOUyjCSwkDbekpSkPhmIZezr8
	qlAgrvkuP4uSflQzeN7cLKL2C1VlpogDDPWeNeDkVdkZ+4R5ca8dJcxdznmVgNGt
	1mdTH51dvGodiUsJUDhOr/BJtEd65VMLNmENJ0S6Gr/OKwHnebbMgYRVGgwoff0x
	zMZKo3zV1y0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B4B8B0E;
	Mon, 16 Jul 2012 14:19:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8062A8B0B; Mon, 16 Jul 2012
 14:19:48 -0400 (EDT)
In-Reply-To: <1342440053-3058-5-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 16 Jul 2012 14:00:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3DA2138-CF72-11E1-8D93-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201541>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The algorithm to find a path from the local revision to the remote one
> was calling "git rev-list" and parsing its output N times. Run rev-list
> only once, and fill a hashtable with the result to optimize the body of
> the loop.

Good thinking.  I wonder if it would further reduce the overhead if
you stop using --children and do this using --parents instead, as
you will be reading the parsed_sha1..local range either way yourself
anyway.

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index 8e46e4e..f9c0cc6 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -1196,16 +1196,27 @@ sub mw_push_revision {
>  	if ($last_local_revid > 0) {
>  		my $parsed_sha1 = $remoteorigin_sha1;
>  		# Find a path from last MediaWiki commit to pushed commit
> +		print STDERR "Computing path from local to remote ...\n";
> +		my @local_ancestry = split(/\n/, run_git("rev-list --boundary --children $local ^$parsed_sha1"));
> +		my %local_ancestry;
> +		foreach my $line (@local_ancestry) {
> +			if (my ($parent, $child) = $line =~ m/^-?([a-f0-9]+) ([a-f0-9]+)/) {
> +				$local_ancestry{$parent} = $child;
> +				if ($parent eq $parsed_sha1 || $child eq $parsed_sha1) {
> +					print STDERR "$parent -> $child\n";
> +				}
> +			} elsif (!$line =~ m/^([a-f0-9]+)/) {
> +				die "Unexpected output from git rev-list: $line";
> +			}
> +		}
>  		while ($parsed_sha1 ne $HEAD_sha1) {
> -			my @commit_info =  grep(/^$parsed_sha1/, split(/\n/, run_git("rev-list --children $local")));
> -			if (!@commit_info) {
> +			my $child = $local_ancestry{$parsed_sha1};
> +			if (!$child) {
> +				printf STDERR "Cannot find a path in history from remote commit to last commit\n";
>  				return error_non_fast_forward($remote);
>  			}
> -			my @commit_info_split = split(/ |\n/, $commit_info[0]);
> -			# $commit_info_split[1] is the sha1 of the commit to export
> -			# $commit_info_split[0] is the sha1 of its direct child
> -			push(@commit_pairs, \@commit_info_split);
> -			$parsed_sha1 = $commit_info_split[1];
> +			push(@commit_pairs, [$parsed_sha1, $child]);
> +			$parsed_sha1 = $child;
>  		}
>  	} else {
>  		# No remote mediawiki revision. Export the whole
