From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git rev-parse -q --verify $SHA doesn't always quiet errors
Date: Fri, 5 Nov 2010 17:40:24 -0500
Message-ID: <20101105224024.GD4457@burratino>
References: <4A1CAE91-E31C-46B5-A614-9634D8FC1FB1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 23:40:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEUxY-0005OE-QN
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 23:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab0KEWkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 18:40:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37806 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab0KEWkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 18:40:31 -0400
Received: by qwb8 with SMTP id 8so928828qwb.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jFC8x4zcmfoUPlVvT/NFMiSwCqmaWeg/mG2QwCZ1UwE=;
        b=r1fQv3Kd/5+1a262kJtMTJT0OxHkcsTyNlJsyKM/QaBpcqiutO6tzI+nT6Ya8pl/un
         PcfixK3llO89iRmP3aYJQFfoj1y9tuDpKxjC/MSJ0k3WXI21fXX5Uvvhaq80/HjnqEL9
         pRDourtBnRrRpOyrZSUBn+pB1AkGkXyRMdGc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cflkfy5jDT1FhFpZdz603ehvM5dc4cxCKP+GOfysIgOoQ5GGlKcyaKdvFi+98P6a5R
         eE8cHmr0zij6vGNOycWOQq208eb0asro4eea29NVXHIGqoIjU20uWNvvADBydq8ZodiQ
         Gs7S3EnRLnt+vjGrVlEDkcTlP7XIYIvmh1p0U=
Received: by 10.229.238.17 with SMTP id kq17mr2453809qcb.193.1288996830936;
        Fri, 05 Nov 2010 15:40:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u2sm1848863qcq.43.2010.11.05.15.40.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 15:40:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1CAE91-E31C-46B5-A614-9634D8FC1FB1@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160829>

Kevin Ballard wrote:

> % cd Dev/git
> % git rev-parse -q --verify e51d
> error: short SHA1 e51d is ambiguous.
> 
> I took a quick look, and the error is being emitted deep within
> sha1_name.c, far outside of any access to the -q flag.

Something to play with.  Sloppy, untested, but maybe it gives an idea
of what's possible.

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..13f099a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -108,8 +108,17 @@ static void show_with_type(int type, const char *arg)
 	show(arg);
 }
 
+static void die_no_single_rev(int quiet)
+{
+	if (quiet)
+		exit(1);
+	else
+		die("Needed a single revision");
+}
+
 /* Output a revision, only if filter allows it */
-static void show_rev(int type, const unsigned char *sha1, const char *name)
+static void show_rev(int type, const unsigned char *sha1, const char *name,
+		     int verify, int quiet)
 {
 	if (!(filter & DO_REVS))
 		return;
@@ -137,6 +146,8 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 				show_with_type(type, full);
 				break;
 			default: /* ambiguous */
+				if (verify)
+					die_no_single_rev(quiet);
 				error("refname '%s' is ambiguous", name);
 				break;
 			}
@@ -171,7 +182,7 @@ static int show_default(void)
 
 		def = NULL;
 		if (!get_sha1(s, sha1)) {
-			show_rev(NORMAL, sha1, s);
+			show_rev(NORMAL, sha1, s, 0, 0);
 			return 1;
 		}
 	}
@@ -180,13 +191,13 @@ static int show_default(void)
 
 static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	show_rev(NORMAL, sha1, refname);
+	show_rev(NORMAL, sha1, refname, 0, 0);
 	return 0;
 }
 
 static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	show_rev(REVERSED, sha1, refname);
+	show_rev(REVERSED, sha1, refname, 0, 0);
 	return 0;
 }
 
@@ -234,8 +245,8 @@ static int try_difference(const char *arg)
 	if (dotdot == arg)
 		this = "HEAD";
 	if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
