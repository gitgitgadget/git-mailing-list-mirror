From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] fetch: show remote name instead of URL if available
Date: Tue, 26 Apr 2011 10:13:27 -0500
Message-ID: <1303830807-21966-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 17:13:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEjxJ-00020q-IM
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 17:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933Ab1DZPNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 11:13:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48143 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929Ab1DZPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 11:13:32 -0400
Received: by ywj3 with SMTP id 3so263844ywj.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=1n4wFZjlobImeFchQ5lE0D5s+99n5WltNis/F+WDa6Q=;
        b=N8mxHAj9iMhxwR18Q23VddGyBl2vS18XiZEHPajvQKCROfFAaq/FW/zNgV7E7zYMSx
         Kk2MHrusPb3a+B0CCr+mOF4p6pelRIj3AUGxm+4eWwqCI5YLHHJFY4QCg1qQl/8Vut/n
         z9bHK0KP3Lw/AQ8auc0PDw+J+O2N1OdILLSH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uIKb9giL5gixe2I2fbvq8sRlZ1jfJQzSM8G5hwWot+1jkn8zsfnU+f3Xl5nYHc9zv2
         lDJ+KqJeFMtPOjhyCZ2bR0EquKapmG7yRl7G8PUc0rXDF2iqPMD5Sxi9NxLHHsoj5MiY
         jkS8r+3okXg97WpxfQTqeGcM1UKAmUnjrYyfc=
Received: by 10.236.66.35 with SMTP id g23mr1065373yhd.143.1303830811964;
        Tue, 26 Apr 2011 08:13:31 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id 45sm2726055yhl.2.2011.04.26.08.13.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 08:13:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172098>

We often have a name such as 'origin' available; use it if so rather
than showing the raw URL.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

The old output:

    $ git fetch -v
    From git://git.kernel.org/pub/scm/git/git
     = [up to date]      html       -> origin/html
    ...

Versus the new output:

    $ ./git fetch -v
    From origin
     = [up to date]      html       -> origin/html
    ...

Alternatively, we could do something like
    From origin (git://git.kernel.org/pub/scm/git/git)
but no other command seems to do such a thing. Note that a fetch with a direct
URL rather than a name will still show the URL as before.

Another RFC in this is the behavior of `git ls-remote`- it also shows a URL
when we may have a nice name available, so I can resubmit with that modified as
well if people agree with the change. The difference is porcelain vs plumbing.

-Dan

 builtin/fetch.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f9c41da..01bda5a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -436,8 +436,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
 			if (verbosity >= 0 && !shown_url) {
-				fprintf(stderr, _("From %.*s\n"),
-						url_len, url);
+				if (remote_name)
+					fprintf(stderr, _("From %s\n"),
+							remote_name);
+				else
+					fprintf(stderr, _("From %.*s\n"),
+							url_len, url);
 				shown_url = 1;
 			}
 			if (verbosity >= 0)
-- 
1.7.5
