From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] get_sha1_oneline: do not leak or double free
Date: Mon, 13 Dec 2010 10:01:13 +0700
Message-ID: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 04:02:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRyg5-0008FV-BM
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 04:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756647Ab0LMDCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 22:02:12 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53020 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab0LMDCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 22:02:12 -0500
Received: by pva4 with SMTP id 4so1041839pva.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 19:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=s7vvy1RUPyJA6Vf2XxaxGfShRlybpBC5XI/TvXLDeqM=;
        b=HXvLA8+V5FqwoPk8l4yTCjw2LAQM4hPDG+cIoujeU5fOdOwWEcQWk0uleXbjSqFJtw
         QeFd2Hi+V9uwYon8GFJlY+BeQvlilx70TrixU1pgt5tnERpWrTEFGiP0oMSAI/AcBGRm
         cyZfyiTtiOX5joIWhj54YiYvzUfqQk8CLSy7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CmHOfHrvbvpXoD6vFV1RNWcrZcyPDAyaHXwDsGa5r6cCEEEVrzPE0Odc6+8lfrXlqD
         NpmQUgkUvHuKKkh7fZ9jGAxe62YbWM9G81UnXzR7TGP+QDkNyL9l06HOCYBFu8qq3lMl
         5jbRNHy2f2dTUpYJlFOM7ZwrwtsPXuGWXAfKk=
Received: by 10.142.185.6 with SMTP id i6mr2773811wff.16.1292209331696;
        Sun, 12 Dec 2010 19:02:11 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id f5sm8275610wfg.2.2010.12.12.19.02.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 19:02:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 10:01:17 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163505>

Double free can happen when commit->buffer =3D=3D NULL in the first
iteration, then !=3D NULL in the next two iterations.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2c3a5fb..13ee6f5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -718,13 +718,13 @@ static int get_sha1_oneline(const char *prefix, u=
nsigned char *sha1)
 		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(commit->object.sha1))
 			continue;
-		free(temp_commit_buffer);
 		if (commit->buffer)
 			p =3D commit->buffer;
 		else {
 			p =3D read_sha1_file(commit->object.sha1, &type, &size);
 			if (!p)
 				continue;
+			free(temp_commit_buffer);
 			temp_commit_buffer =3D p;
 		}
 		if (!(p =3D strstr(p, "\n\n")))
@@ -740,6 +740,7 @@ static int get_sha1_oneline(const char *prefix, uns=
igned char *sha1)
 	free_commit_list(list);
 	for (l =3D backup; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
+	free_commit_list(backup);
 	return retval;
 }
=20
--=20
1.7.3.3.476.g10a82
