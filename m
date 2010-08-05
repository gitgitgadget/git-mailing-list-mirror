From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/12] ll-merge: let caller decide whether to renormalize
Date: Thu, 5 Aug 2010 06:24:58 -0500
Message-ID: <20100805112458.GJ13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:26:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogyai-0003w1-5p
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759040Ab0HEL0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:26:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52453 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758883Ab0HEL0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:26:22 -0400
Received: by iwn33 with SMTP id 33so91619iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BtwQrwBrrlFSIHMhhMMj0TGqE7mAjV+Afb1I6hKAcLg=;
        b=fbiKvO10ZUVxGmtqm4dyKZnyo7DTKsMDhU9JwEuhlZW9E64paHmsDoZc5LVjcMKmuU
         pbXllRsJ2+9DsrLxrONQcKf1cN2wRfk+ICcKGgtqk2IM9jRA0jO0TFVBIlAx8DbZQLht
         yyB1z9iqIBxICP+X/JLrlTlsgzwGIKtWCeQcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=O8BHy4LZ/VOLutFUTJWK5xMGo+iNVQXH19ZVnq/CPmKmlMcyC3fCPnuK5r2vXTo3Jv
         yx+2KdKbme87km6qVK4pzVeoj/DdFjL8lMw9FBqVEuXlaLDEpSBU/nabmT6hswhrOU18
         3mwSzvLKGv72RFHojnNuRjqrl+u2rV7QtDPws=
Received: by 10.231.15.70 with SMTP id j6mr11772437iba.12.1281007576941;
        Thu, 05 Aug 2010 04:26:16 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm60625ibk.1.2010.08.05.04.26.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:26:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152640>

Add a =E2=80=9Crenormalize=E2=80=9D bit to the ll-merge options word so=
 callers can
decide on a case-by-case basis whether the merge is likely to have
overlapped with a change in smudge/clean rules.

This reveals a few commands that have not been taking that situation
into account, though it does not fix them.

No functional change intended.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Uses the flag word now.

The new option is not exposed through =E2=80=9Cgit merge-file=E2=80=9D,=
 just like
the virtual-ancestor option isn=E2=80=99t, but that is only from lazine=
ss.
Exposing it would make tests this easier, too.

Some worries:

 - "checkout -m" does not do convert_to_worktree() but it should;
 - "rerere forget" has not been introduced to the wonderful world
   of smudge filters, either.

 builtin/checkout.c |    4 ++++
 ll-merge.c         |    6 +++---
 ll-merge.h         |    1 +
 merge-recursive.c  |    1 +
 rerere.c           |   15 ++++++++++-----
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..a0c00d3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -150,6 +150,10 @@ static int checkout_merged(int pos, struct checkou=
t *state)
 	read_mmblob(&ours, active_cache[pos+1]->sha1);
 	read_mmblob(&theirs, active_cache[pos+2]->sha1);
=20
+	/*
+	 * NEEDSWORK: re-create conflicts from merges with
+	 * merge.renormalize set, too
+	 */
 	status =3D ll_merge(&result_buf, path, &ancestor, "base",
 			  &ours, "ours", &theirs, "theirs", 0);
 	free(ancestor.ptr);
diff --git a/ll-merge.c b/ll-merge.c
index 290f764..6bb3095 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -99,8 +99,8 @@ static int ll_union_merge(const struct ll_merge_drive=
r *drv_unused,
 			  int flag, int marker_size)
 {
 	/* Use union favor */
-	flag =3D (flag & LL_OPT_VIRTUAL_ANCESTOR) |
-	       create_ll_flag(XDL_MERGE_FAVOR_UNION);
+	flag &=3D ~LL_OPT_FAVOR_MASK;
+	flag |=3D create_ll_flag(XDL_MERGE_FAVOR_UNION);
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
 			    flag, marker_size);
@@ -345,7 +345,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	const struct ll_merge_driver *driver;
 	int virtual_ancestor =3D flag & LL_OPT_VIRTUAL_ANCESTOR;
=20
-	if (merge_renormalize) {
+	if (flag & LL_OPT_RENORMALIZE) {
 		normalize_file(ancestor, path);
 		normalize_file(ours, path);
 		normalize_file(theirs, path);
diff --git a/ll-merge.h b/ll-merge.h
index 5990271..ff7ca87 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -8,6 +8,7 @@
 #define LL_OPT_VIRTUAL_ANCESTOR	(1 << 0)
 #define LL_OPT_FAVOR_MASK	((1 << 1) | (1 << 2))
 #define LL_OPT_FAVOR_SHIFT 1
+#define LL_OPT_RENORMALIZE	(1 << 3)
=20
 static inline int ll_opt_favor(int flag)
 {
diff --git a/merge-recursive.c b/merge-recursive.c
index c0c9f0c..23f7a4d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -648,6 +648,7 @@ static int merge_3way(struct merge_options *o,
 	merge_status =3D ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
 				((o->call_depth ? LL_OPT_VIRTUAL_ANCESTOR : 0) |
+				 (o->renormalize ? LL_OPT_RENORMALIZE : 0) |
 				 create_ll_flag(favor)));
=20
 	free(name1);
diff --git a/rerere.c b/rerere.c
index 2197890..9dd4c7e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -319,6 +319,10 @@ static int handle_cache(const char *path, unsigned=
 char *sha1, const char *outpu
 		if (!mmfile[i].ptr && !mmfile[i].size)
 			mmfile[i].ptr =3D xstrdup("");
 	}
+	/*
+	 * NEEDSWORK: handle conflicts from merges with
+	 * merge.renormalize set, too
+	 */
 	ll_merge(&result, path, &mmfile[0], NULL,
 		 &mmfile[1], "ours",
 		 &mmfile[2], "theirs", 0);
@@ -361,7 +365,7 @@ static int find_conflict(struct string_list *confli=
ct)
 	return 0;
 }
=20
-static int merge(const char *name, const char *path)
+static int merge(const char *name, int renormalize, const char *path)
 {
 	int ret;
 	mmfile_t cur =3D {NULL, 0}, base =3D {NULL, 0}, other =3D {NULL, 0};
@@ -376,7 +380,8 @@ static int merge(const char *name, const char *path=
)
 		ret =3D 1;
 		goto out;
 	}
-	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "", 0)=
;
+	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "",
+			renormalize ? LL_OPT_RENORMALIZE : 0);
 	if (!ret) {
 		FILE *f =3D fopen(path, "w");
 		if (!f)
@@ -424,7 +429,7 @@ static int update_paths(struct string_list *update)
 	return status;
 }
=20
-static int do_plain_rerere(struct string_list *rr, int fd)
+static int do_plain_rerere(struct string_list *rr, int fd, int renorma=
lize)
 {
 	struct string_list conflict =3D { NULL, 0, 0, 1 };
 	struct string_list update =3D { NULL, 0, 0, 1 };
@@ -469,7 +474,7 @@ static int do_plain_rerere(struct string_list *rr, =
int fd)
 		const char *name =3D (const char *)rr->items[i].util;
=20
 		if (has_rerere_resolution(name)) {
-			if (!merge(name, path)) {
+			if (!merge(name, renormalize, path)) {
 				if (rerere_autoupdate)
 					string_list_insert(path, &update);
 				fprintf(stderr,
@@ -553,7 +558,7 @@ int rerere(int flags)
 	fd =3D setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd);
+	return do_plain_rerere(&merge_rr, fd, merge_renormalize);
 }
=20
 static int rerere_forget_one_path(const char *path, struct string_list=
 *rr)
--=20
1.7.2.1.544.ga752d.dirty
