From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Sat, 06 Jul 2013 16:28:00 +0200
Message-ID: <51D82970.5070108@web.de>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com> <1373025947-26495-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 06 16:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvTTP-0001io-4i
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 16:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab3GFO2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 10:28:23 -0400
Received: from mout.web.de ([212.227.15.3]:52057 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3GFO2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 10:28:22 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LlWCR-1UOLRO2sJb-00bGz7; Sat, 06 Jul 2013 16:28:05
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1373025947-26495-2-git-send-email-artagnon@gmail.com>
X-Provags-ID: V03:K0:mjLCgNC0r8oY9HNaaStkIh/ma5/SVWKtPYLU+k7gIUTGmAZL3D4
 WfuUzN7LahVjjV7CF4oDkFUE+bQYwhGPsOubU6mlByI7oDzrjwxBD9qLfu5abL8iq2+BqV1
 ZDvwjUq68/5OsLcEsneA90xMUCjRSWUC+BbHsZfq/v7Q0RaEJAZxd7WqO9aD7z+njz8YIgL
 5Cweh8HIqWsOKFiak7LQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229701>

On 2013-07-05 14.05, Ramkumar Ramachandra wrote:
> Due to a recent change in the Net::SMTP::SSL module, send-email emits
> the following ugly warning everytime a email is sent via SSL:
> 
> *******************************************************************
>  Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
>  is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
>  together with SSL_ca_file|SSL_ca_path for verification.
>  If you really don't want to verify the certificate and keep the
>  connection open to Man-In-The-Middle attacks please set
>  SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
> *******************************************************************
> 
> Fix this by explicitly specifying SSL_verify_mode => SSL_VERIFY_NONE in
> Net::SMTP::SSL->start_SSL().
> 
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-send-email.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index ecbf56f..758100d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1193,10 +1193,12 @@ X-Mailer: git-send-email $gitversion
>  						 Debug => $debug_net_smtp);
>  			if ($smtp_encryption eq 'tls' && $smtp) {
>  				require Net::SMTP::SSL;
> +				use IO::Socket::SSL qw(SSL_VERIFY_NONE);
>  				$smtp->command('STARTTLS');
>  				$smtp->response();
>  				if ($smtp->code == 220) {
> -					$smtp = Net::SMTP::SSL->start_SSL($smtp)
> +					$smtp = Net::SMTP::SSL->start_SSL($smtp,
> +									  SSL_verify_mode => SSL_VERIFY_NONE)
>  						or die "STARTTLS failed! ".$smtp->message;
>  					$smtp_encryption = '';
>  					# Send EHLO again to receive fresh
> 
Hm, this doesn't work on my system, and t9001 fails:

"SSL_VERIFY_PEER" is not exported by the IO::Socket::SSL module
 "SSL_VERIFY_NONE" is not exported by the IO::Socket::SSL module
Can't continue after import errors at /Users/tb/projects/git/git.pu/git-send-email line 1090
/Torsten
