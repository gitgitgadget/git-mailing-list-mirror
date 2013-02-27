From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 6/6] git-send-email: use git credential to obtain password
Date: Wed, 27 Feb 2013 17:13:18 +0100
Message-ID: <vpqy5e9zqe9.fsf@grenoble-inp.fr>
References: <cover.1360677646.git.mina86@mina86.com>
	<cover.1360677646.git.mina86@mina86.com>
	<32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com>
	<vpqhakx4z4c.fsf@grenoble-inp.fr>
	<7vehg1kb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Nazarewicz <mpn@google.com>, peff@peff.net,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 17:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjdi-0003Qb-JG
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 17:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab3B0QNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 11:13:30 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43216 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab3B0QN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 11:13:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1RGDHOJ024267
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Feb 2013 17:13:17 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UAjd8-0007jV-Qn; Wed, 27 Feb 2013 17:13:18 +0100
In-Reply-To: <7vehg1kb09.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 27 Feb 2013 07:54:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Feb 2013 17:13:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1RGDHOJ024267
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362586397.89067@sqJrKXwKAK+wU8eQ5WQBJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217217>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 76bbfc3..c3501d9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1045,6 +1045,14 @@ sub maildomain {
>  	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
>  }
>  
> +sub smtp_host_string {
> +	if (defined $smtp_server_port) {
> +		return "$smtp_server:$smtp_server_port";
> +	} else {
> +		return $smtp_server;
> +	}
> +}
> +
>  # Returns 1 if authentication succeeded or was not necessary
>  # (smtp_user was not specified), and 0 otherwise.
>  
> @@ -1065,7 +1073,7 @@ sub smtp_auth_maybe {
>  	# reject credentials.
>  	$auth = Git::credential({
>  		'protocol' => 'smtp',
> -		'host' => join(':', $smtp_server, $smtp_server_port),
> +		'host' => smtp_host_string(),
>  		'username' => $smtp_authuser,
>  		# if there's no password, "git credential fill" will
>  		# give us one, otherwise it'll just pass this one.
> @@ -1188,9 +1196,7 @@ sub send_message {
>  		else {
>  			require Net::SMTP;
>  			$smtp_domain ||= maildomain();
> -			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
> -						 ? "$smtp_server:$smtp_server_port"
> -						 : $smtp_server,
> +			$smtp ||= Net::SMTP->new(smtp_host_string(),
>  						 Hello => $smtp_domain,
>  						 Debug => $debug_net_smtp);
>  			if ($smtp_encryption eq 'tls' && $smtp) {

Seems obviously correct. I also did a basic test and it worked smoothly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
