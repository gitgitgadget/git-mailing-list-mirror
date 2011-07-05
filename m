From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv9 1/4] Fix prefix handling in ref iteration functions
Date: Tue, 5 Jul 2011 10:54:21 -0700
Message-ID: <7abf27aee944796cdb23cf9703380fe726dbeecb.1309888001.git.josh@joshtriplett.org>
References: <cover.1309888001.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 05 19:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe9pX-0000fw-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 19:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1GERyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 13:54:32 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59896 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1GERyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 13:54:32 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 2968017206D;
	Tue,  5 Jul 2011 19:54:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id t7-nR4osb580; Tue,  5 Jul 2011 19:54:29 +0200 (CEST)
X-Originating-IP: 174.25.139.9
Received: from leaf (174-25-139-9.ptld.qwest.net [174.25.139.9])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8169B172084;
	Tue,  5 Jul 2011 19:54:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cover.1309888001.git.josh@joshtriplett.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176620>

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

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 refs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 3a8789d..8bf8bb6 100644
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
1.7.5.4
