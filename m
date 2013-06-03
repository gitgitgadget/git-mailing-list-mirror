From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] send-email: fix suppress-cc=self on cccmd
Date: Mon, 03 Jun 2013 08:58:14 -0700
Message-ID: <7v7gibjieh.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
	<1369897638-27299-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 17:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjX9J-000312-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab3FCP6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 11:58:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758778Ab3FCP6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:58:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E5CD24370;
	Mon,  3 Jun 2013 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TMWXOi8hM5wT7z1jkvIZV3/jzYk=; b=jaF77L
	vIIXUqMumH+RreX+xTlCPuWqscVb9cA3L8ap4sSCQlu6Hi/DAEoqDg/rqBD417YE
	6yeOfP+JTtUQ6nRf0TUU82eYW/6DiQyB8pZ5Mx05TGKs5vjzvdjfpnKb4fOM3B6E
	eCr9NNFOlRaNuWcPCdR/5Ak/xBbVXNC0UTbOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lq2Yz3PeACUkmPqpMnoQhL883tys3PAa
	OOO6bKShYgBLTVKYd3IfcHYaVPkTTl/iXAvPoEurp040BnJGCztuTy2p4rJzfNyK
	YqsEwfvwrFFLoiqw6AQA9Klw0KcXjq21c71yRPr5Cz55niaL1Pk1GwWoht687Hnc
	FG9BPzBEVw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4344F2436F;
	Mon,  3 Jun 2013 15:58:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AC9B2436B;
	Mon,  3 Jun 2013 15:58:15 +0000 (UTC)
In-Reply-To: <1369897638-27299-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 30 May 2013 10:11:15 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66B56986-CC66-11E2-A0E3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226225>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> When cccmd is used, old-style suppress-from filter
> is applied by the newer suppress-cc=self isn't.
> Fix this up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bd13cc8..a138615 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1462,7 +1462,7 @@ sub recipients_cmd {
>  		$address =~ s/^\s*//g;
>  		$address =~ s/\s*$//g;
>  		$address = sanitize_address($address);
> -		next if ($address eq $sanitized_sender and $suppress_from);
> +		next if ($address eq $sender and $suppress_cc{'self'});

If $suppress_from is defined, $suppress_cc{'self'} gets its value,
so the latter half of this change is very understandable.

The original comparison uses $address that is "sanitized" (whose
definition is roughly "mangled/quoted with rfc2047 etc to fit on
To/Cc headers") against $sanitized_sender, which means for a

    $sender = 'Michael S. Tsirkin <mst@redhat.com>';

we used

    $sanitized_sender = '"Michael S. Tsirkin" <mst@redhat.com>';

for comparison, but the new code does not quote the $recipient_name
part inside dq for the single dot after the middle name.  Is this a
desirable change?

>  		push @addresses, $address;
>  		printf("($prefix) Adding %s: %s from: '%s'\n",
>  		       $what, $address, $cmd) unless $quiet;
