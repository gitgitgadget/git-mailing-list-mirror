From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: don't call methods on undefined values
Date: Mon, 09 Sep 2013 09:45:10 -0700
Message-ID: <xmqqli363pwp.fsf@gitster.dls.corp.google.com>
References: <1378673674-97212-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, artagnon@gmail.com, mst@redhat.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 18:45:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ4aX-0005ui-7B
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 18:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab3IIQpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 12:45:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab3IIQpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 12:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6673B3FAB1;
	Mon,  9 Sep 2013 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B1mlLlZYOuS1ql2qGWB1QAZFgxM=; b=SrcWUH
	WhbGdVWMUekfyHSZ+VxHpKhtVOV6LIMQbYkEiEkMDXNZKXSw92V1SnelOsaD0Tdm
	za6WWqwhpnS9IBaVrUSfBDlV8VsIPjba26e2nhZeaHCIFApXI1Anjf0GWz59SI64
	0AUt5R24WqbwTFIoZZOLK64fHIYhOnkewz3Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hDn3U3cU4Yy0Yq5mJlq6zxRnC6i3rjjb
	6G0w+QiczejbBv3Hkooa8siFKiC0zPFP/4lnfw5ZU3N1TQ8B7VQtbQ1sTWwgw/KN
	xsfrdi3WrbEwT0MOLK05/tmqpEiQNktxbGc+A+yJuzCf6XTif4DvFJIBKNdFir64
	ZKTYs9oEE9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56AB03FAB0;
	Mon,  9 Sep 2013 16:45:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 411283FAA8;
	Mon,  9 Sep 2013 16:45:12 +0000 (UTC)
In-Reply-To: <1378673674-97212-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 8 Sep 2013 20:54:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 320A763A-196F-11E3-87F0-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234351>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If SSL verification is enabled in git send-email, we could attempt to call a
> method on an undefined value if the verification failed, since $smtp would end
> up being undef.  Look up the error string in a way that will produce a helpful
> error message and not cause further errors.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2162478..3782c3b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1234,7 +1234,7 @@ X-Mailer: git-send-email $gitversion
>  				if ($smtp->code == 220) {
>  					$smtp = Net::SMTP::SSL->start_SSL($smtp,
>  									  ssl_verify_params())
> -						or die "STARTTLS failed! ".$smtp->message;
> +						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();

I agree that $smtp->message may be bogus at this point, but could
"require IO::Socket::SSL" have failed on us in ssl_verify_params?
In that degraded mode, we do not do SSL peer verification, but
otherwise we would still attempt to talk with the peer, and in such
a case, IO::Socket::SSL would not be available to us at this point,
no?

>  					$smtp_encryption = '';
>  					# Send EHLO again to receive fresh
>  					# supported commands
