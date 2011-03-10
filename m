From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] diff: support --exclude
Date: Thu, 10 Mar 2011 10:13:39 +0700
Message-ID: <1299726819-5576-6-git-send-email-pclouds@gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 04:15:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWLp-00007p-V6
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab1CJDPl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 22:15:41 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61843 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1CJDPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:15:40 -0500
Received: by gwaa18 with SMTP id a18so256041gwa.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4cNYS6wrRSA6OYOkFhJ8nd4h92PtZAiM07MMHPRUcU0=;
        b=cetSdh2d74bivd9Prd2yhQZdYnn2/y0m81FtgLU4vNSmH399EKpDi2W7UClqKTfi6P
         80u4jXjT8dqDLVXQcgBbQs+kLAMvetaLExTkM8SJKmhHI11LjNmL+JqJdYT3mY5miEy5
         cs/cd24XBLEcZG0v9k45ZzGCwZ9uuEezwAOhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WFHdrEDXOfnfsbaoF+5oh7fzBNAZJv98NWYK0TEbuSD0IpSj/vYrJ1pdQZ0T/9V7aN
         QeeuVIH1vZQ78evYEUHHoNFgxNhFAnq+bPcZpKjaPnJ4vBZnMlUOSmnLMwr7IFb1vxu7
         y/VuTjXjQ83GCWhqaRVMoCCeamK8i8A3CQ4i8=
Received: by 10.150.244.3 with SMTP id r3mr307568ybh.353.1299726938174;
        Wed, 09 Mar 2011 19:15:38 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id p33sm3754290ybk.2.2011.03.09.19.15.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:15:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Mar 2011 10:14:36 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168784>

diff_setup_done() will update diff_options.pathspec, so if you give

--exclude '*.h' -- src/

then the final pathspec looks like

 - src/
 - *.h (negated)

The code is protected against multiple call because setup_revisions()
may call it once, then the outer code calls it again. I'm not sure if
doing it this way is correct though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 diff.h |    1 +
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 6f206a9..14f1cfc 100644
--- a/diff.c
+++ b/diff.c
@@ -2973,6 +2973,34 @@ int diff_setup_done(struct diff_options *options=
)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
=20
+	/*
+	 * Adjust options->pathspec. All --exclude will be appended to
+	 * options->pathspec with to_exclude set.
+	 */
+	if (options->paths &&
+	    options->pathspec.raw !=3D options->paths) { /* avoid being calle=
d twice */
+		int i, nr, new_nr, exc;
+
+		nr =3D options->pathspec.nr ? options->pathspec.nr : 1;
+		for (exc =3D 0; options->paths[exc]; exc++)
+			;			  /* nothing */
+		new_nr =3D nr + exc;
+
+		options->paths =3D xrealloc(options->paths, sizeof(char*) * (new_nr =
+ 1));
+		memmove(options->paths + nr, options->paths, sizeof(char*) * (exc + =
1));
+		if (options->pathspec.nr)
+			memcpy(options->paths, options->pathspec.raw, sizeof(char*) * nr);
+		else
+			options->paths[0] =3D "";
+
+		free_pathspec(&options->pathspec);
+		init_pathspec(&options->pathspec, options->paths);
+		for (i =3D nr; i < new_nr; i++) {
+			struct pathspec_item *item =3D options->pathspec.items + i;
+			item->to_exclude =3D 1;
+		}
+	}
+
 	return 0;
 }
=20
@@ -2980,6 +3008,7 @@ int diff_setup_done(struct diff_options *options)
 void release_diff(struct diff_options *o)
 {
 	free_pathspec(&o->pathspec);
+	free(o->paths);
 }
=20
 static int opt_arg(const char *arg, int arg_short, const char *arg_lon=
g, int *val)
@@ -3347,7 +3376,17 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 			die_errno("Could not open '%s'", optarg);
 		options->close_file =3D 1;
 		return argcount;
-	} else
+	}
+	else if ((argcount =3D parse_long_opt("exclude", av, &optarg))) {
+		int i =3D 1;
+		while (options->paths && options->paths[i])
+			i++;
+		options->paths =3D xrealloc(options->paths, sizeof(char*) * (i + 1))=
;
+		options->paths[i - 1] =3D optarg;
+		options->paths[i] =3D 0;
+		return argcount;
+	}
+	else
 		return 0;
 	return 1;
 }
diff --git a/diff.h b/diff.h
index 12a9907..b60057c 100644
--- a/diff.h
+++ b/diff.h
@@ -134,6 +134,7 @@ struct diff_options {
 	int close_file;
=20
 	struct pathspec pathspec;
+	const char **paths;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
--=20
1.7.3.1.256.g2539c.dirty
