From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [[PATCH v2]] git-send-email: Added the ability to query the number of smtp password questions
Date: Tue, 12 Nov 2013 09:57:39 -0800
Message-ID: <xmqqwqkdh59o.fsf@gitster.dls.corp.google.com>
References: <1383992508-2097-1-git-send-email-silvio@port1024.net>
	<1384084613-12260-1-git-send-email-silvio@port1024.net>
	<1384084613-12260-2-git-send-email-silvio@port1024.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Silvio F <silvio.fricke@gmail.com>,
	Jeff King <peff@peff.net>
To: silvio@port1024.net
X-From: git-owner@vger.kernel.org Tue Nov 12 18:57:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgIDk-0007bQ-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab3KLR5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:57:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3KLR5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:57:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0629A512CD;
	Tue, 12 Nov 2013 12:57:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k9bhJIl/+svxHjwA4y9INFx+iXw=; b=t1paEC
	FwihlFqYHcyIEgRt3+h0DpAwjr387jxVOQna1bBdKoYQsUAop6Dn3W0zY+hhOse4
	t+UA0htOjez32LiPoeFyB0sGlUbuP5nVb9sLhnAX1eVc+jsCraj51e7xfcW/qGNr
	SnLMNCYgRbEOGBm4y6JEEwYwR4UUXXLxb0t9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ef6UHs9INtWu4GCUp/LidXIAKHrdA+yY
	ObRgms3D39VYhkKB8FF4w11NgM09gJZTDJ64eRsXor+GOejCWaFasQ/Db0kBark6
	Ys/+XE6O0NAp7Fp8PNAhpyR6gNelXaNJCvYF4u5T4Kru/5hgZn+/bJ6VVRWrftKn
	lH8iMcUjbYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB043512CC;
	Tue, 12 Nov 2013 12:57:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34687512CA;
	Tue, 12 Nov 2013 12:57:42 -0500 (EST)
In-Reply-To: <1384084613-12260-2-git-send-email-silvio@port1024.net>
	(silvio@port1024.net's message of "Sun, 10 Nov 2013 12:56:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED3EB476-4BC3-11E3-9119-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237725>

silvio@port1024.net writes:

> From: Silvio F <silvio.fricke@gmail.com>
>
> With this patch "git-send-mail" ask a configurable number of questions to
> input the smtp password. Without this patch we have only one trial.
>
> Signed-off-by: Silvio F <silvio.fricke@gmail.com>
> ---

I wonder if Git::credential (or even the underlying lower level
credential_fill() in the helper API) should give hints to the caller
if calling it again may yield a different result.  An interactive
prompt may allow the user to mistype the password and then a later
call may return a correct one, but the .netrc helper will read from
the file and will return a fixed result, so there is no use calling
credential_fill() again.  And in the latter case, you do not want to
loop $askpasswordcount times.

I also have to wonder if this logic belongs to git-send-email.
Specifically, I wonder if we can place the looping logic in
Git::credential, so that other users of the library can take
advantage of it?

Thanks.

[jc: cc'ed peff@ for thoughts on credential helper API]

>  Documentation/git-send-email.txt |  4 ++++
>  git-send-email.perl              | 32 +++++++++++++++++++++-----------
>  2 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index f0e57a5..ac993d6 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -364,6 +364,10 @@ sendemail.confirm::
>  	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
>  	in the previous section for the meaning of these values.
>  
> +sendmail.askpasswordcount::
> +	Number of times the smtp password can be entered before sending mail is
> +	aborted. Default is 1.
> +
>  EXAMPLE
>  -------
>  Use gmail as the smtp server
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3782c3b..aeb2e6d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -203,6 +203,7 @@ my ($validate, $confirm);
>  my (@suppress_cc);
>  my ($auto_8bit_encoding);
>  my ($compose_encoding);
> +my ($askpasswordcount) = 1;
>  
>  my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
>  
> @@ -237,6 +238,7 @@ my %config_settings = (
>      "from" => \$sender,
>      "assume8bitencoding" => \$auto_8bit_encoding,
>      "composeencoding" => \$compose_encoding,
> +    "askpasswordcount" => \$askpasswordcount
>  );
>  
>  my %config_path_settings = (
> @@ -360,6 +362,10 @@ sub read_config {
>  		}
>  	}
>  
> +	if ($askpasswordcount < 1) {
> +		$askpasswordcount = 1;
> +	}
> +
>  	if (!defined $smtp_encryption) {
>  		my $enc = Git::config(@repo, "$prefix.smtpencryption");
>  		if (defined $enc) {
> @@ -1069,17 +1075,21 @@ sub smtp_auth_maybe {
>  	# TODO: Authentication may fail not because credentials were
>  	# invalid but due to other reasons, in which we should not
>  	# reject credentials.
> -	$auth = Git::credential({
> -		'protocol' => 'smtp',
> -		'host' => smtp_host_string(),
> -		'username' => $smtp_authuser,
> -		# if there's no password, "git credential fill" will
> -		# give us one, otherwise it'll just pass this one.
> -		'password' => $smtp_authpass
> -	}, sub {
> -		my $cred = shift;
> -		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
> -	});
> +	for my $i (1 .. $askpasswordcount) {
> +		$auth = Git::credential({
> +			'protocol' => 'smtp',
> +			'host' => smtp_host_string(),
> +			'username' => $smtp_authuser,
> +			# if there's no password, "git credential fill" will
> +			# give us one, otherwise it'll just pass this one.
> +			'password' => $smtp_authpass
> +		}, sub {
> +			my $cred = shift;
> +			return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
> +		});
> +
> +		last if ($auth);
> +	}
>  
>  	return $auth;
>  }
