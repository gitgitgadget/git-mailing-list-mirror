From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Honour SMTP domain when using TLS
Date: Sat, 15 Oct 2011 20:36:48 -0700
Message-ID: <7v62jpvc8f.fsf@alter.siamese.dyndns.org>
References: <1318668292-13818-1-git-send-email-mattjd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Gernhardt <brian@gernhardtsoftware.com>
To: Matthew Daley <mattjd@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 05:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFHWy-0003Fz-Ep
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 05:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab1JPDgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 23:36:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab1JPDgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 23:36:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8393E6807;
	Sat, 15 Oct 2011 23:36:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNjY+zIKdj4olVPi7bcjrP1cGF4=; b=DRJE81
	3xjID07OLW76o90XSRzXNDmXDiAxi2NiNgCmUlbThGrV+cWARmEW+IfC6LGbaYKC
	5BrI5qMtutuauV8ox31srHA80U0w+Cd0xyMYAEhmnbM1iFDeBM22z6ofs5SaQqxs
	woZFSUWRI59G80sMeI382+M7ozo7CT4j697S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3t4z7LoN8UEgD+38EKIJzgoRQERNyzg
	yqpme6XvK0lyNEST/IG8qyYIvZXiYAdFFipniUj4ow2doRWNUOfCtvFfu1i5Bzx9
	8yDU5qXz7nwVtJVGlJokNYArb3MtumzMa/rf5s7Y0KWqByaJbEyJq1lhcP5KC2r1
	CBkbn4Z1IX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B5B46806;
	Sat, 15 Oct 2011 23:36:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DB1B6805; Sat, 15 Oct 2011
 23:36:49 -0400 (EDT)
In-Reply-To: <1318668292-13818-1-git-send-email-mattjd@gmail.com> (Matthew
 Daley's message of "Sat, 15 Oct 2011 04:44:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 150A2E44-F7A8-11E0-9AE1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183685>

Matthew Daley <mattjd@gmail.com> writes:

> git-send-email sends two SMTP EHLOs when using TLS encryption, however
> only the first, unencrypted EHLO uses the SMTP domain that can be
> optionally specified by the user (--smtp-domain).  This is because the
> call to hello() that produces the second, encrypted EHLO does not pass
> the SMTP domain as an argument, and hence a default of
> 'localhost.localdomain' is used instead.
>
> Fix by passing in the SMTP domain in this call.
>
> Signed-off-by: Matthew Daley <mattjd@gmail.com>

Sounds sensible, thanks.

Brian, who did 69cf7bf (send-email: Cleanup smtp-domain and add config,
2010-04-10) to make the initial hello use $smtp_domain, could you take a
quick look and an Ack?

>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 6885dfa..d491db9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1098,7 +1098,7 @@ X-Mailer: git-send-email $gitversion
>  					$smtp_encryption = '';
>  					# Send EHLO again to receive fresh
>  					# supported commands
> -					$smtp->hello();
> +					$smtp->hello($smtp_domain);
>  				} else {
>  					die "Server does not support STARTTLS! ".$smtp->message;
>  				}
