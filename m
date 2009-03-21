From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/2] t7700: demonstrate repack flaw which may loosen objects 
	unnecessarily
Date: Sat, 21 Mar 2009 17:22:30 -0500
Message-ID: <ee63ef30903211522k5694b936ma558513d35ac98d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9bm-0001Fk-Jp
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbZCUWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZCUWWd
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:22:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:57817 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZCUWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:22:33 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1562676yxl.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=akEC/312X735jL0bNoCLEn2E7zfQy0nCIgeH87D2bcA=;
        b=SfH3UJegK1lNXdiW2ifiMOx/oPaAJd4zdNOAaGkOk+lGamQ0B1qMMae8JpflZMcxsX
         Nzhb7PkvaNYpsK+i+9EqHSkgILLtF2CMquihV9m0RnnUI66VWI6/eaBfXvDLRe5nhl/H
         DPp+acjpfXCEuG124CL+cey8LaO3HUqPPWur8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bwhSVSk7bZl4RkuyrhOPSVAGx8W1ZGZ/RPbGxZb2kwrH5uvNgXQ4bvzZMbAM+5eIyY
         4wXniYYyWluhzW3jkY7Ci58mK7ZroqlJiDWDYPpu9FmFV0XTFwRp9s6E1XDYDoRwYgD8
         6QB/mg5Lp4b/moyhH0VDlLtQRg4g6B0BSae7I=
Received: by 10.150.58.5 with SMTP id g5mr8766938yba.86.1237674150942; Sat, 21 
	Mar 2009 15:22:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114085>

If an unreferenced object exists in both a local pack and in either a pack
residing in an alternate object database or a local kept pack, then the
pack-objects call made by repack will loosen that object only to have it
immediately pruned by repack's call to prune-packed.
---
 t/t7700-repack.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1ef3892..013e488 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -113,5 +113,22 @@ test_expect_success 'packed unreachable obs in
alternate ODB are not loosened' '
 	test_must_fail git show $csha1
 '

+test_expect_failure 'local packed unreachable obs that exist in
alternate ODB are not loosened' '
+	echo `pwd`/alt_objects > .git/objects/info/alternates &&
+	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
+	rm -f .git/objects/pack/* &&
+	mv pack-* .git/objects/pack/ &&
+	# The pack-objects call on the next line is equivalent to
+	# git repack -A -d without the call to prune-packed
+	git pack-objects --honor-pack-keep --non-empty --all --reflog \
+	    --unpack-unreachable </dev/null pack &&
+	rm -f .git/objects/pack/* &&
+	mv pack-* .git/objects/pack/ &&
+	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
+		egrep "^$csha1 " | sort | uniq | wc -l) &&
+	echo > .git/objects/info/alternates &&
+	test_must_fail git show $csha1
+'
+
 test_done

-- 
1.6.2.12.g83676
