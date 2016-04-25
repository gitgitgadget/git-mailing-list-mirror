From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>
Subject: [RFC/PATCH] remote: add a fetching priority to each remote
Date: Mon, 25 Apr 2016 23:15:06 +0200
Message-ID: <20160425211506.8421-2-mtzguido@gmail.com>
References: <20160425211506.8421-1-mtzguido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 23:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunqz-0006LT-52
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbcDYVPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 17:15:31 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38728 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361AbcDYVP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:15:28 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so147890011wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CByJfA7d1fH6CNSSzVUFV/ZyXCNdWNl1GvGo6ipZnjM=;
        b=LQrFkG9J9dEbvCOZ5dMa/ssQmN6JOpdD6F/jlmvN04gS2BH/h7UpeNcxW+x2P2SHdl
         wo7O1HtNNicekKRECwt4hpaE183Jn2k1auw+WCjAfItmPO43Kx6ra8IHq23zrUjM4hor
         RA3AmWYU5kghiEgMK3LfhMGRQmG/W6QgY3kB08Xu9Ub2/wBNY2CvIUe12K85OLFTnspr
         MjitC74t1rPYPGFssVZBAr6EgmJ0MPT/xgMxRTkUEcxKxfb/rtFaM/owLxDKFXq5xdY5
         hmWV+jgIvNH9Ve3q/Q+I+dcjI7ATI5f3lotfu4WweXZ400ruSk8QtT1TIKJ1eKE1V4k/
         +ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CByJfA7d1fH6CNSSzVUFV/ZyXCNdWNl1GvGo6ipZnjM=;
        b=BXrLpcjh1ff7Q+/ON8dsh7qRJM2T/bM+078KWaNfNtvXT1MB95B/jzY6RikiJS5RAe
         DjAYC8yz79NEnFNAMCO6zL07voxEgA2mAnKJbrDNQX7JcVOl+GD4IaDBtpgDWYScM/SJ
         ogfeRFHe9rCftyKXr/bc0bBnE4LofhY5nSQEFQLERVHS48cMqbicZWGb9TgIosNWoueU
         61yFy70yytoHTJZiNpO5nOpwX/b816tBW59pb2Z1NyAScLqdpSoXndEbgygfOCiQDXGM
         gAkYYNoSPYTLS1Didw8zsYocMwIHU8XqkVLhQzzCl6755fnYzisTKqPiPQO1ZNZXDwg2
         CQeg==
X-Gm-Message-State: AOPr4FU2I38FkowU4wOxnWiz6+nOm7XBTei7FzyunzpNgWr0yLnOHfFAoW5s9Su7gR3rjg==
X-Received: by 10.194.94.229 with SMTP id df5mr14491930wjb.176.1461618927018;
        Mon, 25 Apr 2016 14:15:27 -0700 (PDT)
Received: from localhost ([78.250.243.110])
        by smtp.gmail.com with ESMTPSA id v143sm20507587wmv.4.2016.04.25.14.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Apr 2016 14:15:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.281.g0994585
In-Reply-To: <20160425211506.8421-1-mtzguido@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292561>

Add an int that allows for a way of setting a fetch order for remotes,
mainly for the use case of "git remote update" which updates every
remote.

This way, users can set local mirrors of repositories first to quickly
get a bunch of objects, and later the upstream repo to make sure that
they pulled the latest commit.

Signed-off-by: Guido Mart=C3=ADnez <mtzguido@gmail.com>
---
 Documentation/config.txt |  5 +++++
 builtin/fetch.c          |  2 +-
 remote.c                 | 43 +++++++++++++++++++++++++++++++++++++++-=
---
 remote.h                 |  2 ++
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..5ca199c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2489,6 +2489,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
=20
+remote.<name>.fetchprio::
+	Set a priority for fetching this remote, to allow you to set
+	a custom order when doing "git fetch --all" (thus also when
+	running "git remote update"). Default value is 50.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8455bd..44f42bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1187,7 +1187,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 			die(_("fetch --all does not take a repository argument"));
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
-		(void) for_each_remote(get_one_remote_for_fetch, &list);
+		(void) for_each_sorted_remote(get_one_remote_for_fetch, &list);
 		result =3D fetch_multiple(&list);
 	} else if (argc =3D=3D 0) {
 		/* No arguments -- use default remote */
diff --git a/remote.c b/remote.c
index 28fd676..3b9f20a 100644
--- a/remote.c
+++ b/remote.c
@@ -168,6 +168,7 @@ static struct remote *make_remote(const char *name,=
 int len)
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] =3D ret;
 	ret->name =3D xstrndup(name, len);
+	ret->fetch_prio =3D 50;
=20
 	hashmap_entry_init(ret, lookup_entry.hash);
 	replaced =3D hashmap_put(&remotes_hash, ret);
@@ -375,6 +376,8 @@ static int handle_config(const char *key, const cha=
r *value, void *cb)
 		remote->mirror =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, "skipdefaultupdate"))
 		remote->skip_default_update =3D git_config_bool(key, value);
+	else if (!strcmp(subkey, "fetchprio"))
+		remote->fetch_prio =3D git_config_int(key, value);
 	else if (!strcmp(subkey, "skipfetchall"))
 		remote->skip_default_update =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, "prune"))
@@ -719,12 +722,12 @@ int remote_is_configured(struct remote *remote)
 	return remote && remote->origin;
 }
=20
-int for_each_remote(each_remote_fn fn, void *priv)
+static int for_each_remote_do(struct remote **rlist, int len,
+			      each_remote_fn fn, void *priv)
 {
 	int i, result =3D 0;
-	read_config();
-	for (i =3D 0; i < remotes_nr && !result; i++) {
-		struct remote *r =3D remotes[i];
+	for (i =3D 0; i < len && !result; i++) {
+		struct remote *r =3D rlist[i];
 		if (!r)
 			continue;
 		if (!r->fetch)
@@ -738,6 +741,38 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
=20
+int for_each_remote(each_remote_fn fn, void *priv)
+{
+	read_config();
+	return for_each_remote_do(remotes, remotes_nr, fn, priv);
+}
+
+int compare_fetch_prio(const void *p, const void *q)
+{
+	const struct remote *pp =3D *(struct remote**)p;
+	const struct remote *qq =3D *(struct remote**)q;
+
+	return pp->fetch_prio - qq->fetch_prio;
+}
+
+int for_each_sorted_remote(each_remote_fn fn, void *priv)
+{
+	struct remote **sr;
+	int i, rc;
+
+	read_config();
+
+	sr =3D xmalloc(sizeof (struct remote*) * remotes_nr);
+	for (i =3D 0; i < remotes_nr; i++)
+		sr[i] =3D remotes[i];
+
+	qsort(sr, remotes_nr, sizeof (struct remote*), compare_fetch_prio);
+
+	rc =3D for_each_remote_do(sr, remotes_nr, fn, priv);
+	free(sr);
+	return rc;
+}
+
 static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 {
 	if (strcmp(ref1->name, ref2->name)) {
diff --git a/remote.h b/remote.h
index c21fd37..09b48e4 100644
--- a/remote.h
+++ b/remote.h
@@ -47,6 +47,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	int fetch_prio;
=20
 	const char *receivepack;
 	const char *uploadpack;
@@ -64,6 +65,7 @@ int remote_is_configured(struct remote *remote);
=20
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
+int for_each_sorted_remote(each_remote_fn fn, void *priv);
=20
 int remote_has_url(struct remote *remote, const char *url);
=20
--=20
2.8.1.281.g0994585
