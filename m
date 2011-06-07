From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv8 1/4] Fix prefix handling in ref iteration functions
Date: Tue,  7 Jun 2011 16:04:47 -0700
Message-ID: <1307487890-3915-2-git-send-email-jamey@minilop.net>
References: <1307487890-3915-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:06:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5Lz-0006pT-Qo
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab1FGXGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:06:02 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37287 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab1FGXFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:05:49 -0400
Received: by pzk9 with SMTP id 9so2784716pzk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 16:05:48 -0700 (PDT)
Received: by 10.68.51.33 with SMTP id h1mr425785pbo.455.1307487948593;
        Tue, 07 Jun 2011 16:05:48 -0700 (PDT)
Received: from oh.minilop.net (host-247-89.pubnet.pdx.edu [131.252.247.89])
        by mx.google.com with ESMTPS id c3sm457383pbk.93.2011.06.07.16.05.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 16:05:47 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QU5LG-00011y-2b; Tue, 07 Jun 2011 16:05:46 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307487890-3915-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175284>

From: Josh Triplett <josh@joshtriplett.org>

The do_for_each_ref iteration function accepts a prefix and a trim, and
checks for the prefix on each ref before passing in that ref; it also
supports trimming off part of the ref before passing it.  However,
do_for_each_ref used trim as the length of the prefix to check, ignoring
the actual length of the prefix.  Switch to using prefixcmp, checking
the entire length of the prefix string, to properly support a trim value
different than the length of the prefix.

Several callers passed a prefix of "refs/" to filter out everything
outside of refs/, but a trim of 0 to avoid trimming off the "refs/"; the
trim of 0 meant that the filter of "refs/" no longer applied.  Change
these callers to pass an empty prefix instead, to avoid changing the
existing behavior.  Various callers count on this lack of filtering,
such as receive-pack which uses add_extra_ref to add alternates as refs
named ".have"; adding filtering would break that, causing
t5501-fetch-push-alternates.sh to fail.  That lack of filtering doesn't
currently have any other effect, since the loose ref functions can never
supply refs outside of "refs/", and packed-refs will not normally
include such refs unless manually edited.

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 refs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index e3c0511..858cf92 100644
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
@@ -728,12 +728,12 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
+	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, "refs/", fn, 0, 0, cb_data);
+	return do_for_each_ref(submodule, "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -819,7 +819,7 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/", fn, 0,
+	return do_for_each_ref(NULL, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-- 
1.7.5.3
