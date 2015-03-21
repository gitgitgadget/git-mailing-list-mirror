From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/15] builtin/unpack-file: fix a memleak
Date: Fri, 20 Mar 2015 17:28:10 -0700
Message-ID: <1426897692-18322-14-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HN-0001p5-RD
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbbCUA2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:35 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34977 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbbCUA2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:32 -0400
Received: by igcau2 with SMTP id au2so1636383igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=csnWS7djinDTbsbkTg9jBzdvAsmqcFidg9qe/StmBkU=;
        b=l5OBt3/rd7vtkT6koOMY8fg06SR9LITzedKf0lbxzydHPABLGQ/X1oqRIwAZGVun5m
         XB5YHhnJlghv/BSu3g25YC1z094rkn/MMNzAGveaNGEili12pmLrrc4L7Xbpjgr3RU6o
         TVDj7BEhTBdIOTUyvmHDVimDRi+jhVKTLKzifmAVon/Bh1M9DGUvu/dkkh5Z738p/Vi4
         t+WK0BxAOV3Tkc8tXswqGMhTJ7SFA6oOLqf5Y9LEcGIgjzjDdduL7COmajga07u0fGQZ
         ewmq2LW2kcc/uNtKTId+xBC57dzooNuU54/epaLGic3xCyHIkJqvC2OGLDXBWpeqLc+m
         w7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=csnWS7djinDTbsbkTg9jBzdvAsmqcFidg9qe/StmBkU=;
        b=GyCzxVerFvxj2WbgZwdhBMl1tF8NZcnzA4qsz8mOj30Um4L+/aQ3x9zcljX93Sm4P1
         AjxV2iPUDyUOYqfUsdn5e+O8O7pmqeHMOEeMg1QsN9VxbbF4e2p0Rl5vQ9XpNJ2v9wmP
         HwZZ7t+VeMovJjvmjjz8F8ZsJPoqXJfPXFIgaEoKAn3oh1FC9nmOWidNSwAxY0hb+2TY
         ueNzhgI6q42wgN2gOwE+yY/g4kQoNRRsZqrofOLNiPwLPEtPPR2MUObR1PKFrSACrG9t
         c/4yVO5APl7iAqafIOlZY37Gg0kGeCBZ6Fi4j00gVLDcBPLRCZ/i34m/qXJ2z7zB8X3z
         CeAg==
X-Gm-Message-State: ALoCoQn/L8c2/kEPjHOqNBqDKA2O7pqYcTmvJmID4zSID67jLB8w0y55YlFLukTFqiZKVXCOnTXF
X-Received: by 10.50.107.7 with SMTP id gy7mr429227igb.49.1426897711730;
        Fri, 20 Mar 2015 17:28:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id b17sm4229813iob.31.2015.03.20.17.28.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:31 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265989>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This is for discussion again,
    see 2nd previous patch.
    
    However why do we close the fd when we know
    the program ends soon? So let's also
    free the memory.

 builtin/unpack-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 1920029..ea5767e 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -17,6 +17,7 @@ static char *create_temp_file(unsigned char *sha1)
 	if (write_in_full(fd, buf, size) != size)
 		die_errno("unable to write temp-file");
 	close(fd);
+	free(buf);
 	return path;
 }
 
-- 
2.3.0.81.gc37f363
