From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Tue, 21 Oct 2014 16:49:07 +0200
Message-ID: <20141021144838.GA11589@seahawk>
References: <1413884908.4175.49.camel@seahawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 16:49:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgakV-0006kf-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 16:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748AbaJUOtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 10:49:20 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:48369 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbaJUOtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 10:49:18 -0400
Received: by mail-la0-f44.google.com with SMTP id hs14so1223560lab.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 07:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MZY5sSOcyA4w3hwKu07AsaWIaYnZH1SCwGCmdqiGstA=;
        b=R9Axf9VVyCUdJevVqe+g7RXK0WG4H2BN6R1V8jdzf/8MndDTHCO0hiyxS3ce8QWg49
         wk/n9WMz/scwAvPr4b9777j+J0hGhyOjYge2kforLM29MDuCbpXu+2T9ItefqH2sk5ra
         s4xIQaKBOQ8cxBvli6CjNkv0Vz+HRh2Q3zZAHaA+KRKQHrf7RKjZdibwYtsXAEygBAXq
         iTMp1HxexRPCRUoE78D44WgAP09FLf3jPyFq5YClT3xlqA5MWyJpC9+GWGcANbJPeXJl
         ns7R3azMr9lQnP86FPqZDMtPOTMH54smkYzcR6g2jgTX3aJcBzhZSLHv9G1xITXDi7dl
         DuOA==
X-Gm-Message-State: ALoCoQk3cyukfQiypNPrvSoZbwx0G1039MwKtGeXtKbhpIkGy63MtPFpFJqBaCrBFftoI4RlyMZi
X-Received: by 10.112.130.41 with SMTP id ob9mr34634701lbb.74.1413902956194;
        Tue, 21 Oct 2014 07:49:16 -0700 (PDT)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id dc5sm4628239lbd.24.2014.10.21.07.49.14
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 07:49:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413884908.4175.49.camel@seahawk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By not clearing the request buffer in stateless-rpc mode, fetch-pack
would keep sending already known-common commits, leading to ever bigger
http requests, eventually getting too large for git-http-backend to
handle properly without filling up the pipe buffer in inflate_request.
---
I'm still not quite sure whether this is the right thing to do, but make
test still passes :) The new testcase demonstrates the problem, when
running t5551 with EXPENSIVE, this test will hang without the patch to
fetch-pack.c and succeed otherwise.

 fetch-pack.c                |  1 -
 t/t5551-http-fetch-smart.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 655ee64..258245c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -410,7 +410,6 @@ static int find_common(struct fetch_pack_args *args,
 						 */
 						const char *hex = sha1_to_hex(result_sha1);
 						packet_buf_write(&req_buf, "have %s\n", hex);
-						state_len = req_buf.len;
 					}
 					mark_common(commit, 0, 1);
 					retval = 0;
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6cbc12d..2aac237 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -245,5 +245,37 @@ test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command lin
 	)
 '
 
+test_expect_success EXPENSIVE 'create 50,000 more tags' '
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	for i in `test_seq 50001 100000`
+	do
+		echo "commit refs/heads/too-many-refs-again"
+		echo "mark :$i"
+		echo "committer git <git@example.com> $i +0000"
+		echo "data 0"
+		echo "M 644 inline bla.txt"
+		echo "data 4"
+		echo "bla"
+		# make every commit dangling by always
+		# rewinding the branch after each commit
+		echo "reset refs/heads/too-many-refs-again"
+		echo "from :50001"
+	done | git fast-import --export-marks=marks &&
+
+	# now assign tags to all the dangling commits we created above
+	tag=$(perl -e "print \"bla\" x 30") &&
+	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
+	)
+'
+
+test_expect_success EXPENSIVE 'fetch the new tags' '
+	(
+		cd too-many-refs &&
+		git fetch --tags &&
+		test $(git for-each-ref refs/tags | wc -l) = 100000
+	)
+'
+
 stop_httpd
 test_done
-- 
2.1.0-245-g26e60d4
