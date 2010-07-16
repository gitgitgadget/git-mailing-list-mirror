From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/9] Add treap implementation
Date: Fri, 16 Jul 2010 13:26:19 -0500
Message-ID: <20100716182619.GA15661@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100716102313.GC14374@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 20:27:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZpd2-0006BT-F4
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 20:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742Ab0GPS1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 14:27:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64544 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846Ab0GPS1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 14:27:15 -0400
Received: by mail-vw0-f46.google.com with SMTP id 5so2841020vws.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RylfPOTzgM7lKvN133PvTD878aooi1wTZD0iyj60A2w=;
        b=ST4E1FYpaqVeec88WBA/gzYrD5+lBF/SbMo5lROLIvWoXEcKE59zZA+qK10kMqEIoi
         NXGCHl/QY/Kxsnq52w4910YCc0n5JwoPCjnZD49EymWHeTjAYp31ksb/L+iRA+05FCp/
         oH7GG+z0dfpGaUl5vbdrTyF9eBKuMaQ+42jLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JrkAIidTwkezchD56Wx6I6gO0ef3gObW90VhXsD5jMfRz8WjGDDVXtpYEqCRziHUD8
         j5/WwSCmfH0JiB688g3uEESWXkSx4CfP8QvGy1RjBzuJhOMS6N1Kf4I0ouGb8NIH1jR5
         qANeM3pGb1D+N8YaYZpZv7/JhFXstLkhP0LYs=
Received: by 10.224.60.211 with SMTP id q19mr1313931qah.160.1279304834596;
        Fri, 16 Jul 2010 11:27:14 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q30sm11090556qcq.36.2010.07.16.11.27.12
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 11:27:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100716102313.GC14374@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151160>

Jonathan Nieder wrote:

> Tweaked treap_search() to always return the node after a missing
> node, like it is documented to.

In this case, the documentation was wrong.

> For vcs-svn this doesn=E2=80=99t matter

Or rather, it does.  Sorry about that.

-- 8< --
Subject: vcs-svn: treap_search should return NULL for missing items

In a misguided attempt to make the code match the documentation,
commit 4692f8e7d (Add treap implementation, 2010-07-15) changed
the semantics of treap_search to return the /next/ node when a
node is missing.

That is great in some circumstances (and the new tests even rely on
it), but the rest of vcs-svn relies on treap_search to return
NULL in that case instead.  The documentation only suggested
otherwise because of a typo.

So fix it: now treap_search can do what it was always supposed
to (return NULL on failure) and Jason Evans=E2=80=99s treap_nsearch fun=
ction
can be used to keep the test suite working.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 test-treap.c    |    2 +-
 vcs-svn/trp.h   |   13 +++++++++++++
 vcs-svn/trp.txt |    9 +++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/test-treap.c b/test-treap.c
index eae7324..cdba511 100644
--- a/test-treap.c
+++ b/test-treap.c
@@ -52,7 +52,7 @@ int main(int argc, char *argv[])
 		next =3D node_offset(treap_next(&root, node_pointer(item)));
=20
 		treap_remove(&root, node_pointer(item));
-		item =3D node_offset(treap_search(&root, tmp));
+		item =3D node_offset(treap_nsearch(&root, tmp));
=20
 		if (item !=3D next && (!~item || node_pointer(item)->n !=3D tmp->n))
 			die("found %"PRIuMAX" in place of %"PRIuMAX"",
diff --git a/vcs-svn/trp.h b/vcs-svn/trp.h
index 49940cf..1f5f51f 100644
--- a/vcs-svn/trp.h
+++ b/vcs-svn/trp.h
@@ -138,6 +138,19 @@ a_attr a_type MAYBE_UNUSED *a_pre##search(struct t=
rp_root *treap, a_type *key) \
 	uint32_t ret =3D treap->trp_root; \
 	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base,ret)))) { \
 		if (cmp < 0) { \
+			ret =3D trp_left_get(a_base, a_field, ret); \
+		} else { \
+			ret =3D trp_right_get(a_base, a_field, ret); \
+		} \
+	} \
+	return trpn_pointer(a_base, ret); \
+} \
+a_attr a_type MAYBE_UNUSED *a_pre##nsearch(struct trp_root *treap, a_t=
ype *key) \
+{ \
+	int cmp; \
+	uint32_t ret =3D treap->trp_root; \
+	while (~ret && (cmp =3D (a_cmp)(key, trpn_pointer(a_base,ret)))) { \
+		if (cmp < 0) { \
 			if (!~trp_left_get(a_base, a_field, ret)) \
 				break; \
 			ret =3D trp_left_get(a_base, a_field, ret); \
diff --git a/vcs-svn/trp.txt b/vcs-svn/trp.txt
index 9247eba..eb4c191 100644
--- a/vcs-svn/trp.txt
+++ b/vcs-svn/trp.txt
@@ -86,8 +86,13 @@ void foo_remove(struct trp_root *treap, node_type \*=
node)::
 node_type *foo_search(struct trp_root \*treap, node_type \*key)::
=20
 	Search for a node that matches key.  If no match is found,
-	return what would be key's successor, were key in treap
-	(NULL if no successor).
+	result is NULL.
+
+node_type *foo_nsearch(struct trp_root \*treap, node_type \*key)::
+
+	Like `foo_search`, but if if the key is missing return what
+	would be key's successor, were key in treap (NULL if no
+	successor).
=20
 node_type *foo_first(struct trp_root \*treap)::
=20
--=20
1.7.2.rc2
