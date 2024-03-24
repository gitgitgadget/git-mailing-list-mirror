Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2528E7
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711279185; cv=none; b=AMJrUAEsOI74a8PR9XOkeVlRW6ue+I4ZYm5cQgiLR6UjdTRBeLWdsp63jjQpNBxmCW7dggQVcFtZJ86OJt8KZxgJH7ysQQ4Wie+/X+8/MZ3RHtRGIVNPnKax5JYtVsR2ZZoz8szxg4YQ/bSkMYSulvIiEjMm57BBkOXxNygX1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711279185; c=relaxed/simple;
	bh=yYMQKA/l6z75dFE4dEz5p2s6QTFjO7zi5pI0M02bwzk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Qe4l28IWUwvZsdz1Y1bXWNHM8C5EYiGTmcUmGseDEzs3EQ1QfM3Xa3OyCnPBfDQWUe8UWJ3RMhINER4BRIgdzLNck2pjRiXuFexI6zoNkkAJZ5/9Ug0x3IqEg/QSNmx46EfyE0UxH4b1pOS7Q6ekjgtqfAZf44pxUlEjrCMBmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=e0UIXo8W; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="e0UIXo8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711279181; x=1711883981; i=l.s.r@web.de;
	bh=CS38GBUpWegRbDu8eNlb0V+oZ/AaqZIxqasKh7WeKZg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=e0UIXo8WB/NgIi/P+oQeCPUUHCM51ZWG2+FjT/sHJL/M9Yra5HE74xZbLgKZa283
	 DU/j8rCSWZACy8OP2ZuwLrma68/A6uU7xS8nx5+RiE5R5jDhVqIOPbx5M9roPnPdk
	 8SXnHCL9yQdvgMWwfmLwN58uF22SdAn9T7YdwzZdY/UPanXMaPc54pNquXq+fCeCe
	 A5uCIdkTSFbQiykWcoIIYZXZ8vSE8jeMX6S6uLabpQTklJQwVqn25faXi8+3li7kZ
	 UjpaAJ14Hfp4ywQULlcROc0ywOM0y0/RQoZAYmJ/GdzsHMIKInf4vdJaHSkWmmU9W
	 lupi6YnR94zlrr10FA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1rqXkC3y92-002TT9 for
 <git@vger.kernel.org>; Sun, 24 Mar 2024 12:19:40 +0100
Message-ID: <cf8f2256-d954-4a3e-bc2a-31b2de4c8e1d@web.de>
Date: Sun, 24 Mar 2024 12:19:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] factor out strbuf_expand_bad_format()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Content-Language: en-US
In-Reply-To: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zlUYuwc0CshU+sAY55ep9v0o2oTJOKXbJximXqsA4jr34kNxf3o
 /0p4JkNr9igoffEnb//O11IZsvM7fqJs9GHKXKCsDCdcY8vOuNHaeWy41AejEs8SZxZFMRY
 PexavJtqdIk+s4lRv8dgtvbgFtXb5iUDdJ4M4cFlNYF8OjJ3telaA9m+bInc1bsAK+SlwPG
 suH2puiQ4JyM9YKXdDjMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WgnMQoeRtao=;oGVQO7rRAMh5mYFiOZegCVpKGqQ
 hA3W5eLKni77B17asYX8/GSWU97Gw9pYzRpTWyX78LHiv1D+H6jR0YGVCzCyy9MiYIZ4VKsTx
 yanu2lqjlq6dOhfoCxA0TdQdsiwrchzdXU4sSiKlGL543n07b+kSm9pcHmabQFWiGHR2AeNxW
 B92rXIhCBh2F1SSh+EmtrRfho3Qi/wcVzDLq2TFR/zHrdMzcBo1DhF5WGkpod4DlFvJXDCEvQ
 C7ngdtN1PcEnO/BAo4OK0DXmIrzB5pX3tfYsjKLd7QIHI0j2nnKQ2REz57jjtHZatjJ8J1nwG
 amahxVq2ftkLWBSOMdC1CY2W1ngbt9U2+qnmz6xzixz+bVr4FVOs7phVHHc2Wm7WZtP1olGp1
 jzTvlnkC1YX5X1KD2nKK520BoL4vM/J4fZ+bJF8nn3JUvW9A9g0x20v5qKbipoMrIu5m/U9o8
 SNHP/OoYuui+u9fT5efWXHNv9cA62gPmQpLVFRx9fbB/2wncdADqeufAgH5Jlj811QrvMeu77
 irR1dUTKpqMouI69hfP5AML0pdScdAH1G2PvA8/UnnrLEPK+hs2I0NXOKb0felT1Whgm1OhoQ
 FRpKaPG/RGSHYrXtT9bbEAZz5xAL2o/7c97XESHHnjVaCX8/B1EdRU0no+xZU20Tvkiukwxjp
 Ew8VAMLxhfIz0/z4Gm7bOMXpt9ZvyccPfL1QemBA0dAdJpT95wVaUiE2i3tZAYodh4aWLCc77
 iXLh98EO+Gg0LwoVgVx3YoVCP38BV700xEpEVqpfIBz6T+TSAztntdMlZEgVRfuSeW8LLTBhN
 jOfM5HcqmBYx45DKRazeP5HVaAedtlcoD24iFk15QdoYs=

