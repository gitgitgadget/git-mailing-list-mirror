From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: fix buffer overflow caused by translations
Date: Sat, 16 Mar 2013 08:25:18 +0700
Message-ID: <1363397118-16015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 02:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGfsf-00039m-Qf
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 02:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab3CPBZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 21:25:27 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35314 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab3CPBZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 21:25:26 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so4477447pbc.7
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=T72EFm2txsuVY8n17q1AMuBrl7uflaRqjF69ycEszZ8=;
        b=hQWKOAdCx1c4q35qZaPGcdw0N30XBCL4M08fjC8Q9Q01S0K/pcxkR9vXanX80NFyiF
         xHMFwULsi7nsJ8/RcMNeDmThz2+oX/pI3ppTn3v56OByvP7atYi3KbKpOMTHYwbLAJJP
         HOr8LcuNXj3IHvVS1XpbnB0ceNjI6+ickXcJ+9f1u4fyfs9OqBDRxOkW4IWC+GaV6tlY
         6y21291WCoJGi4W2NA64gwtzHB4IjoJfcDYjUsgxEpIdD0SBHMezcbnx/o7RAgeBbYQr
         53S053hGnAsdMZ4HR96qffIrz9K42Uq0naipAVH5kg/2ta82Wjs14WQYfatZSqMIVvxQ
         QerQ==
X-Received: by 10.68.98.34 with SMTP id ef2mr3573209pbb.18.1363397125835;
        Fri, 15 Mar 2013 18:25:25 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id hs8sm11283049pbc.27.2013.03.15.18.25.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 18:25:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 08:25:19 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218269>

The translation of "completed with %d local objects" is put in a
48-byte buffer, which may be enough for English but not true for any
translations. Convert it to use strbuf (i.e. no hard limit on
translation length).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 My bad, I should have checked this when I marked this string for
 translation. At least recent Vietnamese translation triggers this.

 builtin/index-pack.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 43d364b..ef62124 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1099,7 +1099,7 @@ static void conclude_pack(int fix_thin_pack, cons=
t char *curr_pack, unsigned cha
 	if (fix_thin_pack) {
 		struct sha1file *f;
 		unsigned char read_sha1[20], tail_sha1[20];
-		char msg[48];
+		struct strbuf msg =3D STRBUF_INIT;
 		int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
 		int nr_objects_initial =3D nr_objects;
 		if (nr_unresolved <=3D 0)
@@ -1109,9 +1109,10 @@ static void conclude_pack(int fix_thin_pack, con=
st char *curr_pack, unsigned cha
 				   * sizeof(*objects));
 		f =3D sha1fd(output_fd, curr_pack);
 		fix_unresolved_deltas(f, nr_unresolved);
-		sprintf(msg, _("completed with %d local objects"),
-			nr_objects - nr_objects_initial);
-		stop_progress_msg(&progress, msg);
+		strbuf_addf(&msg, _("completed with %d local objects"),
+			    nr_objects - nr_objects_initial);
+		stop_progress_msg(&progress, msg.buf);
+		strbuf_release(&msg);
 		sha1close(f, tail_sha1, 0);
 		hashcpy(read_sha1, pack_sha1);
 		fixup_pack_header_footer(output_fd, pack_sha1,
--=20
1.8.2.82.gc24b958.dirty
