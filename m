From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 4/4] Re-implement 'git remote update' using 'git fetch'
Date: Sun, 08 Nov 2009 16:48:53 +0100
Message-ID: <4AF6E865.1030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 16:49:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7A0y-0003I9-He
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 16:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbZKHPsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbZKHPsv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 10:48:51 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52683 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbZKHPsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 10:48:50 -0500
Received: by ewy3 with SMTP id 3so2431036ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=G8/SSMG63FJVv0KurrZ5e60PzHaUvyNKpPa82xngrW8=;
        b=WoqmsOFeVegee0+q1717HDPJymvTUps5yvp5aecSA2XdCSXpFtJSzVpsgd+fUSWBKo
         v7nF0v1G/HGMunCrFHZxUK9UCQdT09luLe3UYOFvg2Gc/27nYT9WfDP3zVdct1N8g0JV
         UK9BDBzI1NBkjCJAptiGYvQAsnR+DMtMPKuWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=kF7BzbCPIknS35dvcj37PcRZbl3plq0/eQrGA012OIXilF4ZB18v1tp9DGoDWyLk5l
         y6cf8rgNs1CDvoJYCelTmkuWxKacJRiOV6ChiV1rbz/WithDE22E0I8E/nq9W54G09oY
         eU8fZT/kVrMaPdrA3sgdjFupVkZsA3/DnNPlU=
Received: by 10.216.87.83 with SMTP id x61mr2268993wee.7.1257695334833;
        Sun, 08 Nov 2009 07:48:54 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm4002018eyd.2.2009.11.08.07.48.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 07:48:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132407>

In order to not duplicate functionality, re-implement 'git remote
update' in terms of 'git fetch'.

There is one incompatibility: the skipDefaultUpdate configuration
variable will only be honored if remotes.default is not set (i.e.
when 'git remote update' will invoke 'git fetch --all', not when
it will invoke 'git fetch default').

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-remote.c |   86 ++++++++++++++++------------------------------=
-------
 1 files changed, 26 insertions(+), 60 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..fd7e0b2 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1189,88 +1189,54 @@ static int prune_remote(const char *remote, int=
 dry_run)
 	return result;
 }
=20
-static int get_one_remote_for_update(struct remote *remote, void *priv=
)
+static int get_remote_default(const char *key, const char *value, void=
 *priv)
 {
-	struct string_list *list =3D priv;
-	if (!remote->skip_default_update)
-		string_list_append(remote->name, list);
-	return 0;
-}
-
-static struct remote_group {
-	const char *name;
-	struct string_list *list;
-} remote_group;
-
-static int get_remote_group(const char *key, const char *value, void *=
num_hits)
-{
-	if (!prefixcmp(key, "remotes.") &&
-			!strcmp(key + 8, remote_group.name)) {
-		/* split list by white space */
-		int space =3D strcspn(value, " \t\n");
-		while (*value) {
-			if (space > 1) {
-				string_list_append(xstrndup(value, space),
-						remote_group.list);
-				++*((int *)num_hits);
-			}
-			value +=3D space + (value[space] !=3D '\0');
-			space =3D strcspn(value, " \t\n");
-		}
+	if (strcmp(key, "remotes.default") =3D=3D 0) {
+		int *found =3D priv;
+		*found =3D 1;
 	}
-
 	return 0;
 }
=20
 static int update(int argc, const char **argv)
 {
-	int i, result =3D 0, prune =3D 0;
-	struct string_list list =3D { NULL, 0, 0, 0 };
-	static const char *default_argv[] =3D { NULL, "default", NULL };
+	int i, prune =3D 0;
 	struct option options[] =3D {
 		OPT_GROUP("update specific options"),
 		OPT_BOOLEAN('p', "prune", &prune,
 			    "prune remotes after fetching"),
 		OPT_END()
 	};
+	const char **fetch_argv;
+	int fetch_argc =3D 0;
+	int default_defined =3D 0;
+
+	fetch_argv =3D xmalloc(sizeof(char *) * (argc+4));
=20
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_usag=
e,
 			     PARSE_OPT_KEEP_ARGV0);
-	if (argc < 2) {
-		argc =3D 2;
-		argv =3D default_argv;
-	}
=20
-	remote_group.list =3D &list;
-	for (i =3D 1; i < argc; i++) {
-		int groups_found =3D 0;
-		remote_group.name =3D argv[i];
-		result =3D git_config(get_remote_group, &groups_found);
-		if (!groups_found && (i !=3D 1 || strcmp(argv[1], "default"))) {
-			struct remote *remote;
-			if (!remote_is_configured(argv[i]))
-				die("No such remote or remote group: %s",
-				    argv[i]);
-			remote =3D remote_get(argv[i]);
-			string_list_append(remote->name, remote_group.list);
-		}
-	}
+	fetch_argv[fetch_argc++] =3D "fetch";
=20
-	if (!result && !list.nr  && argc =3D=3D 2 && !strcmp(argv[1], "defaul=
t"))
-		result =3D for_each_remote(get_one_remote_for_update, &list);
+	if (verbose)
+		fetch_argv[fetch_argc++] =3D "-v";
+	if (argc < 2) {
+		fetch_argv[fetch_argc++] =3D "default";
+	} else {
+		fetch_argv[fetch_argc++] =3D "--multiple";
+		for (i =3D 1; i < argc; i++)
+			fetch_argv[fetch_argc++] =3D argv[i];
+	}
=20
-	for (i =3D 0; i < list.nr; i++) {
-		int err =3D fetch_remote(list.items[i].string);
-		result |=3D err;
-		if (!err && prune)
-			result |=3D prune_remote(list.items[i].string, 0);
+	if (strcmp(fetch_argv[fetch_argc-1], "default") =3D=3D 0) {
+		git_config(get_remote_default, &default_defined);
+		if (!default_defined)
+			fetch_argv[fetch_argc-1] =3D "--all";
 	}
=20
-	/* all names were strdup()ed or strndup()ed */
-	list.strdup_strings =3D 1;
-	string_list_clear(&list, 0);
+	fetch_argv[fetch_argc] =3D NULL;
=20
-	return result;
+	return run_command_v_opt(fetch_argv, RUN_GIT_CMD);
 }
=20
 static int get_one_entry(struct remote *remote, void *priv)
--=20
1.6.5.1.69.g36942
