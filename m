From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] wt-status: split off a function for printing submodule
 summary
Date: Sat, 24 Jul 2010 19:57:47 -0500
Message-ID: <20100725005747.GB18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 02:58:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpYN-0007fL-2j
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 02:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab0GYA6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 20:58:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38910 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab0GYA6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 20:58:49 -0400
Received: by iwn7 with SMTP id 7so1572370iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=miqIGY2EMlR7CHfootgMi6akEeJivU/YHkhnKml7XnY=;
        b=vmYnKqjeRof/xwoMWFr3AXCNw3DYVF9IGRuYP1Xl7vvalRIBZofdULGnrQzw3o/nQQ
         KoRqJd6tYkVdgrVjYBRd8D8wD+Af8Hiq4PggTsXn0y4BmalkTGo03EHg7Rc1tLXyOy1D
         X0Q1j0GAnd0q8ztGBnTEod4dCRxObUTj3fv2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MRyC9OsqxRf7D/RuiGRflfA8NEDMeu9w7JiR1v6G9F9R0Yk5kZZ8Qan1nqdYMkGmS1
         UnNo9DfbHianyky2BPQ65rykL6y39OLvhN47vVVF2/60wbmG149O9LVQmT0Ll3ijYoEk
         1eCbTTgwqVeQuYFMR6gOA80s6xuGFK5sFxAqA=
Received: by 10.231.40.9 with SMTP id i9mr3322389ibe.5.1280019529159;
        Sat, 24 Jul 2010 17:58:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm1910508ibk.21.2010.07.24.17.58.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 17:58:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151694>

This only shaves a couple lines from wt_status_print().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 wt-status.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b0f17cf..90a0824 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -522,7 +522,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	wt_status_print_trailer(s);
 }
 
-static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
+static void do_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary;
 	char summary_limit[64];
@@ -553,6 +553,14 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	run_command(&sm_summary);
 }
 
+static void wt_status_print_submodule_summary(struct wt_status *s)
+{
+	if (s->ignore_submodule_arg && !strcmp(s->ignore_submodule_arg, "all"))
+		return;
+	do_submodule_summary(s, 0);  /* staged */
+	do_submodule_summary(s, 1);  /* unstaged */
+}
+
 static void wt_status_print_other(struct wt_status *s,
 				  struct string_list *l,
 				  const char *what,
@@ -680,12 +688,8 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_updated(s);
 	wt_status_print_unmerged(s);
 	wt_status_print_changed(s);
-	if (s->submodule_summary &&
-	    (!s->ignore_submodule_arg ||
-	     strcmp(s->ignore_submodule_arg, "all"))) {
-		wt_status_print_submodule_summary(s, 0);  /* staged */
-		wt_status_print_submodule_summary(s, 1);  /* unstaged */
-	}
+	if (s->submodule_summary)
+		wt_status_print_submodule_summary(s);
 	if (s->show_untracked_files) {
 		wt_status_print_other(s, &s->untracked, "Untracked", "add");
 		if (s->show_ignored_files)
-- 
1.7.2.9.ge3789.dirty
