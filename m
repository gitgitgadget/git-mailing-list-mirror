From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] Makefile: Improve compiler header dependency check
Date: Sat, 27 Aug 2011 14:00:44 -0700
Message-ID: <1314478844-55379-1-git-send-email-davvid@gmail.com>
References: <20110827162645.GA10476@elie.gateway.2wire.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 23:00:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxPzs-0000ge-ER
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 23:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab1H0VAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 17:00:52 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39425 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab1H0VAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 17:00:51 -0400
Received: by pzk37 with SMTP id 37so6197598pzk.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Qvo6TlnbCnrrNcN7vhnbGRRCb24MP74N0yr2FNMUBiY=;
        b=X7ZfGP6JIe2By4IsR337wNMhReAyG9y5tSlvxv3ddp2YEqT5o/6Lxgg2MwsMkCp61v
         EIgmj85RzTXr0o1pZgcyAWLwru8z09RuPqE+oMHR7gHboHdzdjsvfRbvFgoDTySwebMd
         xwg+IbDgBnboL40K/kkoVHq5y6XgIGWsOymhs=
Received: by 10.142.237.2 with SMTP id k2mr1414162wfh.327.1314478850727;
        Sat, 27 Aug 2011 14:00:50 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id u2sm8927553pbq.9.2011.08.27.14.00.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 14:00:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.308.gc820
In-Reply-To: <20110827162645.GA10476@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180247>

Make the check use the same flags as the invocation to avoid
false positives when user-configured compiler flags contain
incompatible options.

For example, it is possible to build universal git binaries on
OS X with the following snippet in config.mak:

	CFLAGS = -arch i386 -arch x86_64

111ee18c31f9bac9436426399355facc79238566 breaks this setup and
results in the following error message:

	gcc-4.2: -E, -S, -save-temps and -M options are
	not allowed with multiple -arch flags

Include ALL_CFLAGS so that this and other conditions are caught.
Use SHELL_PATH instead of assuming that "sh" is a sane shell.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I'm not sure if "sh -c" is necessary but I did notice that other
parts of the Makefile use $(SHELL_PATH).  The check was adjusted
to use that as well.

 Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index aa67142..9446a4e 100644
--- a/Makefile
+++ b/Makefile
@@ -1250,8 +1250,9 @@ COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
 else
 ifndef COMPUTE_HEADER_DEPENDENCIES
-dep_check = $(shell sh -c \
-	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
+dep_check = $(shell $(SHELL_PATH) -c \
+	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null \
+	$(ALL_CFLAGS) 2>&1; \
 	echo $$?')
 ifeq ($(dep_check),0)
 COMPUTE_HEADER_DEPENDENCIES=YesPlease
-- 
1.7.7.rc0.308.gc820
