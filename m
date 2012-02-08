From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Harden parse_commit and parse_commits
Date: Wed, 8 Feb 2012 16:04:16 +0100
Message-ID: <201202081604.17187.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <CA+EqV8w6k2VrEtMydhGKZHbQdXHxCE3WA_0rtS-AY4cmQvii=A@mail.gmail.com> <201202071753.12436.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 16:04:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv94L-00048S-3o
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 16:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab2BHPEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 10:04:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45433 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab2BHPET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 10:04:19 -0500
Received: by eaah12 with SMTP id h12so204635eaa.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EsUVnMmIcTzx+hDSMpei2yJ63XMoh/vFcW60QcrQ31s=;
        b=Lvn95ES1esV05h6/rnNx42vsXXNGaG54v91mBHEYhCwEX3EciDurYAousNsz1cvz2B
         kuwf7NcCqMpAZhxFQhvNxl3Ec/01Lw+31poG4Y9Z2IRdIlR4xTwfJLfuQfBtS2KVPu0X
         rIJwH0awvhO+EMRGqGH30/EEMIeou1hqg8lsA=
Received: by 10.14.126.68 with SMTP id a44mr8650804eei.101.1328713458493;
        Wed, 08 Feb 2012 07:04:18 -0800 (PST)
Received: from [192.168.1.13] (abvr119.neoplus.adsl.tpnet.pl. [83.8.215.119])
        by mx.google.com with ESMTPS id c16sm6092728eei.1.2012.02.08.07.04.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 07:04:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201202071753.12436.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190237>

On Tue, 7 Feb 2012, Jakub Narebski wrote:
> On Mon, 6 Feb 2012, rajesh boyapati wrote:
[...]
> > Then, I restarted gerrit server to take changes.
> > Now the error log of gerrit shows:
> 
> > [2012-02-06 11:21:46,726] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> > 'HEAD'
> > [2012-02-06 11:21:49,167] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Mon Feb  6 11:21:49
> > 2012] gitweb.cgi: Use of uninitialized value $commit_id in open at
> > /usr/lib/cgi-bin/gitweb.cgi line 2817.
> > [2012-02-06 11:21:49,169] ERROR
> > com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision ''
> [the same errors repeated few times]
> 
> > <<<<<<<<<<<<<<<<
> > Previously, there is a error showing at line 4720. Now, with this patch,
> > that error has gone.
> 
> As I said I was able to find a fix only for part of the issue.  
> Unfortunately I was not able to reproduce this error in this form.
> Note that the error location doesn't help much, because it is more
> interesting for find which callers of parse_commits() pass undefined
> $commit_id.
> 
> I can try to harden parse_commits() against bogus parameters; maybe
> this would help.

Does the following patch help, and does it fix the issue?

(Nb. you can try to simply change filename, and apply it with fuzz
against index.cgi file).
-- >8 -- ----- ----- ----- ----- ----- -- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Harden parse_commit and parse_commits

Gitweb has problems and gives errors when repository it shows is on
unborn branch (HEAD doesn't point to a valid commit), but there exist
other branches.

One of errors that shows in gitweb logs is undefined $commit_id in
parse_commits() subroutine.  Therefore we harden both parse_commit()
and parse_commits() against undefined $commit_id, and against no
output from git-rev-list because HEAD doesn't point to a commit.

Reported-by: rajesh boyapati <boyapatisrajesh@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f9535eb..1181aeb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3334,6 +3334,8 @@ sub parse_commit {
 	my ($commit_id) = @_;
 	my %co;
 
+	return unless defined $commit_id;
+
 	local $/ = "\0";
 
 	open my $fd, "-|", git_cmd(), "rev-list",
@@ -3343,7 +3345,9 @@ sub parse_commit {
 		$commit_id,
 		"--",
 		or die_error(500, "Open git-rev-list failed");
-	%co = parse_commit_text(<$fd>, 1);
+	my $commit_text = <$fd>;
+	%co = parse_commit_text($commit_text, 1)
+		if defined $commit_text;
 	close $fd;
 
 	return %co;
@@ -3353,6 +3357,7 @@ sub parse_commits {
 	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
 	my @cos;
 
+	return unless defined $commit_id;
 	$maxcount ||= 1;
 	$skip ||= 0;
 
-- 
1.7.9
