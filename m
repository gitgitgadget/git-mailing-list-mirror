From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 23:55:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
 <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 25 23:55:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjNne-0002C0-G9
	for gcvg-git@gmane.org; Thu, 25 May 2006 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWEYVzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWEYVzT
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 17:55:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:8385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030459AbWEYVzS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 17:55:18 -0400
Received: (qmail invoked by alias); 25 May 2006 21:55:17 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp027) with SMTP; 25 May 2006 23:55:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20768>

Hi,

On Thu, 25 May 2006, Junio C Hamano wrote:

> "Marco Costalba" <mcostalba@gmail.com> writes:
> 
> > 2) Unhandled ranges list
> >
> > The second one is not so easy.
> 
> This is a real regression;

I was not aware of the possibility to specify several ranges, mostly 
because I did not use it that way.

However, I think it is worth breaking this in that particular case, since 
the range handling has become unified with the framework in revision.[ch]

> As an easy alternative, we could give --start-number=<n> to
> format-patch so that you can do the iteration yourself instead
> of having format-patch to iterate over the list.

Something like this?

---
[PATCH] format-patch: support --start-number=<n> (and --start-number <n>)

This option implicitely sets numbered mode and starts the numbering with <n>.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-log.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index c8feb0f..4e3388b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -148,6 +148,7 @@ int cmd_format_patch(int argc, const cha
 	int nr = 0, total, i, j;
 	int use_stdout = 0;
 	int numbered = 0;
+	int start_number = -1;
 	int keep_subject = 0;
 
 	init_revisions(&rev);
@@ -171,7 +172,14 @@ int cmd_format_patch(int argc, const cha
 		else if (!strcmp(argv[i], "-n") ||
 				!strcmp(argv[i], "--numbered"))
 			numbered = 1;
-		else if (!strcmp(argv[i], "-k") ||
+		else if (!strncmp(argv[i], "--start-number=", 15))
+			start_number = strtol(argv[i] + 15, NULL, 10);
+		else if (!strcmp(argv[i], "--start-number")) {
+			i++;
+			if (i == argc)
+				die("Need a number for --start-number");
+			start_number = strtol(argv[i], NULL, 10);
+		} else if (!strcmp(argv[i], "-k") ||
 				!strcmp(argv[i], "--keep-subject")) {
 			keep_subject = 1;
 			rev.total = -1;
@@ -193,6 +201,11 @@ int cmd_format_patch(int argc, const cha
 	}
 	argc = j;
 
+	if (start_number >= 0)
+		numbered = 1;
+	else if (numbered)
+		start_number = 1;
+
 	if (numbered && keep_subject < 0)
 		die ("-n and -k are mutually exclusive.");
 
@@ -219,11 +232,11 @@ int cmd_format_patch(int argc, const cha
 	}
 	total = nr;
 	if (numbered)
-		rev.total = total;
+		rev.total = total + start_number - 1;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
-		rev.nr = total - nr;
+		rev.nr = rev.total - nr;
 		if (!use_stdout)
 			reopen_stdout(commit, rev.nr, keep_subject);
 		shown = log_tree_commit(&rev, commit);
-- 
1.3.3.gd515
