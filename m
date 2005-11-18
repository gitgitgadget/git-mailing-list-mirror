From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Make git-pack-redundant take a list of unimportant objs on
 stdin
Date: Fri, 18 Nov 2005 23:17:50 +0100
Message-ID: <437E530E.1020803@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sat Nov 19 00:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdEXr-0002qA-1i
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVKRWRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVKRWRU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:17:20 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:24055 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751034AbVKRWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 17:17:20 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.069.1)
        id 437D32AE000404C5; Fri, 18 Nov 2005 23:17:19 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12285>

This lets us do "git-fsck-objects --full --unreachable | cut -d ' ' -f3=
 |
git-pack-redundant --all", which will keep git-pack-redundant from keep=
ing
packs just because they contain unreachable objects.

Also add some more --verbose output.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---

 pack-redundant.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

applies-to: 3771756c044fa4338acc9f6acac3971f2309cc7c
4173f0c77793b13ad50d9c1a1ff5da32fec5e573
diff --git a/pack-redundant.c b/pack-redundant.c
index fb6cb48..f3097a1 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -579,6 +579,8 @@ int main(int argc, char **argv)
 {
 	int i;
 	struct pack_list *min, *red, *pl;
+	struct llist *ignore;
+	char *sha1, buf[42]; /* 40 byte sha1 + \n + \0 */
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
@@ -621,6 +623,23 @@ int main(int argc, char **argv)
 	if (alt_odb)
 		scan_alt_odb_packs();
=20
+	/* ignore objects given on stdin */
+	llist_init(&ignore);
+	if (!isatty(0)) {
+		while (fgets(buf, sizeof(buf), stdin)) {
+			sha1 =3D xmalloc(20);
+			if (get_sha1_hex(buf, sha1))
+				die("Bad sha1 on stdin: %s", buf);
+			llist_insert_sorted_unique(ignore, sha1, NULL);
+		}
+	}
+	llist_sorted_difference_inplace(all_objects, ignore);
+	pl =3D local_packs;
+	while (pl) {
+		llist_sorted_difference_inplace(pl->unique_objects, ignore);
+		pl =3D pl->next;
+	}
+
 	minimize(&min);
=20
 	if (verbose) {
@@ -647,6 +666,8 @@ int main(int argc, char **argv)
 		       pl->pack->pack_name);
 		pl =3D pl->next;
 	}
+	if (verbose)
+		fprintf(stderr, "%luMB of redundant packs in total.\n", pack_set_byt=
ecount(red)/(1024*1024));
=20
 	return 0;
 }
---
0.99.9.GIT
