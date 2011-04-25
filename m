From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WRONG/PATCH 1/3] revisions: clarify handling of --no-walk and
 --do-walk
Date: Sun, 24 Apr 2011 19:21:24 -0500
Message-ID: <20110425002124.GB31168@elie>
References: <20110421102241.GA16185@elie>
 <20110421103926.GA16260@elie>
 <4DB02B24.4030503@drmicha.warpmail.net>
 <20110421213014.GB18418@elie>
 <4DB40941.5030903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 02:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE9YY-0002ci-Je
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 02:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab1DYAVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 20:21:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63766 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757834Ab1DYAVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 20:21:30 -0400
Received: by iwn34 with SMTP id 34so1521427iwn.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 17:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UXCkP14V0MbkseyBgj1julsqiv6TPiOdfJjQvjkmPHg=;
        b=YMtrglLAJ+tQ2tDp2lbWj12hgwPV2oOQ5MuuT0vpx4ZsxbhDJXBHKMYeON3UbxkZ+f
         ZlkuKEw44TWB2MCEyT7sBdDWFRzpa2FA7cRQ3P7FeTTJ0mVX6HJ7jmJhId3cBkz31Qt7
         SGGIi3ahP7dxHD35Hf6b9oPdNCM7lMtaasXJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xAQe/FvzIDC6opTTq/80EfVoG4ID7022eztOxRyfMxwGTSxdjeWH/qp08ZjM1UYaET
         gFYcR0ntXoI8Zid22/SuzB5VpBjLdoaYq4kBYpFID6Ns35/oEbWHFIbTF+kQCeeHOV5C
         5Ky0g33BmxV7e7giNWKpJBSOYFEA6Is5yINnU=
Received: by 10.42.147.65 with SMTP id m1mr3509307icv.217.1303690889388;
        Sun, 24 Apr 2011 17:21:29 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id d9sm2044652ibb.2.2011.04.24.17.21.26
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Apr 2011 17:21:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DB40941.5030903@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172008>

Michael J Gruber wrote:

> We don't do the systematic approach now. In some situations, some
> commands switch on the walker automatically (I think "show A..B") to
> make things more useful (to most users) but less systematic, even less
> predictable if you don't know these deviations/exceptions. I've
> suggested such a "usefulness exception" myself (don't prune commits by
> path for "show").

Ah.  To be clearer about the present state:

 - cmd_show reimplements much of get_revision, to work around the
   revision walking machinery's lack of callbacks to print tags,
   blobs, and so on.

 - ^A means "--do-walk ^A", and A..B means "--do-walk ^A B".  This
   holds in rev-list, log, show, etc --- they all share the code that
   does this.

 - Similarly, -5 means "--do-walk -5".

 - rev-parse shares a revision parser (get_sha1) with rev-list, but it
   doesn't share an option parser (alas).

I personally kind of like the "don't prune commits by path with
--no-walk" idea.  Not sure what happened to that.

> The strict, systematic approach produces some command/argument
> combinations which are not useful or rarely useful.

Well, --no-walk foo..bar would be nonsense regardless of whether "git
show" did the equivalent of "git rev-list --no-walk ...".  And when
the user supplies nonsense, why should she expect us not to give
nonsense back?  So how about something along these lines?

Needs documentation and tests.

-- >8 --
Subject: revisions: treat "log A..B --no-walk" as a synonym for "--no-walk A..B"

When git learned to treat "git show A..B" as "git show --do-walk
A..B", it was only an accident that the implied --do-walk had that
position.

Sure, it meant that one could write "git show A..B --no-walk" to get
the ancient behavior of showing "B" unless the two commits are the
same, but that is not a convenience --- on the contrary, it's a
confusing wart that has required effort to preserve ever since (see
v1.6.0-rc2~42, 2008-07-31, for example).  So let's simplify the
semantics.  After this patch:

Attempts to show A..B or show -5 _always_ walk.  "git log A..B
--no-walk" simply doesn't make sense, so we assume the A..B came from
the end-user who wanted to override a script's suggestion not to walk.

The effect of --no-walk is the same everywhere, except that later
--do-walk overrides early --no-walk.

There is no longer a way to limit the number of commits listed to 5
without walking or to provide a negative revision without walking.
If someone wants that, we can introduce a new option instead of
tacking it onto the hack that supports "git show".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 revision.c |   15 +++++++++------
 revision.h |    1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 0f38364..0996c6f 100644
--- a/revision.c
+++ b/revision.c
@@ -133,8 +133,8 @@ void mark_parents_uninteresting(struct commit *commit)
 
 static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
-	if (revs->no_walk && (obj->flags & UNINTERESTING))
-		revs->no_walk = 0;
+	if (obj->flags & UNINTERESTING)
+		revs->implied_walk = 1;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
 		int len = interpret_branch_name(name, &buf);
@@ -1186,7 +1186,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
 		revs->max_count = atoi(optarg);
-		revs->no_walk = 0;
+		revs->implied_walk = 1;
 		return argcount;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
 		revs->skip_count = atoi(optarg);
@@ -1194,16 +1194,16 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((*arg == '-') && isdigit(arg[1])) {
 	/* accept -<digit>, like traditional "head" */
 		revs->max_count = atoi(arg + 1);
-		revs->no_walk = 0;
+		revs->implied_walk = 1;
 	} else if (!strcmp(arg, "-n")) {
 		if (argc <= 1)
 			return error("-n requires an argument");
 		revs->max_count = atoi(argv[1]);
-		revs->no_walk = 0;
+		revs->implied_walk = 1;
 		return 2;
 	} else if (!prefixcmp(arg, "-n")) {
 		revs->max_count = atoi(arg + 2);
-		revs->no_walk = 0;
+		revs->implied_walk = 1;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age = atoi(optarg);
 		return argcount;
@@ -1691,6 +1691,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
 
+	if (revs->implied_walk)
+		revs->no_walk = 0;
+
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
diff --git a/revision.h b/revision.h
index 9fd8f30..c18d2c1 100644
--- a/revision.h
+++ b/revision.h
@@ -42,6 +42,7 @@ struct rev_info {
 	unsigned int	dense:1,
 			prune:1,
 			no_walk:1,
+			implied_walk:1,
 			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
-- 
1.7.5.rc3
