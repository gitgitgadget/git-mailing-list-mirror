From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 15:43:52 -0500
Message-ID: <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
	 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcn6y-00007g-3O
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbZBZUnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 15:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZBZUnz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:43:55 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:60502 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbZBZUny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 15:43:54 -0500
Received: by rv-out-0506.google.com with SMTP id g37so698564rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rei9T+8JSSytnp3JaeloZlU5auO7kwBgQIjsABQ0HRM=;
        b=SEeN9aKszg7U7aPswhD0+zcFPgJfyaR4jkNT7l2Ay8+5VdJiWF4CEU9AofOcFqLMGW
         xcuCaO3XB6ggzJbBPNBwFJWApLL79NkoSolnp7JfyBlCTpT7/DEKAkd7pKBCQNifK3IM
         Gcs5LxWxwGtBLMgiC/ZHuhKGjarrTY+YJFIjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T88DSY31jXxTl78t+x5p40lqJYb1hG0HgW931N4AaRp8pvzxFYQqWBmWEPDzsUsl39
         JEVhpiCy+u0PXuSIBQnKnbS1jBSt8YetwEgpwt+dx3Fc2Q7B0D6vFI2/WlyxByG/XcM8
         oK/YYy/J14Ca+5HSLE6dKWrIxI8COCzB8S4Bs=
Received: by 10.141.20.6 with SMTP id x6mr817224rvi.40.1235681032362; Thu, 26 
	Feb 2009 12:43:52 -0800 (PST)
In-Reply-To: <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111596>

>> +x1="[a-z0-9]"
>
> Why [a-z0-9] not [0-9a-f]?

No reason. It's just what popped out of my head.

> I'd rather see the basic BRE grep used if you are shooting for
> portability.
>
> There are some oddballs in the source (git-submodule.sh is a notable
> offender) but none of the core-ish scripts uses egrep nor "grep -E".

Sigh, I just wanted the test to pass. I did a check to see if any
other tests were already using egrep, and when I found that they were,
I thought that would be good enough.

Originally I had switched to perl. Would you prefer:

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..a53fe0d 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -96,8 +96,8 @@ test_expect_success 'MKCOL sends directory names
with trailing slashes' '

 test_expect_success 'PUT and MOVE sends object to URLs with SHA-1
hash suffix' '

-	grep -P "\"(?:PUT|MOVE)
.+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
-		< "$HTTPD_ROOT_PATH"/access.log
+	test $(perl -ne "print if m{\"(?:PUT|MOVE)
.+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d}" \
+		< "$HTTPD_ROOT_PATH"/access.log | wc -l) -gt 0

 '

?

j.
