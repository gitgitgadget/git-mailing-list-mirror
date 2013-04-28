From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: improve recipients_cmd()
Date: Sun, 28 Apr 2013 12:18:03 -0700
Message-ID: <7vbo8yqxas.fsf@alter.siamese.dyndns.org>
References: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 21:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWX72-0006vX-C7
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 21:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab3D1TSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 15:18:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756416Ab3D1TSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 15:18:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ED7718C6E;
	Sun, 28 Apr 2013 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c8TPJU+hXZrwye8pG3VZ5QUe6Hg=; b=n2sqba
	TWWh1s5IFegvd1UgVcuavKOcmM2u5g3LKFdnAyPoaiNIAtjN6tntzIeIO4sPm+sm
	vLMdjX/R4KBRMrJ2XMP4PJNqa7yEXW1xwGNAbtBkAcCwg1iog0oMyKS55Ahfu7mj
	0I9pETNg51SSmrI2hjEJfJih5aiAv+7FdFvkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhePv4Kcu6Jip54+cH2j55NBJkrXjjiR
	LPPq+Crp94BVY0/49Dv5l6Anw1eA9N0MytvHcxhtQf76ElmbSKFr9bzXVDDbT1Ap
	7ukepn1OpvvMejJbELFqsfQJ20vOx4L9l38E0i9ixQggaHRnfWskiVsnpHxHlvP/
	/l8Km4nIQjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 261FE18C6D;
	Sun, 28 Apr 2013 19:18:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 840A118C6A;
	Sun, 28 Apr 2013 19:18:04 +0000 (UTC)
In-Reply-To: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 27 Apr 2013 17:26:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59C8B0EC-B038-11E2-9595-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222745>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We don't need to quote the filename to pass to the command, we can use
> an array of all the arguments to pass to the command, which is safer,
> and more extensible.
>
> Commit a47eab0 (send-email: use the three-arg form of open in
> recipients_cmd) stated we couldn't pass $file directly, but in fact, we
> can, the multi-word string is passed as is, and we can pass an array
> too.

I think the comment is not about passing $file directly, but is
about passing $cmd that could be multi-word string directly.  The
caller expects it be split into command and its earlier part of
command line parameters, so that you can say

    $cmd = "cccmd --frotz --nitfol"

but the non-string form of open would not give you that, unless you
rewrite it to

	open $fh, "-|", qw(sh -c), $cmd, @args

or something, no?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-send-email.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bd13cc8..7880d12 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1452,11 +1452,11 @@ foreach my $t (@files) {
>  # Execute a command (e.g. $to_cmd) to get a list of email addresses
>  # and return a results array
>  sub recipients_cmd {
> -	my ($prefix, $what, $cmd, $file) = @_;
> +	my ($prefix, $what, $cmd, @args) = @_;
>  
>  	my $sanitized_sender = sanitize_address($sender);
>  	my @addresses = ();
> -	open my $fh, "-|", "$cmd \Q$file\E"
> +	open my $fh, "-|", $cmd, @args
>  	    or die "($prefix) Could not execute '$cmd'";
>  	while (my $address = <$fh>) {
>  		$address =~ s/^\s*//g;
