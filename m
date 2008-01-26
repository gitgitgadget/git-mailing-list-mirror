From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-options: catch some likely in presense of aggregated options.
Date: Sat, 26 Jan 2008 12:26:57 +0100
Message-ID: <20080126112657.GB13922@artemis.madism.org>
References: <1201198439-3516-1-git-send-email-pascal@obry.net> <alpine.LSU.1.00.0801241818441.5731@racer.site> <4798DE6A.1050201@obry.net> <20080124204711.GC17765@kodama.kitenet.net> <7vd4rp3y6e.fsf@gitster.siamese.dyndns.org> <20080126104216.GA13922@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VrqPEDrXMn8OVzN4";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 12:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIjCK-0001tQ-Iu
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 12:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbYAZL1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 06:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbYAZL1A
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 06:27:00 -0500
Received: from pan.madism.org ([88.191.52.104]:53269 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbYAZL07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 06:26:59 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EF7962BAF7;
	Sat, 26 Jan 2008 12:26:57 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 82FE84D64D5; Sat, 26 Jan 2008 12:26:57 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080126104216.GA13922@artemis.madism.org>
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71777>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If options are aggregated, and that the whole token looks like (is the exact
prefix of length >=3D 3 of) a long option, then parse_options rejects it.

The typo check isn't performed if there is no aggregation, because the stuck
for is the recommended one, hence if we have `-o` being a valid short option
that takes an argument, and --option a long one, then we _MUST_ accept
-option as it is our official recommended form.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c          |   30 ++++++++++++++++++++++++++++--
 t/t0040-parse-options.sh |   11 +++++++++++
 test-parse-options.c     |    1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

    On Sat, Jan 26, 2008 at 10:42:16AM +0000, Pierre Habouzit wrote:
    >   I agree, I think that we should refuse things where the string afte=
r a
    > /one/ dash starts with 3 or more consecutive characters that are also
    > the beginning of a long option. I think that 2 is usually a bit "shor=
t"
    > to assume that it's a typo. I'll provide a patch soon

    Here it is, and we have now:

      $ git commit -amend
      error: did you mean `--amend` (with two dashes ?)


diff --git a/parse-options.c b/parse-options.c
index 7a08a0c..d9562ba 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -216,6 +216,26 @@ is_abbreviated:
 	return error("unknown option `%s'", arg);
 }
=20
+void check_typos(const char *arg, const struct option *options)
+{
+	if (strlen(arg) < 3)
+		return;
+
+	if (!prefixcmp(arg, "no-")) {
+		error ("did you mean `--%s` (with two dashes ?)", arg);
+		exit(129);
+	}
+
+	for (; options->type !=3D OPTION_END; options++) {
+		if (!options->long_name)
+			continue;
+		if (!prefixcmp(options->long_name, arg)) {
+			error ("did you mean `--%s` (with two dashes ?)", arg);
+			exit(129);
+		}
+	}
+}
+
 static NORETURN void usage_with_options_internal(const char * const *,
                                                  const struct option *, in=
t);
=20
@@ -235,12 +255,18 @@ int parse_options(int argc, const char **argv, const =
struct option *options,
=20
 		if (arg[1] !=3D '-') {
 			args.opt =3D arg + 1;
-			do {
+			if (*args.opt =3D=3D 'h')
+				usage_with_options(usagestr, options);
+			if (parse_short_opt(&args, options) < 0)
+				usage_with_options(usagestr, options);
+			if (args.opt)
+				check_typos(arg + 1, options);
+			while (args.opt) {
 				if (*args.opt =3D=3D 'h')
 					usage_with_options(usagestr, options);
 				if (parse_short_opt(&args, options) < 0)
 					usage_with_options(usagestr, options);
-			} while (args.opt);
+			}
 			continue;
 		}
=20
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 462fdf2..0a3b55d 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -19,6 +19,7 @@ string options
                           get a string
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
+    -o <str>              get another string
=20
 EOF
=20
@@ -103,4 +104,14 @@ test_expect_success 'non ambiguous option (after two o=
ptions it abbreviates)' '
 	git diff expect output
 '
=20
+cat > expect.err << EOF
+error: did you mean \`--boolean\` (with two dashes ?)
+EOF
+
+test_expect_success 'detect possible typos' '
+	! test-parse-options -boolean > output 2> output.err &&
+	test ! -s output &&
+	git diff expect.err output.err
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 4d3e2ec..eed8a02 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -19,6 +19,7 @@ int main(int argc, const char **argv)
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering=
)"),
+		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_END(),
 	};
 	int i;
--=20
1.5.4.rc4.24.g5232a


--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHmxkBvGr7W6HudhwRAunBAJ96vVD6h2cteOqKm/Ox8QBevWGoVQCeP7/D
FQCJ6e7/U7TxURS94h7dE84=
=l4+O
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
