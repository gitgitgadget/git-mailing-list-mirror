From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 5/5] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Wed, 18 Jun 2014 10:24:31 -0700
Message-ID: <1403112271-21331-6-git-send-email-sahlberg@google.com>
References: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:24:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJbP-0007cJ-Or
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbaFRRYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:24:43 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:54046 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbaFRRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:24:35 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so126395pdi.3
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fCICeTZ30nIpcJKToeq5hiZkE6eQt0V38UCpxSF/KTg=;
        b=Wj6G8e0Kmm3QIoSPLCOiqsuxmwGSlEs4R1w7pNSecDWjMbvzHdPeyoYQX/0wxEsXh4
         rcCsy3Rj10Rmy3qrdmeoz2UDWFpM7EGGlwbj7ErrY4dvK1tWQEChXix7yKrjNoPgrFDK
         ZGP90J4ndU1hY+AcxgniLzi4BJe0+amHJzJccGS1I1fj6ND8mY/X6BTHS/ivGYM2RUyJ
         hIJ0C8/M01J4amOg7YW8EIniOJXDpn4wFVWyBROWVUnqeFb8J0LEr9tKzF8c/XhFc7u2
         VowckI8dxwpYotAXpWVNMlmu7SM7eAPL5E9c3P55HSwrOP9YHzv5thlPgvsrLdb0WmPB
         STHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fCICeTZ30nIpcJKToeq5hiZkE6eQt0V38UCpxSF/KTg=;
        b=gTHkVgq7fpTZhU1xurn7tUAyXIIn/6Lnu2OdtESv1PTB+3e8J9cTOh77s8brRdzXrh
         tu2oxwG67ewQ+qC7qicP7MhY4FL7OIM2O7rdyAbQbSHSARraYuLWTMNsobwhkaV+DfEa
         xVUxUmCwWlo8hTGwkfV30k2RgYpuqedC1gtCz9WkxIH8XH1jumPYF2pNT3HKiDpmFCGh
         +cTwCWwW/fJZnQUnuhkvFCJ6db7nx0kYbEYyml0+cMnVfS0SpfGsHBkXjYIWwYT05cGv
         k/OS7vv7zvWZkPoFcs060KeAxNMDoB+YCy9mNCGm/YPncnhA+XUBc7Hz7uALh6NesR1x
         jCbQ==
X-Gm-Message-State: ALoCoQnWux62A1CnnaoEvvdqxsTAm4jdnfBClZLnvQwQ3WSvtbEfaurjfY7SLztPyL1/QHjtrs7h
X-Received: by 10.66.160.34 with SMTP id xh2mr1357213pab.6.1403112275058;
        Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si175505yhp.6.2014.06.18.10.24.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DBD635A48B1;
	Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8ACB6E05BF; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252011>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 89e5bc0..582591b 100644
--- a/refs.c
+++ b/refs.c
@@ -2548,8 +2548,10 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
+		if (remove_entry(packed, ref_to_delete->string) == -1) {
+			rollback_packed_refs();
 			die("internal error");
+		}
 	}
 
 	/* Write what remains */
-- 
2.0.0.467.g08c0633
