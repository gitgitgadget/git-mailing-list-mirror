Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF37610B
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754228214; cv=none; b=md92hTbvyN2adBKMGHIQmEpFwi64k5bHNHbHT/68WAQTLEZbVuRB2j8B/cg8Pn+eAYhdugEdEh8owxMVAsA08Oq4JPn7Gpi3E9qCg3/4lbTRPXDUIL5h7ezAckJDM7VzLBggRyNJdR/e9Rd2ILJVr5hHXWdYb1DBdo2a9fL7WXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754228214; c=relaxed/simple;
	bh=k1heT+HZM2SRuagTnleJBC45+KVg6fuuMR5A+4BMXVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GfRkLuWQO2TP0Rkj9VJ1W7S5PWPqb3c6vuhOs1vTK68kBqi8M6Xau8PpZXnlqJLCnP8RC3YEC9DlcYq2HlFYOA3VpEG/KeAnb3ZmgxKbMc9+qySSrYHfFhjWzm5pOgDrlc1u4CTwM83DphjRxdqXT7h3Ic6sQU+pLP4lr8GZxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=dQ6xe5NO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="dQ6xe5NO"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1754228207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfCnAng0eVnxPvVZuDIWaKwzesMVayWQf3/9yeYPYJk=;
	b=dQ6xe5NO6qoakTpJUasGzcwdnqtOMU6tayOe9AUUcORlhpIwDJoTvgZQq7xTmu7j4EunJk
	Sbw7aLuT3K0qB7E2zN3mUxH+AALFXd5UyRrhMzGl3do5pDIy41tKe4xX03q+HSUIcIqCqo
	F4oCm9TNp95X3dMJoP1LY+FqtdR3LOU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 Aug 2025 15:36:47 +0200
Message-Id: <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org>
To: "Aditya Garg" <gargaditya08@live.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>, "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>, "Ben Knoble" <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add --get-smtp-server option to fetch
 SMTP settings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
References: <20250730151227.12389-1-gargaditya08@live.com>
In-Reply-To: <20250730151227.12389-1-gargaditya08@live.com>
X-Migadu-Flow: FLOW_OUT

Hi Aditya, really cool idea, here are some random thoughts:

On Wed Jul 30, 2025 at 5:12 PM CEST, Aditya Garg wrote:
> Autoconfiguring SMTP server settings is a common feature present in many
> email clients. In order to get the correct SMTP server settings easily,
> this commit adds a `--get-smtp-server` option to `git send-email`. This
> option attempts to fetch the SMTP server settings for a given email addre=
ss
> via the following steps:
>
> 1. It first tries to fetch the settings from Mozilla's ISPDB at
>    `https://autoconfig.thunderbird.net/v1.1/[domain]`.

We should first check autoconfig and then move to the 3rd party
database, this is how thunderbird[0] and aerc[1] do it.

>
> 2. If that fails, it attempts to fetch the autoconfig file from the email
>    provider's autoconfig URL, which is typically in the format
>    `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[emai=
l]`.

The documentation mentions using `DOMAIN/.well-known/autoconfig/mail/`
as an alternative to the autoconfig subdomain, what do you think about
supporting that?

>
> 3. If that also fails, it falls back to checking the MX records of the
>    domain used in the email address to find the SMTP server. It can be
>    useful in case of emails with custom domains. It attempts to guess
>    the correct domain for the email from the MX records, and repeats the
>    first 2 steps with the guessed domain.
>
> This feature is heavily inpired by the autoconfig feature in Mozilla

s/inpired/inspired


> +sub parse_config {
> +	require XML::LibXML;
> +	my ($xml, $email) =3D @_;
> +	my $parser =3D XML::LibXML->new;
> +	my $doc =3D eval { $parser->load_xml(string =3D> $xml) };
> +	die "Failed to parse XML\n" unless $doc;
> +	my $config_num =3D 0;
> +	my $smtp_encryption_config;
> +	my $smtp_user_config;
> +
> +	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
> +		$config_num++;
> +		if ($outgoing->findvalue('./socketType') eq 'SSL') {
> +			$smtp_encryption_config =3D 'ssl';
> +		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
> +			$smtp_encryption_config =3D 'tls';
> +		} else {
> +			$smtp_encryption_config =3D 'plain';

'plain' is unencrypted, I think this should be accompanied by a big
warning.

> +		}
> +
> +		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
> +			$smtp_user_config =3D $email;
> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {
> +			$smtp_user_config =3D (split /@/, $email)[0];
> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
> +			$smtp_user_config =3D (split /@/, $email)[1];
> +		} else {
> +			$smtp_user_config =3D $outgoing->findvalue('./username');
> +		}
> +
> +		print "\nConfiguration $config_num:\n";
> +		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
> +		print "  Port: ", $outgoing->findvalue('./port'), "\n";
> +		print "  Encryption: ", $smtp_encryption_config, "\n";
> +		print "  Username: ", $smtp_user_config, "\n";

The new option only gives you the needed SMTP configuration, as a
user you still need to apply them and to do that you will need to
look up how. We could help the user here and give them copy and
paste commands similar to when trying to commit without having an
identity set.

The XML file also contains authentication details, what do you think
about processing those? That would also allow adding references to the
documentation in case it is OAuth2.

> +	}
> +}
> +
> +if ($get_smtp_server) {
> +	require URI::Escape;
> +	print "Enter your email address: ";
> +	chomp(my $email =3D <STDIN>);

Someone sending out emails will most likely already have set up
`user.email` in their gitconfig. We could just use that instead of
prompting for user input, or at least suggest it as a default.

If you don't have an SMTP server configured then `git send-email`
will default to `localhost` and fail if you are not running a
local SMTP server with: `Unable to initialize SMTP properly.
Check config and use --smtp-debug.`. I would suggest altering the
message pointing the user to the new option.

Regards Julian

[0]: https://hg-edge.mozilla.org/comm-central/file/tip/mail/components/acco=
untcreation/content/accountSetup.js#l57
[1]: https://git.sr.ht/~rjarry/aerc/tree/d31995f1e20b1eff28f9cbe95c14efc90d=
991e9a/item/lib/autoconfig/get.go#L29
