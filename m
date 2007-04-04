From: Jeff King <peff@peff.net>
Subject: [PATCH] wt-status: show author info if status.showauthor is set
Date: Wed, 4 Apr 2007 02:24:48 -0400
Message-ID: <20070404062447.GA4136@coredump.intra.peff.net>
References: <20070322104021.GJ29341@mellanox.co.il> <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net> <20070404060213.GB31984@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYyvP-0003nl-PN
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992698AbXDDGYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992697AbXDDGYw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:24:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1795 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992698AbXDDGYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:24:51 -0400
Received: (qmail 12653 invoked from network); 4 Apr 2007 06:25:24 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Apr 2007 06:25:24 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2007 02:24:48 -0400
Content-Disposition: inline
In-Reply-To: <20070404060213.GB31984@mellanox.co.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43713>


Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Apr 04, 2007 at 09:02:13AM +0300, Michael S. Tsirkin wrote:

> - Maybe put Author: (or From:? and maybe Subject:?) line in the pre-formatted
>   commit message, and let the user edit them?

Personally I think it's just clutter, but hey, it's off by default. Of
course what is the chance that you've turned on status.showauthor in
your ~/.gitconfig, but you don't have your identity set up properly? :)

Junio, this is somewhat tongue in cheek, but if people like it, please
take it.

 Documentation/config.txt |    5 +++++
 wt-status.c              |   10 ++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cf1e040..189e703 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -537,6 +537,11 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+status.showauthor::
+	If set to true, the output of git-status and the template used
+	for git-commit will show the author's name and email address.
+	Defaults to false.
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
diff --git a/wt-status.c b/wt-status.c
index a055990..3c3510c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "diffcore.h"
 
+int wt_status_show_author = 0;
 int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
@@ -317,6 +318,11 @@ void wt_status_print(struct wt_status *s)
 			"# %s%s", on_what, branch_name);
 	}
 
+	if (wt_status_show_author)
+		color_printf_ln(color(WT_STATUS_HEADER),
+				"# author: %s",
+				git_author_info(0));
+
 	if (s->is_initial) {
 		color_printf_ln(color(WT_STATUS_HEADER), "#");
 		color_printf_ln(color(WT_STATUS_HEADER), "# Initial commit");
@@ -356,5 +362,9 @@ int git_status_config(const char *k, const char *v)
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
+	if (!strcmp(k, "status.showauthor")) {
+		wt_status_show_author = 1;
+		return 0;
+	}
 	return git_default_config(k, v);
 }
-- 
1.5.1.rc3.671.gd125-dirty
