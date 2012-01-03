From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git-svn: enable platform-specific authentication
Date: Tue, 3 Jan 2012 21:44:04 +0100
Message-ID: <20120103204403.GI17548@login.drsnuggles.stderr.nl>
References: <1305708320-8614-1-git-send-email-grddev@gmail.com> <20110518195710.GA10697@dcvr.yhbt.net> <20110809210638.GK6418@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah9ph+G2cWRpKogL"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
X-From: git-owner@vger.kernel.org Tue Jan 03 22:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiBZs-0001tX-Ou
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 22:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab2ACVHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 16:07:20 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:43394 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab2ACVHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 16:07:18 -0500
X-Greylist: delayed 1386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jan 2012 16:07:17 EST
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1RiBDI-0002HL-2j; Tue, 03 Jan 2012 21:44:05 +0100
Received: (nullmailer pid 8760 invoked by uid 1000);
	Tue, 03 Jan 2012 20:44:04 -0000
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110809210638.GK6418@login.drsnuggles.stderr.nl>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -1.9 (-)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.7 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187897>


--Ah9ph+G2cWRpKogL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

I sent the below patch a few months ago, and not having it applied in
git-svn bit me again just now. Did any of you get a chance to have a
look at it?

I'm still not 100% sure if this patch is correct for all the corner
cases, but it works like a charm in the regular case.

Perhaps it should just be included as is?

Gr.

Matthijs

On Tue, Aug 09, 2011 at 11:06:38PM +0200, Matthijs Kooijman wrote:
> Hey folks,
>=20
> > > Use the platform-specific authentication providers that are
> > > exposed to subversion bindings starting with subversion 1.6.
> >=20
> > This came up several months ago, I understand there were some issues
> > with the SVN Perl bindings.  Cc-ing interested parties.
> I missed the CC, sorry for that.
>=20
> > >  sub _auth_providers () {
> > >  	[
> > > +	  $SVN::Core::VERSION lt '1.6' ? () :
> > > +	    @{SVN::Core::auth_get_platform_specific_client_providers(
> > > +	      undef,undef)},
> >=20
> > I think it needs to take into account the config from
> > SVN::Core::config_get_config, otherwise people with non-standard SVN
> > configurations could get locked out.  I seem to recall this was the
> > broken part in the SVN Perl bindings, but one of the Cc-ed parties would
> > know for sure.
>=20
> Indeed, but a proposed patch by Eric for this did not work. I solved the
> problem quite some time ago, but apparently I never sent out the
> solution (I think I got distracted by trying to get a passphrase prompt
> to unlock locked keychains). I couldn't find my fixes anymore either,
> but I think I've managed to reproduce them just now.
>=20
> Some basic testing shows below patch works, but I think it might need
> some more testing and work. At least the below patch allows for example
> to disable the gnome-keyring provider from a different svn config
> directory by passing --config-dir /some/path to git-svn (which is not
> possible using above patch passing undef, which will only read from
> ~/.subversion).
>=20
> Using strace, I did notice that git-svn still reads stuff
> from ~/.subversion/auth/svn.ssl.server/ and
> .subversion/auth/svn.simple/, but I couldn't exactly find why this is
> right away. In any case, it also happens without this patch applied, so
> I guess it's a completely separate issue.
>=20
> As for the actual patch, notice that config_get_config returns a hash
> that consists again of a "config" and "servers" patch. Previous attempts
> at this patch passed the entire hash to
> auth_get_platform_specific_client_providers, but it only wants the
> "client" part. It's a bit confusing until you realize that the
> config_get_config return value represents your ~/.subversion directory,
> which again contains a "config" and "servers" file.
>=20
> I'm not 100% sure this patch is correct as it is now. I hope to get
> another look at my "automatically unlock keychain" work tomorrow,
> in case there are some hints about flaws in this patch there. In the
> meanwhile, feedback on this patch is welcome.
>=20
> Gr.
>=20
> Matthijs
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index da3fea8..6dc5196 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4916,7 +4916,7 @@ BEGIN {
>  }
> =20
>  sub _auth_providers () {
> -       [
> +       my @rv =3D (
>           SVN::Client::get_simple_provider(),
>           SVN::Client::get_ssl_server_trust_file_provider(),
>           SVN::Client::get_simple_prompt_provider(
> @@ -4932,7 +4932,23 @@ sub _auth_providers () {
>             \&Git::SVN::Prompt::ssl_server_trust),
>           SVN::Client::get_username_prompt_provider(
>             \&Git::SVN::Prompt::username, 2)
> -       ]
> +       );
> +
> +       # earlier 1.6.x versions would segfault, and <=3D 1.5.x didn't ha=
ve
> +       # this function
> +       if ($SVN::Core::VERSION gt '1.6.12') {
> +               my $config =3D SVN::Core::config_get_config($config_dir);
> +               my ($p, @a);
> +              # config_get_config returns all config files from
> +              # ~/.subversion, auth_get_platform_specific_client_provide=
rs
> +              # just wants the config "file".
> +               @a =3D ($config->{'config'}, undef);
> +               $p =3D SVN::Core::auth_get_platform_specific_client_provi=
ders(@a);
> +              # Insert the return value from
> +              # auth_get_platform_specific_providers
> +               unshift @rv, @$p;
> +       }
> +       \@rv;
>  }
> =20
>  sub escape_uri_only {
>=20



--Ah9ph+G2cWRpKogL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk8DaJMACgkQz0nQ5oovr7yHugCfUKw4/lrcDeS/s2Fltir3fDie
7t0AoJq4MydWH2KMdUHveMJ3l07/sAjP
=pYmW
-----END PGP SIGNATURE-----

--Ah9ph+G2cWRpKogL--
