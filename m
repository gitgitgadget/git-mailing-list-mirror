From: Knittl <knittl89@googlemail.com>
Subject: [PATCH] Show branch information in short output of git status
Date: Sun, 2 May 2010 11:13:41 +0200
Message-ID: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 11:14:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VG7-00078f-8e
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab0EBJOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 05:14:08 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:27389 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab0EBJOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:14:03 -0400
Received: by ey-out-2122.google.com with SMTP id d26so88831eyd.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Qg1mOJiw4KcDFN26hkQ0/4Hn4HoiwDZiMhWzLSp5BjA=;
        b=OzsjYiugeJQoYEZeSw5RiWW78BGpQ7pog3u+RsfMG4kPnYNBvwqvwyr3wj5brIzHIo
         d3aZsBvBP0R52Erq3zATAT1ytGXxvw+dYrNzgcE++DXW3vFnouzdrCsOBlolddR4Lfka
         Fx72K783yZA7vXnBPbtpOblqeSM7w/y6DcvSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=iOLgVuIigOg9t2mxm3+iGgOsLbgkXf9AO6k7c1hnobwaYRN6Ih8YNNxD0sJ95E0KPg
         zCLkwidpRT94M1rUNJAxYtGpZLceiTICAvcuVtgqvJ7R/ZryFqv9UFH5ZCNoOylBT5mx
         1kKEYbRM6xG4IAXbI/R0va91inCaU0iN5zYQA=
Received: by 10.213.65.74 with SMTP id h10mr714681ebi.60.1272791641272; Sun, 
	02 May 2010 02:14:01 -0700 (PDT)
Received: by 10.213.2.200 with HTTP; Sun, 2 May 2010 02:13:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146151>

This patch adds a first line in the output of `git status -s`, showing
which branch the user is currently on, and in case of tracking branches
the number of commits on each branch.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 wt-status.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..2e6c56e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "refs.h"

 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -721,9 +722,53 @@ static void wt_shortstatus_untracked(int
null_termination, struct string_list_it
 	}
 }

+static void wt_shortstatus_print_tracking(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *branch_color = color(WT_STATUS_HEADER, s);
+
+	const char *base;
+	const char *branch_name;
+	int num_ours, num_theirs;
+
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
+
+	if(!s->branch) return;
+	branch_name = s->branch;
+
+	if (!prefixcmp(branch_name, "refs/heads/"))
+		branch_name += 11;
+	else if (!strcmp(branch_name, "HEAD")) {
+		branch_color = color(WT_STATUS_NOBRANCH, s);
+	}
+
+	branch = branch_get(s->branch + 11);
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
+
+		if(s->is_initial) {
+			color_fprintf(s->fp,
+				color(WT_STATUS_HEADER, s),
+				"Initial commit ... ");
+		}
+		color_fprintf_ln(s->fp, branch_color,
+			"%s", branch_name);
+		return;
+	}
+
+	base = branch->merge[0]->dst;
+	base = shorten_unambiguous_ref(base, 0);
+	color_fprintf_ln(s->fp, branch_color,
+			"%s (%d) ... %s (%d)",
+			branch_name, num_ours,
+			base, num_theirs);
+}
+
 void wt_shortstatus_print(struct wt_status *s, int null_termination)
 {
 	int i;
+
+	wt_shortstatus_print_tracking(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
-- 
1.7.1.rc2.6.g1015.dirty


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
