From: Jeff King <peff@peff.net>
Subject: Re: long fsck time
Date: Wed, 2 Nov 2011 17:33:32 -0400
Message-ID: <20111102213332.GA14108@sigill.intra.peff.net>
References: <CACsJy8D04Hw0_OoV01g2xtNK2d6fmZD_+YNEOR3A8aMUTpG5Lw@mail.gmail.com>
 <CACsJy8B=5mEWoOBkrTfmJ+p7HxqJM97zdG-k71oW81-3XxuO_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:33:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLiRJ-00071b-2T
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 22:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab1KBVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 17:33:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60422
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab1KBVdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 17:33:35 -0400
Received: (qmail 16556 invoked by uid 107); 2 Nov 2011 21:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 17:39:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 17:33:32 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B=5mEWoOBkrTfmJ+p7HxqJM97zdG-k71oW81-3XxuO_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184672>

On Wed, Nov 02, 2011 at 07:10:26PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Nov 2, 2011 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > On git.git
> >
> > $ /usr/bin/time git fsck
> > 333.25user 4.28system 5:37.59elapsed 99%CPU (0avgtext+0avgdata
> > 420080maxresident)k
> > 0inputs+0outputs (0major+726560minor)pagefaults 0swaps
> >
> > That's really long time, perhaps we should print progress so users
> > know it's still running?
> 
> Ahh.. --verbose. Sorry for the noise. Still good to show the number of
> checked objects though.

fsck --verbose is _really_ verbose. It could probably stand to have some
progress meters sprinkled throughout. The patch below produces this on
my git.git repo:

  $ git fsck
  Checking object directories: 100% (256/256), done.
  Verifying packs: 100% (7/7), done.
  Checking objects (pack 1/7): 100% (241/241), done.
  Checking objects (pack 2/7): 100% (176/176), done.
  Checking objects (pack 3/7): 100% (312/312), done.
  Checking objects (pack 4/7): 100% (252/252), done.
  Checking objects (pack 5/7): 100% (353/353), done.
  Checking objects (pack 6/7): 100% (375/375), done.
  Checking objects (pack 7/7): 100% (171079/171079), done.

which gives reasonably smooth progress. The longest hang is that
"Verifying pack" 7 is slow (I believe it's doing a sha1 over the whole
thing). If you really wanted to get fancy, you could probably do a
throughput meter as we sha1 the whole contents.

Patch is below. It would need --{no-,}progress support on the command
line, and to check isatty(2) before it would be acceptable.

---
diff --git a/builtin/fsck.c b/builtin/fsck.c
index df1a88b..481de4e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -11,6 +11,7 @@
 #include "fsck.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "progress.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -512,15 +513,19 @@ static void get_default_heads(void)
 static void fsck_object_dir(const char *path)
 {
 	int i;
+	struct progress *progress;
 
 	if (verbose)
 		fprintf(stderr, "Checking object directory\n");
 
+	progress = start_progress("Checking object directories", 256);
 	for (i = 0; i < 256; i++) {
 		static char dir[4096];
 		sprintf(dir, "%s/%02x", path, i);
 		fsck_dir(i, dir);
+		display_progress(progress, i+1);
 	}
+	stop_progress(&progress);
 	fsck_sha1_list();
 }
 
@@ -622,19 +627,36 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (check_full) {
 		struct packed_git *p;
+		int i, nr_packs = 0;
+		struct progress *progress;
 
 		prepare_packed_git();
 		for (p = packed_git; p; p = p->next)
+			nr_packs++;
+
+		progress = start_progress("Verifying packs", nr_packs);
+		for (i = 1, p = packed_git; p; p = p->next, i++) {
 			/* verify gives error messages itself */
 			verify_pack(p);
+			display_progress(progress, i);
+		}
+		stop_progress(&progress);
 
-		for (p = packed_git; p; p = p->next) {
+		for (i = 1, p = packed_git; p; p = p->next, i++) {
+			char buf[32];
 			uint32_t j, num;
 			if (open_pack_index(p))
 				continue;
 			num = p->num_objects;
-			for (j = 0; j < num; j++)
+
+			snprintf(buf, sizeof(buf), "Checking objects (pack %d/%d)",
+				 i, nr_packs);
+			progress = start_progress(buf, num);
+			for (j = 0; j < num; j++) {
 				fsck_sha1(nth_packed_object_sha1(p, j));
+				display_progress(progress, j+1);
+			}
+			stop_progress(&progress);
 		}
 	}
 
