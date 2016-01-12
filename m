From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] Teach 'git pull' to handle --rebase=interactive
Date: Tue, 12 Jan 2016 16:22:11 +0100 (CET)
Message-ID: <5ed91705cc70323dd3f175627acf86a4f594536c.1452612112.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:22:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ0mE-0000R9-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762741AbcALPWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:22:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:61260 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762707AbcALPWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:22:19 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Ld3t6-1Zsml30QLY-00iBdy; Tue, 12 Jan 2016 16:22:13
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452612112.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:emDp1aby4BU94yJuwBIG50NNyATggc1/XrdhVDvxuS82ZuZtzV5
 6CawitrvkUaxwFWmYhWTy1qV+1OLbEn7YmhfMzTGE8xSBLvUruAAWNzxRkBgtBpeNc3dy4/
 QkaacBaW7U9LF+FfVFPxUCe1ZDYsVv5oLgqedu7faq5RaLQF+zRuhTkvA6+l2AtXChoLUYi
 WIcOeZM/I58KGJZcSPILg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+djwB6eyX/8=:PBg9ZECBDJc2iaqEOCOPHY
 3072CqxmSJXp/NzUKH466I/sadrQK3a0akdQz6aaAjpnTFC2lTRjA8njo3/o4sv/719L8Ro1y
 fO+6qoOIM2BrxDXg7Xf9GIMRCsygzfSONX4hTu8TiX618yaUSZ9PIgK5IsnXeaTIQ7OVgyQd0
 K1t7rZX3q4I7QxS4vfOQLlNTr5tZChQmrDF3e0GWVid2Pg7TaQRgVBn+milT2eC1fa+0zqfU9
 yiCvuBA7BjHc5Lufkymz21B2Y3ppDKD5NxUfFprzYPPtjFFedtc6uqvJly7CdtauZ2+4LtBPs
 GQVYXV/bphhQ2Aesw7X3YpTa5z2QgRm2OwU87O5CqXnUprBSetEkQyNPCcViJbFbgRzICNISn
 GryX1l4nC5oKN02iT+tzysuZhNXRYTAb4ofK6dx0VwvFSURnJPmUuAyEp6PmiW4WosOCRGdK+
 kfioaS0GAJvPzawhTliJU9Sf8ColcVXcVo1FZZmzn6NTgsHxrtcCErD9w2rdFPT2MB3imkbGs
 NbM80salbxEAKpqPEZyBM5RGmx6eA+4a3GLfvSi1uoxVebgDn+lqM9KGr1/A9gkJSLFtrr+NM
 B0k29VC0THMvICUmta6M3jtzThproK139oHMjHHvsOILWdi5PD/qMsH1gIFavQ0IvhV7VRXmp
 fBxtYVK5N3NCksBIl/YJ+M3X0tQL4/VLzNQ0phv3MNHeoeR7WCPaRUOP1hVPX+tvMFRhaY2UM
 EVbREi2lN/DBXYh+MgdNkr+EkQXM71hsKtbi5HNL+vc5m/qJnbKysT8kyXVyv2C2/7zoXhOy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283819>

The way builtin pull works, this incidentally also supports the value
'interactive' for the 'branch.<name>.rebase' config variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt   |  1 +
 Documentation/git-pull.txt |  4 +++-
 builtin/pull.c             |  7 ++++++-
 t/t5520-pull.sh            | 10 ++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index beb18da..647b5f0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -865,6 +865,7 @@ branch.<name>.rebase::
 	instead of merging the default branch from the default remote when
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
+	When the value is `interactive`, the rebase is run in interactive mode.
 +
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 93c72a2..a62a2a6 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,7 +101,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve]::
+--rebase[=false|true|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
@@ -113,6 +113,8 @@ to `git rebase` so that locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
+When `interactive`, enable the interactive mode of rebase.
++
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
diff --git a/builtin/pull.c b/builtin/pull.c
index 9e3c738..832d0ad 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -22,7 +22,8 @@ enum rebase_type {
 	REBASE_INVALID = -1,
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
-	REBASE_PRESERVE
+	REBASE_PRESERVE,
+	REBASE_INTERACTIVE
 };
 
 /**
@@ -42,6 +43,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "interactive"))
+		return REBASE_INTERACTIVE;
 
 	if (fatal)
 		die(_("Invalid value for %s: %s"), key, value);
@@ -778,6 +781,8 @@ static int run_rebase(const unsigned char *curr_head,
 	/* Options passed to git-rebase */
 	if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
+	else if (opt_rebase == REBASE_INTERACTIVE)
+		argv_array_push(&args, "--interactive");
 	if (opt_diffstat)
 		argv_array_push(&args, opt_diffstat);
 	argv_array_pushv(&args, opt_strategies.argv);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a0013ee..c952d5e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -326,6 +326,16 @@ test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
+test_expect_success 'pull.rebase=interactive' '
+	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
+	echo I was here >fake.out &&
+	false
+	EOF
+	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
+	test_must_fail git pull --rebase=interactive . copy &&
+	test "I was here" = "$(cat fake.out)"
+'
+
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-- 
2.6.3.windows.1.300.g1c25e49
