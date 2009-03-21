From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] pack-objects: don't loosen objects available in alternate 
	or kept packs
Date: Sat, 21 Mar 2009 17:23:18 -0500
Message-ID: <ee63ef30903211523l1d25db8br9bf644e2f253d32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:25:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9d2-0001ZN-U3
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbZCUWXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbZCUWXV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:23:21 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:49600 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbZCUWXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:23:21 -0400
Received: by gxk4 with SMTP id 4so4326054gxk.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=KdM6n1g45JYLQJ1rsPU46bnsDcblGA3tqanKE8V5Lkc=;
        b=c7XA8Myxq89nLnBul9sUyzu7SeVcuajGoBZ1WYRpHa5Imdk6/7w71Qj2gEVBxpwfBc
         LS8AU7bolODPWJSdtZHv4V5b/9PB/mpfT0SSAlHk4O13VlVEqEsDmNInagKcMIK8l1H1
         wMBnuC7Lb87XHeZd3FERZSC5H7PCjdS1OCeLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=QZkk7kVhXPHW8G1gtkpGdTkfDgBsQDoH3qqWry7zAgfLCwRRBbcgc+50nd9veAvPf1
         R+0M2H+PxRNszfSvvKlIwMxE+NmEsyQQJXbxMnB0/F7MfMswBn2aWO/hTb8PeWfzw0BY
         ppmN3Y0OTvrcNB8qHpBbHLhbgZBrAp3FaMEzs=
Received: by 10.150.57.17 with SMTP id f17mr9425722yba.78.1237674198677; Sat, 
	21 Mar 2009 15:23:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114086>

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
---
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
