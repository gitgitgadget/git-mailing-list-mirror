From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch-pack: check for valid commit from server
Date: Fri, 19 Aug 2011 22:11:33 +0700
Message-ID: <1313766693-20798-1-git-send-email-pclouds@gmail.com>
References: <1313674563-12755-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 17:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuQjc-0000GM-6X
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 17:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab1HSPLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 11:11:43 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65356 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab1HSPLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 11:11:42 -0400
Received: by pzk37 with SMTP id 37so4979695pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k29bQdkVKS/KDQHZ4kqcr5qcoolGTp1FGhaoJKF52Uc=;
        b=UOutpBVO12zYCwmuBzbcwkANHqheZUu5m2Qk6nrH+Ia8EgYwKF0bgKbZiG4TcRcytV
         unimArSJQLGFNhRuDT15wyINyHz7AgeokSsIQ1sTKE694kMRH1hEhSftw4xl8NuoOPSV
         4BIcXY5At1VmuEZhDD7drVVky0hLQBltHwOsg=
Received: by 10.143.97.15 with SMTP id z15mr1094076wfl.405.1313766702392;
        Fri, 19 Aug 2011 08:11:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id l7sm2402613pbh.26.2011.08.19.08.11.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 08:11:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Aug 2011 22:11:35 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313674563-12755-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179708>

A malicious server can return ACK with non-existent SHA-1 or not a
commit. lookup_commit() in this case may return NULL. Do not let
fetch-pack crash by accessing NULL address in this case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/8/19 Shawn Pearce <spearce@spearce.org>:
 > 2011/8/18 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
 >>  However it raises another question, what if the other end returns =
a
 >>  valid commit, but not the one in "have" line fetch-pack sent? Are =
we
 >>  OK with that?
 >
 > Not really. The server is not supposed to return a SHA-1 in the ACK
 > line unless the client said it first in a have line. So aborting wit=
h
 > an error is reasonable thing for a client to do.

 I assumed I could check result_sha1 against sha1. If it did not match,
 fetch-pack would abort. But I was wrong because fetch-pack would send
 a few have lines before receiving the first ack (which carries sha1
 of some 'have' line in the middle, not the last 'have'). I'd leave it
 here if anyone wants to tackle it.

 builtin/fetch-pack.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4367984..561f1a3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -395,6 +395,9 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 				case ACK_continue: {
 					struct commit *commit =3D
 						lookup_commit(result_sha1);
+					if (!commit)
+						die("server ACK contained unknown commit %s",
+						    sha1_to_hex(result_sha1));
 					if (args.stateless_rpc
 					 && ack =3D=3D ACK_common
 					 && !(commit->object.flags & COMMON)) {
--=20
1.7.4.74.g639db
