From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] remote: use skip_prefix
Date: Mon, 15 Feb 2016 13:18:38 -0500
Message-ID: <20160215181837.GE26443@sigill.intra.peff.net>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:18:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNjS-0005L6-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbcBOSSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:18:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:42279 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751193AbcBOSSk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:18:40 -0500
Received: (qmail 25157 invoked by uid 102); 15 Feb 2016 18:18:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:18:40 -0500
Received: (qmail 10008 invoked by uid 107); 15 Feb 2016 18:18:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:18:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:18:38 -0500
Content-Disposition: inline
In-Reply-To: <1455558150-30267-2-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286223>

On Mon, Feb 15, 2016 at 06:42:27PM +0100, Thomas Gummerer wrote:

> 95b567c7 ("use skip_prefix to avoid repeating strings") transformed
> calls using starts_with() and then skipping the length of the prefix to
> skip_prefix() calls.  In remote.c there are a few calls like:
> 
>   if (starts_with(foo, "bar"))
>       foo += 3
> 
> These calls weren't touched by the commit mentioned above, but can
> benefit from the same treatment to avoid magic numbers.

This is definitely an improvement, but I think we can actually go a step
further here, and use parse_config_key. Like:

diff --git a/remote.c b/remote.c
index 21e4ec3..8d2c3ca 100644
--- a/remote.c
+++ b/remote.c
@@ -318,15 +318,14 @@ static void read_branches_file(struct remote *remote)
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
+	int namelen;
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
-	if (starts_with(key, "branch.")) {
-		name = key + 7;
-		subkey = strrchr(name, '.');
-		if (!subkey)
+	if (starts_with(key, "branch", &name, &namelen, &subkey)) {
+		if (!name)
 			return 0;
-		branch = make_branch(name, subkey - name);
+		branch = make_branch(name, namelen);
 		if (!strcmp(subkey, ".remote")) {
 			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, ".pushremote")) {

and so on. The difference in lines of code isn't that great, but I think
it makes the resulting code more obvious to read.

-Peff
