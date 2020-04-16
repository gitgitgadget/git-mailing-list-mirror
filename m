Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E21C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 13:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B3220771
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 13:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895119AbgDPNTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:19:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895029AbgDPNTd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 09:19:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id u13so4814900wrp.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=RFP4BwmmbFq1gSM2Rh4VGMYnaxVCGqtAof6JXBv4fwk=;
        b=pj7a8PbxZRAq98NCju70dg3tEe+w0sazZLsVGegwcDsqbZ87QJwBy+WMgTOeJemurX
         TzxV1eZ7Xdc678KO6LTou+DCZHG+GQ+/CtqzS+caPxx2wNMEckE9Zcli4zTWB/nAgZta
         yw1Joj9X3+7QhNkEu2pbw2Nce36DyL+H8wUDZt8vaT68yUTNiyVLk4plRFTNtt90cPMo
         HKfWJQOSZNZ0WrWnh9hpr/m0nsh2edMlXBIXuJ8TtPHR/ka8DEODyiWvEP1/4pNQpBNN
         QxxyT+JphQO9uzwOlggXutkR5gNTT+DMeH3l5Dz0pIFq0dfRKjwNjZeyu7iTBB41CDeq
         P1Uw==
X-Gm-Message-State: AGi0PubyGgrlGmHMC5IAZDYCvTPZ7S2jGF7ltFbDOWqK0OHK08FVfZHZ
        /9eFqxUj7RSvE5+OPRP3y1zPNCTS
X-Google-Smtp-Source: APiQypKHA9Pm/J0ttcF5MZaKjdubb2pqQPeNSl2DjSa8RIo0nbDU1ukf6Wj2aPr/NjK9yAlU5fhNpA==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr33243653wre.37.1587043171212;
        Thu, 16 Apr 2020 06:19:31 -0700 (PDT)
Received: from rhea.home.vuxu.org (ipservice-092-217-012-230.092.217.pools.vodafone-ip.de. [92.217.12.230])
        by smtp.gmail.com with ESMTPSA id t16sm3570434wmi.27.2020.04.16.06.19.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 06:19:30 -0700 (PDT)
Received: from localhost (rhea.home.vuxu.org [local])
        by rhea.home.vuxu.org (OpenSMTPD) with ESMTPA id 302c7871
        for <git@vger.kernel.org>;
        Thu, 16 Apr 2020 13:19:23 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     git@vger.kernel.org
Subject: [RFC PATCH] sequencer: do_commit: print the change summary ala git-am
Date:   Thu, 16 Apr 2020 14:39:31 +0200
Message-ID: <87mu7blg9w.fsf@vuxu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This makes the output of "git pull --rebase" look as if using the
apply backend.

Signed-off-by: Leah Neukirchen <leah@vuxu.org>
---
I noticed that the new "merge" rebase backend does not print lines ala
"Applying: reticulate the splines" anymore.  I found these useful when
using "git pull --rebase", as one easily saw which unpushed patches
were in the tree.  (Also, eliminated patches were not printed anymore,
but that is a special thing about our workflow, where many committers
can do exactly the same trivial patches often.)

I found do_commit to be the best place to put this, but I'm not
super familiar with the Git code base; perhaps this also prints
in other invocations where it rather shouldn't.

linelen is taken from builtin/am.c.

 sequencer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 6fd2674632..5e315eda1c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1442,6 +1442,14 @@ static int write_rebase_head(struct object_id *oid)
 	return 0;
 }
 
+/**
+ * Returns the length of the first line of msg.
+ */
+static int linelen(const char *msg)
+{
+        return strchrnul(msg, '\n') - msg;
+}
+
 static int do_commit(struct repository *r,
 		     const char *msg_file, const char *author,
 		     struct replay_opts *opts, unsigned int flags,
@@ -1458,6 +1466,10 @@ static int do_commit(struct repository *r,
 					     "from '%s'"),
 					   msg_file);
 
+		if (!opts->quiet)
+			fprintf_ln(stdout, _("Applying: %.*s"),
+				linelen(sb.buf), sb.buf);
+
 		res = try_to_commit(r, msg_file ? &sb : NULL,
 				    author, opts, flags, &oid);
 		strbuf_release(&sb);
-- 
2.26.1
