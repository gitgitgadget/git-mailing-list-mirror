From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2 3/5] gitweb: Always use three argument form of open
Date: Mon, 11 May 2009 03:29:40 +0200
Message-ID: <200905110329.40666.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com> <200905100238.34838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 03:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3KL3-0003fp-Ga
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 03:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbZEKB3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755141AbZEKB3p
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 21:29:45 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33699 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbZEKB3o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 21:29:44 -0400
Received: by fxm2 with SMTP id 2so2399849fxm.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 18:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pugPHccNki1n111EBQb7E3w5xfgeHWQ+eCqjHJU2CU8=;
        b=n7pUeJ06WesaonHedIDMOkebaO5JDhc808AttboQB/EBomeTJ/kdWUq0emX3fLSNub
         YDf7dvLviAiLuHrSmJyNAB2y7m+eDoPb/cGfSCqiPkpfDRaOGFgMqVA8A4Vkz/dAU1Vt
         a3JIjAvQPyAK0GrhVG7wsGfLbZVyQf79hb190=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=R0OsAL4oMjaolfH5YWklUGdiuP33pELmvEpPBdtwFF026zgDv7Vu1dQDiAXjmStyPR
         s3LHzQo8M9RbbTta4oUEq7UQka+l/Y0XdHc8XCrMVYPhymNy+Pn8NJmIYfjFxKHz5qXX
         1IsuXsRxzwtV/DmylkSpddouz0W3W9h6LTiFE=
Received: by 10.86.91.16 with SMTP id o16mr5907499fgb.26.1242005383899;
        Sun, 10 May 2009 18:29:43 -0700 (PDT)
Received: from ?192.168.1.13? (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id e11sm3410062fga.26.2009.05.10.18.29.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 18:29:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100238.34838.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118767>

>From 94638fb6edf3ea693228c680a6a30271ccd77522 Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Mon, 11 May 2009 03:25:55 +0200
Subject: [PATCH] gitweb: Localize magic variable $/

Instead of undefining and then restoring magic variable $/ (input
record separator) for 'slurp mode', localize it.

While at it, state explicitely that "local $/;" makes it undefined, by
using explicit  "local $/ = undef;".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This also required correction. I am extremely sorry about that.
Below there is (whitespace mangled) interdiff to previous version

	diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
	index 76c0684..4efeeed 100755
	--- a/gitweb/gitweb.perl
	+++ b/gitweb/gitweb.perl
	@@ -4906,11 +4906,12 @@ sub git_tree {
	        }
	        die_error(404, "No such tree") unless defined($hash);
	 
	+       my @entries = ();
	        {
	                local $/ = "\0";
	                open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
	                        or die_error(500, "Open git-ls-tree failed");
	-               my @entries = map { chomp; $_ } <$fd>;
	+               @entries = map { chomp; $_ } <$fd>;
	                close $fd
	                        or die_error(404, "Reading tree failed");
	        }



 gitweb/gitweb.perl |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e7cab90..4efeeed 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3325,7 +3325,7 @@ sub git_get_link_target {
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or return;
 	{
-		local $/;
+		local $/ = undef;
 		$link_target = <$fd>;
 	}
 	close $fd
@@ -4800,11 +4800,10 @@ sub git_blob_plain {
 		-content_disposition =>
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
-	undef $/;
+	local $/ = undef;
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	$/ = "\n";
 	close $fd;
 }
 
@@ -4906,12 +4905,16 @@ sub git_tree {
 		}
 	}
 	die_error(404, "No such tree") unless defined($hash);
-	$/ = "\0";
-	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
-		or die_error(500, "Open git-ls-tree failed");
-	my @entries = map { chomp; $_ } <$fd>;
-	close $fd or die_error(404, "Reading tree failed");
-	$/ = "\n";
+
+	my @entries = ();
+	{
+		local $/ = "\0";
+		open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+			or die_error(500, "Open git-ls-tree failed");
+		@entries = map { chomp; $_ } <$fd>;
+		close $fd
+			or die_error(404, "Reading tree failed");
+	}
 
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $hash_base);
@@ -5806,7 +5809,7 @@ sub git_search {
 
 		print "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
-		$/ = "\n";
+		local $/ = "\n";
 		open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
 			'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
 			($search_use_regexp ? '--pickaxe-regex' : ());
@@ -5876,7 +5879,7 @@ sub git_search {
 		print "<table class=\"grep_search\">\n";
 		my $alternate = 1;
 		my $matches = 0;
-		$/ = "\n";
+		local $/ = "\n";
 		open my $fd, "-|", git_cmd(), 'grep', '-n',
 			$search_use_regexp ? ('-E', '-i') : '-F',
 			$searchtext, $co{'tree'};
-- 
1.6.3
