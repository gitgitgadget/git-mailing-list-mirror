From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn dcommit ignores --username if there are cached
	credentials
Date: Tue, 12 Jan 2010 21:41:38 -0800
Message-ID: <20100113054138.GB23182@dcvr.yhbt.net>
References: <loom.20100112T233835-324@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michel Jouvin <jouvin@lal.in2p3.fr>
X-From: git-owner@vger.kernel.org Wed Jan 13 06:41:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUvzF-0006GT-8t
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 06:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab0AMFll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 00:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281Ab0AMFlj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 00:41:39 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57573 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab0AMFlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 00:41:39 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853911F50B;
	Wed, 13 Jan 2010 05:41:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20100112T233835-324@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136770>

Michel Jouvin <jouvin@lal.in2p3.fr> wrote:
> Hi,
> 
> I am new to Git and using 1.6.6. I'm very interested by using it to mirror SVN 
> repositories. But I am running into troubles with the way git-svn handles SVN 
> credentials. 
> 
> For one SVN I use I have some cached credentials that have only very restricted 
> write access. With svn command, I am using --username for every commit and this 
> cached credential is just ignored: I'm asked for a password.
> 
> With git-svn, I use --username at init/fetch but during dcommit --username is 
> ignored becaused of the cached credential. I can see in SVN logs that the 
> cached credential (which doesn't have the right to commit the mods I made) has 
> been used instead of the one specified during fetch. If I removed the cached 
> credential, the username specified with --username is taken into account (I'm 
> asked a password for it and it works) and if I ommit the --username, the one 
> specified at fetch time is used.
> 
> IMO, looks like a bug... Thanks in advance for any comment.
 
Hi Michel,

I wonder if this is because we explicitly reread the config directory
when creating Git::SVN::Editor.

Does using --no-auth-cache work for you?

Otherwise, try pointing --config-dir= to an empty directory.

Or you can try this patch to force us to not reread the config_dir:

diff --git a/git-svn.perl b/git-svn.perl
index 650c9e5..280fd15 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -550,9 +550,6 @@ sub cmd_dcommit {
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
 			                ra => Git::SVN::Ra->new($url),
-			                config => SVN::Core::config_get_config(
-			                        $Git::SVN::Ra::config_dir
-			                ),
 			                tree_a => "$d~1",
 			                tree_b => $d,
 			                editor_cb => sub {

We have a good reason to read config dirs there for getting auto-props,
though, so the above patch isn't going into git.git

-- 
Eric Wong
