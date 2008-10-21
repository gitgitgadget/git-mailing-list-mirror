From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 1/5] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Tue, 21 Oct 2008 21:34:50 +0200
Message-ID: <1224617694-29277-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:36:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsN1j-0004hL-Ks
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYJUTed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbYJUTed
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:34:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:6888 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbYJUTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:34:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so43301fgg.17
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pg2JMQI7htb30Wdj3ocMTt6jAnODWwxC5nQzQXFdxWE=;
        b=b183sa+fYKDLZ+tv2lg6MTg9AAxj8FQtRivIu+9G+b6PWrV0yTtkopZfoPlV8y2ZP6
         ibvmsvAxz+PnBWcTRgDvKLRPlxG9nXZgy7OgTJ82E1/qM9cSnjtEVUOQAAnWu3wLuhlc
         bOGOk1WpEk6YXpAOGPbqngsQ4+tyNOIZ3RTLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bh/YNQWC2N11dPg9df8p5TA2FOLgQDbm8gwPK3vqbHlHIk7b/tNxlZtX20acu1Z1oU
         ERKRz1YJDDV52VcR9W2+n4NQyrd/RtjoUxOfQRf6C6nGUVR1W4QkRe0+uUha4sEL+MQp
         0kHPSWP8mxT+lHV4lXq/D3OY8Fyz2k0y+d9Ks=
Received: by 10.181.33.18 with SMTP id l18mr240259bkj.192.1224617669236;
        Tue, 21 Oct 2008 12:34:29 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id h2sm10213245fkh.11.2008.10.21.12.34.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 12:34:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98812>

This patch enables gitweb to parse URLs with more information embedded
in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
path is now $project/$action/$hash_base:$file_name or
$project/$action/$hash

This is mostly backwards compatible with the old-style gitweb paths,
$project/$branch[:$filename], except when it was used to access a branch
whose name matches a gitweb action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   46 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 98f1bfa..1f847bb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -534,23 +534,55 @@ sub evaluate_path_info {
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
+	# list of actions that want hash_base instead of hash, but can have no
+	# pathname (f) parameter
+	my @wants_base = (
+		'tree',
+		'history',
+	);
+
 	my ($refname, $pathname) = split(/:/, $path_info, 2);
 	if (defined $pathname) {
-		# we got "project.git/branch:filename" or "project.git/branch:dir/"
-		# we could use git_get_type(branch:pathname), but it needs $git_dir
+		# we got "branch:filename" or "branch:dir/"
+		# we could use git_get_type(branch:pathname), but:
+		# - it needs $git_dir
+		# - it does a git() call
+		# - the convention of terminating directories with a slash
+		#   makes it superfluous
+		# - embedding the action in the PATH_INFO would make it even
+		#   more superfluous
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
+		# we got "branch". In this case we have to choose if we have to
+		# set hash or hash_base.
+		#
+		# Most of the actions without a pathname only want hash to be
+		# set, except for the ones specified in @wants_base that want
+		# hash_base instead. It should also be noted that hand-crafted
+		# links having 'history' as an action and no pathname or hash
+		# set will fail, but that happens regardless of PATH_INFO.
+		$input_params{'action'} ||= "shortlog";
+		if (grep { $_ eq $input_params{'action'} } @wants_base) {
+			$input_params{'hash_base'} ||= $refname;
+		} else {
+			$input_params{'hash'} ||= $refname;
+		}
 	}
 }
 evaluate_path_info();
-- 
1.5.6.5
