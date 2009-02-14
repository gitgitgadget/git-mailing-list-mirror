From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH] Documentation: pruning recipe for destructive
 filter-branch
Date: Sat, 14 Feb 2009 07:49:54 +0100
Message-ID: <20090214074954.7e423dd2@perceptron>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
	<20090214025115.615119bf@perceptron>
	<alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 07:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEND-0007Oa-QG
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbZBNGuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 01:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbZBNGuA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:50:00 -0500
Received: from zoidberg.org ([88.198.6.61]:51213 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbZBNGt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Feb 2009 01:49:59 -0500
Received: from perceptron (xdsl-78-34-186-86.netcologne.de [::ffff:78.34.186.86])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 14 Feb 2009 07:49:56 +0100
  id 0042C8CE.49966994.0000388F
In-Reply-To: <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109833>

Hi,

On Sat, 14 Feb 2009 06:46:18 +0100 (CET), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> > Is the --expire=3Dnow actually needed for prune? The way I read it
> > git-prune(1), it defaults to pruning everything anyway.
>=20
> [...] Ah, that default is only set in "git gc", and "git prune" still
> prunes everything. [...] But maybe we do not want to direct the user
> to use "prune" here, but rather "gc"?

I just read the source code of gc and noticed that the only way to
influence its expiration limit for prune is to set it in the config fil=
e
(gc.pruneExpire). Thus there is no immediate way to tell gc to prune
*all* unreachable objects and we need to stick to the instructions that
are in the patch (minus the unnecessary --expire=3Dnow for prune). The
alternative would be to add a command line option to gc that
corresponds to gc.pruneExpire. I don't really care about that, but a
patch for it is below.

-Jan

-----8<-----

=46rom 42226c6c542be4e9fff0817662115f180033e75a Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Jan=3D20Kr=3DC3=3DBCger?=3D <jk@jk.gs>
Date: Sat, 14 Feb 2009 07:39:23 +0100
Subject: [PATCH] gc: add --prune-expire option equivalent to gc.pruneEx=
pire
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

In semi-regular intervals, people tend to want to get rid of huge
objects they accidentally created in a repository. Of course it
shouldn't be too easy to do but also not too hard. Thus we allow them t=
o
get rid of unreferenced objects more easily once they have managed to
make the objects unreferenced, by allowing them to override the prune
expiration limit.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-gc.txt |    5 +++++
 builtin-gc.c             |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 7086eea..a4d35fb 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -59,6 +59,11 @@ are consolidated into a single pack by using the `-A=
` option of
 'git-repack'. Setting `gc.autopacklimit` to 0 disables
 automatic consolidation of packs.
=20
+--prune-expire <time>::
+	Expire unreachable objects older than <time>, rather than
+	considering the configuration variable or the default explained in
+	the next section.
+
 --quiet::
 	Suppress all progress reports.
=20
diff --git a/builtin-gc.c b/builtin-gc.c
index a201438..a62c762 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -179,16 +179,17 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 	int quiet =3D 0;
 	char buf[80];
=20
+	git_config(gc_config, NULL);
+
 	struct option builtin_gc_options[] =3D {
 		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects (depreca=
ted)"),
+		OPT_STRING(0, "prune-expire", &prune_expire, "time", "expire unrefer=
enced objects older than <time>"),
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increas=
ed runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
 		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
 		OPT_END()
 	};
=20
-	git_config(gc_config, NULL);
-
 	if (pack_refs < 0)
 		pack_refs =3D !is_bare_repository();
=20
--=20
1.6.2.rc0.61.g5cd12.dirty
