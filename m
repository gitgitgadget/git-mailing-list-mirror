From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] gitweb: quote commands properly when calling the shell
Date: Tue, 17 Jun 2008 23:46:35 +0200
Message-ID: <1213739195-29284-1-git-send-email-LeWiemann@gmail.com>
References: <7vd4mg9824.fsf@gitster.siamese.dyndns.org>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 23:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8j1q-0006FJ-Qz
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbYFQVql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbYFQVql
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:46:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:23911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbYFQVqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:46:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3675443fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=BMiyx45JTRAbU9oQKZ7RJYXwXZMYaH3OISpThfhQGZ8=;
        b=uNfLlGvVuIaE76kvrB+u19sC9wUdXQnUhqv2yrGb3U6s+7puGyrH3pr5aSaxRxmNrD
         vyLPicJqd+A13PZEpoTS+EE4xNO3dT/pGOrjMnQxqMPTvMSff1dPJ0PFAFvv/WKqQtBt
         kuehsnMBUIE4q0wNjZDVi1EXIcEsyseIDgHaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=ijFQE23XInXQiCo0wDYjDFCJzXEGhuSWyhn8lHeppygOff7J7V42bXe40+3Mb0bPMt
         6aDJQM1fTIO1yzvvuxYRXsDw79bMtv/EDdsElqkq9efFro8s8FPuaHvXq/csKjRVHsIX
         7aB1gTq6XTZqFckrGeiMpK9ucdhqva9yxB5XI=
Received: by 10.78.179.3 with SMTP id b3mr3328979huf.80.1213739196503;
        Tue, 17 Jun 2008 14:46:36 -0700 (PDT)
Received: from fly ( [91.33.241.48])
        by mx.google.com with ESMTPS id 39sm11543922hug.5.2008.06.17.14.46.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 14:46:35 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8j0d-0007dK-55; Tue, 17 Jun 2008 23:46:35 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
In-Reply-To: <7vd4mg9824.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85327>

This eliminates the function git_cmd_str, which was used for composing
command lines, and adds a quote_command function, which quotes all of
its arguments (as in quote.c).

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changed since v1: Quote the whole command line, safely.

I've tested that the object and snapshot actions still work (which is
where git_cmd_str was used), and I've hand-tested the quote_command
function.  *wait-for-test-suite-to-appear-in-later-revisions*

Hope this addresses your concerns, Junio!

-- Lea


 gitweb/gitweb.perl |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7b1b076..3a7adae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1500,9 +1500,13 @@ sub git_cmd {
 	return $GIT, '--git-dir='.$git_dir;
 }
 
-# returns path to the core git executable and the --git-dir parameter as string
-sub git_cmd_str {
-	return join(' ', git_cmd());
+# quote the given arguments for passing them to the shell
+# quote_command("command", "arg 1", "arg with ' and ! characters")
+# => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
+# Try to avoid using this function wherever possible.
+sub quote_command {
+	return join(' ',
+		    map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
 }
 
 # get HEAD ref of given project as hash
@@ -4493,7 +4497,6 @@ sub git_snapshot {
 		$hash = git_get_head_hash($project);
 	}
 
-	my $git_command = git_cmd_str();
 	my $name = $project;
 	$name =~ s,([^/])/*\.git$,$1,;
 	$name = basename($name);
@@ -4501,11 +4504,12 @@ sub git_snapshot {
 	$name =~ s/\047/\047\\\047\047/g;
 	my $cmd;
 	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
-	$cmd = "$git_command archive " .
-		"--format=$known_snapshot_formats{$format}{'format'} " .
-		"--prefix=\'$name\'/ $hash";
+	$cmd = quote_command(
+		git_cmd(), 'archive',
+		"--format=$known_snapshot_formats{$format}{'format'}",
+		"--prefix=$name/", $hash);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
-		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
+		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
 
 	print $cgi->header(
@@ -4718,8 +4722,8 @@ sub git_object {
 	if ($hash || ($hash_base && !defined $file_name)) {
 		my $object_id = $hash || $hash_base;
 
-		my $git_command = git_cmd_str();
-		open my $fd, "-|", "$git_command cat-file -t $object_id 2>/dev/null"
+		open my $fd, "-|", quote_command(
+			git_cmd(), 'cat-file', '-t', $object_id) . ' 2> /dev/null'
 			or die_error('404 Not Found', "Object does not exist");
 		$type = <$fd>;
 		chomp $type;
-- 
1.5.6.rc3.7.ged9620
