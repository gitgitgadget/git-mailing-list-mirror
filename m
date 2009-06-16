From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not request sideband
Date: Tue, 16 Jun 2009 20:41:16 +0200
Message-ID: <200906162041.16608.j6t@kdbg.org>
References: <200906142238.51725.j6t@kdbg.org> <7vprd4hito.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0906161354010.16467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 20:41:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGdbM-0004M5-5J
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 20:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761005AbZFPSlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZFPSlS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 14:41:18 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:24230 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbZFPSlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 14:41:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 57F5B10024;
	Tue, 16 Jun 2009 20:41:17 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D451360F9A;
	Tue, 16 Jun 2009 20:41:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0906161354010.16467@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121699>

On Dienstag, 16. Juni 2009, Nicolas Pitre wrote:
> On Mon, 15 Jun 2009, Junio C Hamano wrote:
> > Stated differently, I think "not using sideband _and_ spawned via daemon"
> > would be an indication that "the client won't see the progress anyway
> > even if it were sent."  So the question becomes "will it be a small
> > enough change to detect if the upload-pack is driven by the daemon in the
> > codepath J6t added 'if (!use_sideband)' to, and if so shouldn't we do
> > so?"
>
> I don't think it is worth it at all.  The regression is purely cosmetic,
> and I suspect you'll have a really hard time finding someone still using
> those ancient git clients anyway.  Remember that such clients are unable
> to fetch with HTTP from repositories using version 2 of the pack index
> by default already.  That's why we created version 1.4.4.5.

Keep in mind that there could exist clients outside git.git that use modern
pack-index or unpack-objects, but omit sideband support.

I propose this patch instead, although the assumption that the --timeout
option is only used by git-daemon may not be quite right. In this case it
may be better to add a new option that sets the new flag and that
git-daemon has to use.

-- Hannes

Subject: [PATCH] upload-pack: squelch progress indicator if client cannot see it

upload-pack runs pack-objects, which generates progress indicator output
on its stderr. If the client requests a sideband, this indicator is sent
to the client; but if it did not, then the progress is written to
upload-pack's own stderr.

If upload-pack is itself run from git-daemon (and if the client did not
request a sideband) the progress indicator never reaches the client and it
need not be generated in the first place. With this patch the progress
indicator is suppressed in this situation.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 upload-pack.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index edc7861..841ebb5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -28,7 +28,7 @@ static unsigned long oldest_have;
 
 static int multi_ack, nr_our_refs;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
-static int no_progress;
+static int no_progress, daemon_mode;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -521,6 +521,10 @@ static void receive_needs(void)
 	}
 	if (debug_fd)
 		write_in_full(debug_fd, "#E\n", 3);
+
+	if (!use_sideband && daemon_mode)
+		no_progress = 1;
+
 	if (depth == 0 && shallows.nr == 0)
 		return;
 	if (depth > 0) {
@@ -630,6 +634,7 @@ int main(int argc, char **argv)
 		}
 		if (!prefixcmp(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
+			daemon_mode = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
-- 
1.6.3.17.g1665f
