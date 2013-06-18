From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 8/8] rebase -i: write better reflog messages
Date: Tue, 18 Jun 2013 17:44:30 +0530
Message-ID: <1371557670-12534-9-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:18:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UourL-0008Sz-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab3FRMRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42500 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab3FRMRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3856140pbb.19
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hTegT99tz+ej1Usc067e+YWAskDnNyzM+/Z0cKa7c5E=;
        b=yvdcXJVemRe24lZmWna1KU6JMWC9qASyxij3dTBCqdo9TPvaU/gOzzPpv5/NrPGPxi
         F6H2UXb3Hgd0HtavlvlWxweHiJ/5BAAU3bBRuLojaabui0dqTH1kRDVTo2BZbFjSnpgU
         xei+svMouD+LI6VkR3eaSPbuZF1XIR5ULXzDT1W4ddLL0py7p+xWsBhHLdyqYxJLMN8d
         oVPAmmUTq81mJSLIoIDD5GRHWqzIRLlea6RT2heFca1F0sAkOV/ICqI3MfraLgOCLsTF
         J9laio35MbvT5DRilYNH9nDBhZ+YqCWvXiauF3PjrgOfv/5QsumgPwDIl9XR3T/07Ojn
         PM/A==
X-Received: by 10.66.221.2 with SMTP id qa2mr1866117pac.188.1371557871481;
        Tue, 18 Jun 2013 05:17:51 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228210>

Now that the "checkout" invoked internally from "rebase -i" knows to
honor GIT_REFLOG_ACTION, we can start to use it to write a better reflog
message when "rebase -i anotherbranch", "rebase -i --onto branch",
etc. internally checks out the new fork point.  We will write:

  rebase -i (start): checkout master

instead of the old

  rebase -i (start)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..5179500 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -326,6 +326,7 @@ pick_one_preserving_merges () {
 		if [ "$1" != "-n" ]
 		then
 			# detach HEAD to current parent
+			GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $first_parent"
 			output git checkout $first_parent 2> /dev/null ||
 				die "Cannot move HEAD to $first_parent"
 		fi
@@ -838,6 +839,7 @@ comment_for_reflog start
 
 if test ! -z "$switch_to"
 then
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
 	output git checkout "$switch_to" -- ||
 		die "Could not checkout $switch_to"
 fi
@@ -981,6 +983,7 @@ has_action "$todo" ||
 
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
-- 
1.8.3.1.456.gb7f4cb6
