From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: support NNTP
Date: Tue, 23 Apr 2013 08:02:52 -0700
Message-ID: <7vobd5l277.fsf@alter.siamese.dyndns.org>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUekW-0004rW-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab3DWPC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Apr 2013 11:02:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab3DWPC5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 11:02:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEFAB18C1C;
	Tue, 23 Apr 2013 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sleh4Xc8b8Nl
	mCeUxaVKNEXt7Bc=; b=Q8vF/yYbFL5yS2uRwANXuz/xo2i5Ln4gzPGx+zggARC/
	nKCZs9gzZeADLpxA2ESLkKRI0AppgfybIfhkmgrANrr/Ma3//fPgbxVx/C3WyOAX
	1Y2m5KK4WB6SuK2+O4c1YDGoSodKOkfuWhxPHKMFP0tlK5nxMtIhHxrBWbNb1zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dRDzTY
	bieIJFH3H6jgE/wxAgZFYhRZAR3vhNzuMiKYH0nUT0Vm7V8xWiOTOTy1yVvGfl8Z
	1KfE8SnsWjkQ/AF6P5QVKQtzWNbW4WswRvmHqxio4HaYtmhB7FjzRE7UVdPxylGR
	YC7r6IUjrvwyTo6tyUHfG58R4vBHU7pdE4C9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2C2318C1B;
	Tue, 23 Apr 2013 15:02:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 677B218C18;
	Tue, 23 Apr 2013 15:02:54 +0000 (UTC)
