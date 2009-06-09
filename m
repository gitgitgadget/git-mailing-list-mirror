From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] show-branch: fix segfault when showbranch.default exists
Date: Mon, 08 Jun 2009 23:26:44 -0700
Message-ID: <7vfxe9udln.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 08:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDunO-0005I8-7d
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 08:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZFIG0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 02:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZFIG0n
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 02:26:43 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64669 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbZFIG0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 02:26:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609062644.OZEO18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jun 2009 02:26:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1iSk1c0044aMwMQ04iSkND; Tue, 09 Jun 2009 02:26:44 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=peqd20d9aYoA:10 a=K3128E0kj6wA:10
 a=ybZZDoGAAAAA:8 a=3HqTN-wNYG9LWAGDqkcA:9 a=DN2aKf4sicsS5yREyzMA:7
 a=fZCZQK-bNrfNWIrM2X4l6p90KEoA:4 a=qIVjreYYsbEA:10 a=Nj9nSCg5LJp6YWzr:21
 a=OQNFo6sxkL0u_7-0:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121142>

When running "git show-branch" without any parameter in a repository that
has showbranch.default defined, we used to rely on the fact that our
handcrafted option parsing loop never looked at av[0].

The array of default strings had the first real command line argument in
default_arg[0], but the option parser wanted to look at the array starting
at av[1], so we assigned the address of -1th element to av to force the
loop start working from default_arg[0].

This no longer worked since 5734365 (show-branch: migrate to parse-options
API, 2009-05-21), as parse_options_start() saved the incoming &av[0] in
its ctx->out and later in parse_options_end() it did memmove to ctx->out
(with ctx->cpidx == 0), overwriting the memory before default_arg[] array.

I am not sure if this is a bug in parse_options(), or a bug in the caller,
and tonight I do not have enough concentration to figure out which.  In
any case, this patch works the issue around.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-show-branch.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 01bea3b..baec9ed 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -565,7 +565,15 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "showbranch.default")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (default_alloc <= default_num + 1) {
+		/*
+		 * default_arg is now passed to parse_options(), so we need to
+		 * mimick the real argv a bit better.
+		 */
+		if (!default_num) {
+			default_alloc = 20;
+			default_arg = xcalloc(default_alloc, sizeof(*default_arg));
+			default_arg[default_num++] = "show-branch";
+		} else if (default_alloc <= default_num + 1) {
 			default_alloc = default_alloc * 3 / 2 + 20;
 			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
 		}
@@ -692,8 +700,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
-		ac = default_num + 1;
-		av = default_arg - 1; /* ick; we would not address av[0] */
+		ac = default_num;
+		av = default_arg;
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
