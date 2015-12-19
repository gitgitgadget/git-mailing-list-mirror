From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v3 0/3] prepare_packed_git(): find more garbage
Date: Fri, 18 Dec 2015 18:06:37 -0600
Message-ID: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
References: <20151215232534.GA30998@sigill.intra.peff.net>
Cc: peff@peff.net, sbeller@google.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 01:07:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA53P-0000DE-Ml
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 01:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbbLSAHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 19:07:04 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35591 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbLSAHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 19:07:02 -0500
Received: by mail-yk0-f178.google.com with SMTP id v6so76647203ykc.2
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 16:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yvk4Ws1ggWokks+3LqvYE3sYB91PuJWKnsKtpMemDbU=;
        b=EihOYlfSIaOi8pZ6xyrIaIzDTPu/SV2YekB7SiKRsmnKMM7CKkg9OBzDvBrmCyNn8Z
         jMfPYJG+CArsrSrKeAZiJqJyJrzgM6u2hgJJrQfMR/QZO/5WBcGlnOFHgU6AdbrFXkEY
         YQ5Q6xOxnKVhGITNZpJxKaj9vOKRDYTccwM1i4zBYXWgSIVmUbDVPN03ecqvFTh7hoAn
         PlcLgXPGVmsV+zN3zhxYe8Ba36qjLk+Ip7HhnxkMTXQfRRNizZ2+S93BWK9JetxI7fiJ
         At1jtHDTCy9rrPg3xogboDYpqyQzZJCPnEW16chGVJaLcwoiL5FSaXuxEzLvhg3Ii51e
         AyZg==
X-Received: by 10.129.38.3 with SMTP id m3mr5600289ywm.306.1450483622223;
        Fri, 18 Dec 2015 16:07:02 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id w184sm18490831ywc.41.2015.12.18.16.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Dec 2015 16:07:01 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <20151215232534.GA30998@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282723>

Corrects the issues found in review by Peff, including simplifying
the logic in report_helper().  bits_to_msg() would've been an alternate
solution to that change, however it'll get called by
real_report_garbage(), so there's no need to call it twice, especially
when the check we need within report_helper().

I think checking for seen_bits == 0 would be future-proofing should we
arrive at a file bit not otherwise match it (i.e. file.foo and
file.bar, but nothing else would cause seen_bits to be zero, but if
that's the case, we wouldn't have PACKDIR_FILE_IDX or
PACKDIR_FILE_PACK set, either, and the second half would also match.

Doug Kelly (3):
  prepare_packed_git(): find more garbage
  t5304: Add test for .bitmap garbage files
  gc: Clean garbage .bitmap files from pack dir

 builtin/count-objects.c | 16 ++++++----------
 builtin/gc.c            | 12 ++++++++++--
 cache.h                 |  4 +++-
 sha1_file.c             | 12 +++++++++---
 t/t5304-prune.sh        | 20 ++++++++++++++++++++
 5 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.6.1
