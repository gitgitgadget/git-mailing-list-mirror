From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Do not use bareword filehandles
Date: Sun, 10 May 2009 02:36:19 +0200
Message-ID: <200905100236.20158.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x7P-0005rl-9s
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbZEJAl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZEJAl5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:41:57 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:54999 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbZEJAly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 20:41:54 -0400
Received: by ewy24 with SMTP id 24so2659320ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zd3jWUlEv80KqVR54TbTQkZ1C74s9/qaX246Ezc59GE=;
        b=UjxYM5u1jFbw0VNUdIixe4uFqHbYQcl/ZzV0DVRpz7GcInZCGWEwczhup+D6AO2RSY
         4LK3O6NWUlacO4aHTWR2DLSXLw/35Rn7OA9BVw5Wx8boNedF/PC7l1h2vat55VNDXBUl
         nfYs+TrGgX2tudSzVOTXTCXSpiK9pzPPQnGco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=luY1W9kEacW7dMdJ4XeDROOZ98AO8ILp/UMtYwGh+MAjwqcqXam/CjgcK9IJ+9KmeV
         nIRQUNx6X8tKKn7TDs4SYnP56r8ajOwgAA2lD9fAmefou4Ncr6Zq9r+dep3qCO177GgN
         NB2oEVmIvzsozl9f3ov3N7e6pMrA8EX9ZAHvY=
Received: by 10.210.60.3 with SMTP id i3mr3082361eba.87.1241916113302;
        Sat, 09 May 2009 17:41:53 -0700 (PDT)
Received: from ?192.168.1.13? (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 7sm4827142eyb.25.2009.05.09.17.41.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 17:41:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100203.51744.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118694>

The script was using bareword filehandles.  This is considered a bad
practice so they have been changed to indirect filehandles.
Changes touch git_get_project_ctags and mimetype_guess_file.

While at it rename local variable from $mime to $mimetype (in
mimetype_guess_file) to better reflect its value (its contents).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Perl::Critic::Policy::InputOutput::ProhibitBarewordFileHandles

  Write open my $fh, q{<}, $filename; instead of open FH, q{<}, $filename;.

  Using bareword symbols to refer to file handles is particularly evil
  because they are global, and you have no idea if that symbol already
  points to some other file handle. You can mitigate some of that risk by
  'local'izing the symbol first, but that's pretty ugly. Since Perl 5.6, you
  can use an undefined scalar variable as a lexical reference to an
  anonymous filehandle.

See also Damian Conway's book "Perl Best Practices",
chapter "10.1. Filehandles" (Don't use bareword filehandles.)


This follows similar patch for git-send-email.perl by Bill Pemberton
http://permalink.gmane.org/gmane.comp.version-control.git/117886

CC-ed Pasky, who is responsible for code in both cases...

 gitweb/gitweb.perl |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 06e9160..a9daa1d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2065,18 +2065,18 @@ sub git_get_project_ctags {
 	my $ctags = {};
 
 	$git_dir = "$projectroot/$path";
-	unless (opendir D, "$git_dir/ctags") {
+	unless (opendir my $dh, "$git_dir/ctags") {
 		return $ctags;
 	}
-	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir(D)) {
-		open CT, $_ or next;
-		my $val = <CT>;
+	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
+		open my $ct, $_ or next;
+		my $val = <$ct>;
 		chomp $val;
-		close CT;
+		close $ct;
 		my $ctag = $_; $ctag =~ s#.*/##;
 		$ctags->{$ctag} = $val;
 	}
-	closedir D;
+	closedir $dh;
 	$ctags;
 }
 
@@ -2804,18 +2804,18 @@ sub mimetype_guess_file {
 	-r $mimemap or return undef;
 
 	my %mimemap;
-	open(MIME, $mimemap) or return undef;
-	while (<MIME>) {
+	open(my $mh, $mimemap) or return undef;
+	while (<$mh>) {
 		next if m/^#/; # skip comments
-		my ($mime, $exts) = split(/\t+/);
+		my ($mimetype, $exts) = split(/\t+/);
 		if (defined $exts) {
 			my @exts = split(/\s+/, $exts);
 			foreach my $ext (@exts) {
-				$mimemap{$ext} = $mime;
+				$mimemap{$ext} = $mimetype;
 			}
 		}
 	}
-	close(MIME);
+	close($mh);
 
 	$filename =~ /\.([^.]*)$/;
 	return $mimemap{$1};
-- 
1.6.3
