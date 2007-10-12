From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH amend] git-config: print error message if the config file cannot be read
Date: Fri, 12 Oct 2007 11:40:57 +0000
Message-ID: <20071012114057.30803.qmail@12f4c67b8560e2.315fe32.mid.smarden.org>
References: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org> <470B8286.5060006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgIsp-0000Dv-8W
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbXJLLki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXJLLki
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:40:38 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:47823 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753720AbXJLLkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:40:37 -0400
Received: (qmail 30804 invoked by uid 1000); 12 Oct 2007 11:40:57 -0000
Content-Disposition: inline
In-Reply-To: <470B8286.5060006@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60680>

Instead of simply exiting with 255, print an error message including
the reason why a config file specified through --file cannot be opened
or read.

The problem was noticed by Joey Hess, reported through
 http://bugs.debian.org/445208
---

On Tue, Oct 09, 2007 at 02:16:41PM +0100, Johannes Schindelin wrote:
> On Tue, 9 Oct 2007, Gerrit Pape wrote:
> > +           if (git_config(show_all_config) == -1)
> I'd rather check for < 0, just for future proofing.

Okay.

On Tue, Oct 09, 2007 at 03:30:46PM +0200, Johannes Sixt wrote:
> Gerrit Pape schrieb:
> >+    if (show_all) {
> >+            if (git_config(show_all_config) == -1)
> >+                    die("unable to read config file %s: %s",
> >+                        getenv(CONFIG_ENVIRONMENT), strerror(errno));
> I don't think that this works well: If there are no config files at
> all, then we don't want to see an error - just as if the config file
> were empty.
>
> Also, I don't think that errno is reliable at this point.
>
> You probably want to see an error message *only* if you have supplied
> a file name with --file.

I changed the patch to die() only if --file was sepcified, and errno is
not 0.

Thanks, Gerrit.


 builtin-config.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 4444d52..e5bf791 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -172,8 +172,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_INT;
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
-		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
-			return git_config(show_all_config);
+		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
+			if (git_config(show_all_config) < 0 && file && errno)
+				die("unable to read config file %s: %s", file,
+				    strerror(errno));
+			return 0;
+		}
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
-- 
1.5.3.4
