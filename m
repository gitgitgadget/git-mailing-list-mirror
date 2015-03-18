From: Wilhelm Schuermann <wimschuermann@googlemail.com>
Subject: [PATCH/RFC] grep: fix "--quiet" overwriting current output
Date: Wed, 18 Mar 2015 19:00:13 +0100
Message-ID: <1426701613-12533-1-git-send-email-wimschuermann@googlemail.com>
Cc: Wilhelm Schuermann <wimschuermann@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 19:00:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYIGc-0006HB-SF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 19:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbbCRSA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 14:00:26 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34343 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbbCRSAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 14:00:25 -0400
Received: by wggv3 with SMTP id v3so42015444wgg.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=F3X9Van+AD1ICx6wUUdCtjCTAkC6uxfqX1/SFWLzIGk=;
        b=0CiAdhaeTvyGu41VNfeA9SUMQ8R2oDlnfQuCw2Ne2LHpo/dy4MbXFBKTF+f1EAVuBi
         UCpwBCmm9UBI7Ockcvo8tUBcT3tpSZUCKVvFSawcpL2qOhDgJQvvcAKVkLy/hyxQNDxs
         0NV3uq+h+tTfeIUSx7FC00mwqFJfvr5cBqcAcFnSrc9zGfz7lGYX0497b/UnLYh/wwon
         njR5wZs0lC1Q3gllyvmXybKatuUPxLL+wXfbczSnHXKY0cQPPhRk/zac04oO2LxkKVYe
         BAHb61U+durQxn/3YZNhSVoClDZcANgHYUZ9h2u1zU0xm4tFyd+Z1sSSxe9Gzaf+7+lT
         /5bA==
X-Received: by 10.194.176.162 with SMTP id cj2mr79514025wjc.93.1426701624342;
        Wed, 18 Mar 2015 11:00:24 -0700 (PDT)
Received: from localhost (dslb-146-060-121-085.146.060.pools.vodafone-ip.de. [146.60.121.85])
        by mx.google.com with ESMTPSA id pa4sm25465068wjb.11.2015.03.18.11.00.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Mar 2015 11:00:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265744>

When grep is called with the --quiet option, the pager is initialized
despite not being used.  When the pager is "less", anything output by
previous commands and not ended with a newline is overwritten.

$ echo -n aaa; echo bbb
aaabbb
$ echo -n aaa; git grep -q foo; echo bbb
bbb

This can be worked around, for example, by making sure STDOUT is not a
TTY or more directly by setting git's pager to "cat":

$ echo -n aaa; git grep -q foo > /dev/null; echo bbb
aaabbb
$ echo -n aaa; PAGER=cat git grep -q foo; echo bbb
aaabbb

This patch prevents calling the pager in the first place, saving an
unnecessary fork() call.

Signed-off-by: Wilhelm Schuermann <wimschuermann@googlemail.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e77f7cf..fe7b9fd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -885,7 +885,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (!show_in_pager)
+	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
 	if (!use_index && (untracked || cached))
-- 
2.3.3.dirty
