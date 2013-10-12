From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/10] transport-helper: updates
Date: Sat, 12 Oct 2013 02:05:23 -0500
Message-ID: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMa-0004MJ-QU
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab3JLHLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49923 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab3JLHLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:34 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm4so3414609obc.19
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wYZ9w/x5gjnnACXhqv3pWkwR40vvEtj4oK4qidnGkfU=;
        b=01IOhDR9EGK4q/VF88/uvjCaWoH6oXXSj0/K0exaudcLErbpnpcAStAJLLFr4I0DNT
         E7gBl6gDr9CMGXVpbmGYiXCqBdEXU9wxYDjykeWZFFLKsGA02FwJ12BPNfuRJq3o5t9z
         pjUbeonMAPyFA0PegXtqc/IFEtPhUbagioc5g0xCEMPsVXA4jc8C094rk1BGGb24qJnC
         FrHj+9lSFDDRxWINAl9FVySHFuv3ZMXPY7hnNR/Xu0qq733o9UrcXzQJFzOXIBBi3ljR
         JzOkY/Mt9DLKUqORhZ3HIGPZhuNg9jK9agg4d84Jo6tzzGsi1MeqWLKC/mCFFjz1j964
         ni8A==
X-Received: by 10.182.44.167 with SMTP id f7mr17780135obm.3.1381561894181;
        Sat, 12 Oct 2013 00:11:34 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm28657149obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235970>

Hi,

Here are the patches that allow transport helpers to be completely transparent;
renaming branches, deleting them, custom refspecs, --force, --dry-run,
reporting forced update, everything works.

Some of these were were sent before and rejected without a reason, but here
they are again in case anybody is interested.

Diff from v2:

--- a/transport-helper.c
+++ b/transport-helper.c
@@ -821,8 +821,10 @@ static int push_refs_with_export(struct transport *transport,
                        die("helper %s does not support dry-run", data->name);
        }
 
-       if (flags & TRANSPORT_PUSH_FORCE)
-               set_helper_option(transport, "force", "true");
+       if (flags & TRANSPORT_PUSH_FORCE) {
+               if (set_helper_option(transport, "force", "true") != 0)
+                       die("helper %s does not support 'force'", data->name);
+       }
 
        helper = get_helper(transport);
 

Felipe Contreras (10):
  transport-helper: add 'force' to 'export' helpers
  transport-helper: fix extra lines
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches
  transport-helper: don't update refs in dry-run

 Documentation/git-fast-export.txt |  4 ++++
 Documentation/git-fast-import.txt |  3 +++
 builtin/fast-export.c             | 47 ++++++++++++++++++++++++++++++++++++++-
 fast-import.c                     | 13 ++++++++---
 t/t5801-remote-helpers.sh         | 10 ++++++++-
 t/t9300-fast-import.sh            | 18 +++++++++++++++
 t/t9350-fast-export.sh            | 18 +++++++++++++++
 transport-helper.c                | 44 ++++++++++++++++++++++++++----------
 8 files changed, 140 insertions(+), 17 deletions(-)

-- 
1.8.4-fc
