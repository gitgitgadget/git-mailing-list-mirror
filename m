From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 7/7] t2016 (checkout -p): use printf for multiline y/n
 input
Date: Mon, 6 Sep 2010 20:55:09 -0500
Message-ID: <20100907015509.GH1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnQx-0001Dn-4S
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0IGB5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:57:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61006 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0IGB5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:57:08 -0400
Received: by qyk33 with SMTP id 33so4843865qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rQdPD540UelHTeqlDjBFmezF/dSLhQEBHfNG67/OmG0=;
        b=Km78SlhTi5cU/OjIIzN7QaSD2z0jL79bqaaKSSgqP/do1waQSz9+sC9RXBJs3oogx4
         lhBkj6fvdap7mdFfXK+p4owbgDftAoY5kBhiSUlu9Jr99rWL4elc+aOZyYlzpCsd0d9D
         YaSsRCx3QvSpgCpaz7EAY5P/ZEIoRDuISodMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rFpJeG77gW/TDtwBePzqcZVAmu/UxWM/qj/Iz0Fc5KT9FTN8iaJpoIZU+zerTgNe0g
         iD9cpFvUkO3UuJQkuCJrF4SBfFzCL88bhhm4Bq6DFXsXVlyYXJjT8rZYrLmBgaJaiAQk
         znz5/mmlERq3SkXp52xH3SS8xc2jLV/f8ahoE=
Received: by 10.229.71.68 with SMTP id g4mr3167540qcj.174.1283824627608;
        Mon, 06 Sep 2010 18:57:07 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t18sm6430698qco.20.2010.09.06.18.57.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:57:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155665>

Instead of

	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir

write

	printf "%s\n" y n n |
	git checkout -p HEAD^ -- dir

which means the same thing but might be easier to read.

While at it, add a missing && to the "git checkout -p HEAD with change
already staged" test.

Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t2016-checkout-patch.sh |   43 +++++++++++++++++++++++++++++--------------
 1 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 2144184..8cb7f46 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -20,48 +20,55 @@ test_expect_success 'setup' '
 
 test_expect_success 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
-	(echo n; echo n) | git checkout -p &&
+	printf "%s\n" n n |
+	git checkout -p &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
 test_expect_success 'git checkout -p' '
-	(echo n; echo y) | git checkout -p &&
+	printf "%s\n" n y |
+	git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success 'git checkout -p with staged changes' '
-	set_state dir/foo work index
-	(echo n; echo y) | git checkout -p &&
+	set_state dir/foo work index &&
+	printf "%s\n" n y |
+	git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
 
 test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
 	set_and_save_state dir/foo work head &&
-	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	printf "%s\n" n y n |
+	git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
 test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
-	(echo n; echo y; echo y) | git checkout -p HEAD &&
+	printf "%s\n" n y y |
+	git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index
+	set_state dir/foo index index &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	printf "%s\n" n y n |
+	git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success 'git checkout -p HEAD^' '
 	# the third n is to get out in case it mistakenly does not apply
-	(echo n; echo y; echo n) | git checkout -p HEAD^ &&
+	printf "%s\n" n y n |
+	git checkout -p HEAD^ &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
@@ -69,7 +76,8 @@ test_expect_success 'git checkout -p HEAD^' '
 test_expect_success 'git checkout -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
-	(echo n; echo y) | git checkout -p &&
+	printf "%s\n" n y |
+	git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
@@ -81,21 +89,24 @@ test_expect_success 'git checkout -p handles deletion' '
 
 test_expect_success 'path limiting works: dir' '
 	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p dir &&
+	printf "%s\n" y n |
+	git checkout -p dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p -- dir &&
+	printf "%s\n" y n |
+	git checkout -p -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
 test_expect_success 'path limiting works: HEAD^ -- dir' '
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir &&
+	printf "%s\n" y n n |
+	git checkout -p HEAD^ -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
@@ -103,7 +114,11 @@ test_expect_success 'path limiting works: HEAD^ -- dir' '
 test_expect_success 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
+	printf "%s\n" y n n |
+	(
+		cd dir &&
+		git checkout -p foo
+	) &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
-- 
1.7.2.3
