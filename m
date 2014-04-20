From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 0/5] fc/transport-helper-sync-error-fix rebased
Date: Sun, 20 Apr 2014 13:36:59 -0500
Message-ID: <535413cbc7eaa_1f08dd12eca5@nysa.notmuch>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 20:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbwmH-0005M5-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 20:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbaDTSrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 14:47:22 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:35574 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaDTSrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 14:47:20 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so2948271yhl.34
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=D9+k0CIMPbCKqYxlfXDLLcluPGR2TYfqs3C6+xa09p8=;
        b=LKJwQs2qmOuqqSsMutVa8Fyk+zBUayrnY6q+4G7ga1sqLskz8kz/lxt1zGDlpSB/tu
         lRs+pWlc4KFWebKc9FnsrmpZDdwsou2rXQ9qcHM7+/YWHO4G5cnc0Z8kaDl9nL/rvZgo
         u+qalKemTOSn0rMbJ6INamLTpGeoJ6e3wOLDqL+xN6cEMFumtWGbdyD1k3UBtPlKjuLo
         45nYOxkYlhMEm/Z73SdWbF3/aPp/UcVjw8b5GVrgWgfTKBG1Ml9RsAj3hf8hYaY8VIfo
         lHW0I8E87Vpgd6sQ0Iczz6l7FNU6qtiGF5N/R9Q4zP+ndldzx9Yj+KpbvtOTODiXiZtf
         nYVg==
X-Received: by 10.236.119.99 with SMTP id m63mr18763958yhh.65.1398019640017;
        Sun, 20 Apr 2014 11:47:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m23sm65327591yho.15.2014.04.20.11.47.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 11:47:18 -0700 (PDT)
In-Reply-To: <1397890843-27035-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246556>

Junio C Hamano wrote:
> As I have said in the recent What's cooking reports, the original
> posted here were based on older codebase and needed to be rebased,
> but it had some conflicts and I wanted to see the result double
> checked by the original author before we can merge it to 'next',
> cooked there and hopefully merged to 'master' before tagging -rc1.
> 
> So here is the series that has been queued in 'pu' for the past
> several days.
> 
> Felipe, can you double check it?

These patches don't help much, I did and interdiff with my own fixes and this
is the result:

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 284bf3f..aa3e223 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -221,13 +221,16 @@ test_expect_success 'push update refs failure' '
 '
 
 clean_mark () {
-       cut -f 2 -d ' ' $1 | git cat-file --batch-check | grep commit | sort > $(basename $1)
+       cut -f 2 -d ' ' "$1" |
+       git cat-file --batch-check |
+       grep commit |
+       sort >$(basename "$1")
 }
 
 cmp_marks () {
        test_when_finished "rm -rf git.marks testgit.marks" &&
-       clean_mark .git/testgit/$1/git.marks &&
-       clean_mark .git/testgit/$1/testgit.marks &&
+       clean_mark ".git/testgit/$1/git.marks" &&
+       clean_mark ".git/testgit/$1/testgit.marks" &&
        test_cmp git.marks testgit.marks
 }
 
@@ -244,7 +247,7 @@ test_expect_success 'proper failure checks for fetching' '
 test_expect_success 'proper failure checks for pushing' '
        (cd local &&
        git checkout -b crash master &&
-       echo crash >> file &&
+       echo crash >>file &&
        git commit -a -m crash &&
        test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all &&
        cmp_marks origin

I don't like it, but it's OK.

-- 
Felipe Contreras
