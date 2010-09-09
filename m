From: der Mouse <mouse@Rodents-Montreal.ORG>
Subject: Re: git's use of mkdir(2)
Date: Thu, 9 Sep 2010 15:38:43 -0400 (EDT)
Message-ID: <201009091938.PAA18955@Sparkle.Rodents-Montreal.ORG>
References: <201009081936.PAA07078@Sparkle.Rodents-Montreal.ORG>
	<7v62yen3ts.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 21:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmxQ-0007l6-4F
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab0IITis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:38:48 -0400
Received: from Sparkle.Rodents-Montreal.ORG ([216.46.5.7]:56280 "EHLO
	Sparkle.Rodents-Montreal.ORG" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751730Ab0IITiq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 15:38:46 -0400
Received: from localhost (localhost [[UNIX: localhost]])
	by Sparkle.Rodents-Montreal.ORG (8.8.8/8.8.8) id PAA18955;
	Thu, 9 Sep 2010 15:38:43 -0400 (EDT)
X-Erik-Conspiracy: There is no Conspiracy - and if there were I wouldn't be part of it anyway.
X-Message-Flag: Microsoft: the company who gave us the botnet zombies.
X-Composition-Start-Date: Thu, 9 Sep 2010 15:15:06 -0400 (EDT)
In-Reply-To: <7v62yen3ts.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155893>

>> Specifically, if /foo/bar does not exist but /foo does,
>> mkdir("/foo/bar/",...) works on one and fails showing ENOENT on the
>> other.  (Without the trailing slash, it works on both.)
> What vintage of BSD do you have that exhibits the problem?

NetBSD 1.4T.  (About a decade old at this point.)  It's unlikely that
the machine I most care about this on is going to switch versions
anytime soon, though I may be able to convince its mkdir(2) to strip
trailing slashes - I should look at the other implementation....

> It smells like a POSIX violation, considering what "4.12 Pathname
> Resolution" says on the matter:

>   A pathname that contains at least one non-<slash> character and
>   that ends with one or more trailing <slash> characters shall not be
>   resolved successfully unless the last pathname component before the
>   trailing <slash> characters names an existing directory or a
>   directory entry that is to be created for a directory immediately
>   after the pathname is resolved.

Well, notice that it does not say that it shall be successfully
resolved in either of those exception cases, just that it shall not be
successfully resolved in other cases.  I read this as "you can append a
slash to require that the last component be a directory", with the
second exception so that the mkdir-with-trailing-slash-works behaviour
is permitted; I don't read it as mandating that mkdir work with a
trailing slash.  Is there a rationale of any sort that elaborates on
this choice, or perhaps something about mkdir elsewhere?

> Not that I am saying that such a system does not deserve to be
> supported, but I am curious to know how widespread the damage is.

I don't know.  Of my own experience, I know one version that tolerates
what git does and one version that doesn't; I haven't experimented to
try to determine how widespread either is - though I can infer that
Linux falls in the trailing-slash-allowed camp.

For the moment, I bludgeoned it into working with the patch below, but
I haven't really exercised it very much yet, so it's entirely possible
it's going to trip over the same thing somewhere else - there are a lot
of mkdir calls scattered around and I haven't looked at any outside
builtin-init-db.c.

Personally, I'd tend to avoid depending on this detail of mkdir, when
it's easy (which it appears to be in the case of builtin-init-db.c)
just on general principles.  But I don't know whether this is outside
the scope of what git cares about - I just know _I_ care about it. :)

Given the existing code, a mkdir wrapper which strips trailing slashes
might be the least-pain answer; it feels wrong to accrete wrappers like
that all over the place, but sometimes they are right answers....

/~\ The ASCII				  Mouse
\ / Ribbon Campaign
 X  Against HTML		mouse@rodents-montreal.org
/ \ Email!	     7D C8 61 52 5D E7 2D 39  4E F1 31 3E E8 B3 27 4B

Here's the patch I mentioned above.  (This is relative to 1.6.4.1's
builtin-init-db.c; so far I haven't tried to build anything newer.  I
have a handful more patches which I apply as part of my build script,
but they're not relevant to this particular thread; I don't think any
of them interact with this one.)

--- OLD/builtin-init-db.c	Thu Jan  1 00:00:00 1970
+++ NEW/builtin-init-db.c	Thu Jan  1 00:00:00 1970
@@ -46,6 +46,8 @@
 	 * be really carefully chosen.
 	 */
 	safe_create_dir(path, 1);
+	path[baselen++] = '/';
+	template[template_baselen++] = '/';
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st_git, st_template;
 		int namelen;
@@ -75,8 +77,6 @@
 			int template_baselen_sub = template_baselen + namelen;
 			if (!subdir)
 				die_errno("cannot opendir '%s'", template);
-			path[baselen_sub++] =
-				template[template_baselen_sub++] = '/';
 			path[baselen_sub] =
 				template[template_baselen_sub] = 0;
 			copy_templates_1(path, baselen_sub,
@@ -127,10 +127,6 @@
 	if (PATH_MAX <= (template_len+strlen("/config")))
 		die("insanely long template path %s", template_dir);
 	strcpy(template_path, template_dir);
-	if (template_path[template_len-1] != '/') {
-		template_path[template_len++] = '/';
-		template_path[template_len] = 0;
-	}
 	dir = opendir(template_path);
 	if (!dir) {
 		warning("templates not found %s", template_dir);
@@ -138,7 +134,7 @@
 	}
 
 	/* Make sure that template is from the correct vintage */
-	strcpy(template_path + template_len, "config");
+	strcpy(template_path + template_len, "/config");
 	repository_format_version = 0;
 	git_config_from_file(check_repository_format_version,
 			     template_path, NULL);
@@ -155,8 +151,6 @@
 	}
 
 	memcpy(path, git_dir, len);
-	if (len && path[len - 1] != '/')
-		path[len++] = '/';
 	path[len] = 0;
 	copy_templates_1(path, len,
 			 template_path, template_len,
@@ -217,7 +211,7 @@
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	strcpy(path + len, "HEAD");
+	strcpy(path + len, "/HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
@@ -230,7 +224,7 @@
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	path[len] = 0;
-	strcpy(path + len, "config");
+	strcpy(path + len, "/config");
 
 	/* Check filemode trustability */
 	filemode = TEST_FILEMODE;
@@ -259,7 +253,7 @@
 	if (!reinit) {
 		/* Check if symlink is supported in the work tree */
 		path[len] = 0;
-		strcpy(path + len, "tXXXXXX");
+		strcpy(path + len, "/tXXXXXX");
 		if (!close(xmkstemp(path)) &&
 		    !unlink(path) &&
 		    !symlink("testing", path) &&
@@ -271,7 +265,7 @@
 
 		/* Check if the filesystem is case-insensitive */
 		path[len] = 0;
-		strcpy(path + len, "CoNfIg");
+		strcpy(path + len, "/CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
 	}
