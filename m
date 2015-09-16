From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/67] trace: use strbuf for quote_crnl output
Date: Wed, 16 Sep 2015 06:31:14 -0400
Message-ID: <20150916103114.GE13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152843.GK29753@sigill.intra.peff.net>
 <CAPig+cS3WFg1JtN7WU-SFSbT3a2L3o7wiZr8OMGJ5E3As00q3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:31:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9zs-0005or-J7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbbIPKbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:31:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59853 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753861AbbIPKbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:31:23 -0400
Received: (qmail 16598 invoked by uid 102); 16 Sep 2015 10:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:31:24 -0500
Received: (qmail 16606 invoked by uid 107); 16 Sep 2015 10:31:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:31:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:31:14 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cS3WFg1JtN7WU-SFSbT3a2L3o7wiZr8OMGJ5E3As00q3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278016>

On Tue, Sep 15, 2015 at 08:55:58PM -0400, Eric Sunshine wrote:

> On Tue, Sep 15, 2015 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> > When we output GIT_TRACE_SETUP paths, we quote any
> > meta-characters. But our buffer to hold the result is only
> > PATH_MAX bytes, and we could double the size of the input
> > path (if every character needs quoted). We could use a
> 
> s/quoted/to be &/ ...or... s/quoted/quoting/

Thanks, fixed.

> >  static const char *quote_crnl(const char *path)
> >  {
> > -       static char new_path[PATH_MAX];
> > +       static struct strbuf new_path = STRBUF_INIT;
> >         const char *p2 = path;
> > -       char *p1 = new_path;
> 
> It's a little sad that this leaves a variable named 'p2' when there is
> no corresponding 'p1'. Would this deserve a cleanup patch which
> renames 'p2' to 'p' or do we not care enough?

Yeah, you're right. The original had symmetry in p1 and p2, in that it
moved them forward together. Now that symmetry is gone, and I wonder if
the simplest cleanup is to just drop "p2" altogether and advance the
"path" source pointer? Like this:

-- >8 --
Subject: [PATCH] trace: use strbuf for quote_crnl output

When we output GIT_TRACE_SETUP paths, we quote any
meta-characters. But our buffer to hold the result is only
PATH_MAX bytes, and we could double the size of the input
path (if every character needs quoting). We could use a
2*PATH_MAX buffer, if we assume the input will never be more
than PATH_MAX. But it's easier still to just switch to a
strbuf and not worry about whether the input can exceed
PATH_MAX or not.

The original copied the "p2" pointer to "p1", advancing
both. Since this gets rid of "p1", let's also drop "p2",
whose name is now confusing. We can just advance the
original "path" pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/trace.c b/trace.c
index 7393926..4aeea60 100644
--- a/trace.c
+++ b/trace.c
@@ -277,25 +277,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 static const char *quote_crnl(const char *path)
 {
-	static char new_path[PATH_MAX];
-	const char *p2 = path;
-	char *p1 = new_path;
+	static struct strbuf new_path = STRBUF_INIT;
 
 	if (!path)
 		return NULL;
 
-	while (*p2) {
-		switch (*p2) {
-		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
-		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
-		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
+	strbuf_reset(&new_path);
+
+	while (*path) {
+		switch (*path) {
+		case '\\': strbuf_addstr(&new_path, "\\\\"); break;
+		case '\n': strbuf_addstr(&new_path, "\\n"); break;
+		case '\r': strbuf_addstr(&new_path, "\\r"); break;
 		default:
-			*p1++ = *p2;
+			strbuf_addch(&new_path, *path);
 		}
-		p2++;
+		path++;
 	}
-	*p1 = '\0';
-	return new_path;
+	return new_path.buf;
 }
 
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
-- 
2.6.0.rc2.408.ga2926b9
