From: Sven Brauch <svenbrauch@googlemail.com>
Subject: [PATCH] git-cat-file: fix output when format string contains no variables
Date: Tue, 05 Nov 2013 21:03:11 +0100
Message-ID: <1748846.6BAMC5enOx@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: svenbrauch@googlemail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 21:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdmqO-0001KA-5p
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 21:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab3KEUDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 15:03:15 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:41136 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab3KEUDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 15:03:14 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so2724738bkz.25
        for <git@vger.kernel.org>; Tue, 05 Nov 2013 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=3BbQxT6KKIDmHMQAJb6ZXOj7DYChErxSnXUfk2VUaxw=;
        b=mTuvGpnRywxdiJ9OaxZXyvWgJ2vZLlKoKXnWtCJouHHeSJVGkoow3aSQzZE79axzGa
         DEk9otavpPFRyILTS0gwef4z87ktwYYHLhXU5rPeHtjvl5Yc6i9qWv6ImcR6LStvrBgS
         n8Ae5UBKgEyR2udYc9T2INd4CFGUTWSiLP7Q9wZdsNYAwBoJqBX9H7aAAUAFfuBmkjbj
         TD2bT2uXNhEbLfpxSBcr7lLOqR6JMfl/wqio1aXb/gCmch5eja1auN7pp/JVlQ6X8XUL
         oS/kIb8HNCsFKscqRg9vxXceUh/nwqzEvpuFsxlsHhGcGwtMLtCw9zLoYVZbuAMQL/vz
         H5ig==
X-Received: by 10.204.2.140 with SMTP id 12mr105285bkj.47.1383681793307;
        Tue, 05 Nov 2013 12:03:13 -0800 (PST)
Received: from localhost.localdomain (p4FDCFAC3.dip0.t-ipconnect.de. [79.220.250.195])
        by mx.google.com with ESMTPSA id b7sm20628891bkg.1.2013.11.05.12.03.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2013 12:03:12 -0800 (PST)
User-Agent: KMail/4.11.2 (Linux/3.11.6-1-ARCH; KDE/4.11.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237340>

>From 2e7b5aed771faeff654a447346bb0b57570d9569 Mon Sep 17 00:00:00 2001
From: Sven Brauch <svenbrauch@googlemail.com>
Date: Tue, 5 Nov 2013 20:06:21 +0100
Subject: [PATCH] git-cat-file: fix output when format string contains no
 variables

When the format string for git-cat-object --batch-check contained no
variables, the function would not actually look for the object on disk,
but just verify that the hash is correct. Thus it would report no error
if asking for objects which did not actually exist on disk if the SHA hash
looked ok.

Example of buggy behaviour:
echo "XYZ" | git hash-object --stdin | git cat-file --batch-check="found"
would report "found" although the manpage claims it would report an error.

Signed-off-by: Sven Brauch <svenbrauch@googlemail.com>
---

Notes:
    This fixes a bug where git-cat-file --batch-check would erroneously tell
    that objects exist while they did in fact not in case the argument to
    --batch-check was just a constant strig (i.e. no %(...) variables).
    The reason was that calling sha1_object_info_extended while requesting no
    properties of the object would not even verify this object existed, or more
    exactly, sha1_loose_object_info would not do that.
    
    I'm entirely unfamiliar with the git codebase; the suggested fix ensures
    that always at least one property is requested. If there's a better way
    to fix this issue, please let me know.

 builtin/cat-file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..32d0b63 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -238,6 +238,15 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 		return 0;
 	}
 
+	if (!data->info.disk_sizep && !data->info.sizep && !data->info.typep) {
+		/*
+		 * None of the info fields was requested, so we request the cheapest
+		 * one (disk_sizep) to force sha1_object_info_extended to actually
+		 * look for the file.
+		 */
+		data->info.disk_sizep = &data->disk_size;
+	}
+
 	if (sha1_object_info_extended(data->sha1, &data->info) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
-- 
1.8.4.2
