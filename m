From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rerere: demonstrate a weakness with identical conflicts
 in different files
Date: Thu, 12 Aug 2010 09:28:18 +0200
Message-ID: <4C63A292.4010604@viscovery.net>
References: <4C629495.60105@viscovery.net> <7vmxssvi2t.fsf@alter.siamese.dyndns.org> <7vfwykv92a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 09:28:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjSDH-0008QW-L1
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 09:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810Ab0HLH20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 03:28:26 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20856 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab0HLH2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 03:28:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OjSD6-00087Z-Mi; Thu, 12 Aug 2010 09:28:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 672581660F;
	Thu, 12 Aug 2010 09:28:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <7vfwykv92a.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153349>

Am 8/12/2010 4:50, schrieb Junio C Hamano:
> Yes, rr-cache/ database keys off of the
> conflict id, so if your repository has more than one contents that produce
> exactly the same conflict, say F and G, then, most likely:
> 
>  * You see one of them first, say F, record preimage.F and record its
>    resolution as postimage.F
> 
>  * You encounter conflict G; record it in thisimage, try three-way merge
>    between postimage.F and that using preimage.F as the common ancestor.
>    If this doesn't work (and it likely doesn't), rerere punts.

Aha! Since the files differ in the immediate neighborhood of the context
markers, the merge that applies the resolution fails.

Squash in this and the test passes:

diff --git a/t/t4208-rerere-dup.sh b/t/t4208-rerere-dup.sh
index 34c182a..2afa0ef 100755
--- a/t/t4208-rerere-dup.sh
+++ b/t/t4208-rerere-dup.sh
@@ -12,6 +12,7 @@
 test_expect_success 'setup' '
 	cat > a1 <<- EOF &&
 	alpha
+	delta
 	beta
 	gamma
 	EOF
@@ -23,6 +24,7 @@ test_expect_success 'setup' '
 	git checkout -b first &&
 	cat > a1 <<- EOF &&
 	alpha
+	delta
 	BETA
 	gamma
 	EOF
@@ -32,6 +34,7 @@ test_expect_success 'setup' '
 	git checkout master &&
 	cat > a1 <<- EOF &&
 	alpha
+	delta
 	----
 	gamma
 	EOF
@@ -49,6 +52,7 @@ test_expect_success 'merge records
 test_expect_success 'record a resolution' '
 	cat > a1 <<- EOF &&
 	alpha
+	delta
 	--beta--
 	gamma
 	EOF
@@ -61,7 +65,7 @@ test_expect_success 'postimage must
 '

 test_expect_success 'same resolution recorded twice' '
-	test $(grep "Recorded resolution" actual | wc -l) = 2 &&
+#	test $(grep "Recorded resolution" actual | wc -l) = 2 &&
 	test $(ls .git/rr-cache | wc -w) = 1
 '


The last hunk is necessary because the output of rerere is now:

Recorded resolution for 'a1'.
Resolved 'a2' using previous resolution.

where the second statement is slightly misleading because the resolution
was not "used". But already present in the file (the resolution-merge
still succeeded, hence, rerere thought it had "used" the resolution).

I assumed that in my case I had identical text immediately outside the
conflict markers, and so I also assumed that the resolution-merge would
succeed, but it seems I was wrong. I'll go back and investigate closer as
time permits.

Thanks for your help so far.

-- Hannes
