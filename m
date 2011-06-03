From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv5 1/4] Fix prefix handling in ref iteration functions
Date: Fri,  3 Jun 2011 14:29:50 -0700
Message-ID: <1307136593-16306-2-git-send-email-jamey@minilop.net>
References: <1307136593-16306-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSbxa-0007U0-Jr
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 23:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756352Ab1FCVa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 17:30:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54011 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab1FCVaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 17:30:55 -0400
Received: by pvg12 with SMTP id 12so1053054pvg.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:30:55 -0700 (PDT)
Received: by 10.68.47.33 with SMTP id a1mr996487pbn.436.1307136655275;
        Fri, 03 Jun 2011 14:30:55 -0700 (PDT)
Received: from oh.minilop.net (host-246-52.pubnet.pdx.edu [131.252.246.52])
        by mx.google.com with ESMTPS id o2sm1732969pbj.33.2011.06.03.14.30.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 14:30:53 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QSbxE-0004IY-O4; Fri, 03 Jun 2011 14:30:52 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307136593-16306-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175027>

From: Josh Triplett <josh@joshtriplett.org>

The do_for_each_ref iteration function accepts a prefix and a trim, and
checks for the prefix on each ref before passing in that ref; it also
supports trimming off part of the ref before passing it.  Several
callers passed a prefix of "refs/" to filter out everything outside of
refs/, but a trim of 0 to avoid trimming off the "refs/".  However,
do_for_each_ref used trim as the length of the prefix to check, so it
ignored the "refs/" prefix entirely.  Switch to using prefixcmp,
checking the entire length of the prefix string, to properly support a
trim value different than the length of the prefix.

This fixes a bug where the ref iteration functions did not properly
ignore refs outside of "refs/".  The loose ref functions can never
supply such refs, and packed-refs would not normally include such refs,
but nothing prevents a packed-refs file from including refs outside of
"refs/".  (Confirmed by manually editing a packed-refs file.)

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index e3c0511..003680f 100644
--- a/refs.c
+++ b/refs.c
@@ -584,7 +584,7 @@ int read_ref(const char *ref, unsigned char *sha1)
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_list *entry)
 {
-	if (strncmp(base, entry->name, trim))
+	if (prefixcmp(entry->name, base))
 		return 0;
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
-- 
1.7.5.3
