From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 2/2] pack-objects: don't loosen objects available in 
	alternate or kept packs
Date: Sat, 21 Mar 2009 17:26:11 -0500
Message-ID: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9fL-0002KR-TH
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZCUW0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZCUW0O
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:26:14 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:18101 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbZCUW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:26:13 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1560088ywb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=NrDOx1gsOioJoUjJcTSiM8Tsx77bGGVSbdEptAqE8j8=;
        b=bD/F5MFg98+XZuRDfxLDuFgEe78OToHS3pebHTHszrMp1nHPy/Pb/z4SOB4Jf3zuz2
         B7mGnZSwks0WXoUXZ+vWjLUj2SGjWu1Su6vBgznGQeec831Swq/PK2ImN452inGNgBfc
         C+s8vOZ/CHyGL4RYYLOuN8jXoL1x1kYe42DQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bJ0dbAkL7wD6YI+lfKXaakk4LuuoBU9yctqJvXHjyfIdd4CXLzbTu8D5C94EhfMyir
         Fd9QBNCvD3RQQVlOyx1ogB1U0jn4+hgD3o6Q193J+BhUJGoYM6VSQj67udkbNGgasRnL
         WaisM7WKT75tAIsbtqesPOypL62MyN8qhwh4c=
Received: by 10.151.42.13 with SMTP id u13mr9419710ybj.97.1237674371573; Sat, 
	21 Mar 2009 15:26:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114088>

If pack-objects is called with the --unpack-unreachable option then it will
unpack (i.e. loosen) all unreferenced objects from local not-kept packs,
including those that also exist in packs residing in an alternate object
database or a local kept pack.  The primary(sole?) user of this option is
git-repack.  In this case, repack will follow the call to pack-objects with
a call to prune-packed which will delete these newly loosened objects,
making the act of loosening a waste of time.  The unnecessary loosening can
be avoided by checking whether an object exists in a non-local pack or a
local kept pack before loosening it.

This fixes the 'local packed unreachable obs that exist in alternate ODB
are not loosened' test in t7700.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Signed version of the previous version.


 builtin-pack-objects.c |   26 +++++++++++++++++++++++++-
 t/t7700-repack.sh      |    2 +-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 6222f19..3f477c5 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1944,6 +1944,29 @@ static void
add_objects_in_unpacked_packs(struct rev_info *revs)
 	free(in_pack.array);
 }

+static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
+{
+	static struct packed_git *last_found = (void *)1;
+	struct packed_git *p;
+
+	p = (last_found == (void *)1) ? packed_git : last_found;
+
+	while (p) {
+		if ((!p->pack_local || p->pack_keep) &&
+			find_pack_entry_one(sha1, p)) {
+			last_found = p;
+			return 1;
+		}
+		if (p == last_found)
+			p = packed_git;
+		else
+			p = p->next;
+		if (p == last_found)
+			p = p->next;
+	}
+	return 0;
+}
+
 static void loosen_unused_packed_objects(struct rev_info *revs)
 {
 	struct packed_git *p;
@@ -1959,7 +1982,8 @@ static void loosen_unused_packed_objects(struct
rev_info *revs)

 		for (i = 0; i < p->num_objects; i++) {
 			sha1 = nth_packed_object_sha1(p, i);
-			if (!locate_object_entry(sha1))
+			if (!locate_object_entry(sha1) &&
+				!has_sha1_pack_kept_or_nonlocal(sha1))
 				if (force_object_loose(sha1, p->mtime))
 					die("unable to force loose object");
 		}
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 013e488..9ce546e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -113,7 +113,7 @@ test_expect_success 'packed unreachable obs in
alternate ODB are not loosened' '
 	test_must_fail git show $csha1
 '

-test_expect_failure 'local packed unreachable obs that exist in
alternate ODB are not loosened' '
+test_expect_success 'local packed unreachable obs that exist in
alternate ODB are not loosened' '
 	echo `pwd`/alt_objects > .git/objects/info/alternates &&
 	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
-- 
1.6.2.12.g83676
