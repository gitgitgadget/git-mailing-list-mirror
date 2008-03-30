From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 01:39:16 +0200
Message-ID: <20080330233916.GU11666@genesis>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg78E-0003wF-Rj
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYC3XjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 19:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYC3XjS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:39:18 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60440 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbYC3XjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:39:18 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DD0521B2579;
	Mon, 31 Mar 2008 01:39:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C3E8844659;
	Mon, 31 Mar 2008 01:36:08 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 55ECF1190547; Mon, 31 Mar 2008 01:39:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080330232612.GA23063@atjola.homenet>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78526>

This patch modifies git gc --auto so that it will not always repack whe=
n
a user is on battery.

It introduces the new gc.deferonbattery configuration variable, which
defaults to true. If it's true and the user is on battery, it will not
run git gc --auto.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Mar 31, 2008 at 01:26:12AM +0200, Bj=F6rn Steinbrink <B.Steinbr=
ink@gmx.de> wrote:
> Hm, maybe move that check into need_to_gc instead? Seems a bit weird
> to
> lie about the status instead of just skipping the status check.

Right, I've moved the check to need_to_gc().

> The /proc stuff is already deprecated IIRC, the new file to check on
> Linux is /sys/class/power_supply/AC/online.

And that makes the patch smaller as well. :)

Something like this?

 Documentation/git-gc.txt |    4 ++++
 builtin-gc.c             |   24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index d424a4e..7d54148 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -104,6 +104,10 @@ The optional configuration variable 'gc.pruneExpir=
e' controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
=20
+The optional configuration variable 'gc.deferonbattery' determines if
+`git gc --auto` should be disabled if the system is running on battery=
=2E
+This defaults to true.
+
 See Also
 --------
 linkgit:git-prune[1]
diff --git a/builtin-gc.c b/builtin-gc.c
index 8cef36f..512a357 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -23,6 +23,7 @@ static const char * const builtin_gc_usage[] =3D {
 };
=20
 static int pack_refs =3D 1;
+static int defer_on_battery =3D 1;
 static int aggressive_window =3D -1;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
@@ -67,6 +68,10 @@ static int gc_config(const char *var, const char *va=
lue)
 		prune_expire =3D xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.deferonbattery")) {
+		defer_on_battery =3D git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
=20
@@ -157,6 +162,20 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit <=3D cnt;
 }
=20
+static int is_on_battery(void)
+{
+	FILE *fp;
+	unsigned int state =3D 1;
+
+	if ((fp =3D fopen("/sys/class/power_supply/AC/online", "r"))) {
+		if (fscanf(fp, "%d", &state) !=3D 1)
+			state =3D 1;
+		fclose(fp);
+		return state !=3D 1;
+	}
+	return 0;
+}
+
 static int need_to_gc(void)
 {
 	/*
@@ -176,6 +195,11 @@ static int need_to_gc(void)
 		append_option(argv_repack, "-A", MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
+
+	if(defer_on_battery && is_on_battery()) {
+		fprintf(stderr, "Auto packing deferred; on battery");
+		return 0;
+	}
 	return 1;
 }
=20
--=20
1.5.4.5
