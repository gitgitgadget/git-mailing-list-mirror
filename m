From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 18:30:58 +0100
Message-ID: <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O110G-0001ER-Cb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab0DKRbD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 13:31:03 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:55269 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336Ab0DKRbA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:31:00 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 627D4819C6D7;
	Sun, 11 Apr 2010 18:30:53 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 2282820CF4D;
	Sun, 11 Apr 2010 18:30:59 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hpgC8FSCgfQs; Sun, 11 Apr 2010 18:30:58 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 65A66C8153;
	Sun, 11 Apr 2010 18:30:58 +0100 (BST)
In-Reply-To: <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144661>

On Sun, 11 Apr 2010 17:48:28 +0200, Sverre Rabbelier
<srabbelier@gmail.com>
wrote:
> Heya,
>=20
> On Sun, Apr 11, 2010 at 13:37, Julian Phillips
<julian@quantumfyre.co.uk>
> wrote:
>> Here is an attempt at making a format agnostic structured output
>> library. =C2=A0The
>> idea being that the command doing the output doesn't have to care wh=
at
>> the
>> actual output format is, it just uses the abstract notion of objects
and
>> arrays.
>=20
> How easy is it to add support for this to other commands using the
> infrastructure this command adds? I assume that we'd want to do this
> for all/most plumbing commands, so I think it's important that we mak=
e
> sure it's easy to add for other commands other than 'git status', no?

It's intended to be easy, as the intention was to make the structured
output available from all plumbing commands (and maybe even some porcel=
ain
commands, if they are often scripted?).  Easy is in the eye of the beho=
lder
though.  I've done ls-tree as an example below (I expect my MUA will
probably mangle the patch - sorry).  I didn't think it was too hard, bu=
t
that's not really surprising since I wrote the API ... you'll have to t=
ell
me what you think.

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dc86b0d..7b5a5e8 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "output.h"
=20
 static int line_termination =3D '\n';
 #define LS_RECURSIVE 1
@@ -22,6 +23,7 @@ static int ls_options;
 static const char **pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+static struct output_context *oc;
=20
 static const  char * const ls_tree_usage[] =3D {
 	"git ls-tree [<options>] <tree-ish> [path...]",
@@ -90,6 +92,25 @@ static int show_tree(const unsigned char *sha1, cons=
t
char *base, int baselen,
 	    (baselen < chomp_prefix || memcmp(ls_tree_prefix, base,
chomp_prefix)))
 		return 0;
=20
+	if (oc !=3D NULL) {
+		output_start_object(oc, "entry");
+		output_strf(oc, "path", "%s%s", base + chomp_prefix, pathname);
+		if (!(ls_options & LS_NAME_ONLY)) {
+			output_strf(oc, "mode", "%06o", mode);
+			output_str(oc, "type", type);
+			output_str(oc, "hash", sha1_to_hex(sha1));
+			if ((ls_options & LS_SHOW_SIZE) && !strcmp(type, blob_type)) {
+				unsigned long size;
+				if (sha1_object_info(sha1, &size) =3D=3D OBJ_BAD)
+					output_str(oc, "size", "bad");
+				else
+					output_uint(oc, "size", size);
+			}
+		}
+		output_end_current(oc);
+		return retval;
+	}
+
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
@@ -119,6 +140,8 @@ int cmd_ls_tree(int argc, const char **argv, const
char *prefix)
 	unsigned char sha1[20];
 	struct tree *tree;
 	int full_tree =3D 0;
+	char *structured_output_arg =3D NULL;
+	enum output_style output_style;
 	const struct option ls_tree_options[] =3D {
 		OPT_BIT('d', NULL, &ls_options, "only show trees",
 			LS_TREE_ONLY),
@@ -140,6 +163,7 @@ int cmd_ls_tree(int argc, const char **argv, const
char *prefix)
 			    "list entire tree; not just current directory "
 			    "(implies --full-name)"),
 		OPT__ABBREV(&abbrev),
+		OPT_OUTPUT(0, "structured-output", &structured_output_arg),
 		OPT_END()
 	};
=20
@@ -159,6 +183,8 @@ int cmd_ls_tree(int argc, const char **argv, const
char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |=3D LS_SHOW_TREES;
=20
+	output_style =3D handle_output_arg(structured_output_arg);
+
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_sha1(argv[0], sha1))
@@ -168,7 +194,16 @@ int cmd_ls_tree(int argc, const char **argv, const
char *prefix)
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
+
+	if (output_style !=3D OUTPUT_NORMAL) {
+		oc =3D output_start(output_style);
+		output_start_array(oc, "entries");
+	}
+
 	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree, NULL);
=20
+	if (output_style !=3D OUTPUT_NORMAL)
+		output_end(oc);
+
 	return 0;
 }


--=20
Julian
