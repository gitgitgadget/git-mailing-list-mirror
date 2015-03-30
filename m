From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] enter_repo(): fix suffix precedence documentation
Date: Mon, 30 Mar 2015 07:44:08 -0400
Message-ID: <20150330114407.GA2936@peff.net>
References: <1427711433-3104-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 13:44:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcY76-0003UF-GY
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 13:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbbC3LoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 07:44:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:39814 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751659AbbC3LoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 07:44:10 -0400
Received: (qmail 23070 invoked by uid 102); 30 Mar 2015 11:44:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 06:44:10 -0500
Received: (qmail 14111 invoked by uid 107); 30 Mar 2015 11:44:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 07:44:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 07:44:08 -0400
Content-Disposition: inline
In-Reply-To: <1427711433-3104-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266453>

On Mon, Mar 30, 2015 at 06:30:33PM +0800, Paul Tan wrote:

> The ordering of the list of suffixes tested in enter_repo() is
> documented as "%s.git/.git", "%s/.git", "%s.git", "%s". This does not
> match the ordering of the list of suffixes tested in the code which is
> "%s/.git", "%s", "%s.git/.git", "%s.git". Fix this.

Yes, this was adjusted in b3256eb (standardize and improve lookup rules
for external local repos, 2012-02-02), but I failed to update the
comment.

Your patch is certainly an improvement, but I think there are more
inaccuracies in the comment caused by that commit. Maybe squash this on
top:

diff --git a/path.c b/path.c
index 56f50bd..586f2c9 100644
--- a/path.c
+++ b/path.c
@@ -383,14 +383,9 @@ return_null:
  * (3) "relative/path" to mean cwd relative directory; or
  * (4) "/absolute/path" to mean absolute directory.
  *
- * Unless "strict" is given, we try access() for existence of "%s/.git",
- * "%s", "%s.git/.git", "%s.git" in this order. The first one that exists is
- * what we try.
- *
- * Second, we try chdir() to that.  Upon failure, we return NULL.
- *
- * Then, we try if the current directory is a valid git repository.
- * Upon failure, we return NULL.
+ * Unless "strict" is given, we check "%s/.git", "%s", "%s.git/.git", "%s.git"
+ * in this order. We select the first one that is a valid git repository, and
+ * chdir() to it. If none match, or we fail to chdir, we return NULL.
  *
  * If all goes well, we return the directory we used to chdir() (but
  * before ~user is expanded), avoiding getcwd() resolving symbolic
