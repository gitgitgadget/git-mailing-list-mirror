From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/11] vcs-svn: Reject deltas that do not consume all inline
 data
Date: Wed, 13 Oct 2010 04:48:07 -0500
Message-ID: <20101013094807.GI32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xzj-0008AZ-O4
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab0JMJva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:51:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42868 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0JMJva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:51:30 -0400
Received: by gwj17 with SMTP id 17so1770325gwj.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bMwUv6k9YNXAq5XbYRNzojndDbHPzkuaTXRr/+k9dWc=;
        b=KI6FX9FkKfsmgqF44YgsX+K60kkeiEqOjvYFZigHXX9aPNePLX+pnhtGeK6ovc0G+u
         UaT7w3s6c2YO5PJls/TWeGfCrCA7KpnUD9Bwtiyi8vaT2CFoHjKaH3Wmm7i6iSSzdXwH
         MSTdPzATj/igZ2CWcr8yKyEMPDgUkuhkM3UqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Vhx8Po4SKJ3deeVu1Z0JVT+sEjLXtpOjWiRNSEMO9icwNoqh3Q4ZZVmQ3ypVmCtW71
         iTrAgoJsZ/AUALTwLLvOkQv61u7fmoFqCscZQTDGnECqJR2a/NVI1cR3bGb0k83DLVRy
         3zIohoRRvpRXgq2hrfcmjXQLNwPek9xe/oU88=
Received: by 10.236.105.148 with SMTP id k20mr17805637yhg.33.1286963488696;
        Wed, 13 Oct 2010 02:51:28 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id r25sm314963yhc.0.2010.10.13.02.51.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:51:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158921>

The main point is to constrain the format of deltas more,
so corruption and other breakage can be more easily detected.

Requiring deltas not to provide unconsumed data also opens
the possibility of ignoring the declared amount of new data
and simply streaming the data as needed to fulfill
copyfrom_data requests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9011-svn-da.sh |   12 +++---------
 vcs-svn/svndiff.c |    2 ++
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 9279924..c9f4768 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -117,20 +117,14 @@ test_expect_success 'preimage view: accept truncated preimage' '
 	test_cmp empty actual.longread
 '
 
-test_expect_success 'inline data' '
+test_expect_success 'unconsumed inline data' '
 	printf "SVNQ%b%s%b%s" "QQQQ\003" "bar" "QQQQ\001" "x" |
 		q_to_nul >inline.clear &&
-	test-svn-fe -d preimage inline.clear 18 >actual &&
-	test_cmp empty actual
+	test_must_fail test-svn-fe -d preimage inline.clear 18 >actual
 '
 
 test_expect_success 'truncated inline data' '
-	printf "SVNQ%b%s" "QQQQ\003" "b" | q_to_nul >inline.trunc &&
-	test_must_fail test-svn-fe -d preimage inline.trunc 10
-'
-
-test_expect_success 'truncated inline data (after instruction section)' '
-	printf "SVNQ%b%b%s" "QQ\001\001\003" "\0201" "b" | q_to_nul >insn.trunc &&
+	printf "SVNQ%b%b%s" "QQ\003\001\003" "\0203" "b" | q_to_nul >insn.trunc &&
 	test_must_fail test-svn-fe -d preimage insn.trunc 11
 '
 
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index c03cd7e..8755c83 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -188,6 +188,8 @@ static int apply_window_in_core(struct window *ctx)
 	while (insn != ctx->instructions.buf + ctx->instructions.len)
 		if (step(ctx, &insn, &data_pos))
 			return -1;
+	if (data_pos != ctx->data.len)
+		return error("Invalid delta: does not copy all new data");
 	return 0;
 }
 
-- 
1.7.2.3
