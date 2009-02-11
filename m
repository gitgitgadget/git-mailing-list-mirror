From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 20:42:25 +0200
Message-ID: <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211180559.GC19749@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK3v-0006GE-Q4
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894AbZBKSm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756765AbZBKSm2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:42:28 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:63878 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbZBKSm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:42:27 -0500
Received: by bwz5 with SMTP id 5so489985bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jTUwbnXCG1pHkgG0x3Lxdfl3+M/9r+Nrd+EoILKTpEQ=;
        b=HSJqqINU7PTBEy/BafrAUhNjnIk+mehGGWsKu9/+7jOnhCPH0c7AimUhIwhRcQ4oIe
         /31kKCA7f7TZB6BDBMQhBuK3g9k6axqNvlicCRJMWhrvdIKoTkG+07Okd4Brje1jqCwJ
         ab23IXta+5gP+vdxrHMmPZnsKxf/ffnOwqgVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4HYT1b/Txw8qHBBZeqXT1angk+L24/CRHdA/mN3FV3PegUF0VZ2XfyIqogu3KxCYd
         n3sQfC4RjMm9uoJmxOnCboECWWs5mIpxMF5Ps1oSQQI+6DEFCjY4TkRxDH7szQ+9/9bm
         qzaqJM74xiOxJFr6DmTioa1/yejoOaMJ8DyKw=
Received: by 10.181.159.11 with SMTP id l11mr20310bko.186.1234377745221; Wed, 
	11 Feb 2009 10:42:25 -0800 (PST)
In-Reply-To: <20090211180559.GC19749@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109496>

On Wed, Feb 11, 2009 at 8:05 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 11, 2009 at 06:24:29PM +0200, Ciprian Dorin, Craciun wrote:
>
>>    15  git push file:///tmp/r2 master
>> Counting objects: 3, done.
>> Writing objects: 100% (3/3), 197 bytes, done.
>> Total 3 (delta 0), reused 0 (delta 0)
>> error: unpack should have generated
>> ea8c5601f49a4bdeea03db3adb909d590ea730d3, but I can't find it!
>> To file:///tmp/r2
>>  ! [remote rejected] master -> master (bad pack)
>> error: failed to push some refs to 'file:///tmp/r2'
>
> I can't reproduce the problem here. It looks like your receive-pack is
> somehow broken (which should be the only difference between pushing to a
> local repo and a remote one).
>
> Can you try with a vanilla version of git to be sure it is not your
> add-on patch responsible?
>
> -Peff

    Indeed it seems it's from my patch... Because with a vanila
1.6.1.1 it works perfectly... I'll dig into what I've done, although I
couldn't imagine that it was from my patch...

    For now I see that the problem comes from the function
setup_git_directory_gentry which I call inside the setup_path function
in exec_cmd.c
    Can someone help? (My patch is below...)

    Thanks,
    Ciprian Craciun.

--------

diff --git a/exec_cmd.c b/exec_cmd.c
index cdd35f9..1513ee0 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -44,6 +44,44 @@ const char *git_exec_path(void)
 	return system_path(GIT_EXEC_PATH);
 }

+/* Returns the path of the bin folder inside the .git folder. */
+/* (This could be used to store repository specific git programs.) */
+const char *git_repo_exec_path(void)
+{
+	static char path_buffer[PATH_MAX + 1];
+	static char *path = NULL;
+	
+	int non_git;
+	const char *git_dir;
+	char cwd[PATH_MAX + 1];
+	
+	if (!path) {
+		
+		path = path_buffer;
+		path[0] = '\0';
+		
+		if (!getcwd(cwd, PATH_MAX))
+			die("git_repo_exec_path: can not getcwd");
+		
+		setup_git_directory_gently(&non_git);
+		
+		if (!non_git) {
+			
+			git_dir = get_git_dir();
+			strncat(path, git_dir, PATH_MAX);
+			strncat(path, "/", PATH_MAX);
+			strncat(path, "bin", PATH_MAX);
+			
+			strncpy(path, make_absolute_path(path), PATH_MAX);
+			
+			if (chdir(cwd))
+				die("git_repo_exec_path: can not chdir to '%s'", cwd);
+		}
+	}
+	
+	return path;
+}
+
 static void add_path(struct strbuf *out, const char *path)
 {
 	if (path && *path) {
@@ -61,6 +99,7 @@ void setup_path(void)
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;

+	add_path(&new_path, git_repo_exec_path());
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
 	add_path(&new_path, system_path(GIT_EXEC_PATH));
