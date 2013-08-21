From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] reject duplicates when indexing a packfile we created
Date: Wed, 21 Aug 2013 16:53:32 -0400
Message-ID: <20130821205332.GC28165@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 22:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFPP-0002yZ-5W
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab3HUUxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:53:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:49734 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab3HUUxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:53:34 -0400
Received: (qmail 11695 invoked by uid 102); 21 Aug 2013 20:53:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 15:53:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 16:53:32 -0400
Content-Disposition: inline
In-Reply-To: <20130821204955.GA28025@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232734>

The pack index-writing code is capable of detecting and
rejecting duplicate entries. This can be used with
index-pack to prevent buggy foreign packs from entering the
repository.  However, we can also be careful about the packs
we generate, by double-checking during the index write that
we do not have any duplicate objects. This should never
happen, but it serves as an additional check that we are not
generating such packfiles.

Signed-off-by: Jeff King <peff@peff.net>
---
This turns on rejection for everywhere _except_ a separately-run
index-pack. If we decide to turn it on there, too, it would make sense
to scrap this patch and just put it in reset_pack_idx_opts().

 builtin/pack-objects.c | 1 +
 bulk-checkin.c         | 1 +
 fast-import.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..8da2a66 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2511,6 +2511,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	reset_pack_idx_option(&pack_idx_opts);
+	pack_idx_opts.duplicates = WRITE_IDX_DUPLICATES_REJECT;
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6b0b6d4..bad191f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -174,6 +174,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
 
 	state->f = create_tmp_packfile(&state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
+	state->pack_idx_opts.duplicates = WRITE_IDX_DUPLICATES_REJECT;
 
 	/* Pretend we are going to write only one object */
 	state->offset = write_pack_header(state->f, 1);
diff --git a/fast-import.c b/fast-import.c
index 23f625f..b7beab0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3360,6 +3360,7 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 	reset_pack_idx_option(&pack_idx_opts);
+	pack_idx_opts.duplicates = WRITE_IDX_DUPLICATES_REJECT;
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
-- 
1.8.4.rc2.28.g6bb5f3f
