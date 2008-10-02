From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: parse parent..current syntax from pathinfo
Date: Thu,  2 Oct 2008 02:10:33 +0200
Message-ID: <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnK-00017h-Us
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbYJBAKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYJBAKU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48915 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbYJBAKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:10:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so341125nfc.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s8WVQdVbRAt4eOhA1Sdy3U/0bZj9zJwO63uchp0SyH4=;
        b=FywilxiiWOqFhJqn9aG69OWT4QOqkhZ1dkoqLCVfUHigxR922KFSW9dDszbDZutZPJ
         S7DkUkzQR50C9HHCx6aEo6ORIZwnqEizpRp9cRwmqFwimk7RMl+iWUgIqzCHqL5dRuJp
         0vk8zfVmYAhpo39H9gqWQNck430tzyFxFdaNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cxot/qeFKIdbfHEILCMwfS4XmLzjnQKAonH1SoPpM5YEzcVRqT6pAcuskfIk2+RfKv
         6PrzQ9nAuCWZp+/IcgEX9ldetDgBzXPBY3hdW6b6o+bJ5nqBt32VpirF+3IiExOPr6L/
         Mf/lxixSosEPKKnjp6axvipQHOELKKogmTlrs=
Received: by 10.210.130.14 with SMTP id c14mr10471621ebd.141.1222906216912;
        Wed, 01 Oct 2008 17:10:16 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 7sm1093882eyb.1.2008.10.01.17.10.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:10:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97284>

This makes it possible to use an URL such as
$project/somebranch..otherbranch:/filename to get a diff between
different version of a file. Paths like
$project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
as well.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3e5b2b7..89e360f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -534,7 +534,9 @@ if ($path_info && !defined $action) {
 
 # we can now parse ref and pathnames in PATH_INFO
 if ($path_info) {
-	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	$path_info =~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?$/;
+	my ($parentrefname, $parentpathname, $refname, $pathname) = (
+		$2, $4, $5, $7);
 	if (defined $pathname) {
 		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
@@ -543,7 +545,11 @@ if ($path_info) {
 			$input_params{'action'} ||= "tree";
 			$pathname =~ s,/$,,;
 		} else {
-			$input_params{'action'}  ||= "blob_plain";
+			if ($parentrefname) {
+				$input_params{'action'} ||= "blobdiff_plain";
+			} else {
+				$input_params{'action'} ||= "blob_plain";
+			}
 		}
 		$input_params{'hash_base'} ||= $refname;
 		$input_params{'file_name'} ||= $pathname;
@@ -553,6 +559,22 @@ if ($path_info) {
 		$input_params{'hash'}      ||= $refname;
 		$input_params{'hash_base'} ||= $refname;
 	}
+	# the parent part might be missing the pathname, in which case we use the $file_name, if present
+	if (defined $parentrefname) {
+		$input_params{'hash_parent_base'} ||= $parentrefname;
+		if ($parentpathname) {
+			$parentpathname =~ s,^/+,,;
+			$parentpathname =~ s,/$,,;
+			$input_params{'file_parent'} ||= $parentpathname;
+		} else {
+			$input_params{'file_parent'} ||= $input_params{'file_name'};
+		}
+		if (defined $input_params{'file_parent'}) {
+			$input_params{'hash_parent'} ||= git_get_hash_by_path($input_params{'hash_parent_base'}, $input_params{'file_parent'});
+		} else {
+			$input_params{'hash_parent'} ||= $parentrefname;
+		}
+	}
 }
 
 # and now the rest of the validation
-- 
1.5.6.5
