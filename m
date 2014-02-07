From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with
 no-done cap
Date: Sat, 8 Feb 2014 06:39:06 +0700
Message-ID: <20140207233906.GA5791@lanh>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-7-git-send-email-pclouds@gmail.com>
 <xmqqppmyvm3f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 00:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBv0q-000738-KS
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 00:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaBGXjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 18:39:07 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51227 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaBGXjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 18:39:06 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so3813717pad.22
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Rw+TK62e8u9e5+fuO0kIwUzonC4+PDIMHHVb0zflCm0=;
        b=wlLj/IZaKTr+Qjdb3jPcsMtI2D2ZNVbZtouL6W/ByioGvdFoiDJ63ZUZYMHQCbmlWx
         gl6/vMPdGcPpziwznshp1pkWF3NuzMEPlBnOtvMbplZuc/rkSQVgdLgEcUiNRVVkvm7f
         HfGcsch7ATDLziHiwd+ZFV0hF6A5yI80MdQE5HyDjfAN1ZXbaVBD8OdiVoM7iB4Y6LM1
         +8Bq8+ATb4heIzh87t2qlxk+kjcV/ZiF0wBiD8l1VBUcty5DGShaTx2OQYpd/HZfBetK
         LyT266Z+RDx6L1ngSV8I5PfKCqG9/9m6oix0tXv1JSK18cFK+rpz3uH3Al850cvujgPT
         7OEw==
X-Received: by 10.66.124.230 with SMTP id ml6mr11228648pab.29.1391816345124;
        Fri, 07 Feb 2014 15:39:05 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id ei4sm17425785pbb.42.2014.02.07.15.39.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 15:39:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 06:39:06 +0700
Content-Disposition: inline
In-Reply-To: <xmqqppmyvm3f.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241813>

On Fri, Feb 07, 2014 at 10:01:08AM -0800, Junio C Hamano wrote:
> Here is the difference between the posted series and what I queued
> after applying the changes suggested during the review.
> 
> Thanks.

I was going to send a reroll after the received comments. Could you
put this on top of 6/6, just to make sure future changes in t5537
(maybe more or less commits created..) does not change the test
behavior?

It fixes the test name too. I originally thought, ok let's create
commits in one test and do fetch in another. But it ended up in the
same test and I forgot to update test name.

-- 8< --
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 1413caf..b300383 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -203,7 +203,7 @@ EOF
 # This test is tricky. We need large enough "have"s that fetch-pack
 # will put pkt-flush in between. Then we need a "have" the server
 # does not have, it'll send "ACK %s ready"
-test_expect_success 'add more commits' '
+test_expect_success 'no shallow lines after receiving ACK ready' '
 	(
 		cd shallow &&
 		for i in $(test_seq 10)
@@ -224,7 +224,9 @@ test_expect_success 'add more commits' '
 		cd clone &&
 		git checkout --orphan newnew &&
 		test_commit new-too &&
-		git fetch --depth=2
+		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch --depth=2 &&
+		grep "fetch-pack< ACK .* ready" ../trace &&
+		! grep "fetch-pack> done" ../trace
 	)
 '
 
-- 8< -- 
