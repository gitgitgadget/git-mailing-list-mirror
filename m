Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDB135A57
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262877; cv=none; b=gjcLB1vI+/VNiFy4Gkk9t3dqmuKEjWiLLuh6C0ReNItAOkmaQnGBIFih/1Zcu0TG5BifGJTe7f7VE+nIDMJtaJGj0xfJawd1d4XrgAHm4i+njzdMYCL/mUqksiyd1Fj9MZ2TeDQgsRiSJNxgxmdm9X4/2/hd9wcRipAPAt7aOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262877; c=relaxed/simple;
	bh=G1kjw8Rwf1wjDf9zKecuCtTbuog/KA7u0bgwFtEzdcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mI3jyaCzVr+pVpN8niNPeayIx2vW9v+CKLihrVezj/TqGPYixQV4u8vRAsh4ZqFvXahNbzrNaDcGFQ4ubc4SLtKsqEpiM5b3Dt/IGJ/0wOTNohq+uXN6K/R7Zo6xagEfK6o4eYG8MX3yuQUMdHccmUCAtrSXaoqasVSRgGAlc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZSBeTBg6; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZSBeTBg6"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712262872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ry+nryYzK3Wiaqk6ctwYFwnHYXmkpQMnxFgJrXtwP4c=;
	b=ZSBeTBg6s0ClKHqzsSvGaXyM9AyfT7vCMPn/Vxcy1GRaTZr32nMkf0ZSpoO0xTg4ULvU4u
	IJMEVqkj+QCUquayzHkXdHIrNy7a1gtngTpYvBfgW7k//gecs2DgXlfB+9JBikfHJbAe3C
	rdFv5/jA/3l8yrPYWXTeNOTjClwQ3skHAr4Ovuxg7y/jidB4GYFw8g1fZmNjWkM73PVkQ/
	zQdbGJoXtZ8jJAAxS4tbXk5xbBdI+/ThTaZwlBUetfzq22NfrckRfbwrIreUtVzGGkD66W
	4ytUDOXtSOHMtCWU60zKIdD6wIJ6oxdZ3Fr+ZeEUDZ8W/NqYzoFHnn1lcUFINg==
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v2] send-email: make it easy to discern the messages for each patch
Date: Thu,  4 Apr 2024 22:34:28 +0200
Message-Id: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When sending multiple patches at once, without confirming the sending of each
patch separately, the displayed result statuses of sending each patch become
bunched together with the messages produced for the subsequent patch.  This
unnecessarily makes discerning each of the result statuses a bit difficult,
as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250
    OK. Log says:
    ...

As visible above, bunching the "Result: <status-code>" lines together with
the messages produced for the subsequent patch makes the output unreadable.
Thus, let's add a newline after each displayed result status, to make the
outputs more readable, as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250

    OK. Log says:
    ...

This change also adds a newline after the last produced result status, which
may be seen as redundant.  Though, it doesn't look too bad, and making that
last newline not displayed would make the code much more complex, which would
not be worth neither the time and effort now, nor the additional maintenance
burden in the future.

The way the additional newline separators are introduced to the source code
also moves the already existing newline characters out of the translatable
strings, which should help a bit with the translation efforts.

While there, remove one spotted stray newline in the source code.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
     * send-email: make produced outputs more readable by separating
       the result statuses from the subsequent patch outputs
    
    Changes in v2:
        - Improved the way additional newline separators are introduced to
          the source code, as suggested by Junio, [1], to help a bit with
          the translation efforts
        - Improved the patch subject and description a bit, to provide some
          additional information, as suggested by Junio [1]
    
    Notes for v1:
        - This is a resubmission of the patch I submitted about a week and
          a half ago. [2]  The patch subject in the original submission was
          selected in a bit unfortunate way, which this submission corrects,
          and also improves the patch description a bit.
        - There are no changes to the patch itself, vs. the original patch.
    
    Link to v1: https://lore.kernel.org/git/62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org/T/#u
    
    [1] https://lore.kernel.org/git/xmqqy19tylrm.fsf@gitster.g/
    [2] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/

 git-send-email.perl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a135a..ac0c691d3a46 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1576,7 +1576,6 @@ sub send_message {
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
-
 		if (!defined $smtp_server) {
 			die __("The required SMTP server is not properly defined.")
 		}
@@ -1686,10 +1685,12 @@ sub send_message {
 		print $header, "\n";
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+				($smtp->message =~ /\n([^\n]+\n)$/s);
 		} else {
-			print __("Result: OK\n");
+			print __("Result: OK");
 		}
+		# Make it easy to discern the messages for each patch
+		print "\n\n";
 	}
 
 	return 1;
