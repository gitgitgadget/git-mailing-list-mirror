From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 3/4] git-p4: fix filetype detection on files opened exclusively
Date: Fri,  3 Apr 2015 19:53:37 +0100
Message-ID: <1428087218-8186-4-git-send-email-luke@diamand.org>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Blair Holloway <blair_holloway@playstation.sony.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye6jd-0001J2-6T
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 20:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbbDCSyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 14:54:21 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38026 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbDCSyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 14:54:14 -0400
Received: by wiun10 with SMTP id n10so1860508wiu.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SJdGB3ZtzKYGTy0VstrN/+PAMe5H3ny9bp33JhmV9V4=;
        b=SLlJEIfrJJbG0UJ9goeDTgbyYFq3qf9hhqwTfHMdZ3sCNILNLXOQAJoa8Ul9D3WQ2C
         8GXcPUTtkgthwnmJ8akdUYLZ731rZTayFvyuUJkSTMkoq+O0V4D0zazj7QV3eZriJrta
         HOqviKjGANzDh1YT5YvoOBeTvYaTvrvDSuH9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SJdGB3ZtzKYGTy0VstrN/+PAMe5H3ny9bp33JhmV9V4=;
        b=f0Yn3ALlpVogYFJDDQGio95Byh+JVKJpao5oJrY8mS+/61SrDvoq/oZ8zXZHXPDwIv
         XwENc8zzoX2VLIhr6Ui3Tpsutqm7Q6lR03pIaXnkn3VAzODWjDksPxY+1+xsS04CLSCW
         vNfGAkiB7Ex4Nvo2DS1kli1j4VoA8hL0es4wHjKWgm/dpPXy/fycQms/hwJu9KFMH5KG
         126e2Mp2SwT+JIqxK5oBUIZsRvBxl9J1KyiW3+ILDNfBrZu1oJd987exeYBusBiIWUYz
         6BMKq7N+vwB3YsRZsFDRgJzXFJ/3IRVSft8VBWwLCsjMnVvNDW8+N8UoPCE9jpeVh62N
         LvnQ==
X-Gm-Message-State: ALoCoQlHpgRCokIq4RkkCzOnC7lawHGHvmELoSEN5CtEEFNnebBeaONaqHwoPvh2QfiWBoSl1QBw
X-Received: by 10.180.86.234 with SMTP id s10mr7817422wiz.49.1428087253689;
        Fri, 03 Apr 2015 11:54:13 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id fy2sm3782967wic.15.2015.04.03.11.54.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 11:54:12 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428087218-8186-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266719>

From: "Holloway, Blair" <Blair_Holloway@playstation.sony.com>

If a Perforce server is configured to automatically set +l (exclusive lock) on
add of certain file types, git p4 submit will fail during getP4OpenedType, as
the regex doesn't expect the trailing '*exclusive*' from p4 opened:

//depot/file.png#1 - add default change (binary+l) *exclusive*

Signed-off-by: Blair Holloway <blair_holloway@playstation.sony.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index ff132b2..d43482a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -368,7 +368,7 @@ def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
-    match = re.match(".*\((.+)\)\r?$", result)
+    match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
     if match:
         return match.group(1)
     else:
-- 
2.3.0.rc1.30.g76afe74
