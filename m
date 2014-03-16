From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] gc --aggressive: make --depth configurable
Date: Sun, 16 Mar 2014 20:35:03 +0700
Message-ID: <1394976904-15395-5-git-send-email-pclouds@gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:34:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBDK-000646-Aq
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbaCPNet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:34:49 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:45694 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaCPNer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:34:47 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so4625222pbb.1
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/e45uforVn+yoV4fGcOV3pvFuMA/trPTxId0k1oZXYI=;
        b=tzlnPsNJhV/39f64yWnw1zITPr/LPAz+DUbu5GENwU7z0nrk2O9C2HcY2P4M+LR3O1
         MfXKNJambF4xDN/rzwmMqUtFIoAGdnMvNLb41bMvu6XeBiAbrMz/Za5KAwtBdlMmwEya
         1Guc9+mLc280fgiNkQYDf+uBVbZiB+MbwvQBT+elZ//a8MlcIEkP5XVOIjTRrGSJgdy8
         u3DOf3KWklOCi4uiiIu8KDv8tNaLxr9nU8zpVWFXPTFoqJtJk+gioRVuaS/hT+a6P8/t
         kYsGowiIvfROp0SRt5K2J/gGfO0ctfz8qxBWAsXuucsWph0bg/NtnNPmzXSrM3E2Uk5p
         5adQ==
X-Received: by 10.68.170.66 with SMTP id ak2mr20001055pbc.5.1394976887028;
        Sun, 16 Mar 2014 06:34:47 -0700 (PDT)
Received: from lanh ([115.73.203.48])
        by mx.google.com with ESMTPSA id xn10sm56777709pab.0.2014.03.16.06.34.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:34:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Mar 2014 20:35:29 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244198>

When 1c192f3 (gc --aggressive: make it really aggressive - 2007-12-06)
made --depth=3D250 the default value, it didn't really explain the
reason behind, especially the pros and cons of --depth=3D250.

An old mail from Linus below explains it at length. Long story short,
--depth=3D250 is a disk saver and a performance killer. Not everybody
agrees on that aggressiveness. Let the user configure it.

-- 8< --
=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 6 Dec 2007 08:19:24 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712060803430.13796@woody.linux-foundati=
on.org>
Gmane-URL: http://article.gmane.org/gmane.comp.gcc.devel/94637

On Thu, 6 Dec 2007, Harvey Harrison wrote:
>
> 7:41:25elapsed 86%CPU

Heh. And this is why you want to do it exactly *once*, and then just
export the end result for others ;)

> -r--r--r-- 1 hharrison hharrison 324094684 2007-12-06 07:26 pack-1d46=
ca030c3d6d6b95ad316deb922be06b167a3d.pack

But yeah, especially if you allow longer delta chains, the end result c=
an
be much smaller (and what makes the one-time repack more expensive is t=
he
window size, not the delta chain - you could make the delta chains long=
er
with no cost overhead at packing time)

HOWEVER.

The longer delta chains do make it potentially much more expensive to t=
hen
use old history. So there's a trade-off. And quite frankly, a delta dep=
th
of 250 is likely going to cause overflows in the delta cache (which is
only 256 entries in size *and* it's a hash, so it's going to start havi=
ng
hash conflicts long before hitting the 250 depth limit).

So when I said "--depth=3D250 --window=3D250", I chose those numbers mo=
re as
an example of extremely aggressive packing, and I'm not at all sure tha=
t
the end result is necessarily wonderfully usable. It's going to save di=
sk
space (and network bandwidth - the delta's will be re-used for the netw=
ork
protocol too!), but there are definitely downsides too, and using long
delta chains may simply not be worth it in practice.

(And some of it might just want to have git tuning, ie if people think
that long deltas are worth it, we could easily just expand on the delta
hash, at the cost of some more memory used!)

That said, the good news is that working with *new* history will not be
affected negatively, and if you want to be _really_ sneaky, there are w=
ays
to say "create a pack that contains the history up to a version one yea=
r
ago, and be very aggressive about those old versions that we still want=
 to
have around, but do a separate pack for newer stuff using less aggressi=
ve
parameters"

So this is something that can be tweaked, although we don't really have
any really nice interfaces for stuff like that (ie the git delta cache
size is hardcoded in the sources and cannot be set in the config file, =
and
the "pack old history more aggressively" involves some manual scripting
and knowing how "git pack-objects" works rather than any nice simple
command line switch).

So the thing to take away from this is:
 - git is certainly flexible as hell
 - .. but to get the full power you may need to tweak things
 - .. happily you really only need to have one person to do the tweakin=
g,
   and the tweaked end results will be available to others that do not
   need to know/care.

And whether the difference between 320MB and 500MB is worth any really
involved tweaking (considering the potential downsides), I really don't
know. Only testing will tell.

			Linus
-- 8< --

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 5 +++++
 Documentation/git-gc.txt | 3 +++
 builtin/gc.c             | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 79e5768..5ce7f9a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1151,6 +1151,11 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
=20
+gc.aggressiveDepth::
+	The depth parameter used in the delta compression
+	algorithm used by 'git gc --aggressive'.  This defaults
+	to 250.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index e158a3b..273c466 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -124,6 +124,9 @@ the value, the more time is spent optimizing the de=
lta compression.  See
 the documentation for the --window' option in linkgit:git-repack[1] fo=
r
 more details.  This defaults to 250.
=20
+Similarly, the optional configuration variable 'gc.aggressiveDepth'
+controls --depth option in linkgit:git-repack[1]. This defaults to 250=
=2E
+
 The optional configuration variable 'gc.pruneExpire' controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
diff --git a/builtin/gc.c b/builtin/gc.c
index 63d400b..72aa912 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -26,6 +26,7 @@ static const char * const builtin_gc_usage[] =3D {
 };
=20
 static int pack_refs =3D 1;
+static int aggressive_depth =3D 250;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
@@ -66,6 +67,10 @@ static int gc_config(const char *var, const char *va=
lue, void *cb)
 		aggressive_window =3D git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.aggressivedepth")) {
+		aggressive_depth =3D git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "gc.auto")) {
 		gc_auto_threshold =3D git_config_int(var, value);
 		return 0;
@@ -294,7 +299,8 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
=20
 	if (aggressive) {
 		argv_array_push(&repack, "-f");
-		argv_array_push(&repack, "--depth=3D250");
+		if (aggressive_depth > 0)
+			argv_array_pushf(&repack, "--depth=3D%d", aggressive_depth);
 		if (aggressive_window > 0)
 			argv_array_pushf(&repack, "--window=3D%d", aggressive_window);
 	}
--=20
1.9.0.40.gaa8c3ea
