From: Jeff King <peff@peff.net>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Wed, 4 Nov 2009 02:10:54 -0500
Message-ID: <20091104071053.GB24263@coredump.intra.peff.net>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
 <20091104063612.GA24263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5a1H-0001rb-LX
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZKDHKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 02:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZKDHKx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:10:53 -0500
Received: from peff.net ([208.65.91.99]:59845 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbZKDHKw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:10:52 -0500
Received: (qmail 8211 invoked by uid 107); 4 Nov 2009 07:14:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Nov 2009 02:14:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2009 02:10:54 -0500
Content-Disposition: inline
In-Reply-To: <20091104063612.GA24263@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132048>

On Wed, Nov 04, 2009 at 01:36:13AM -0500, Jeff King wrote:

> Here's a patch which fixes the regression, but it feels awfully hack-=
ish
> to me, as it treats "-p" specially in diff_opt (but in a way that no
> other existing code should care about). It would be "cleaner" to me t=
o
> have some infrastructure for keeping an implicit and an explicit form=
at,
> and then merging them at the end. But I don't think we ever care abou=
t
> this explicitness for any other formats, so this is at least simple.
>=20
> Another option might be for format-patch to simply parse "-p" itself,
> setting the format and marking an "explicit" flag. I'll look into tha=
t
> as an alternative.

OK, doing that turned out to be much nicer. Less code, localized to
format-patch, and less confusing to read.

This patch goes on top of master, and terribly conflicts with Bj=C3=B6r=
n's
changes in the area. But I had the impression you wanted to revert thos=
e
changes for now anyway, so probably this should go in as a bug fix and
everything else should be built on top. It actually would be an even
smaller change on top of his "always show patch, even when other format=
s
are given" change, but I didn't want to depend on it.

-- >8 --
Subject: [PATCH] format-patch: make "-p" suppress diffstat

Once upon a time, format-patch would use its default stat
plus patch format only when no diff format was given on the
command line. This meant that "format-patch -p" would
suppress the stat and show just the patch.

Commit 68daa64 changed this to keep the stat format when we
had an "implicit" patch format, like "-U5". As a side
effect, this meant that an explicit patch format was now
ignored (because cmd_format_patch didn't know the reason
that the format was set way down in diff_opt_parse).

This patch unbreaks what 68daa64 did (while still preserving
what 68daa64 was trying to do), reinstating "-p" to suppress
the default behavior. We do this by parsing "-p" ourselves
in format-patch, and noting whether it was used explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
The help text for "-p" is up for debate. It can also of course be used
as "show patch in addition to other things you already specified on the
command line". But I wanted to point out that its main use is the side
effect that it suppresses the default output. I am open to suggestions.

 builtin-log.c           |    9 +++++++--
 t/t4014-format-patch.sh |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 207a361..da79047 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -891,6 +891,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	struct patch_ids ids;
 	char *add_signoff =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
+	int use_patch_format =3D 0;
 	const struct option builtin_format_patch_options[] =3D {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    "use [PATCH n/m] even with a single patch",
@@ -940,6 +941,8 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
 			    "enable message threading, styles: shallow, deep",
 			    PARSE_OPT_OPTARG, thread_callback },
+		OPT_BOOLEAN('p', NULL, &use_patch_format,
+			"show patch format instead of default (patch + stat)"),
 		OPT_END()
 	};
=20
@@ -1027,8 +1030,10 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
=20
-	if (!rev.diffopt.output_format
-		|| rev.diffopt.output_format =3D=3D DIFF_FORMAT_PATCH)
+	if (patch_format)
+		rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
+	else if (!rev.diffopt.output_format ||
+		  rev.diffopt.output_format =3D=3D DIFF_FORMAT_PATCH)
 		rev.diffopt.output_format =3D DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUM=
MARY | DIFF_FORMAT_PATCH;
=20
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 531f5b7..cab6ce2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -455,6 +455,27 @@ test_expect_success 'format-patch respects -U' '
=20
 '
=20
+cat > expect << EOF
+
+diff --git a/file b/file
+index 40f36c6..2dc5c23 100644
+--- a/file
++++ b/file
+@@ -14,3 +14,19 @@ C
+ D
+ E
+ F
++5
+EOF
+
+test_expect_success 'format-patch -p suppresses stat' '
+
+	git format-patch -p -2 &&
+	sed -e "1,/^$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subje=
ct-line-for-a-messa.patch > output &&
+	test_cmp expect output
+
+'
+
 test_expect_success 'format-patch from a subdirectory (1)' '
 	filename=3D$(
 		rm -rf sub &&
--=20
1.6.5.2.308.g2bb5