-		show_rev(NORMAL, end, next);
-		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
+		show_rev(NORMAL, end, next, 0, 0);
+		show_rev(symmetric ? NORMAL : REVERSED, sha1, this, 0, 0);
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
@@ -245,7 +256,8 @@ static int try_difference(const char *arg)
 			while (exclude) {
 				struct commit_list *n = exclude->next;
 				show_rev(REVERSED,
-					 exclude->item->object.sha1,NULL);
+					 exclude->item->object.sha1,
+					 NULL, 0, 0);
 				free(exclude);
 				exclude = n;
 			}
@@ -277,11 +289,11 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	if (!parents_only)
-		show_rev(NORMAL, sha1, arg);
+		show_rev(NORMAL, sha1, arg, 0, 0);
 	commit = lookup_commit_reference(sha1);
 	for (parents = commit->parents; parents; parents = parents->next)
 		show_rev(parents_only ? NORMAL : REVERSED,
-				parents->item->object.sha1, arg);
+				parents->item->object.sha1, arg, 0, 0);
 
 	return 1;
 }
@@ -429,14 +441,6 @@ static int cmd_sq_quote(int argc, const char **argv)
 	return 0;
 }
 
-static void die_no_single_rev(int quiet)
-{
-	if (quiet)
-		exit(1);
-	else
-		die("Needed a single revision");
-}
-
 static const char builtin_rev_parse_usage[] =
 "git rev-parse --parseopt [options] -- [<args>...]\n"
 "   or: git rev-parse --sq-quote [<arg>...]\n"
@@ -707,12 +711,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_sha1(name, sha1)) {
-			if (verify)
-				revs_count++;
-			else
-				show_rev(type, sha1, name);
-			continue;
+		{
+			struct object_context dummy;
+			if (!get_sha1_with_context_2(name, sha1, &dummy, 1, NULL, quiet)) {
+				if (verify)
+					revs_count++;
+				else
+					show_rev(type, sha1, name, 0, 0);
+				continue;
+			}
 		}
 		if (verify)
 			die_no_single_rev(quiet);
@@ -723,7 +730,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	}
 	if (verify) {
 		if (revs_count == 1) {
-			show_rev(type, sha1, name);
+			show_rev(type, sha1, name, verify, quiet);
 			return 0;
 		} else if (revs_count == 0 && show_default())
 			return 0;
diff --git a/cache.h b/cache.h
index 33decd9..2bef387 100644
--- a/cache.h
+++ b/cache.h
@@ -773,6 +773,7 @@ static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsig
 	return get_sha1_with_mode_1(str, sha1, mode, 1, NULL);
 }
 extern int get_sha1_with_context_1(const char *name, unsigned char *sha1, struct object_context *orc, int gently, const char *prefix);
+extern int get_sha1_with_context_2(const char *name, unsigned char *sha1, struct object_context *orc, int gently, const char *prefix, int quietly);
 static inline int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc)
 {
 	return get_sha1_with_context_1(str, sha1, orc, 1, NULL);
diff --git a/sha1_name.c b/sha1_name.c
index 484081d..5cefb75 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -611,7 +611,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+static int get_sha1_2(const char *name, int len, unsigned char *sha1, int quietly)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -656,7 +656,12 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 	if (!ret)
 		return 0;
 
-	return get_short_sha1(name, len, sha1, 0);
+	return get_short_sha1(name, len, sha1, quietly);
+}
+
+static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+{
+	return get_sha1_2(name, len, sha1, 0);
 }
 
 /*
@@ -1046,9 +1051,9 @@ int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
 	return ret;
 }
 
-int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+int get_sha1_with_context_2(const char *name, unsigned char *sha1,
 			    struct object_context *oc,
-			    int gently, const char *prefix)
+			    int gently, const char *prefix, int quietly)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -1056,7 +1061,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1);
+	ret = get_sha1_2(name, namelen, sha1, quietly);
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
@@ -1141,3 +1146,10 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	}
 	return ret;
 }
+
+int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+			    struct object_context *oc,
+			    int gently, const char *prefix)
+{
+	return get_sha1_with_context_2(name, sha1, oc, gently, prefix, 0);
+}
