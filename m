From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] diff/status: print submodule path when looking for changes
 fails
Date: Wed, 07 Dec 2011 22:50:14 +0100
Message-ID: <4EDFDF96.9030601@web.de>
References: <201112061930.pB6JUuDx004171@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPNk-0003zB-1D
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486Ab1LGVuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:50:22 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:49412 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758467Ab1LGVuV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:50:21 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id B26A91AB3EF9A
	for <git@vger.kernel.org>; Wed,  7 Dec 2011 22:50:19 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LqUKH-1QuNaq2VwP-00eJGT; Wed, 07 Dec 2011 22:50:18
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <201112061930.pB6JUuDx004171@no.baka.org>
X-Provags-ID: V02:K0:zz5nrlgtxXkrtmTk5CNp72pecmBk8rcVeIoL/Ytbg8g
 uLbtS5jIP9SPdY0zVNBsxocQtJ/c+MLnq2eTFIkKiWmc3Eee0N
 5ANvB+RUvCcaswIgMD1XIpyOkIEyUn44accA6RNZL8moDpkXjO
 OvRZINCmXfJZcFDjDQqs/DURC8Se9WoiZNWPM4qcHY8/790RrL
 kZC5DxusSYPxZgz0KpHmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186502>

diff and status run "git status --porcelain" inside each populated
submodule to see if it contains changes (unless told not to do so via
config or command line option). When that fails, e.g. due to a corrupt
submodule .git directory, it just prints "git status --porcelain failed"
or "Could not run git status --porcelain" without giving the user a clue
where that happened.

Add '"in submodule %s", path' to these error strings to tell the user
where exactly the problem occurred.

Reported-by: Seth Robertson <in-gitvger@baka.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 06.12.2011 20:30, schrieb Seth Robertson:
> Someone on #git just encountered a problem where `git init && git add . &&
> git status` was failing with a message about a corrupted index.
> 
>     error: bad index file sha1 signature
>     fatal: index file corrupt
>     fatal: git status --porcelain failed
> 
> This confused everyone for a while, until he provided access to the
> directory to play with.  I eventually tracked it down to a directory
> in the tree which already had a .git directory in it.  Unfortunately,
> that .git repo was corrupted and was the one returning the message
> about a corrupted index.  The problem is that the error message we
> were seeing did not provide any direct hints that submodules were
> involved or that the problem was not at the top level (`git status
> --porcelain` is admittedly an indirect hint to both).  Here is a
> recipe to reproduce a similar problem:
> 
> (mkdir -p z/foo; cd z/foo; git init; echo A>A; git add A; git commit -m A; cd ..; echo B>B; rm -f foo/.git/objects/*/*; git init; git add .; git status)

Thanks for the report and the recipe to reproduce it.

> Providing an expanded error message which clarifies that this is
> failing in a submodule directory makes everything clear.
> 
> ----------------------------------------------------------------------
> --- submodule.c~	2011-12-02 14:25:08.000000000 -0500
> +++ submodule.c	2011-12-06 14:13:00.554413432 -0500
> @@ -714,7 +714,7 @@
>  	close(cp.out);
>  
>  	if (finish_command(&cp))
> -		die("git status --porcelain failed");
> +		die("git status --porcelain failed in submodule directory %s", path);
>  
>  	strbuf_release(&buf);
>  	return dirty_submodule;
> ----------------------------------------------------------------------

Makes lots of sense.

> Do more error messages in submodule.c need adjusting?  It seems likely.

It looks like only the die() after the start_command() in the same
is_submodule_modified() function would also need to print the path.

The only other place that dies after starting a command inside a
submodule is in submodule_needs_pushing(), and it already says:
	die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
	...
So let's do the same in is_submodule_modified().


 submodule.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 52cdcc6..68c1ba9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -689,7 +689,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run git status --porcelain");
+		die("Could not run 'git status --porcelain' in submodule %s", path);

 	len = strbuf_read(&buf, cp.out, 1024);
 	line = buf.buf;
@@ -714,7 +714,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	close(cp.out);

 	if (finish_command(&cp))
-		die("git status --porcelain failed");
+		die("'git status --porcelain' failed in submodule %s", path);

 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
1.7.8.111.gd3732
