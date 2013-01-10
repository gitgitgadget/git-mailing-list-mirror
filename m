From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: t7400 broken on pu (Mac OS X)
Date: Thu, 10 Jan 2013 13:28:38 +0700
Message-ID: <20130110062838.GA11634@duynguyen-vnpc.dek-tpc.internal>
References: <50EDBA37.30205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 07:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtBdd-0005AY-NF
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 07:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab3AJG25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 01:28:57 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:41034 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab3AJG24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 01:28:56 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so101260dam.18
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 22:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x57MDITYW3XsfhNxyx8I6KVOZBlWeZyhfMuK4D9Agpg=;
        b=eMrCC+NaWfmZVwaAdIgOsJgtiMu12FnFsusLI8Znj71dzJw4Y9V8f3TMyD4BmHXubh
         ff9l7AtCjpacc87nDCaZiQGp0R8ijI3DPkWolwrY7+6C6eR67OOldAv0Pk1xT1oFxxwA
         AT+08r9Z7hEUrzrPbmpcs2qDmXYsNYnnc7GmOoc+cd4hpMYwkq+vcySyDdYohUcX0Vga
         JWusfUJVtje4jd0UCxVnE98frICUjUhTfvjFO16B115GndXIABfGuugLXUXtUXbAUkAT
         cfUc+dnKMtb6Hckxs0r5mKelUhxjKjCGamzCqoj9MztQXinQWPpomH6rr1IUP1gsbSAi
         cV6w==
X-Received: by 10.68.134.130 with SMTP id pk2mr215665888pbb.31.1357799336387;
        Wed, 09 Jan 2013 22:28:56 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id c2sm538372pay.34.2013.01.09.22.28.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 09 Jan 2013 22:28:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Jan 2013 13:28:38 +0700
Content-Disposition: inline
In-Reply-To: <50EDBA37.30205@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213123>

On Wed, Jan 09, 2013 at 07:43:03PM +0100, Torsten B=F6gershausen wrote:
> The current pu fails on Mac OS, case insensitive FS.
>=20
>=20
> Bisecting points out
> commit 3f28e4fafc046284657945798d71c57608bee479
> [snip]
> Date:   Sun Jan 6 13:21:07 2013 +0700
>=20
>     Convert add_files_to_cache to take struct pathspec
>=20

I can reproduce it by setting core.ignorecase to true. There is a bug
that I overlooked. Can you verify if this throw-away patch fixes it
for you? A proper fix will be in the reroll later.

-- 8< --
diff --git a/builtin/add.c b/builtin/add.c
index 641037f..61cb8bd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -155,12 +155,13 @@ static char *prune_directory(struct dir_struct *d=
ir, const char **pathspec, int
 	return seen;
 }
=20
-static void treat_gitlinks(const char **pathspec)
+static int treat_gitlinks(const char **pathspec)
 {
 	int i;
+	int modified =3D 0;
=20
 	if (!pathspec || !*pathspec)
-		return;
+		return modified;
=20
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
@@ -171,15 +172,17 @@ static void treat_gitlinks(const char **pathspec)
 				if (len2 <=3D len || pathspec[j][len] !=3D '/' ||
 				    memcmp(ce->name, pathspec[j], len))
 					continue;
-				if (len2 =3D=3D len + 1)
+				if (len2 =3D=3D len + 1) {
 					/* strip trailing slash */
 					pathspec[j] =3D xstrndup(ce->name, len);
-				else
+					modified =3D 1;
+				} else
 					die (_("Path '%s' is in submodule '%.*s'"),
 						pathspec[j], len, ce->name);
 			}
 		}
 	}
+	return modified;
 }
=20
 static void refresh(int verbose, const struct pathspec *pathspec)
@@ -418,7 +421,16 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-	treat_gitlinks(pathspec.raw);
+	if (treat_gitlinks(pathspec.raw))
+		/*
+		 * HACK: treat_gitlinks strips the trailing slashes
+		 * out of submodule entries but it only affects
+		 * raw[]. Everything in pathspec.items is not touched.
+		 * Re-init it to propagate the change. Long term, this
+		 * function should be moved to pathspec.c and update
+		 * everything in a consistent way.
+		 */
+		init_pathspec(&pathspec, pathspec.raw);
=20
 	if (add_new_files) {
 		int baselen;
-- 8< --
