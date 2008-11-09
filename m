From: "Joe MacDonald" <joe.macdonald@gmail.com>
Subject: [PATCH] git send-email: add --body option for --compose
Date: Sun, 9 Nov 2008 10:29:23 -0500
Message-ID: <840404080811090729t5933f3a4gc2be71d655d6ea21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Nov 09 16:30:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzCFS-0002pg-TK
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 16:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbYKIP30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 10:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755051AbYKIP30
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 10:29:26 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:17789 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbYKIP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 10:29:25 -0500
Received: by an-out-0708.google.com with SMTP id d40so191493and.1
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=keuXGLngKDzjLyx0gN1bDbAmBs3ddjXlXn0NhTbtR4I=;
        b=ldzOiX6apnrueKHMB5p1E1/bIKv1r3A5NTJyFLCTDcUJdCN0cDvFW4Iw3SS1JVYgyL
         T7h0uVrJUj5DTXCVC3mFJDS/BKz+jp7Y3jEr1cnXTohdY6gVVGRruAVveaMS9rzX3Uzj
         i8gJd9C1vlPoOykskardmhQj4fh+/kPDDorug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oPt9jSuS9yEbQqcj7IyJ1lyycRB/auQ07pGkmMwBili7pSoajuACGu3FFKltFQkeDX
         MaHHEU3C0p/tv0B4If/KmXQ2GFoeXFrl16PoBSvf8O+8lN2J8+WXLQaUR+rYBPZy3M/a
         kpOvrxHjqSHNqr2FEPMZC2HbgYePY+QDZQH48=
Received: by 10.100.190.14 with SMTP id n14mr1320155anf.19.1226244564023;
        Sun, 09 Nov 2008 07:29:24 -0800 (PST)
Received: by 10.101.67.11 with HTTP; Sun, 9 Nov 2008 07:29:23 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100450>

If the --compose option is specified, --body will allow you to specify a
file that should be included in the message body when the editor starts
up.

Signed-off-by: Joe MacDonald <joe.macdonald@gmail.com>
---
I use --compose with nearly all of my send-email bundles, but
immediately after I enter the editor I read in the contents of another
text file that contains boilerplate text.  So I modified
git-send-email.perl to take a new option --body, which takes a filename
as an argument and appends the contents of that file to the standard
text that send-email normally puts into the .msg.$$ (or whatever file is
pointed to by $compose_filename).

I suppose this is even a step closer to having a batch version of
send-email that will include an introduction email in the patch thread,
but I don't know that such a thing is really useful to anyone.  It would
be for me, but I might be a special case (or at least a minority) in
that.

 git-send-email.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94ca5c8..17120d3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -48,6 +48,7 @@ git send-email [options] <file | directory>...
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --compose                      * Open an editor for introduction.
+    --body                  <str>  * Initial body for the introduction.

   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -156,6 +157,7 @@ my ($smtp_server, $smtp_server_port,
$smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate);
 my (@suppress_cc);
+my ($compose_body);

 my %config_bool_settings = (
     "thread" => [\$thread, 1],
@@ -222,6 +224,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "identity=s" => \$identity,
 		    "compose" => \$compose,
+		    "body=s" => \$compose_body,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
@@ -483,7 +486,11 @@ if (!defined $smtp_server) {
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
-	open(C,">",$compose_filename)
+	if ($compose_body) {
+		open(CB, "<",$compose_body)
+			or die "Failed to open $compose_body : ". $!;
+	}
+	open(C,">>",$compose_filename)
 		or die "Failed to open for writing $compose_filename: $!";
 	print C "From $sender # This line is ignored.\n";
 	printf C "Subject: %s\n\n", $initial_subject;
@@ -494,6 +501,11 @@ GIT: Consider including an overall diffstat or
table of contents
 GIT: for the patch you are writing.

 EOT
+	if ($compose_body) {
+		local $/;
+		print C <CB>;
+		close(CB);
+	}
 	close(C);

 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor")
|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-- 
1.6.0.3.640.g6331a.dirty
