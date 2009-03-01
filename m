From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add --confirm option
Date: Sun, 01 Mar 2009 01:03:11 -0800
Message-ID: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
References: <1235895801-80414-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 10:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdhbR-0006AB-K9
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 10:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZCAJDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 04:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbZCAJDZ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 04:03:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZCAJDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 04:03:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A2F72C41;
	Sun,  1 Mar 2009 04:03:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EE3D12C40; Sun, 
 1 Mar 2009 04:03:13 -0500 (EST)
In-Reply-To: <1235895801-80414-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sun, 1 Mar 2009 03:23:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CF89638C-063F-11DE-8797-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111829>

Jay Soffian <jaysoffian@gmail.com> writes:

> send-email violates the principle of least surprise by automatically
> cc'ing additional recipients without confirming this with the user.
>
> This patch teaches send-email a --confirm option. It takes the
> following values:
>
>  --confirm=3Dalways   always confirm before sending
>  --confirm=3Dnever    never confirm before sending
>  --confirm=3Dcc       confirm before sending when send-email has
>                     automatically added addresses from the patch to
>                     the Cc list
>  --confirm=3Dcompose  confirm before sending the first message when
>                     using --compose. (Needed to maintain backwards
>                     compatibility with existing behavior.)
>  --confirm=3Dauto     'cc' + 'compose'
>
> The option defaults to 'compose' if any suppress Cc related options h=
ave
> been used, otherwise it defaults to 'auto'.

It is hard to judge if this is a good thing to do _at this point_.  Tho=
se
who complained may welcome it but that is hardly the point.  You need t=
o
convince those who stayed silent (because they thought the default won'=
t
change and were not paying attention) that it is a good change.

Especially the changes (not additions) to existing tests worries me; ea=
ch
change to the existing one is a demonstration of breaking existing user=
s.

You cannot retrofit safety by disallowing things once you used to allow=
,
without upsetting existing users.

> @@ -837,6 +834,25 @@ X-Mailer: git-send-email $gitversion
>  	unshift (@sendmail_parameters,
>  			'-f', $raw_from) if(defined $envelope_sender);
> =20
> +	if ($needs_confirm && !$dry_run) {
> +		print "\n$header\n";
> +		while (1) {
> +			chomp ($_ =3D $term->readline(
> +				"Send this email? ([y]es|[n]o|[q]uit|[a]ll): "
> +			));
> +			last if /^(?:yes|y|no|n|quit|q|all|a)/i;
> +			print "\n";
> +		}
> +		if (/^n/i) {
> +			return;
> +		} elsif (/^q/i) {
> +			cleanup_compose_files();
> +			exit(0);
> +		} elsif (/^a/i) {
> +			$confirm =3D 'never';
> +		}
> +	}

I think "[a]ll" would make it a bit less objectionable to people who ha=
te
unsolicited confirmation dialogs.  Nice touch.

> @@ -1094,13 +1119,10 @@ foreach my $t (@files) {
>  	$message_id =3D undef;
>  }
> =20
> -if ($compose) {
> -	cleanup_compose_files();
> -}
> +cleanup_compose_files();
> =20
>  sub cleanup_compose_files() {
> -	unlink($compose_filename, $compose_filename . ".final");
> -
> +	unlink($compose_filename, $compose_filename . ".final") if $compose=
;
>  }

Does this hunk have anything to do with this topic, or is it just a chu=
rn
that does not change any behaviour?

> @@ -175,15 +180,13 @@ test_set_editor "$(pwd)/fake-editor"
> =20
>  test_expect_success '--compose works' '
>  	clean_fake_sendmail &&
> -	echo y | \
> -		GIT_SEND_EMAIL_NOTTY=3D1 \
> -		git send-email \
> -		--compose --subject foo \
> -		--from=3D"Example <nobody@example.com>" \
> -		--to=3Dnobody@example.com \
> -		--smtp-server=3D"$(pwd)/fake.sendmail" \
> -		$patches \
> -		2>errors
> +	git send-email \
> +	--compose --subject foo \
> +	--from=3D"Example <nobody@example.com>" \
> +	--to=3Dnobody@example.com \
> +	--smtp-server=3D"$(pwd)/fake.sendmail" \
> +	$patches \
> +	2>errors
>  '

How would test this break without this hunk?  "echo" dies of sigpipe, o=
r
something?

I am not objecting to this particular change; just asking why this chan=
ge
is here.  "It does not break, but the command shouldn't ask for
confirmation, and giving 'y' into it is unnecessary" is a perfectly
acceptable answer, but if that is the case you probably would want to
verify that the command indeed does go ahead without asking.

> @@ -375,15 +378,56 @@ test_expect_success '--suppress-cc=3Dcc' '
>  	test_suppression cc
>  '
> =20
> +test_confirm () {
> +	echo y | \
> +		GIT_SEND_EMAIL_NOTTY=3D1 \
> +		git send-email \
> +		--from=3D"Example <nobody@example.com>" \
> +		--to=3Dnobody@example.com \
> +		--smtp-server=3D"$(pwd)/fake.sendmail" \
> +		$@ \
> +		$patches | grep "Send this email"
> +}
> +
> +test_expect_success '--confirm=3Dalways' '
> +	test_confirm --confirm=3Dalways --suppress-cc=3Dall
> +'
> + ...
> +test_expect_success 'confirm by default (due to --compose)' '
> +	CONFIRM=3D$(git config --get sendemail.confirm) &&
> +	git config --unset sendemail.confirm &&
> +	test_confirm --suppress-cc=3Dall --compose
> +	ret=3D"$?"
> +	git config sendemail.confirm ${CONFIRM:-never}
> +	test $ret =3D "0"
> +'

These all test you would get a prompt when you as the author expect the
code to give one.  Do you also need tests that verify you do not ask
needless confirmation when the code shouldn't?

>  test_expect_success '--compose adds MIME for utf8 body' '
>  	clean_fake_sendmail &&
>  	(echo "#!$SHELL_PATH" &&
>  	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
>  	) >fake-editor-utf8 &&
>  	chmod +x fake-editor-utf8 &&
> -	echo y | \
>  	  GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\"" \
> -	  GIT_SEND_EMAIL_NOTTY=3D1 \
>  	  git send-email \
>  	  --compose --subject foo \
>  	  --from=3D"Example <nobody@example.com>" \

If the change you made to git-send-email.perl is later broken and the
command (incorrectly) starts asking for confirmation with these command
line options, what does this test do?  Does it get stuck, forbidding th=
e
test suite to be run unattended?
