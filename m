From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] commit: allow --pretty= args to be abbreviated
Date: Tue, 16 May 2006 06:25:41 -0700
Message-ID: <20060516132541.GA1066@soma>
References: <11476199622462-git-send-email-normalperson@yhbt.net> <1147619963765-git-send-email-normalperson@yhbt.net> <7vwtcoyxs2.fsf@assigned-by-dhcp.cox.net> <20060515003405.GA5533@localdomain> <7vac9jhv66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 15:28:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfzYa-0005Do-OM
	for gcvg-git@gmane.org; Tue, 16 May 2006 15:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWEPNZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 09:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWEPNZp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 09:25:45 -0400
Received: from hand.yhbt.net ([66.150.188.102]:1454 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751665AbWEPNZp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 09:25:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B0DCF7DC020;
	Tue, 16 May 2006 06:25:42 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 16 May 2006 06:25:41 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac9jhv66.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20122>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Unlike the original one, this one only does prefix matches, so
> > you can't do --pretty=er anymore :)
> 
> Sounds good.  But then you know how long the unique prefix
> are for each candidate, so wouldn't this rather be redundant, I
> wonder?

I just copied the idea for the 2nd for loop from gitopt, since it makes
maintenance easier when there are lots of possibilities.  We only have 6
(soon 7) to worry about for --pretty= here, so hard coding lengths
probably makes more sense.

> > +
> > +	/* look for abbreviations */
> > +	len = strlen(arg);
> > +	found = -1;
> > +	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
> > +		if (!strncmp(cmt_fmts[i].n, arg, len)) {
> > +			if (found >= 0)
> > +				die("invalid --pretty format: %s", arg);
> > +			found = i;
> > +		}
> > +	}
> > +	if (found >= 0)
> > +		return cmt_fmts[found].v;
> > +	die("invalid --pretty format: %s", arg);
> >  }
> 
> It would probably be better to say "ambiguous" not "invalid" in
> the die() message.

Yes, but only one die() message left now :)

-- 
Eric Wong

>From nobody Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 14 May 2006 17:20:46 -0700
Subject: [PATCH] commit: allow --pretty= args to be abbreviated

Unlike the original one, this one only does prefix matches, so
you can't do --pretty=er anymore :)

This one really works with and without the gitopt changes.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 commit.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

044dff6523c25e173eb7fb1c5d5c8a8e6ada8fdc
diff --git a/commit.c b/commit.c
index 2717dd8..4a26070 100644
--- a/commit.c
+++ b/commit.c
@@ -22,23 +22,33 @@ struct sort_node
 
 const char *commit_type = "commit";
 
+struct cmt_fmt_map {
+	const char *n;
+	size_t cmp_len;
+	enum cmit_fmt v;
+} cmt_fmts[] = {
+	{ "raw",	1,	CMIT_FMT_RAW },
+	{ "medium",	1,	CMIT_FMT_MEDIUM },
+	{ "short",	1,	CMIT_FMT_SHORT },
+	{ "full",	5,	CMIT_FMT_FULL },
+	{ "fuller",	5,	CMIT_FMT_FULLER },
+	{ "oneline",	1,	CMIT_FMT_ONELINE },
+};
+
 enum cmit_fmt get_commit_format(const char *arg)
 {
-	if (!*arg)
+	int i;
+
+	if (!arg || !*arg)
 		return CMIT_FMT_DEFAULT;
-	if (!strcmp(arg, "=raw"))
-		return CMIT_FMT_RAW;
-	if (!strcmp(arg, "=medium"))
-		return CMIT_FMT_MEDIUM;
-	if (!strcmp(arg, "=short"))
-		return CMIT_FMT_SHORT;
-	if (!strcmp(arg, "=full"))
-		return CMIT_FMT_FULL;
-	if (!strcmp(arg, "=fuller"))
-		return CMIT_FMT_FULLER;
-	if (!strcmp(arg, "=oneline"))
-		return CMIT_FMT_ONELINE;
-	die("invalid --pretty format");
+	if (*arg == '=')
+		arg++;
+	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
+		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len))
+			return cmt_fmts[i].v;
+	}
+
+	die("invalid --pretty format: %s", arg);
 }
 
 static struct commit *check_commit(struct object *obj,
-- 
1.3.2.g7d11
