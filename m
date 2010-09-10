From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] git-svn: Use platform-specific svn authentication
	providers (e.g., gnome-keyring)
Date: Fri, 10 Sep 2010 12:07:05 +0200
Message-ID: <20100910100705.GJ22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YqRP4mvCGTXkUB2y"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 12:07:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou0Vo-0006oz-HX
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 12:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab0IJKHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 06:07:10 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:35378 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0IJKHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 06:07:07 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1Ou0Vd-0002ua-D7
	for git@vger.kernel.org; Fri, 10 Sep 2010 12:07:06 +0200
Received: (nullmailer pid 11192 invoked by uid 1000);
	Fri, 10 Sep 2010 10:07:05 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://katherina.student.utwente.nl/~matthijs/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155924>


--YqRP4mvCGTXkUB2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've create below patch to make git work with platform-specific
authentication providers (in particular, I needed this to get my svn
passwords out of gnome-keyring, which isn't working currently).

Index: git-core/git-svn
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- git-core.orig/git-svn       2010-09-08 20:11:16.000000000 +0200
+++ git-core/git-svn    2010-09-08 20:26:38.000000000 +0200
@@ -4830,6 +4830,7 @@
=20
 sub _auth_providers () {
        [
+         @{SVN::Core::auth_get_platform_specific_client_providers(undef, u=
ndef)},
          SVN::Client::get_simple_provider(),
          SVN::Client::get_ssl_server_trust_file_provider(),
          SVN::Client::get_simple_prompt_provider(

Note that the auth_get_platform_specific_client_provides function used is n=
ot
working correctly in current versions of SVN, I've posted a separate patch =
to
fix the perl bindings there [1].

[1]: http://svn.haxx.se/dev/archive-2010-09/0171.shtml

Furthermore, the function accepts two parameters: $config and $pool. I've l=
eft
both undef here, which works. For $config, this means the default set of
providers is used. I'm not sure what the implications are of not passing a
$pool, any comments?

The _auth_providers function is called from:
 - Git::SVN::Ra::new, where a $config and $pool would be available.
 - Git::SVN::Ra::trees_match, where neither is readily available (though
   looking more closely, it seems that both values are in fact stored in $s=
elf in
   the new method, so they would be available.
 - cmd_branch, where neither seems to be available.

So it does not seem trivial to pass in useful values for these two argument=
s in
all places. Any ideas on what would be a good way to handle this?

What's the idea behind custom SVN configuration anyway?  From the sources, =
it
seems that only a few commands allow specifying the SVN configuration, thro=
ugh
the --config-dir option (namely init, migrate, fetch, clone, dcommit, set-t=
ree,
multi-fetch, rebase, but notably not dcommit).

Gr.

Matthijs

--YqRP4mvCGTXkUB2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyKA0kACgkQz0nQ5oovr7zuUwCg4XQOzinLu2qy0ifAPp0dgWBb
HuoAoMPlr5HV1l/NgjW5aqxkJgu74IeI
=5rG9
-----END PGP SIGNATURE-----

--YqRP4mvCGTXkUB2y--
