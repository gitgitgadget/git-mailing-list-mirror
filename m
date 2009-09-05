From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] grep: accept relative paths outside current working
	directory
Date: Sat, 5 Sep 2009 14:31:17 +0200
Message-ID: <20090905123117.GA3099@darc.dnsalias.org>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905072017.GA5152@coredump.intra.peff.net> <7v3a717rgl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 14:31:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjuQa-0004GZ-30
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 14:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbZIEMb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 08:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757312AbZIEMbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 08:31:25 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:47010 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZIEMbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 08:31:24 -0400
Received: by fxm17 with SMTP id 17so1171478fxm.37
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=KngV+8F0vRpmnCGPDdzWsGKzmF0QP05+GK1t4wKmfBc=;
        b=m4mg463lumEH8uaYriS7FXgeP3jo7yR3YaOQ+Ip063ufeWr5fUSQI/wmRro+mXgDhT
         JDySNMlPBUHhIej6Y1PUecZMm3KHOTBNZtogM/6PsJ2vPs9fSvp08VX5Cf0qp5fdNlx5
         af7EFVYr9hbtZEn9/ZIo1pQ2B/uqYVSibj4ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=utqg/FZb5WZdOI95aKmzQ5Kqv5sASK5cZ2/5IS/tnZGw8AXlPwcW+F29tFTIyafFwF
         CT45JtOWuKhXNIJ/5+bGPisofSIo9EpK3cwPyIfuS2i7vjvMQt6o5ocVQz87yj4JtJqe
         LM49K/4ZZm5XM3vh3wNvFYmMCrx7ItASPWpgY=
Received: by 10.86.208.2 with SMTP id f2mr6025675fgg.16.1252153886010;
        Sat, 05 Sep 2009 05:31:26 -0700 (PDT)
Received: from darc.lan (p549A2AE8.dip.t-dialin.net [84.154.42.232])
        by mx.google.com with ESMTPS id l19sm3872504fgb.21.2009.09.05.05.31.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Sep 2009 05:31:25 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MjuQH-0003I0-HU; Sat, 05 Sep 2009 14:31:17 +0200
Content-Disposition: inline
In-Reply-To: <7v3a717rgl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127810>

On Sat, Sep 05, 2009 at 12:58:50AM -0700, Junio C Hamano wrote:
> >> If "git add -u ../.." (I mean "the grand parent directory", not "an
> >> unnamed subdirectory") did not work 

I just noticed that this doesn't work with grep. In git.git:

$ cd t
$ git grep addremove -- ../
fatal: git grep: cannot generate relative filenames containing '..'

So here's a fix for that. And a configurable solution for add and grep's
scope as a follow-up. I did not look at any other commands yet.

Clemens

--o<--
Previously, "git grep" would bark at relative paths pointing outside
the current working directory (or subdirectories thereof). We already
have quote_path_relative(), which can handle such cases just fine. So
use that instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin-grep.c |   44 ++++++++++++++------------------------------
 grep.h         |    1 +
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ad0e0a5..f6af3d4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "userdiff.h"
 #include "grep.h"
+#include "quote.h"
 
 #ifndef NO_EXTERNAL_GREP
 #ifdef __unix__
@@ -152,40 +153,27 @@ static int pathspec_matches(const char **paths, const char *name, int max_depth)
 	return 0;
 }
 
-static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name, int tree_name_len)
+static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *path, int tree_name_len)
 {
 	unsigned long size;
 	char *data;
 	enum object_type type;
-	char *to_free = NULL;
 	int hit;
+	struct strbuf pathbuf = STRBUF_INIT;
 
 	data = read_sha1_file(sha1, &type, &size);
 	if (!data) {
-		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
+		error("'%s': unable to read %s", path, sha1_to_hex(sha1));
 		return 0;
 	}
 	if (opt->relative && opt->prefix_length) {
-		static char name_buf[PATH_MAX];
-		char *cp;
-		int name_len = strlen(name) - opt->prefix_length + 1;
-
-		if (!tree_name_len)
-			name += opt->prefix_length;
-		else {
-			if (ARRAY_SIZE(name_buf) <= name_len)
-				cp = to_free = xmalloc(name_len);
-			else
-				cp = name_buf;
-			memcpy(cp, name, tree_name_len);
-			strcpy(cp + tree_name_len,
-			       name + tree_name_len + opt->prefix_length);
-			name = cp;
-		}
+		quote_path_relative(path + tree_name_len, -1, &pathbuf, opt->prefix);
+		strbuf_insert(&pathbuf, 0, path, tree_name_len);
+		path = pathbuf.buf;
 	}
-	hit = grep_buffer(opt, name, data, size);
+	hit = grep_buffer(opt, path, data, size);
+	strbuf_release(&pathbuf);
 	free(data);
-	free(to_free);
 	return hit;
 }
 
@@ -195,6 +183,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	int i;
 	char *data;
 	size_t sz;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (lstat(filename, &st) < 0) {
 	err_ret:
@@ -219,8 +208,9 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	}
 	close(i);
 	if (opt->relative && opt->prefix_length)
-		filename += opt->prefix_length;
+		filename = quote_path_relative(filename, -1, &buf, opt->prefix);
 	i = grep_buffer(opt, filename, data, sz);
+	strbuf_release(&buf);
 	free(data);
 	return i;
 }
@@ -798,6 +788,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&opt, 0, sizeof(opt));
+	opt.prefix = prefix;
 	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt.relative = 1;
 	opt.pathname = 1;
@@ -868,15 +859,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			verify_filename(prefix, argv[j]);
 	}
 
-	if (i < argc) {
+	if (i < argc)
 		paths = get_pathspec(prefix, argv + i);
-		if (opt.prefix_length && opt.relative) {
-			/* Make sure we do not get outside of paths */
-			for (i = 0; paths[i]; i++)
-				if (strncmp(prefix, paths[i], opt.prefix_length))
-					die("git grep: cannot generate relative filenames containing '..'");
-		}
-	}
 	else if (prefix) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
diff --git a/grep.h b/grep.h
index 28e6b2a..f6eecc6 100644
--- a/grep.h
+++ b/grep.h
@@ -59,6 +59,7 @@ struct grep_opt {
 	struct grep_pat *pattern_list;
 	struct grep_pat **pattern_tail;
 	struct grep_expr *pattern_expression;
+	const char *prefix;
 	int prefix_length;
 	regex_t regexp;
 	int linenum;
-- 
1.6.4.2.264.g79b4f
