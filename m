From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 19:05:27 -0700
Message-ID: <20150725020526.GA8948@peff.net>
References: <20150723012343.GA21000@peff.net>
 <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
 <20150724072325.GC2111@peff.net>
 <xmqq8ua5oapm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 04:05:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIoqF-0002Y9-SH
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 04:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbbGYCFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 22:05:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:34777 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbbGYCFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 22:05:30 -0400
Received: (qmail 17120 invoked by uid 102); 25 Jul 2015 02:05:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 21:05:30 -0500
Received: (qmail 24507 invoked by uid 107); 25 Jul 2015 02:05:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 22:05:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 19:05:27 -0700
Content-Disposition: inline
In-Reply-To: <xmqq8ua5oapm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274609>

On Fri, Jul 24, 2015 at 08:07:49AM -0700, Junio C Hamano wrote:

> > I am not entirely convinced this won't bite somebody who gets a sha1
> > from some other source, and then wants to run:
> >
> >   git log $some_other_sha1
> >
> > who might be quite confused to start a first-parent traversal from
> > somewhere other than the tip of "master" or the tip of a topic branch.
> 
> Yeah, you actually convinced me reasonably well that it would
> happen.  I'd never use it myself.  If people want to shoot
> themselves in the foot, be my guest ;-)
> 
> Perhaps we should drop this, and give a shorter synonym to the
> option?

I'm still on the fence to have the config kick in only for HEAD.
Something like (on top of my other patch, and the tests would still need
adjusted):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e9c3763..f2b6a21 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1802,9 +1802,11 @@ log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`.
 
-log.firstparent::
-	If true, linkgit:git-log[1] will default to `--first-parent`;
-	can be overridden by supplying `--no-first-parent`.
+log.defaultImpliesFirstParent::
+	If true, linkgit:git-log[1] will default to `--first-parent`
+	when showing the default ref (i.e., if you run only `git
+	log` to show `HEAD`, but not `git log $sha1`). Can be overridden
+	by supplying `--no-first-parent`.
 
 mailinfo.scissors::
 	If true, makes linkgit:git-mailinfo[1] (and therefore
diff --git a/builtin/log.c b/builtin/log.c
index 3e9b034..2bdb3fc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,7 +31,7 @@ static const char *default_date_mode = NULL;
 
 static int default_abbrev_commit;
 static int default_show_root = 1;
-static int default_first_parent;
+static int default_implies_first_parent;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -110,7 +110,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
-	rev->first_parent_only = default_first_parent;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
@@ -398,8 +397,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		use_mailmap_config = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "log.firstparent")) {
-		default_first_parent = git_config_bool(var, value);
+	if (!strcmp(var, "log.defaultimpliesfirstparent")) {
+		default_implies_first_parent = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -504,6 +503,8 @@ static int show_tree_object(const unsigned char *sha1,
 
 static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
+	if (default_implies_first_parent && !rev->pending.nr)
+		rev->first_parent_only = 1;
 	if (rev->ignore_merges) {
 		/* There was no "-m" on the command line */
 		rev->ignore_merges = 0;


It feels somewhat magical, but at least the config option name makes it
painfully clear exactly when it would kick in. I dunno. I am happy
enough for myself to just run "--first-parent" when that is what I want
to see. Giving it a shorter name would not help much, I think. It is not
the number of characters, but the fact that most people do not _know_
that --first-parent exists in the first place, or that it would be
useful in this case. I hoped with a config option it might become
something projects could recommend to their users[1] if the project has a
matching workflow. But maybe we could also rely on those same projects
to educate their users.

-Peff

[1] And if not an official recommendation from a project, this is the
    sort of "tips and tricks" information that may spread informally. But in
    theory so could knowledge of --first-parent.
