From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Always use three argument form of open
Date: Sun, 10 May 2009 02:38:34 +0200
Message-ID: <200905100238.34838.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x7P-0005rl-TS
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZEJAmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755396AbZEJAmA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:42:00 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:61361 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbZEJAly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 20:41:54 -0400
Received: by ewy24 with SMTP id 24so2659321ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DDe5Bk5GQWr3B9wGaaaaz1qp/u5YwQwxvvOQuuGFw7k=;
        b=MHkJbQkBAzbNZf4cSBmHnnnyUAqrSNTtyGJ76KXaY5/eJicUSGBus3SWlU0bGjW/x+
         3mKKYELOPSIfb5R4kiBhVp48dcOjCXM4jCQJE7dtxviIvo0J+avLMjkfJD0vr8c60k27
         0tNUHOKzGVveAOLHgmIRecka+hW2CvaCcAqtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=mneTxZfZr7b5h4jeWf26HKJWDAXAI5l+ax6LnDA4YC5g4dlhNE+d/3sQznbCf+K3EK
         OhFU7lv91nbNHE3oFp7ueBYSF2Miyl0kah8xCZsYCYk2h2rqMAh2/RnZCCI9HXy+0ye5
         KKCWMbOHXdhgrg8gdLXab8AS5Rf4wJEHluJOw=
Received: by 10.210.89.4 with SMTP id m4mr3073854ebb.76.1241916114166;
        Sat, 09 May 2009 17:41:54 -0700 (PDT)
Received: from ?192.168.1.13? (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 7sm4827142eyb.25.2009.05.09.17.41.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 17:41:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100203.51744.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118693>

In most cases (except insert_file() subroutine) we used old two argument
form of 'open' to open files for reading.  This can cause subtle bugs when
$projectroot or $projects_list file starts with mode characters ('>', '<',
'+<', '|', etc.) or with leading whitespace; and also when $projects_list
file or $mimetypes_file or ctags files end with trailing whitespace or '|'.

Additionally it is also more clear to explicitly state that we open those
files for reading.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Perl::Critic::Policy::InputOutput::ProhibitTwoArgOpen

  Write open $fh, q{<}, $filename; instead of open $fh, "<$filename";.

  The three-argument form of open (introduced in Perl 5.6) prevents subtle
  bugs that occur when the filename starts with funny characters like
  '>' or '<'.  It's also more explicitly clear to define the input mode of
  the file, and not to e.g. use open( $fh, 'foo.txt' );

See also Damian Conway's book "Perl Best Practices",
chapter "10.4. Opening Cleanly" (Use either the 'IO::File' module
or the three-argument form of 'open'.)


This patch _textually_ depends on the previous patch (no bareword
filehandles), even if _conceptually_ they are quite independent.

 gitweb/gitweb.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9daa1d..852beb6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2050,7 +2050,7 @@ sub git_get_project_description {
 	my $path = shift;
 
 	$git_dir = "$projectroot/$path";
-	open my $fd, "$git_dir/description"
+	open my $fd, '<', "$git_dir/description"
 		or return git_get_project_config('description');
 	my $descr = <$fd>;
 	close $fd;
@@ -2069,7 +2069,7 @@ sub git_get_project_ctags {
 		return $ctags;
 	}
 	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
-		open my $ct, $_ or next;
+		open my $ct, '<', $_ or next;
 		my $val = <$ct>;
 		chomp $val;
 		close $ct;
@@ -2129,7 +2129,7 @@ sub git_get_project_url_list {
 	my $path = shift;
 
 	$git_dir = "$projectroot/$path";
-	open my $fd, "$git_dir/cloneurl"
+	open my $fd, '<', "$git_dir/cloneurl"
 		or return wantarray ?
 		@{ config_to_multi(git_get_project_config('url')) } :
 		   config_to_multi(git_get_project_config('url'));
@@ -2187,7 +2187,7 @@ sub git_get_projects_list {
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
 		my %paths;
-		open my ($fd), $projects_list or return;
+		open my $fd, '<', $projects_list or return;
 	PROJECT:
 		while (my $line = <$fd>) {
 			chomp $line;
@@ -2250,7 +2250,7 @@ sub git_get_project_list_from_file {
 	# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 	# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
 	if (-f $projects_list) {
-		open (my $fd , $projects_list);
+		open(my $fd, '<', $projects_list);
 		while (my $line = <$fd>) {
 			chomp $line;
 			my ($pr, $ow) = split ' ', $line;
@@ -2804,7 +2804,7 @@ sub mimetype_guess_file {
 	-r $mimemap or return undef;
 
 	my %mimemap;
-	open(my $mh, $mimemap) or return undef;
+	open(my $mh, '<', $mimemap) or return undef;
 	while (<$mh>) {
 		next if m/^#/; # skip comments
 		my ($mimetype, $exts) = split(/\t+/);
-- 
1.6.3
