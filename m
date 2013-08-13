From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] unpack-trees: plug a memory leak
Date: Tue, 13 Aug 2013 20:27:58 +0200
Message-ID: <520A7AAE.6010309@web.de>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com> <CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com> <CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com> <CAMP44s1CAMPWXDSAc7WHahmrKRrB8aG_H9fnXAMi2LFOGy5EdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?B?0JvQtdC20LDQvQ==?= =?UTF-8?B?0LrQuNC9INCY0LLQsNC9?= 
	<abyss.7@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 13 20:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9JKL-00022F-CV
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab3HMS2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Aug 2013 14:28:13 -0400
Received: from mout.web.de ([212.227.15.14]:56522 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677Ab3HMS2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 14:28:13 -0400
Received: from [192.168.2.102] ([79.253.133.173]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lfj2k-1Vt23c45iU-00pNVl for <git@vger.kernel.org>;
 Tue, 13 Aug 2013 20:28:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s1CAMPWXDSAc7WHahmrKRrB8aG_H9fnXAMi2LFOGy5EdA@mail.gmail.com>
X-Provags-ID: V03:K0:EjSyRwugTUHgRehjkMWYAQbG6kj/bTq9ww4fHuPYwMAebuHTefb
 86D9bp2zaqugxo+gcSZShH8YDXWKtkMpYndTS4EDwHfDBLgwer4OPvy0lgKHGc+kh9Ab280
 61CNJsjH/qKwYcT5XRWuZWC5cDqoeRALV6he5mhMkt8IsR2PtxL5Ib4SqdUuisla6V3L+xh
 eAcp5LcAfgFMt35PQSUEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232244>

=46rom: Felipe Contreras <felipe.contreras@gmail.com>

Before overwriting the destination index, first let's discard its
contents.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Tested-by: =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=B2=
=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
---
=46elipe sent this patch as part of multiple series in June, but it can
stand on its own.  This version is trivially rebased against master.
The leak seems to have been introduced by 34110cd4 (2008-03-06,
"Make 'unpack_trees()' have a separate source and destination index").

 unpack-trees.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bf01717..1a61e6f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1154,8 +1154,10 @@ int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
=20
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
-	if (o->dst_index)
+	if (o->dst_index) {
+		discard_index(o->dst_index);
 		*o->dst_index =3D o->result;
+	}
=20
 done:
 	clear_exclude_list(&el);
--=20
1.8.3.3
