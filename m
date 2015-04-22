From: Jeff King <peff@peff.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 18:00:54 -0400
Message-ID: <20150422220053.GA32268@peff.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
 <20150422202910.GB26917@peff.net>
 <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
 <20150422212904.GA32043@peff.net>
 <20150422214445.GC827497@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 00:01:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl2hZ-0002Q6-BX
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 00:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbbDVWA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 18:00:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:48903 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756248AbbDVWA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 18:00:56 -0400
Received: (qmail 24186 invoked by uid 102); 22 Apr 2015 22:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 17:00:56 -0500
Received: (qmail 14645 invoked by uid 107); 22 Apr 2015 22:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 18:01:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 18:00:54 -0400
Content-Disposition: inline
In-Reply-To: <20150422214445.GC827497@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267647>

On Wed, Apr 22, 2015 at 09:44:45PM +0000, brian m. carlson wrote:

> On Wed, Apr 22, 2015 at 05:29:04PM -0400, Jeff King wrote:
> > > Perhaps it would be worthwhile to check instead if the text "plink" is
> > > the beginning of string or is preceded by a path separator.  That would
> > > give us a bit more confidence that the user is looking for plink, but
> > > would still allow people to use "plink-0.63" if they like.
> > 
> > Yeah, I think that is a reasonable approach. Note that it needs to
> > handle the "tortoiseplink" case from below, too (you can still use your
> > strategy, you just need to look for either string).
> 
> So maybe something like this?
> 
> diff --git a/connect.c b/connect.c
> index 391d211..ba3ab34 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -749,10 +749,15 @@ struct child_process *git_connect(int fd[2], const char *url,
>  					conn->use_shell = 1;
>  					putty = 0;
>  				} else {
> +					char *plink, *tplink;
> +
>  					ssh = getenv("GIT_SSH");
>  					if (!ssh)
>  						ssh = "ssh";
> -					putty = !!strcasestr(ssh, "plink");
> +					plink = strcasestr(ssh, "plink");
> +					tplink = strcasestr(ssh, "tortoiseplink");
> +					putty = plink == ssh || (plink && is_dir_sep(plink[-1])) ||
> +						tplink == ssh || (tplink && is_dir_sep(tplink[-1]));

Yeah, that looks right to me. You might want to represent the "are we
tortoise" check as a separate flag, though, and reuse it a few lines
later.

Also, not related to your patch, but I notice the "putty" declaration is
in a different scope than I would have expected, which made me wonder if
it gets initialized in all code paths. I think is from the recent
addition of CONNECT_DIAG_URL, which pushes the bulk of the code into its
own else clause, even though the first part of the "if" always returns
early.  I wonder if it would be simpler to read like:

diff --git a/connect.c b/connect.c
index 391d211..749a07b 100644
--- a/connect.c
+++ b/connect.c
@@ -743,28 +743,28 @@ struct child_process *git_connect(int fd[2], const char *url,
 				free(path);
 				free(conn);
 				return NULL;
-			} else {
-				ssh = getenv("GIT_SSH_COMMAND");
-				if (ssh) {
-					conn->use_shell = 1;
-					putty = 0;
-				} else {
-					ssh = getenv("GIT_SSH");
-					if (!ssh)
-						ssh = "ssh";
-					putty = !!strcasestr(ssh, "plink");
-				}
-
-				argv_array_push(&conn->args, ssh);
-				if (putty && !strcasestr(ssh, "tortoiseplink"))
-					argv_array_push(&conn->args, "-batch");
-				if (port) {
-					/* P is for PuTTY, p is for OpenSSH */
-					argv_array_push(&conn->args, putty ? "-P" : "-p");
-					argv_array_push(&conn->args, port);
-				}
-				argv_array_push(&conn->args, ssh_host);
 			}
+
+			ssh = getenv("GIT_SSH_COMMAND");
+			if (ssh) {
+				conn->use_shell = 1;
+				putty = 0;
+			} else {
+				ssh = getenv("GIT_SSH");
+				if (!ssh)
+					ssh = "ssh";
+				putty = !!strcasestr(ssh, "plink");
+			}
+
+			argv_array_push(&conn->args, ssh);
+			if (putty && !strcasestr(ssh, "tortoiseplink"))
+				argv_array_push(&conn->args, "-batch");
+			if (port) {
+				/* P is for PuTTY, p is for OpenSSH */
+				argv_array_push(&conn->args, putty ? "-P" : "-p");
+				argv_array_push(&conn->args, port);
+			}
+			argv_array_push(&conn->args, ssh_host);
 		} else {
 			/* remove repo-local variables from the environment */
 			conn->env = local_repo_env;

-Peff
