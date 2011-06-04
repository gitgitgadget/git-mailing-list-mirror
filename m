From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv6 1/4] Fix prefix handling in ref iteration functions
Date: Fri,  3 Jun 2011 17:11:40 -0700
Message-ID: <1307146303-4524-2-git-send-email-jamey@minilop.net>
References: <1307146303-4524-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:12:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeTg-0004ez-Bq
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 02:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab1FDAMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 20:12:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45154 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab1FDAMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 20:12:07 -0400
Received: by pzk9 with SMTP id 9so1013620pzk.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 17:12:06 -0700 (PDT)
Received: by 10.68.4.129 with SMTP id k1mr1000333pbk.72.1307146326602;
        Fri, 03 Jun 2011 17:12:06 -0700 (PDT)
Received: from oh.minilop.net (host-242-103.pubnet.pdx.edu [131.252.242.103])
        by mx.google.com with ESMTPS id o2sm1820342pbj.17.2011.06.03.17.12.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 17:12:05 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QSeTE-0001Bn-RM; Fri, 03 Jun 2011 17:12:04 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307146303-4524-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175049>

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
