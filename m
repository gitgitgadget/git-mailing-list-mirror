From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: fix handling of special characters
Date: Thu, 23 May 2013 12:52:11 -0700
Message-ID: <7vk3mpeaok.fsf@alter.siamese.dyndns.org>
References: <20130523135418.GA20741@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 21:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfbYh-0007CJ-RT
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758314Ab3EWTwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:52:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758071Ab3EWTwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:52:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4195821912;
	Thu, 23 May 2013 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rsDMrawlYSSqXKcetl2C6mNpDc0=; b=tzF39I
	nZfxj3LVRAR1BnBndV3RmRhz5HOE9i5Hk239mLAVHrf7FS21dDgv9h2HpwcIxSY/
	VA7Q3wG6ECHeCZVqV6HNkKngSw1GwRcMlCOZ44Btz7ljKxQ8Kz25hjbWQoWYRKOv
	UwY33cGZc1RpgrD/nlXqCPAmi7aF1xTsgwVhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZnNgHwyRn8+A8sYh5YJS6mF7Tj4A7Ccp
	AQs2jyIVh+UnW0fbrvyHEbkNOUPVpm6hMJWnmHLI7QvuoXtI5rVIFJ979ow0jn9a
	AZw+ynq1aswzs/1BszkrYfElk2gep3IHO8mS4/FDeamUiVpKdK0I765XJw/x13rw
	n3k8DZFEIpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38FF421911;
	Thu, 23 May 2013 19:52:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F65121910;
	Thu, 23 May 2013 19:52:13 +0000 (UTC)
In-Reply-To: <20130523135418.GA20741@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 23 May 2013 16:54:18 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4365ACF2-C3E2-11E2-B147-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225288>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> When patch sender's name has special characters,
> git send-email did not quote it before matching
> against the author name.
> As a result it would produce mail like this:
>
> 	Date: Thu, 23 May 2013 16:36:00 +0300
> 	From: "Michael S. Tsirkin" <mst@redhat.com>
> 	To: qemu-devel@nongnu.org
> 	Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 	Subject: [PATCH 0/9] virtio: switch to linux headers
> 	Message-Id: <1369316169-20181-1-git-send-email-mst@redhat.com>
>
> 	From: "Michael S. Tsirkin" <mst@redhat.com>
>
> Fix by sanitizing before matching to patch author name.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  git-send-email.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bd13cc8..c4dc438 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1400,7 +1400,8 @@ foreach my $t (@files) {
>  		$subject = quote_subject($subject, $auto_8bit_encoding);
>  	}
>  
> -	if (defined $author and $author ne $sender) {
> +	my $sanitized_sender = sanitize_address($sender);
> +	if (defined $author and $author ne $sanitized_sender) {
>  		$message = "From: $author\n\n$message";
>  		if (defined $author_encoding) {
>  			if ($has_content_type) {

Is $author already sanitized at this point in the code?  I see it
was unwrapped with unquote_rfc2047 after it was read from the From:
line; will it always be the same as sanitize_address($author) would
return, and if not, would you rather compare between sanitized
versions of sender and author, no?

Also, isn't the $sender the same during the whole outer loop that
iterates over @files?  Do we need to apply sanitize_address() on it
over and over for each and every logical line in the @header?

This comment also applies to the other patch but they probably
should become a single patch anyway, I guess?
