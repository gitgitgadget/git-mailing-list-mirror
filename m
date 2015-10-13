From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/26] mailinfo: fix for off-by-one error in boundary stack
Date: Tue, 13 Oct 2015 16:16:23 -0700
Message-ID: <1444778207-859-3-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oj-00064u-IE
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbbJMXRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:10 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35901 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbJMXQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:52 -0400
Received: by pacex6 with SMTP id ex6so34346700pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=mfzeNwstm5VN7+43vXAzISeHC4ar95ZqYZAc3GErmkA=;
        b=wQnrOEddFa48dFYyN70uHXe83izWuRG00THYU0/pYdasou5P6GSMtrhj13/llG2KzX
         T7BXMcChEqRF9lmLRzjzjhKREXM/ICj2a1BWlBp3i6oPOuPDxlcPHKgpgHWHcldNNeJI
         IHfxdRwSY0rpz0M11EvYVOxGxeLI4rP9LzcKdONMGztUPFkmDvjI1GfTK+heIs3prkkQ
         C3yC4gwmZBpnJRuKbBtSTnmbgZ0c89fc0JkfMuEgQ5/gH5iZMzkcqCawXUURg/JbB01c
         I1e+FtnET2gtwQmfPPMZc/E2kFhkQAfqh8KmwdmBl4mZGqU147O+iL+ba/YPyvmYfZGW
         Hh1w==
X-Received: by 10.68.180.131 with SMTP id do3mr43339617pbc.133.1444778212155;
        Tue, 13 Oct 2015 16:16:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id qp5sm5834902pbc.43.2015.10.13.16.16.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:51 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279533>

We pre-increment the pointer that we will use to store something at,
so the pointer is already beyond the end of the array if it points
at content[MAX_BOUNDARIES].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 As always, I am very bad at checking and fixing off-by-one errors.
 A few extra sets of eyeballs are very much appreciated.
---
 builtin/mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 330bef4..2742d0d 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -185,7 +185,7 @@ static void handle_content_type(struct strbuf *line)
 
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
-		if (++content_top > &content[MAX_BOUNDARIES]) {
+		if (++content_top >= &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
-- 
2.6.1-320-g86a1181
