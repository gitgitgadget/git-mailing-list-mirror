From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sun, 08 Oct 2006 12:56:19 -0700
Message-ID: <7vfydyinto.fsf@assigned-by-dhcp.cox.net>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
	<BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
	<BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
	<7viriwsa75.fsf@assigned-by-dhcp.cox.net> <eg82tq$2uq$1@sea.gmane.org>
	<Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061007223023.GI20017@pasky.or.cz>
	<Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqonpfyl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP053FFB92C509E9427F85B0AE110@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sun Oct 08 21:56:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWel6-0006j7-3L
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 21:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWJHT4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 15:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWJHT4W
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 15:56:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31227 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751386AbWJHT4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 15:56:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008195620.BXKO22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 15:56:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XvwB1V00U1kojtg0000000
	Sun, 08 Oct 2006 15:56:12 -0400
To: Sean <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28546>

Sean <seanlkml@sympatico.ca> writes:

> On Sat, 07 Oct 2006 21:52:02 -0700
> Junio C Hamano <junkio@cox.net> wrote:
>
>> Using DAV, if it works with the server, has the advantage of not
>> having to keep objects/info/packs up-to-date from repository
>> owner's point of view.  But the repository owner ends up keeping
>> up-to-date as a side effect of keeping info/refs up-to-date
>> anyway (as I do not see a code to read that information over
>> DAV), so there is no point doing this over DAV in practice.
>> 
>> Perhaps we should remove call to remote_ls() from
>> fetch_indices() unconditionally, not just protected with
>> NO_EXPAT and be done with it?
>
> That makes a lot of sense.  A server really has to always provide
> a objects/info/packs anyway, just to be fetchable today by clients
> that are compiled with NO_EXPAT.

And even for an isolated group where everybody knows that
everybody else runs DAV-enabled clients, they need info/refs
prepared for ls-remote and git-fetch script, which means you
will run update-server-info to keep objects/info/packs up to
date.

Nick, do you see holes in my logic?

-- >8 --
http-fetch.c: drop remote_ls()

While doing remote_ls() over DAV potentially allows the server
side not to keep objects/info/pack up-to-date, misconfigured or
buggy servers can silently ignore or not to respond to DAV
requests and makes the client hang.

The server side (unfortunately) needs to run git-update-server-info
even if remote_ls() removes the need to keep objects/info/pack file
up-to-date, because the caller of git-http-fetch (git-fetch) and other
clients that interact with the repository (e.g. git-ls-remote) need to
read from info/refs file (there is no code to make that unnecessary by
using DAV yet).

Perhaps the right solution in the longer-term is to make info/refs
also unnecessary by using DAV, and we would want to resurrect the
code this patch removes when we do so, but let's drop remote_ls()
implementation for now.  It is causing problems without really
helping anything yet.

git will keep it for us until we need it next time.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/http-fetch.c b/http-fetch.c
index 8f251e7..396552d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -4,35 +4,6 @@ #include "pack.h"
 #include "fetch.h"
 #include "http.h"
 
-#ifndef NO_EXPAT
-#include <expat.h>
-
-/* Definitions for DAV requests */
-#define DAV_PROPFIND "PROPFIND"
-#define DAV_PROPFIND_RESP ".multistatus.response"
-#define DAV_PROPFIND_NAME ".multistatus.response.href"
-#define DAV_PROPFIND_COLLECTION ".multistatus.response.propstat.prop.resourcetype.collection"
-#define PROPFIND_ALL_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:propfind xmlns:D=\"DAV:\">\n<D:allprop/>\n</D:propfind>"
-
-/* Definitions for processing XML DAV responses */
-#ifndef XML_STATUS_OK
-enum XML_Status {
-  XML_STATUS_OK = 1,
-  XML_STATUS_ERROR = 0
-};
-#define XML_STATUS_OK    1
-#define XML_STATUS_ERROR 0
-#endif
-
-/* Flags that control remote_ls processing */
-#define PROCESS_FILES (1u << 0)
-#define PROCESS_DIRS  (1u << 1)
-#define RECURSIVE     (1u << 2)
-
-/* Flags that remote_ls passes to callback functions */
-#define IS_DIR (1u << 0)
-#endif
-
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
@@ -90,30 +61,6 @@ struct alternates_request {
 	int http_specific;
 };
 
-#ifndef NO_EXPAT
-struct xml_ctx
-{
-	char *name;
-	int len;
-	char *cdata;
-	void (*userFunc)(struct xml_ctx *ctx, int tag_closed);
-	void *userData;
-};
-
-struct remote_ls_ctx
-{
-	struct alt_base *repo;
-	char *path;
-	void (*userFunc)(struct remote_ls_ctx *ls);
-	void *userData;
-	int flags;
-	char *dentry_name;
-	int dentry_flags;
-	int rc;
-	struct remote_ls_ctx *parent;
-};
-#endif
-
 static struct object_request *object_queue_head;
 
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
@@ -714,193 +661,6 @@ #endif
 	free(url);
 }
 