In-Reply-To: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	(=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Tue, 23 Apr 2013
 13:13:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E02D0676-AC26-11E2-A7D6-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222171>

=C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:

> Enable sending patches to NNTP servers (Usenet, Gmane).
> ---
>
> The patch implements support for sending messages to groups on NNTP s=
erviers.

Cute.

A Perl guru might want to encapsulate the differences between $smtp
and $nntp codepaths into two Perl modules, but it looks like a good
starting point.

> The patch does not (attempts not to) change the default behavior i.e.=
 to use sendmail
> and/or Net::SMTP. To use NNTP one needs to configure the server (see =
the help message)
> and protocol ("--protocol nntp"). Then after giving --newsgroups the
> message will be sent via NNTP. Like this one:
>
> perl git-send-email.perl --protocol nntp --newsgroups gmane.comp.vers=
ion-control.git --nntp-server news.gmane.org 0001-send-email-support-NN=
TP.patch
>
>  git-send-email.perl |  156 +++++++++++++++++++++++++++++++++++++++++=
----------
>  1 file changed, 125 insertions(+), 31 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index bd13cc8..0356635 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -54,12 +54,14 @@ git send-email [options] <file | directory | rev-=
list options >
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> +    --newsgroups            <str>  * NNTP Newsgroups:
>      --[no-]annotate                * Review each patch that will be =
sent in an editor.
>      --compose                      * Open an editor for introduction=
=2E
>      --compose-encoding      <str>  * Encoding to assume for introduc=
tion.
>      --8bit-encoding         <str>  * Encoding to assume 8bit mails i=
f undeclared
> =20
>    Sending:
> +    --protocol              <str>  * 'smtp' or 'nntp'. Default 'smtp=
'.
>      --envelope-sender       <str>  * Email envelope sender.
>      --smtp-server       <str:int>  * Outgoing SMTP server to use. Th=
e port
>                                       is optional. Default 'localhost=
'.
> @@ -71,6 +73,12 @@ git send-email [options] <file | directory | rev-l=
ist options >
>      --smtp-ssl                     * Deprecated. Use '--smtp-encrypt=
ion ssl'.
>      --smtp-domain           <str>  * The domain name sent to HELO/EH=
LO handshake
>      --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug=
=2E
> +    --nntp-server       <str:int>  * Outgoing NNTP server to use. Th=
e port
> +                                     is optional.
> +    --nntp-server-port      <int>  * Outgoing NNTP server port.
> +    --nntp-user             <str>  * Username for NNTP AUTHINFO.
> +    --nntp-pass             <str>  * Password for NNTP AUTHINFO.
> +    --nntp-debug            <0|1>  * Disable, enable Net::NNTP debug=
=2E
> =20
>    Automating:
>      --identity              <str>  * Use the sendemail.<id> options.
> @@ -138,12 +146,14 @@ sub format_2822_time {
>  my $have_email_valid =3D eval { require Email::Valid; 1 };
>  my $have_mail_address =3D eval { require Mail::Address; 1 };
>  my $smtp;
> +my $nntp;
>  my $auth;
> =20
>  # Variables we fill in automatically, or via prompting:
>  my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@=
xh,
>  	$initial_reply_to,$initial_subject,@files,
> -	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
> +	$author,$sender,$smtp_authpass,$annotate,$compose,$time,
> +	@initial_newsgroups, @newsgroups);
> =20
>  my $envelope_sender;
> =20
> @@ -192,7 +202,9 @@ sub do_edit {
> =20
>  # Variables with corresponding config settings
>  my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
> -my ($to_cmd, $cc_cmd);
> +my ($to_cmd, $cc_cmd, $newsgroups_cmd);
> +my ($email_protocol) =3D 'smtp';
> +my ($nntp_server, $nntp_server_port, $nntp_authuser, $nntp_authpass)=
;
>  my ($smtp_server, $smtp_server_port, @smtp_server_options);
>  my ($smtp_authuser, $smtp_encryption);
>  my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
> @@ -202,6 +214,7 @@ my ($auto_8bit_encoding);
>  my ($compose_encoding);
> =20
>  my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
> +my ($debug_net_nntp) =3D 0;		# Net::NNTP, see send_message()
> =20
>  my $not_set_by_user =3D "true but not set by the user";
> =20
> @@ -235,6 +248,13 @@ my %config_settings =3D (
>      "from" =3D> \$sender,
>      "assume8bitencoding" =3D> \$auto_8bit_encoding,
>      "composeencoding" =3D> \$compose_encoding,
> +    "nntpserver" =3D> \$nntp_server,
> +    "nntpserverport" =3D> \$nntp_server_port,
> +    "nntpuser" =3D> \$nntp_authuser,
> +    "nntppass" =3D> \$nntp_authpass,
> +    "protocol" =3D> \$email_protocol,
> +    "newsgroups" =3D> \@initial_newsgroups,
> +    "newsgroupscmd" =3D> \$newsgroups_cmd,
>  );
> =20
>  my %config_path_settings =3D (
> @@ -291,6 +311,7 @@ my $rc =3D GetOptions("h" =3D> \$help,
>  		    "to-cmd=3Ds" =3D> \$to_cmd,
>  		    "no-to" =3D> \$no_to,
>  		    "cc=3Ds" =3D> \@initial_cc,
> +		    "cc-cmd=3Ds" =3D> \$cc_cmd,
>  		    "no-cc" =3D> \$no_cc,
>  		    "bcc=3Ds" =3D> \@bcclist,
>  		    "no-bcc" =3D> \$no_bcc,
> @@ -304,11 +325,18 @@ my $rc =3D GetOptions("h" =3D> \$help,
>  		    "smtp-encryption=3Ds" =3D> \$smtp_encryption,
>  		    "smtp-debug:i" =3D> \$debug_net_smtp,
>  		    "smtp-domain:s" =3D> \$smtp_domain,
> +		    "newsgroups=3Ds" =3D> \@initial_newsgroups,
> +		    "newsgroups-cmd" =3D> \$newsgroups_cmd,
> +		    "nntp-server=3Ds" =3D> \$nntp_server,
> +		    "nntp-server-port=3Ds" =3D> \$nntp_server_port,
> +		    "nntp-user=3Ds" =3D> \$nntp_authuser,
> +		    "nntp-pass:s" =3D> \$nntp_authpass,
> +		    "nntp-debug:i" =3D> \$debug_net_nntp,
> +		    "protocol=3Ds" =3D> \$email_protocol,
>  		    "identity=3Ds" =3D> \$identity,
>  		    "annotate!" =3D> \$annotate,
>  		    "compose" =3D> \$compose,
>  		    "quiet" =3D> \$quiet,
> -		    "cc-cmd=3Ds" =3D> \$cc_cmd,
>  		    "suppress-from!" =3D> \$suppress_from,
>  		    "suppress-cc=3Ds" =3D> \@suppress_cc,
>  		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
> @@ -390,6 +418,24 @@ foreach my $setting (values %config_bool_setting=
s) {
>  	${$setting->[0]} =3D $setting->[1] unless (defined (${$setting->[0]=
}));
>  }
> =20
> +unless ($email_protocol eq 'smtp' || $email_protocol eq 'nntp') {
> +	die "Unsupported protocol: $email_protocol";
> +}
> +
> +# Transport specific setup
> +my ($email_authuser, $email_authpass);
> +if ($email_protocol eq 'nntp') {
> +    $email_authuser =3D $nntp_authuser;
> +    $email_authuser =3D $nntp_authuser;
> +    @initial_to =3D @initial_cc =3D @bcclist =3D ();
> +    $to_cmd =3D $cc_cmd =3D undef;
> +    $no_cc =3D $no_bcc =3D 1;
> +} else {
> +    $email_authuser =3D $smtp_authuser;
> +    $email_authpass =3D $smtp_authpass;
> +    $newsgroups_cmd =3D undef;
> +}
> +
>  # 'default' encryption is none -- this only prevents a warning
>  $smtp_encryption =3D '' unless (defined $smtp_encryption);
> =20
> @@ -668,8 +714,8 @@ EOT
>  		} elsif (/^From:\s*(.+)\s*$/i) {
>  			$sender =3D $1;
>  			next;
> -		} elsif (/^(?:To|Cc|Bcc):/i) {
> -			print "To/Cc/Bcc fields are not interpreted yet, they have been i=
gnored\n";
> +		} elsif (/^(?:To|Cc|Bcc|Newsgroup):/i) {
> +			print "To/Cc/Bcc/Newsgroup fields are not interpreted yet, they h=
ave been ignored\n";
>  			next;
>  		}
>  		print $c2 $_;
> @@ -761,12 +807,21 @@ if (!defined $sender) {
>  }
> =20
>  my $prompting =3D 0;
> -if (!@initial_to && !defined $to_cmd) {
> +
> +if ($email_protocol eq 'smtp' && !@initial_to && !defined $to_cmd) {
>  	my $to =3D ask("Who should the emails be sent to (if any)? ",
>  		     default =3D> "",
>  		     valid_re =3D> qr/\@.*\./, confirm_only =3D> 1);
>  	push @initial_to, parse_address_line($to) if defined $to; # sanitiz=
ed/validated later
>  	$prompting++;
> +} elsif ($email_protocol eq 'nntp' &&
> +	 !@initial_newsgroups &&
> +	 !defined $newsgroups_cmd) {
> +	my $newsgroup =3D ask("Which newsgroups should the message be sent =
to (if any)? ",
> +		     default =3D> "",
> +		     valid_re =3D> qr/[\x20-\x7f]+/, confirm_only =3D> 1);
> +	push @initial_newsgroups, $newsgroup if defined $newsgroup; # sanit=
ized/validated later
> +	$prompting++;
>  }
> =20
>  sub expand_aliases {
> @@ -802,7 +857,7 @@ if (defined $initial_reply_to) {
>  	$initial_reply_to =3D "<$initial_reply_to>" if $initial_reply_to ne=
 '';
>  }
> =20
> -if (!defined $smtp_server) {
> +if ($email_protocol eq 'smtp' && !defined $smtp_server) {
>  	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
>  		if (-x $_) {
>  			$smtp_server =3D $_;
> @@ -1048,41 +1103,56 @@ sub maildomain {
>  	return maildomain_net() || maildomain_mta() || 'localhost.localdoma=
in';
>  }
> =20
> -sub smtp_host_string {
> -	if (defined $smtp_server_port) {
> -		return "$smtp_server:$smtp_server_port";
> +sub email_host_string {
> +	if ($email_protocol eq 'nntp') {
> +		if (defined $nntp_server_port) {
> +			return "$nntp_server:$nntp_server_port";
> +		} else {
> +			return $nntp_server;
> +		}
> +
>  	} else {
> -		return $smtp_server;
> +		if (defined $smtp_server_port) {
> +			return "$smtp_server:$smtp_server_port";
> +		} else {
> +			return $smtp_server;
> +		}
>  	}
>  }
> =20
>  # Returns 1 if authentication succeeded or was not necessary
>  # (smtp_user was not specified), and 0 otherwise.
> =20
> -sub smtp_auth_maybe {
> -	if (!defined $smtp_authuser || $auth) {
> +sub email_auth_maybe {
> +	if (!defined $email_authuser || $auth) {
>  		return 1;
>  	}
> =20
>  	# Workaround AUTH PLAIN/LOGIN interaction defect
>  	# with Authen::SASL::Cyrus
> -	eval {
> -		require Authen::SASL;
> -		Authen::SASL->import(qw(Perl));
> -	};
> +	if ($email_protocol eq 'smtp') {
> +		eval {
> +			require Authen::SASL;
> +			Authen::SASL->import(qw(Perl));
> +		};
> +	}
> =20
>  	# TODO: Authentication may fail not because credentials were
>  	# invalid but due to other reasons, in which we should not
>  	# reject credentials.
>  	$auth =3D Git::credential({
> -		'protocol' =3D> 'smtp',
> -		'host' =3D> smtp_host_string(),
> -		'username' =3D> $smtp_authuser,
> +		'protocol' =3D> $email_protocol,
> +		'host' =3D> email_host_string(),
> +		'username' =3D> $email_authuser,
>  		# if there's no password, "git credential fill" will
>  		# give us one, otherwise it'll just pass this one.
> -		'password' =3D> $smtp_authpass
> +		'password' =3D> $email_authpass
>  	}, sub {
>  		my $cred =3D shift;
> +		if ($email_protocol eq 'nntp') {
> +			return !!$nntp->authinfo($cred->{'username'},
> +						 $cred->{'password'});
> +		}
>  		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
>  	});
> =20
> @@ -1099,7 +1169,7 @@ sub send_message {
>  		      not grep { $cc eq $_ || $_ =3D~ /<\Q${cc}\E>$/ } @recipients
>  		    }
>  	       @cc);
> -	my $to =3D join (",\n\t", @recipients);
> +	my $to =3D join (",\n\t", (($email_protocol eq 'nntp') ? @newsgroup=
s : @recipients));
>  	@recipients =3D unique_email_list(@recipients,@cc,@bcclist);
>  	@recipients =3D (map { extract_valid_address_or_die($_) } @recipien=
ts);
>  	my $date =3D format_2822_time($time++);
> @@ -1117,12 +1187,17 @@ sub send_message {
>  	make_message_id() unless defined($message_id);
> =20
>  	my $header =3D "From: $sanitized_sender
> -To: $to${ccline}
>  Subject: $subject
>  Date: $date
>  Message-Id: $message_id
>  X-Mailer: git-send-email $gitversion
>  ";
> +	if ($email_protocol eq 'nntp') {
> +		$header =3D "Newsgroups: $to\n" . $header;
> +	} else {
> +		$header =3D "To: $to${ccline}\n" . $header;
> +	}
> +
>  	if ($reply_to) {
> =20
>  		$header .=3D "In-Reply-To: $reply_to\n";
> @@ -1174,6 +1249,18 @@ X-Mailer: git-send-email $gitversion
> =20
>  	if ($dry_run) {
>  		# We don't want to send the email.
> +	} elsif ($email_protocol eq 'nntp') {
> +		if (!defined $nntp_server) {
> +			die "The requires NNTP server is not properly defined."
> +		}
> +		require Net::NNTP;
> +		$nntp =3D  Net::NNTP->new(email_host_string(),
> +		                        Debug =3D> $debug_net_nntp);
> +		email_auth_maybe or die $nntp->message;
> +		$nntp->post or die $nntp->message;
> +		$nntp->datasend("$header\n$message") or die $nntp->message;
> +		$nntp->dataend() or die $nntp->message;
> +		$nntp->code eq "240" or die "Failed to send $subject\n".$nntp->mes=
sage;
>  	} elsif ($smtp_server =3D~ m#^/#) {
>  		my $pid =3D open my $sm, '|-';
>  		defined $pid or die $!;
> @@ -1195,11 +1282,10 @@ X-Mailer: git-send-email $gitversion
>  			$smtp ||=3D Net::SMTP::SSL->new($smtp_server,
>  						      Hello =3D> $smtp_domain,
>  						      Port =3D> $smtp_server_port);
> -		}
> -		else {
> +		} else {
>  			require Net::SMTP;
>  			$smtp_domain ||=3D maildomain();
> -			$smtp ||=3D Net::SMTP->new(smtp_host_string(),
> +			$smtp ||=3D Net::SMTP->new(email_host_string(),
>  						 Hello =3D> $smtp_domain,
>  						 Debug =3D> $debug_net_smtp);
>  			if ($smtp_encryption eq 'tls' && $smtp) {
> @@ -1227,7 +1313,7 @@ X-Mailer: git-send-email $gitversion
>  			    defined $smtp_server_port ? " port=3D$smtp_server_port" : "";
>  		}
> =20
> -		smtp_auth_maybe or die $smtp->message;
> +		email_auth_maybe or die $smtp->message;
> =20
>  		$smtp->mail( $raw_from ) or die $smtp->message;
>  		$smtp->to( @recipients ) or die $smtp->message;
> @@ -1240,7 +1326,9 @@ X-Mailer: git-send-email $gitversion
>  		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
>  	} else {
>  		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
> -		if ($smtp_server !~ m#^/#) {
> +		if ($email_protocol eq 'nntp') {
> +			print "Server: $nntp_server\n";
> +		} elsif ($smtp_server !~ m#^/#) {
>  			print "Server: $smtp_server\n";
>  			print "MAIL FROM:<$raw_from>\n";
>  			foreach my $entry (@recipients) {
> @@ -1250,9 +1338,10 @@ X-Mailer: git-send-email $gitversion
>  			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\=
n";
>  		}
>  		print $header, "\n";
> -		if ($smtp) {
> -			print "Result: ", $smtp->code, ' ',
> -				($smtp->message =3D~ /\n([^\n]+\n)$/s), "\n";
> +		my $transport =3D $nntp || $smtp;
> +		if ($transport) {
> +			print "Result: ", $transport->code, ' ',
> +				($transport->message =3D~ /\n([^\n]+\n)$/s), "\n";
>  		} else {
>  			print "Result: OK\n";
>  		}
> @@ -1383,6 +1472,9 @@ foreach my $t (@files) {
>  	}
>  	close $fh;
> =20
> +	push @newsgroups, recipients_cmd("newsgroups-cmd", "newsgroups",
> +					 $newsgroups_cmd, $t)
> +		if defined $newsgroups_cmd;
>  	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
>  		if defined $to_cmd;
>  	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
> @@ -1430,6 +1522,7 @@ foreach my $t (@files) {
>  	@to =3D validate_address_list(sanitize_address_list(@to));
>  	@cc =3D validate_address_list(sanitize_address_list(@cc));
> =20
> +	@newsgroups =3D (@initial_newsgroups, @newsgroups);
>  	@to =3D (@initial_to, @to);
>  	@cc =3D (@initial_cc, @cc);
> =20
> @@ -1479,6 +1572,7 @@ sub cleanup_compose_files {
>  }
> =20
>  $smtp->quit if $smtp;
> +$nntp->quit if $nntp;
> =20
>  sub unique_email_list {
>  	my %seen;
