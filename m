From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 1/5] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Mon, 13 Oct 2008 12:19:21 +0200
Message-ID: <1223893165-26022-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 12:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpKYe-0003xi-Iu
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994AbYJMKT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762610AbYJMKT2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:19:28 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:25739 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762278AbYJMKTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:19:21 -0400
Received: by ey-out-2122.google.com with SMTP id 6so551093eyi.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/WxBlJpA2PYIZ8a/QKN7CkdxRG1ssof7ltA3PrP2jLE=;
        b=u7uOupNK3oQVbO388blo7ruPD14vHWVlID7zYD67PsQaqSeTHIcGHEsqikO1csnaZc
         rWEU0rgL3Vas1q5B9JdbVDw37KqqjGEPPlZ0xYUUT3gN2GM/ZIeolvxlo4csFY5n8DE6
         udtCHRPod4egVFQpOYzcOtIQTz3hbAPUQN6Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Zo4GTvZdXQMGxWCaP7kaGGIrHCe2PCZ+bANfZMXAAlggnW6FEHyojLr8jtEW01B0ym
         fwoPXE++GgDkhQHzPAlcc3wEAkcRK58iYpPaZ5uF+B3c+DmUecvVFsCklHJdUXqLdrA8
         6jShH+tVT8jFEVbAomZrRzNHUPCuXwVa7yD2M=
Received: by 10.210.30.1 with SMTP id d1mr5260396ebd.31.1223893158718;
        Mon, 13 Oct 2008 03:19:18 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id 3sm9522425eyj.3.2008.10.13.03.19.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 03:19:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98105>

This patch enables gitweb to parse URLs with more information embedded
in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
path is now $project/$action/$hash_base:$file_name or
$project/$action/$hash

This is mostly backwards compatible with the old-style gitweb paths,
$project/$branch[:$filename], except when it was used to access a branch
whose name matches a gitweb action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c5254af..6d0dc26 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -534,23 +534,48 @@ sub evaluate_path_info {
 	return if $input_params{'action'};
 	$path_info =~ s,^\Q$project\E/*,,;
 
+	# next, check if we have an action
+	my $action = $path_info;
+	$action =~ s,/.*$,,;
+	if (exists $actions{$action}) {
+		$path_info =~ s,^$action/*,,;
+		$input_params{'action'} = $action;
+	}
+
+	# list of actions that want hash_base instead of hash
+	my @wants_base = (
+		'tree',
+		'history',
+	);
+
 	my ($refname, $pathname) = split(/:/, $path_info, 2);
 	if (defined $pathname) {
-		# we got "project.git/branch:filename" or "project.git/branch:dir/"
+		# we got "branch:filename" or "branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
 		$pathname =~ s,^/+,,;
 		if (!$pathname || substr($pathname, -1) eq "/") {
-			$input_params{'action'} = "tree";
+			$input_params{'action'} ||= "tree";
 			$pathname =~ s,/$,,;
 		} else {
-			$input_params{'action'} = "blob_plain";
+			$input_params{'action'} ||= "blob_plain";
 		}
 		$input_params{'hash_base'} ||= $refname;
 		$input_params{'file_name'} ||= $pathname;
 	} elsif (defined $refname) {
-		# we got "project.git/branch"
-		$input_params{'action'} = "shortlog";
-		$input_params{'hash'} ||= $refname;
+		# we got "branch". in this case we have to choose if we have to
+		# set hash or hash_base.
+		#
+		# Most of the actions without a pathname only want hash to be
+		# set, except for the ones specified in @wants_base that want
+		# hash_base instead. It should also be noted that hand-crafted
+		# links having 'history' as an action and no pathname or hash
+		# set will fail, but that happens regardless of PATH_INFO.
+		$input_params{'action'} ||= "shortlog";
+		if (grep($input_params{'action'},@wants_base)) {
+			$input_params{'hash_base'} ||= $refname;
+		} else {
+			$input_params{'hash'} ||= $refname;
+		}
 	}
 }
 evaluate_path_info();
-- 
1.5.6.5