Extract a function for reporting placeholders that are not enclosed in a
parenthesis or are unknown.  This reduces the number of strings to
translate and improves consistency across commands.  Call it at the end
of the if/else chain, after exhausting all accepted possibilities.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1: s/ls-format/ls-files/

 builtin/ls-files.c | 10 +---------
 builtin/ls-tree.c  | 10 +---------
 strbuf.c           | 20 ++++++++++++++++++++
 strbuf.h           |  5 +++++
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 92f94e65bf..6eeb5cba78 100644
=2D-- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -266,7 +266,6 @@ static void show_ce_fmt(struct repository *repo, const=
 struct cache_entry *ce,
 	struct strbuf sb =3D STRBUF_INIT;

 	while (strbuf_expand_step(&sb, &format)) {
-		const char *end;
 		size_t len;
 		struct stat st;

@@ -274,12 +273,6 @@ static void show_ce_fmt(struct repository *repo, cons=
t struct cache_entry *ce,
 			strbuf_addch(&sb, '%');
 		else if ((len =3D strbuf_expand_literal(&sb, format)))
 			format +=3D len;
-		else if (*format !=3D '(')
-			die(_("bad ls-files format: element '%s' "
-			      "does not start with '('"), format);
-		else if (!(end =3D strchr(format + 1, ')')))
-			die(_("bad ls-files format: element '%s' "
-			      "does not end in ')'"), format);
 		else if (skip_prefix(format, "(objectmode)", &format))
 			strbuf_addf(&sb, "%06o", ce->ce_mode);
 		else if (skip_prefix(format, "(objectname)", &format))
@@ -308,8 +301,7 @@ static void show_ce_fmt(struct repository *repo, const=
 struct cache_entry *ce,
 		else if (skip_prefix(format, "(path)", &format))
 			write_name_to_buf(&sb, fullname);
 		else
-			die(_("bad ls-files format: %%%.*s"),
-			    (int)(end - format + 1), format);
+			strbuf_expand_bad_format(format, "ls-files");
 	}
 	strbuf_addch(&sb, line_terminator);
 	fwrite(sb.buf, sb.len, 1, stdout);
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e4a891337c..bd803ace03 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -100,19 +100,12 @@ static int show_tree_fmt(const struct object_id *oid=
, struct strbuf *base,
 		return 0;

 	while (strbuf_expand_step(&sb, &format)) {
-		const char *end;
 		size_t len;

 		if (skip_prefix(format, "%", &format))
 			strbuf_addch(&sb, '%');
 		else if ((len =3D strbuf_expand_literal(&sb, format)))
 			format +=3D len;
-		else if (*format !=3D '(')
-			die(_("bad ls-tree format: element '%s' "
-			      "does not start with '('"), format);
-		else if (!(end =3D strchr(format + 1, ')')))
-			die(_("bad ls-tree format: element '%s' "
-			      "does not end in ')'"), format);
 		else if (skip_prefix(format, "(objectmode)", &format))
 			strbuf_addf(&sb, "%06o", mode);
 		else if (skip_prefix(format, "(objecttype)", &format))
@@ -135,8 +128,7 @@ static int show_tree_fmt(const struct object_id *oid, =
struct strbuf *base,
 			strbuf_setlen(base, baselen);
 			strbuf_release(&sbuf);
 		} else
-			die(_("bad ls-tree format: %%%.*s"),
-			    (int)(end - format + 1), format);
+			strbuf_expand_bad_format(format, "ls-tree");
 	}
 	strbuf_addch(&sb, options->null_termination ? '\0' : '\n');
 	fwrite(sb.buf, sb.len, 1, stdout);
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..449eb610f1 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -442,6 +442,26 @@ size_t strbuf_expand_literal(struct strbuf *sb, const=
 char *placeholder)
 	return 0;
 }

+void strbuf_expand_bad_format(const char *format, const char *command)
+{
+	const char *end;
+
+	if (*format !=3D '(')
+		/* TRANSLATORS: The first %s is a command like "ls-tree". */
+		die(_("bad %s format: element '%s' does not start with '('"),
+		    command, format);
+
+	end =3D strchr(format + 1, ')');
+	if (!end)
+		/* TRANSLATORS: The first %s is a command like "ls-tree". */
+		die(_("bad %s format: element '%s' does not end in ')'"),
+		    command, format);
+
+	/* TRANSLATORS: %s is a command like "ls-tree". */
+	die(_("bad %s format: %%%.*s"),
+	    command, (int)(end - format + 1), format);
+}
+
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *=
src)
 {
 	size_t i, len =3D src->len;
diff --git a/strbuf.h b/strbuf.h
index e959caca87..c758de3729 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -337,6 +337,11 @@ size_t strbuf_expand_literal(struct strbuf *sb, const=
 char *placeholder);
  */
 int strbuf_expand_step(struct strbuf *sb, const char **formatp);

+/**
+ * Used with `strbuf_expand_step` to report unknown placeholders.
+ */
+void strbuf_expand_bad_format(const char *format, const char *command);
+
 /**
  * Append the contents of one strbuf to another, quoting any
  * percent signs ("%") into double-percents ("%%") in the
=2D-
2.44.0
