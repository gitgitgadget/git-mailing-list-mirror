From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
Date: Sat, 11 Feb 2012 14:02:30 +0100
Message-ID: <201202111402.31684.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <CA+EqV8xiLYo8XE--c1QfuXdhentUFpHqfPYXHt72eCpEA_hCNQ@mail.gmail.com> <201202092114.40832.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 14:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwCbD-0003Un-RO
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 14:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab2BKNCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 08:02:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62089 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab2BKNCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 08:02:37 -0500
Received: by eaah12 with SMTP id h12so1199928eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 05:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/droxIgwbi8RMm2PdgWHTN0hcn8ODE4+DXsBVhjDBBo=;
        b=LEzyrQ6ehQ5BYUbPqzNEQsDlAogAjn90mV5i4zaRn2EpuR0ryVzt2YcnRchQBvx8Q+
         yCwDHrQmyygsUqk4GW8Zldk9aRHFgM5btGHVMv5VvWKSyXz9ME4rFIjOogXKHztYATJ2
         90xm0CldJY8uMIKKhNMVaQdeNvDO7dGjbiQg8=
Received: by 10.213.8.133 with SMTP id h5mr917133ebh.13.1328965355928;
        Sat, 11 Feb 2012 05:02:35 -0800 (PST)
Received: from [192.168.1.13] (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id n56sm35030119eeh.6.2012.02.11.05.02.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 05:02:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201202092114.40832.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190511>

On Thu, 9 Feb 2012, Jakub Narebski wrote:
> On Wed, 8 Feb 2012, rajesh boyapati wrote:
> > 2012/2/8 Jakub Narebski <jnareb@gmail.com>
>  
> [...]
> > > Does the following patch help, and does it fix the issue?
> > >
> > > (Nb. you can try to simply change filename, and apply it with fuzz
> > > against index.cgi file).
> > > -- >8 -- ----- ----- ----- ----- ----- -- >8 --
> > > From: Jakub Narebski <jnareb@gmail.com>
> > > Subject: [PATCH] gitweb: Harden parse_commit and parse_commits
> [...]
> > When I applied the above patch and also the patch from your previous
> > e-mail, I am getting this error
> > >>>>>>>>>>>>>
> > [2012-02-08 14:09:58,396] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> > 'HEAD'
> > [2012-02-08 14:10:06,732] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> > 'HEAD'
> > [2012-02-08 14:10:11,404] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> > 'HEAD'
> > [2012-02-08 14:10:15,270] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: Not a valid
> > object name HEAD
> > <<<<<<<<<<<<<<
> > With these patches, the previous errors at line numbers are gone.
> 
> Thanks for information.
> 
> 
> This final issue will be a bit harder to fix.  This error message
> 
>   fatal: bad revision 'HEAD'
> 
> comes from git (I think from "git rev-list" command), and not from gitweb.
> It is printed on STDERR of git command.  What has to be done to fix it is
> to capture stderr of a process, or silence it.
> 
> Unfortunately it is not that easy.  We use list form of open, which avoids
> using a shell interpreter to run command, and is safer wrt. shell escaping.
> 
> The only place where gitweb cares about redirecting standard error from git
> command is git_object().  It is a bit hacky, and might be not entirely safe.
> To fix this issue we would have to do the same in parse_commit*() as in
> git_object(), or provide some kind of wrapper like IPC::Run provides
> for redirecting stderr of called command.
> 
> Note that this issue was not considered very important, because this message
> doesn't goes into web server logs when running gitweb via mod_cgi with
> Apache... and probably also with other web servers.  Gerrit (or rather
> whatever it uses for serving CGI scripts) might be exception here.

Anyway, here is the patch that should fix those "CGI: fatal: Not a valid
object name HEAD" errors for you.

I'll resend the all the patches as single patch series for inclusion in
git, but I am not sure if this latest patch will be accepted because of
drawbacks of its implementation.

-- >8 ---- ----- ----- ----- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines

git-rev-list command in parse_commit() and parse_commits() can fail
because $commit_id doesn't point to a valid commit; for example if we
are on unborn branch HEAD doesn't point to a valid commit.

In this case git-rev-list prints

  fatal: bad revision 'HEAD'

on its standard error.  This commit silences this warning, at the cost
of using shell to redirect it to /dev/null, and relying on
quote_command() to protect against code injection.

Note however that such error message from git (from extrenal command)
usually but not always does not appear in web server logs.

Reported-by: rajesh boyapati <boyapatisrajesh@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1181aeb..081ac45 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3338,12 +3338,13 @@ sub parse_commit {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "rev-list",
+	open my $fd, "-|", quote_command(
+		git_cmd(), "rev-list",
 		"--parents",
 		"--header",
 		"--max-count=1",
 		$commit_id,
-		"--",
+		"--") . ' 2>/dev/null',
 		or die_error(500, "Open git-rev-list failed");
 	my $commit_text = <$fd>;
 	%co = parse_commit_text($commit_text, 1)
@@ -3363,7 +3364,8 @@ sub parse_commits {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "rev-list",
+	open my $fd, "-|", quote_command(
+		git_cmd(), "rev-list",
 		"--header",
 		@args,
 		("--max-count=" . $maxcount),
@@ -3371,7 +3373,7 @@ sub parse_commits {
 		@extra_options,
 		$commit_id,
 		"--",
-		($filename ? ($filename) : ())
+		($filename ? ($filename) : ())) . ' 2>/dev/null'
 		or die_error(500, "Open git-rev-list failed");
 	while (my $line = <$fd>) {
 		my %co = parse_commit_text($line);
-- 
1.7.9
