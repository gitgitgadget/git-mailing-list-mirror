From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: confirm on empty mail subjects
Date: Fri, 11 Sep 2009 16:27:03 -0700
Message-ID: <7v4or9qczc.fsf@alter.siamese.dyndns.org>
References: <1249490994-23455-1-git-send-email-jengelh@medozas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Sep 12 01:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmFWR-0008FC-0o
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 01:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183AbZIKX1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 19:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757138AbZIKX1I
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 19:27:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbZIKX1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 19:27:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D06BA2E25C;
	Fri, 11 Sep 2009 19:27:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ElaswRsqggQ9EbkwcXdKtm5W73w=; b=QD7PsZ
	ZrJyZk/RpfiZw7MhbQzsUVIcZyAQxy1eaPGGb43LdMpou/vmYHk+zHAiKKVgPAnr
	JPt6wrTxyYc+PA5yvIaAxCep1iMgzc/aq9IP77GuTSoOguurWSHUbgx3VIpLTgqh
	WamYxrGd+ytBAutvMwe2UACtEmQWkOh2ECRp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jJ5MHRd2I6JoPIn+qmACCJWMgHp1/Kjx
	lPZiczkr0S1HLatapjct1ahYo1TgWmRxS25CoxX7I7/eT3m0HjKssqJqykbrQzlc
	pd79t85dMP67C85PBKd9O4V8R+XwRaCaQfqZkuIKf95adjFpXXq82A58VkeykU8Q
	7kaTW8KjGv8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B30E12E255;
	Fri, 11 Sep 2009 19:27:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9A032E253; Fri, 11 Sep
 2009 19:27:04 -0400 (EDT)
In-Reply-To: <1249490994-23455-1-git-send-email-jengelh@medozas.de> (Jan
 Engelhardt's message of "Wed\,  5 Aug 2009 18\:49\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FDA4118-9F2A-11DE-BEE0-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128230>

Jan Engelhardt <jengelh@medozas.de> writes:

> When the user forgot to enter a subject in a compose session,
> send-email will now inquire whether this is really intended, similar
> to what the Alpine MUA does when a subject is absent.
>
> Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
> ---
>  git-send-email.perl |   25 ++++++++++++++++++++-----
>  1 files changed, 20 insertions(+), 5 deletions(-)

We have had this for quite a long time but I have two niggling worries,
one minor, another one showstopper from maintainability point of view.

 - With --confirm=never the program still seems to talk with the terminal.
   I think with --confirm=neber we should not ask but just fail.

 - This does not hook into the confirmation framework the program already
   has, and does not have any way to turn it off.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index d508f83..7d56fba 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -553,11 +553,26 @@ EOT
>  	}
>  	close(C);
>  
> -	if ($annotate) {
> -		do_edit($compose_filename, @files);
> -	} else {
> -		do_edit($compose_filename);
> -	}
> +	my $re_edit = 0;
> +	do {
> +		if ($annotate) {
> +			do_edit($compose_filename, @files);
> +		} else {
> +			do_edit($compose_filename);
> +		}
> +
> +		open(C, "<", $compose_filename) ||
> +			die "Failed to open $compose_filename: $!";
> +		if (grep(/^Subject:\s*$/i, <C>)) {
> +			my $r = ask("No Subject, send anyway? ".
> +			            "([y]es|[n]o|[e]dit again): ",
> +			            valid_re => qr/^[yne]/i,
> +			            default => "n");
> +			$re_edit = lc(substr($r, 0, 1)) eq "e";
> +			exit(0) if lc(substr($r, 0, 1)) eq "n";
> +		}
> +		close C;
> +	} while ($re_edit);
>  
>  	open(C2,">",$compose_filename . ".final")
>  		or die "Failed to open $compose_filename.final : " . $!;
> -- 
> 1.6.4
