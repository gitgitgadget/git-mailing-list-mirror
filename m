From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 03:57:40 -0500
Message-ID: <20160220085740.GC17171@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
 <20160219112324.GF9319@sigill.intra.peff.net>
 <CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
 <20160220081010.GA16722@sigill.intra.peff.net>
 <CAPig+cTACku01im72Cd7LxYopwwFaXtKYXkxi53GMrTRyZpFGQ@mail.gmail.com>
 <20160220083426.GA17171@sigill.intra.peff.net>
 <CAPig+cQK15OoNdG0zyCC0eZJ1XeidD7sOU8BggnNN7k=Zi9zdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:57:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX3MP-0006uF-1m
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949986AbcBTI5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:57:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:45996 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1948978AbcBTI5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:57:42 -0500
Received: (qmail 11937 invoked by uid 102); 20 Feb 2016 08:57:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:57:43 -0500
Received: (qmail 4427 invoked by uid 107); 20 Feb 2016 08:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:57:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Feb 2016 03:57:40 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQK15OoNdG0zyCC0eZJ1XeidD7sOU8BggnNN7k=Zi9zdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286773>

On Sat, Feb 20, 2016 at 03:39:36AM -0500, Eric Sunshine wrote:

> I also had made the strbuf_detach() analogy in my response but deleted
> it before sending; I do think it's a reasonable API template to mirror
> via new argv_array_detach().

That would look like this, which I think is not too bad (on top of my
series for now; I'd do the API function as a separate patch at the
beginning and then use it immediately).

diff --git a/argv-array.c b/argv-array.c
index eaed477..5d370fa 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -74,3 +74,14 @@ void argv_array_clear(struct argv_array *array)
 	}
 	argv_array_init(array);
 }
+
+const char **argv_array_detach(struct argv_array *array)
+{
+	if (array->argv == empty_argv)
+		return xcalloc(1, sizeof(const char *));
+	else {
+		const char **ret = array->argv;
+		argv_array_init(array);
+		return ret;
+	}
+}
diff --git a/argv-array.h b/argv-array.h
index a2fa0aa..29056e4 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -20,5 +20,6 @@ void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
+const char **argv_array_detach(struct argv_array *);
 
 #endif /* ARGV_ARRAY_H */
diff --git a/line-log.c b/line-log.c
index fa095b9..bbe31ed 100644
--- a/line-log.c
+++ b/line-log.c
@@ -748,15 +748,17 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 
 	if (!rev->diffopt.detect_rename) {
 		struct line_log_data *r;
-		struct argv_array paths = ARGV_ARRAY_INIT;
+		struct argv_array array = ARGV_ARRAY_INIT;
+		const char **paths;
 
 		for (r = range; r; r = r->next)
-			argv_array_push(&paths, r->path);
+			argv_array_push(&array, r->path);
+		paths = argv_array_detach(&array);
+
 		parse_pathspec(&rev->diffopt.pathspec, 0,
-			       PATHSPEC_PREFER_FULL, "", paths.argv);
-		/* argv strings are now owned by pathspec */
-		paths.argc = 0;
-		argv_array_clear(&paths);
+			       PATHSPEC_PREFER_FULL, "", paths);
+		/* strings are now owned by pathspec */
+		free(paths);
 	}
 }
 
