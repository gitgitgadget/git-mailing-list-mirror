From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 1/2] t7700: demonstrate repack flaw which may loosen 
	objects unnecessarily
Date: Sat, 21 Mar 2009 17:25:30 -0500
Message-ID: <ee63ef30903211525q4a95a27eoa4e95c7954e5cc93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9eh-00027u-1Y
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbZCUWZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZCUWZd
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:25:33 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:55182 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbZCUWZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:25:33 -0400
Received: by gxk4 with SMTP id 4so4327150gxk.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=IvLxpZjrOoT3fDVn3ZGEYE6uAvtjqWW6c99g/DWsmgo=;
        b=olIa76MOf/J3AL2If69pi/bHY0hZY2T+O/AcZqMCHG7nVILK6jfBiyPwe/CsROCwhU
         OwitM4jLXNhefiOaxUERlwxd7epZ4qckxPMP2vSj3/SzKHzjOG3AQEXsStq75hVGCmD7
         9d88Cbf05TSdrqpTlZv78dQPgqlQQmTvoUxo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=S23d6YxxU5r38PEHj13my5tngeYC0PKBONRHjWcLZaFE/kGVilwfy9EV2hF6NrY4QS
         7iEPIbU0pkrLQ/9dsB+jNDPnAtk8d1/cY/J3/P9WusYcN6yTok0JCIUAnoZ0jT5oXaIZ
         QCcGZTTt6omb66Hy6yimvRUtKcg5qbdjSwe7Q=
Received: by 10.150.206.1 with SMTP id d1mr9392903ybg.170.1237674330761; Sat, 
	21 Mar 2009 15:25:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114087>

If an unreferenced object exists in both a local pack and in either a pack
residing in an alternate object database or a local kept pack, then the
pack-objects call made by repack will loosen that object only to have it
immediately pruned by repack's call to prune-packed.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Signed version of the previous version.


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
