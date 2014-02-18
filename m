From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: [PATCH] revert.c: Allow to specify -x via git-config
Date: Tue, 18 Feb 2014 07:56:20 +0100
Message-ID: <20140218065620.GA3448@bogon.m.sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 08:05:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFejm-0002sa-4S
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 08:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbaBRHE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 02:04:58 -0500
Received: from xvm-169-183.ghst.net ([95.142.169.183]:41139 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaBRHE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 02:04:57 -0500
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2014 02:04:57 EST
Received: from honk.sigxcpu.org (localhost [IPv6:::1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id 33D42695
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 07:56:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id B899AFB03
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 07:56:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yiXwSMAKB8TD for <git@vger.kernel.org>;
	Tue, 18 Feb 2014 07:56:26 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id AB32041B74; Tue, 18 Feb 2014 07:56:20 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242275>

Without this when maintaining stable branches it's easy to forget to us=
e
-x to track where a patch was cherry-picked from.

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
---
 Documentation/git-cherry-pick.txt |  8 ++++++++
 builtin/revert.c                  | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cher=
ry-pick.txt
index c205d23..c35064f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -215,6 +215,14 @@ the working tree.
 spending extra time to avoid mistakes based on incorrectly matching
 context lines.
=20
+CONFIGURATION
+-------------
+
+See linkgit:git-config[1] for core variables.
+
+cherrypick.record-origin::
+	Default for the `-x` option. Defaults to `false`.
+
 SEE ALSO
 --------
 linkgit:git-revert[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 87659c9..df9718f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -196,6 +196,15 @@ int cmd_revert(int argc, const char **argv, const =
char *prefix)
 	return res;
 }
=20
+static int git_cherry_pick_config(const char *var, const char *value, =
void *cb)
+{
+	struct replay_opts *opts =3D cb;
+
+	if (!strcmp(var, "cherrypick.record-origin"))
+		opts->record_origin =3D git_config_bool (var, value);
+	return 0;
+}
+
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -204,6 +213,7 @@ int cmd_cherry_pick(int argc, const char **argv, co=
nst char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.action =3D REPLAY_PICK;
 	git_config(git_default_config, NULL);
+	git_config(git_cherry_pick_config, &opts);
 	parse_args(argc, argv, &opts);
 	res =3D sequencer_pick_revisions(&opts);
 	if (res < 0)
--=20
1.9.0.rc3
