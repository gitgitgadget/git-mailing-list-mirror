From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 1/5] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Thu, 16 Oct 2008 22:27:07 +0200
Message-ID: <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZS4-0000BA-5Y
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYJPU07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbYJPU07
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:26:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17896 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYJPU06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:26:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so137749nfc.21
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0rhAk4XZzGcpGjmCsvl3tp1XM97YEAcsx+glKwaR8Pk=;
        b=DuozaFhs/Sntq2xWjbJ5JjxST1I2pkivr3bpkXeBL+sAkG5/c6I1kifkluakAbwD1+
         kTCYDdz41xzOP/8K2TFd2T21TuSaPBvxonxmrPgTfEZ2t8WcciQiCxX+1dvzkMvRN4Ve
         +ouJEkOAfLKBr7gaqoWg1EesaDs30f4xOgjKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m7wG+XsgCTOB2xzy4ICYgsoi5UnfMGS+hHQUcUxvp1s6Fo8u5WqHbTZPk1p74eTqt6
         SZQSm27cs82Ng9flnwPheqdr2qA2VlQ7ZxfYyvAEDXzpH8sAWq8rTiMOvtSskYpOVoHz
         b19QhF4DTvx6ZTjWA0x38jtgFJESN1hQNO4Uw=
Received: by 10.210.126.5 with SMTP id y5mr3423731ebc.94.1224188817880;
        Thu, 16 Oct 2008 13:26:57 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 20sm2547539eyk.4.2008.10.16.13.26.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:26:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98413>

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
+		if (grep {$input_params{'action'} eq $_} @wants_base) {
+			$input_params{'hash_base'} ||= $refname;
+		} else {
+			$input_params{'hash'} ||= $refname;
+		}
 	}
 }
 evaluate_path_info();
-- 
1.5.6.5
