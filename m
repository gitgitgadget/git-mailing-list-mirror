From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/10] transport-helper.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:23 +0000
Message-ID: <20160603074724.12173-9-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:49:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqm-0000fm-DY
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbcFCHst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34366 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbcFCHsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so20992572wmn.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4RepfPCFxDmuqTuwkHciyM513nabxzuj9gx7DaeCZ0=;
        b=CEUfSYFPKrFAEvDZQfQxnb/I9G9egvpOOFGrZTcr+X7nAdGvCmcwm/t1DKL4cp0Fw4
         jsq8G0qvoW9sD58DRXW4v2JtcU1BfC5MK9sOnLe8QaJgqzCE3/Hdm4+NKVJZ2Io4lPk0
         O5qFa9GrgIIoOQDdALUY8xfjgS92c+4TOIObQ4m2VR8yKcrbeFtsnvYdCI/lr9FhzjQk
         vUnAoNauejkv8f65FJbhtioprQkyvp5dwD0mloHWwRDjUyXfWKG2JeGlDmprbPTNP8/J
         vSou4P3XM83IebP3QlkaRnJ+5EO3hZnCAOBXKHqhKyzAR8NvTx+dVX4Nqa3T5XVnB9uP
         D4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4RepfPCFxDmuqTuwkHciyM513nabxzuj9gx7DaeCZ0=;
        b=SwR+MaHh9EU2qr9aCGnIuy9b+3PNr7DFQ+VF0dR2kr720QZj+YBjLSR42tgKtTXIBK
         /FtK2XiKguoXSYYScJ/+FFncCz45G2nMa3ytqvMQs+YlULOo8WodgLw64EGczbtQdbU/
         yF0JILo/xh0A7iuSGr5SbJb3yqh1AaST1SW6162qJhH9ETqymqCkutn21O+6cpcaJpPC
         ofYCz6j0KpMT6QqkQpiQ2zh5kQGLI4qLeA0OYyVsyjU6Qt3EKS5GG5GzyNEibtN84Aee
         hNCznOyQGbDSt2f/lbHU62QZp+TyH4FTgYWjvNPe7PPics15uBKXasIr1RB5IplEaCvR
         GzEA==
X-Gm-Message-State: ALyK8tKG8SN/98olJ7bHgnwnC48UjXHeKp9UALw7e8EpZuHsYsmEzKh74HE3amV0/8no8Q==
X-Received: by 10.28.170.21 with SMTP id t21mr2768246wme.0.1464940124398;
        Fri, 03 Jun 2016 00:48:44 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:43 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296283>

With the commits f2f02675 and 5096d490 we have been converted in some files the call
from snprintf/sprintf/strcpy to xsnprintf. This patch converts the remaining calls
to snprintf with xsnprintf under the following conditions:

- The call to snprintf does not control the outcome of the command
  or the presence of truncation errors.
- A call to snprintf can generate a fatal error, directly or indirectly.

The other few remaining cases in which a call to snprintf can generate a soft error
have not been changed.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 transport-helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index bd666b2..18e9f44 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -317,9 +317,7 @@ static void standard_options(struct transport *t)
 
 	set_helper_option(t, "progress", t->progress ? "true" : "false");
 
-	n = snprintf(buf, sizeof(buf), "%d", v + 1);
-	if (n >= sizeof(buf))
-		die("impossibly large verbosity value");
+	n = xsnprintf(buf, sizeof(buf), "%d", v + 1);
 	set_helper_option(t, "verbosity", buf);
 
 	switch (t->family) {
-- 
2.9.0.rc1.265.geb5d750
