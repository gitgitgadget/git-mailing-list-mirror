From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/32] merge: prepare commit properly in narrow mode
Date: Wed, 25 Aug 2010 08:20:15 +1000
Message-ID: <1282688422-7738-26-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uR-00030j-I1
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0HXWXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab0HXWXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:39 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZDiqZdkNuhu77nakzQGmQdRzN+qqpRpMYhEPrfQs89Y=;
        b=E/ifm3RXAygYOMYQFF0RFLQ8bL/Ppqh3JYsxzn4hJT41A5Qw8oCLhsM2wMblEHYs/w
         BUSE6r+hrCUMhSrbidr7xHqx6OIYEedVaimjxHEemKyecfSMvU5Rnqrx/VzBaxxHwnfT
         VYzpYkQc9h4j+E7HQZ8qGnzkfDNZdEpUdkU4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aEFnJ2+yj49Z+1+6fpL7qzg3Q53ir8Qhd6erpfjTjyMBB2FHj/YxMQC3U5UvmlP/8y
         F9nHFa6U+GThmlTSdbe1HHcSgjqCgu7NWnJHZ/SgngpCUJY/f4JWJdoLmGhYuQM3eSYf
         aLjnOKEuPT/33isNRx2O7ittVmFa2lxSQjCc0=
Received: by 10.142.47.17 with SMTP id u17mr6179614wfu.260.1282688618771;
        Tue, 24 Aug 2010 15:23:38 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id z1sm645041wfd.3.2010.08.24.15.23.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:37 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:32 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154367>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c70d39d..d05c528 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -57,6 +57,7 @@ static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static int verbosity;
 static int allow_rerere_auto;
+static unsigned char narrow_base[20];
=20
 static struct strategy all_strategy[] =3D {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -780,7 +781,8 @@ static int merge_trivial(void)
 	parent->next =3D xmalloc(sizeof(*parent->next));
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	commit_narrow_tree(merge_msg.buf, result_tree, narrow_base,
+			   parent, result_commit, NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -809,7 +811,8 @@ static int finish_automerge(struct commit_list *com=
mon,
 	}
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
+	commit_narrow_tree(merge_msg.buf, result_tree, narrow_base,
+			   parents, result_commit, NULL);
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
@@ -1064,6 +1067,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		}
 		if (item)
 			die("Different narrow base, couldn't do merge (yet)");
+		hashcpy(narrow_base, lookup_commit(head)->tree->object.sha1);
 	}
=20
 	if (!remoteheads->next)
--=20
1.7.1.rc1.69.g24c2f7
