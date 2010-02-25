From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Add `[decorate]' configuration section.
Date: Fri, 26 Feb 2010 11:44:11 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002261131190.19126@vqena.qenxr.bet.am>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz> <7vr5ojwy38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkmZ7-00047Y-FJ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 23:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934342Ab0BYWwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 17:52:12 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:53185 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934287Ab0BYWwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 17:52:11 -0500
Received: from idran.drake.org.nz (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 9F1D31709BB;
	Fri, 26 Feb 2010 11:52:08 +1300 (NZDT)
In-Reply-To: <7vr5ojwy38.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141076>

Sorry for taking so  long to reply to your email, got destracted.
 
On Wed, 17 Feb 2010, Junio C Hamano wrote:
> Steven Drake <sdrake@xnet.co.nz> writes:
> 
> > This can be used to enable the display of ref names of commits that are
> > shown by log commands.  Each of the log commands (whatchanged, show,
> > reflog, and log) can be enable separately.
> >
> > e.g:
> > 	[decorate]
> > 		log
> > 		reflog
> 
> What is the reason to set these configuration differently except "because
> we can"? 

Basicly yes, but I did this when I was looking at what you said in a reply
about the "log.decorate" changes, I.E.

  On Tue, 16 Feb 2010, Junio C Hamano wrote:
  > I was not worried about what your change does.  I am worried about
  > protecting what the code after your change currently does from future
  > changes done by other people while you are not actively watching the
  > patches in flight on this list.

But that can easly be with the patch below.

> Also, if it is a good idea to allow setting them independently,
> you would need to make it easier for people who want to set them all to
> the same value, e.g. "[decorate] logfamily = short" or something.

Good Idea!

> I somehow find the older "log.decorate" much more natural and the changes
> from it to this version not worth it, but maybe it is just me.

I agree with you, I just thought having a single "[decorate]" section in the
config file was cleaner.  But nomater which way around it was done someone
would want t done the other way around.

--- >8 ---
Subject: [PATCH 1/1] log.decorate: future proofing against builtin-log.c changes

Instead of directly setting 'decoration_style' in git_log_config() we set
an intermediate variable, then for each of the commands we want
'log.decorate' to have an affect 'decoration_style' is set from the
intermediate.

This is to protect against future change to cmd_log_init() and how it is
used or the commands 'log.decorate' affects.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 builtin-log.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 0afba31..91712e6 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -24,7 +24,7 @@
 static const char *default_date_mode = NULL;
 
 static int default_show_root = 1;
-static int decoration_style;
+static int default_decoration_style, decoration_style;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -269,9 +269,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
-		decoration_style = parse_decoration_style(var, value);
-		if (decoration_style < 0)
-			decoration_style = 0; /* maybe warn? */
+		default_decoration_style = parse_decoration_style(var, value);
+		if (default_decoration_style < 0)
+			default_decoration_style = 0; /* maybe warn? */
 		return 0;
 	}
 	if (!strcmp(var, "log.showroot")) {
@@ -286,6 +286,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config, NULL);
+	decoration_style = default_decoration_style;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -353,6 +354,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	int i, count, ret = 0;
 
 	git_config(git_log_config, NULL);
+	decoration_style = default_decoration_style;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -429,6 +431,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config, NULL);
+	decoration_style = default_decoration_style;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
@@ -462,6 +465,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config, NULL);
+	decoration_style = default_decoration_style;
 
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
-- 
1.6.6
