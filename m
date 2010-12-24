From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] interpret_branch_name: takes @{u} code out and reorder the function
Date: Fri, 24 Dec 2010 21:07:48 +0700
Message-ID: <1293199669-19016-5-git-send-email-pclouds@gmail.com>
References: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 15:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8L3-000736-BY
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab0LXOJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:09:38 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61411 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0LXOJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 09:09:37 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so1330022pva.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6G6SJLD7St2PrsmZBFzm6dVAth2BP1BUP+PYiHgJyyw=;
        b=QrIx9mmQib3OaV/KJmm/ZLLamhi5dlIatASRDxo6OTBmP9a0jJAHntPOf5ujcaf4P6
         94ktXzr/HyGfLGPg2jqlWaYlA5BbVW8AXFWVvZeew72d6wb4hUP81piy9BBiOm6hlTdP
         avV9qxqGEHz9GEA10h05se0vJqcSMxWjeW17Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KeNapssT7vnbxAhTP8IXa59WfH5lgYYaijWJzL56k0yvpycyXzRWavSv16Bhrh+I8d
         3VyzorNWgYFKhsGfUCPbx1RCpzFQHrFpMCV9E+kJJNi7aGyyeyxWjna8+gfawWS27kHH
         /QBkumAXFVqWn0DiU3wiKuzDkfjALvqMlYxbs=
Received: by 10.142.99.3 with SMTP id w3mr6006678wfb.287.1293199777779;
        Fri, 24 Dec 2010 06:09:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id q13sm12370078wfc.5.2010.12.24.06.09.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:09:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Dec 2010 21:08:20 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164158>

Previously interpret_branch_name() is structured as:

 - check for @{-N}
 - if there's still some more chars left, recurse to try again
 - check for @{upstream}

Now it looks like

 - check for @{-N}
 - check for @{upstream}
 - still more? recurse

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |   99 ++++++++++++++++++++++++++++++++++-----------------=
--------
 1 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index dcdf1e6..cdf14c7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -973,6 +973,27 @@ release_return:
 	return retval;
 }
=20
+static int interpret_at_upstream(const char *at, struct strbuf *real_r=
ef)
+{
+	struct branch *upstream;
+	int cplen =3D strlen(at);
+	int len;
+	char *upstream_ref;
+
+	len =3D upstream_mark(at, cplen);
+	if (!len)
+		return -1;
+	upstream =3D branch_get(real_ref->buf);
+	if (!upstream
+	    || !upstream->merge
+	    || !upstream->merge[0]->dst)
+		return error("No upstream branch found for '%s'", real_ref->buf);
+	upstream_ref =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
+	cplen =3D strlen(upstream_ref);
+	strbuf_attach(real_ref, upstream_ref, cplen, cplen+1);
+	return len;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -996,55 +1017,49 @@ release_return:
  */
 int interpret_branch_name(const char *name, struct strbuf *buf)
 {
-	char *cp;
-	struct branch *upstream;
 	int namelen =3D strlen(name);
-	int len =3D interpret_nth_prior_checkout(name, buf);
-	int tmp_len;
-
-	if (!len)
-		return len; /* syntax Ok, not enough switches */
-	if (0 < len && len =3D=3D namelen)
-		return len; /* consumed all */
-	else if (0 < len) {
-		/* we have extra data, which might need further processing */
-		struct strbuf tmp =3D STRBUF_INIT;
-		int used =3D buf->len;
-		int ret;
-
-		strbuf_add(buf, name + len, namelen - len);
-		ret =3D interpret_branch_name(buf->buf, &tmp);
-		/* that data was not interpreted, remove our cruft */
-		if (ret < 0) {
-			strbuf_setlen(buf, used);
-			return len;
-		}
-		strbuf_reset(buf);
-		strbuf_addbuf(buf, &tmp);
-		strbuf_release(&tmp);
-		/* tweak for size of {-N} versus expanded ref name */
-		return ret - used + len;
-	}
+	struct strbuf tmp =3D STRBUF_INIT;
+	int ret, len =3D -1, used =3D 0;
+	const char *cp;
=20
 	cp =3D strchr(name, '@');
 	if (!cp)
 		return -1;
-	tmp_len =3D upstream_mark(cp, namelen - (cp - name));
-	if (!tmp_len)
+	if (cp =3D=3D name)
+		len =3D interpret_nth_prior_checkout(cp, buf);
+	else {
+		strbuf_reset(buf);
+		strbuf_add(buf, name, cp - name);
+		used +=3D cp - name;
+	}
+
+	if (len =3D=3D -1)
+		len =3D interpret_at_upstream(cp, buf);
+	if (len =3D=3D -1) {
+		strbuf_reset(buf);
 		return -1;
-	len =3D cp + tmp_len - name;
-	cp =3D xstrndup(name, cp - name);
-	upstream =3D branch_get(*cp ? cp : NULL);
-	if (!upstream
-	    || !upstream->merge
-	    || !upstream->merge[0]->dst)
-		return error("No upstream branch found for '%s'", cp);
-	free(cp);
-	cp =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
+	}
+
+	if (!len)
+		return len; /* syntax Ok, not enough switches */
+
+	used +=3D len;
+	if (used =3D=3D namelen)
+		return used; /* consumed all */
+
+	/* we have extra data, which might need further processing */
+	len =3D buf->len;
+	strbuf_add(buf, name + used, namelen - used);
+	ret =3D interpret_branch_name(buf->buf, &tmp);
+	/* that data was not interpreted, remove our cruft */
+	if (ret < 0) {
+		strbuf_setlen(buf, len);
+		return used;
+	}
 	strbuf_reset(buf);
-	strbuf_addstr(buf, cp);
-	free(cp);
-	return len;
+	strbuf_addbuf(buf, &tmp);
+	strbuf_release(&tmp);
+	return used + (ret - len);
 }
=20
 int strbuf_branchname(struct strbuf *sb, const char *name)
--=20
1.7.3.3.476.g10a82
