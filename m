From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: let fprintf handle the formatting
Date: Fri,  5 Dec 2014 11:53:41 -0800
Message-ID: <1417809221-27209-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu,
	ronniesahlberg@gmail.com, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 05 20:53:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwywv-0003Zf-6I
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaLETxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:53:53 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37524 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaLETxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:53:52 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so1406861iga.14
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=j7zFqjRykCIgJ9RJbdNEm1moUeWjb4wHSs4ObPJ6lGE=;
        b=kfo59sgy0I+QQcbJphL0moncJ/k6M0eb3krEmBR0yBIW0DMS81u+dEJllDiY5nDN5i
         zwNC4hWNI5+GwvqobXFXNZZZseh68VyqIePF5+/0ghPfBqjlFMbKK246CPpD1M3l+d1D
         hWS3RRMBiavM3OkBOWKPgYUwr6p+lQ9uyP0pQUaqLkSuwKkjN8pf5NgUyJ7pQiWyYU+K
         W0VO54OoSJxESvbGROzNVqZrj90BO6dcWFUibdf/CANBz4V9FWQ7byu8IJU28KiPJKaz
         5IqoIJqNnefIfLxv7ySOVnEqi5czrEbzRnOTQXkqSTCkm/taak7GyOsKs+2TDAxjyNae
         z+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j7zFqjRykCIgJ9RJbdNEm1moUeWjb4wHSs4ObPJ6lGE=;
        b=aZ1N9q26X2tt9p5xMIip33ztYeaN8FPMFdA3upkaDmoHAUC52dady0FzdltbiL2VB7
         ziO3oiLaE5+4ZlZ16eGfmG/cmuhqKjXEKBaskc5uNXoVEl/r2anvW4bx55gHzxhibfqL
         kMSVegn1x1Fn2qaE9PCOIaks2fyN7okkqI/LTYJnW/+SWvEilmHYQHShJLVTk06pcTfJ
         xaeqH5qCNF4xMZx1hd45S0YWZDdTiko8YSvdMlp2Y1waFYA4XcyvaZV7WMOACuFrqT2L
         w20Cad/EMeC1jA0j7raLzpfSo3SJ03keynKjQA3OJHaAkugsty27oANQlhoUAKXEuPxf
         SEjg==
X-Gm-Message-State: ALoCoQkBh8q0MrbJPi1dJuFksfrhFHdpAZOq+IxxMTzIDZbjOVLvCSK3GmLlmni4dzfZeLnNZ287
X-Received: by 10.107.19.133 with SMTP id 5mr332821iot.58.1417809231720;
        Fri, 05 Dec 2014 11:53:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id c1sm1265404igo.17.2014.12.05.11.53.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 11:53:51 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260887>

Instead of calculating, whether to put a plus or minus sign, offload
the responsibilty to the fprintf function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 40c5591..1147216 100644
--- a/refs.c
+++ b/refs.c
@@ -3972,12 +3972,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			printf("prune %s", message);
 	} else {
 		if (cb->newlog) {
-			char sign = (tz < 0) ? '-' : '+';
-			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
 				sha1_to_hex(osha1), sha1_to_hex(nsha1),
-				email, timestamp, sign, zone,
-				message);
+				email, timestamp, tz, message);
 			hashcpy(cb->last_kept_sha1, nsha1);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-- 
2.2.0