-#ifndef NO_EXPAT
-static void
-xml_start_tag(void *userData, const char *name, const char **atts)
-{
-	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = strchr(name, ':');
-	int new_len;
-
-	if (c == NULL)
-		c = name;
-	else
-		c++;
-
-	new_len = strlen(ctx->name) + strlen(c) + 2;
-
-	if (new_len > ctx->len) {
-		ctx->name = xrealloc(ctx->name, new_len);
-		ctx->len = new_len;
-	}
-	strcat(ctx->name, ".");
-	strcat(ctx->name, c);
-
-	free(ctx->cdata);
-	ctx->cdata = NULL;
-
-	ctx->userFunc(ctx, 0);
-}
-
-static void
-xml_end_tag(void *userData, const char *name)
-{
-	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = strchr(name, ':');
-	char *ep;
-
-	ctx->userFunc(ctx, 1);
-
-	if (c == NULL)
-		c = name;
-	else
-		c++;
-
-	ep = ctx->name + strlen(ctx->name) - strlen(c) - 1;
-	*ep = 0;
-}
-
-static void
-xml_cdata(void *userData, const XML_Char *s, int len)
-{
-	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	free(ctx->cdata);
-	ctx->cdata = xmalloc(len + 1);
-	strlcpy(ctx->cdata, s, len + 1);
-}
-
-static int remote_ls(struct alt_base *repo, const char *path, int flags,
-		     void (*userFunc)(struct remote_ls_ctx *ls),
-		     void *userData);
-
-static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
-{
-	struct remote_ls_ctx *ls = (struct remote_ls_ctx *)ctx->userData;
-
-	if (tag_closed) {
-		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry_name) {
-			if (ls->dentry_flags & IS_DIR) {
-				if (ls->flags & PROCESS_DIRS) {
-					ls->userFunc(ls);
-				}
-				if (strcmp(ls->dentry_name, ls->path) &&
-				    ls->flags & RECURSIVE) {
-					ls->rc = remote_ls(ls->repo,
-							   ls->dentry_name,
-							   ls->flags,
-							   ls->userFunc,
-							   ls->userData);
-				}
-			} else if (ls->flags & PROCESS_FILES) {
-				ls->userFunc(ls);
-			}
-		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
-			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
-						  ls->repo->path_len + 1);
-			strcpy(ls->dentry_name, ctx->cdata + ls->repo->path_len);
-		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
-			ls->dentry_flags |= IS_DIR;
-		}
-	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
-		free(ls->dentry_name);
-		ls->dentry_name = NULL;
-		ls->dentry_flags = 0;
-	}
-}
-
-static int remote_ls(struct alt_base *repo, const char *path, int flags,
-		     void (*userFunc)(struct remote_ls_ctx *ls),
-		     void *userData)
-{
-	char *url = xmalloc(strlen(repo->base) + strlen(path) + 1);
-	struct active_request_slot *slot;
-	struct slot_results results;
-	struct buffer in_buffer;
-	struct buffer out_buffer;
-	char *in_data;
-	char *out_data;
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
-	struct curl_slist *dav_headers = NULL;
-	struct xml_ctx ctx;
-	struct remote_ls_ctx ls;
-
-	ls.flags = flags;
-	ls.repo = repo;
-	ls.path = xstrdup(path);
-	ls.dentry_name = NULL;
-	ls.dentry_flags = 0;
-	ls.userData = userData;
-	ls.userFunc = userFunc;
-	ls.rc = 0;
-
-	sprintf(url, "%s%s", repo->base, path);
-
-	out_buffer.size = strlen(PROPFIND_ALL_REQUEST);
-	out_data = xmalloc(out_buffer.size + 1);
-	snprintf(out_data, out_buffer.size + 1, PROPFIND_ALL_REQUEST);
-	out_buffer.posn = 0;
-	out_buffer.buffer = out_data;
-
-	in_buffer.size = 4096;
-	in_data = xmalloc(in_buffer.size);
-	in_buffer.posn = 0;
-	in_buffer.buffer = in_data;
-
-	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
-	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
-
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.size);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			ctx.name = xcalloc(10, 1);
-			ctx.len = 0;
-			ctx.cdata = NULL;
-			ctx.userFunc = handle_remote_ls_ctx;
-			ctx.userData = &ls;
-			XML_SetUserData(parser, &ctx);
-			XML_SetElementHandler(parser, xml_start_tag,
-					      xml_end_tag);
-			XML_SetCharacterDataHandler(parser, xml_cdata);
-			result = XML_Parse(parser, in_buffer.buffer,
-					   in_buffer.posn, 1);
-			free(ctx.name);
-
-			if (result != XML_STATUS_OK) {
-				ls.rc = error("XML error: %s",
-					      XML_ErrorString(
-						      XML_GetErrorCode(parser)));
-			}
-		} else {
-			ls.rc = -1;
-		}
-	} else {
-		ls.rc = error("Unable to start PROPFIND request");
-	}
-
-	free(ls.path);
-	free(url);
-	free(out_data);
-	free(in_buffer.buffer);
-	curl_slist_free_all(dav_headers);
-
-	return ls.rc;
-}
-
-#endif
-
 static int fetch_indices(struct alt_base *repo)
 {
 	unsigned char sha1[20];
