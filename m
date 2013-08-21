From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-remote-mediawiki: reset private ref after non-dumb push
Date: Wed, 21 Aug 2013 10:59:27 -0700
Message-ID: <xmqq1u5nudq8.fsf@gitster.dls.corp.google.com>
References: <1377072617-25086-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 21 19:59:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCCh5-0005kc-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 19:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab3HUR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 13:59:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988Ab3HUR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 13:59:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B86153AE6B;
	Wed, 21 Aug 2013 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7RGsEAfnj06+Kh7Ln2IBtH0ZcFE=; b=l9feRV
	mB+n11wDhCqUyzy8vY5lCpaPpYjBAyTcVBj79pTsxWq/k4cPXLs+5coMkLR5/cQd
	kQJlsYQdNno3abLatiJ10tSJ3YcurC5x55INVT3/wxkyYiY0FJEAGSkGeAEW1b/y
	VhEyQ1lUYp1LP/OIiHSLTjeklrirrE9wFG6bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfPBJxIsHzLb5jmHEDvg37doxiKO/Fol
	PFqKub2NZ36vI7akzvdozxp7AArBkHU1XIfa0Y8NDn6uGXpFFpM1vC5a8JnSRRvd
	4TSKBa2/1/OMdokGg6Mhp0PRHkUqYgir/N80OuBIt5X2s7xhMkmcGahuwUtxtM5a
	aAK+e3DAmBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA133AE6A;
	Wed, 21 Aug 2013 17:59:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B1403AE62;
	Wed, 21 Aug 2013 17:59:29 +0000 (UTC)
In-Reply-To: <1377072617-25086-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 21 Aug 2013 10:10:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6D3ABE2E-0A8B-11E3-A739-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232711>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Git-mediawiki's "dumb push" sends the local revisions to the remote wiki,
> but does not update the local metadata to reflect the push (hence, the
> next pull will have to re-import the exported revisions).
>
> The previous implementation was simply omitting the update to the private
> ref after a dumb push. This was broken by 664059fb62 (Felipe Contreras,
> Apr 17 2013, transport-helper: update remote helper namespace), which
> does an automatic update of the private ref (not just the
> remote-tracking) on push.
>
> This patch fixes git-remote-mediawiki to reset the private ref after the
> push is completed, cancelling the automatic update triggered by
> 664059fb62.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Just a resend of the RFC
> ( http://thread.gmane.org/gmane.comp.version-control.git/232224 ),
> which received no comment.
>
>  contrib/mw-to-git/git-remote-mediawiki.perl | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index f8d7d2c..13919ad 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -53,6 +53,7 @@ if (@ARGV != 2) {
>  
>  my $remotename = $ARGV[0];
>  my $url = $ARGV[1];
> +my $reset_private_ref_to = undef;
>  
>  # Accept both space-separated and multiple keys in config file.
>  # Spaces should be written as _ anyway because we'll use chomp.
> @@ -161,6 +162,9 @@ sub parse_command {
>  	my ($line) = @_;
>  	my @cmd = split(/ /, $line);
>  	if (!defined $cmd[0]) {
> +		if ($reset_private_ref_to) {
> +			run_git("update-ref -m \"Git-MediaWiki non-dumb push\" refs/mediawiki/$remotename/master $reset_private_ref_to");
> +		}

So reset-private-ref-to is recorded for a non-dumb push, but...

>  		return 0;
>  	}
>  	if ($cmd[0] eq 'capabilities') {
> @@ -1209,9 +1213,10 @@ sub mw_push_revision {
>  				die("Unknown error from mw_push_file()\n");
>  			}
>  		}
> -		if (!$dumb_push) {
> +		if ($dumb_push) {
> +			$reset_private_ref_to = $remoteorigin_sha1;

... it is set for dumb-push?  I am confused.

> +		} else {
>  			run_git(qq(notes --ref=${remotename}/mediawiki add -f -m "mediawiki_revision: ${mw_revision}" ${sha1_commit}));
> -			run_git(qq(update-ref -m "Git-MediaWiki push" refs/mediawiki/${remotename}/master ${sha1_commit} ${sha1_child}));
>  		}
>  	}
