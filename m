From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH 4/6] Add check_repo_format check for all major operations.
Date: Tue, 22 Nov 2005 15:55:23 +0300
Organization: digital Solutions
Message-ID: <200511221555.24572.matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com> <113261929333-git-send-email-matlads@dsmagic.com> <7vlkzhf5li.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 13:58:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeXh7-0005dA-ND
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 13:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVKVM4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 07:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVKVM4P
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 07:56:15 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:34564 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964936AbVKVM4O
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 07:56:14 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 886F2524E; Tue, 22 Nov 2005 15:57:18 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.54)
	id 1EeXgD-0004FZ-Ho; Tue, 22 Nov 2005 15:55:25 +0300
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7vlkzhf5li.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12545>

On Tuesday 22 November 2005 11:29, Junio C Hamano wrote:
> Martin Atukunda <matlads@dsmagic.com> writes:
> > The git-* command set uses 3 entry points in order to prepare
> > to work with a git repo: enter_repo, get_git_dir, and obviously
> > setup_git_directory.
>
> Thanks, but I think this one is wrong.
<snip>
> In setup_git_env() you have only read GIT_DIR environment but
> have not done the toplevel discovery.  Especially, this is
> called from get_git_dir(), and you call that as the first thing
> as setup_git_directory().  However, that function is supposed to
> be callable by processes that are in a subdirectory, without
> GIT_DIR explicitly specified, and the place get_git_dir() is
> called in that function is way before the discovery of the
> toplevel happens.  Until then, you do not know where your .git/
> directory or .git/config file is. If you start in Documentation
> subdirectory in git project, your setup_git_directory() would
> first call get_git_dir(), which says "I assume the config file
> is at ./.git/config -- oh there is no such thing".  At that
> point you are checking Documentation/.git/config.
>
> It would happen to work because you intend to allow version 0
> repository for any future version of tool, and even if this
> codepath mistakenly thinks the repository is version 0, it does
> not hurt, as long as your setup_git_directory() calls
> check_repo_format again after doing the toplevel discovery and
> checks the true .git/config file, but I do not think you have
> that call in the current series yet.  Even if you had, this does
> not feel quite right to me.

would something like the following apply in this case: (totally untested :)

--

Add check_repo_format check for setup_git_directory(). This check needs
to be done in 2 cases in this function. first if GIT_DIR is set, and also
after the top_level directory is found.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

diff --git a/setup.c b/setup.c
index 44b9866..45e716a 100644
--- a/setup.c
+++ b/setup.c
@@ -101,8 +101,11 @@ const char *setup_git_directory(void)
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery
 	 */
-	if (getenv(GIT_DIR_ENVIRONMENT))
+	if (getenv(GIT_DIR_ENVIRONMENT)) {
+		get_git_dir(1);
+		check_repo_format();
 		return NULL;
+	}
 
 	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
 		die("Unable to read current working directory");
@@ -118,6 +121,8 @@ const char *setup_git_directory(void)
 		} while (cwd[--offset] != '/');
 	}
 
+	check_repo_format();
+
 	if (offset == len)
 		return NULL;
 
