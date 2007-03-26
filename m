From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Mon, 26 Mar 2007 18:12:09 +0100
Message-ID: <200703261912.09445.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsiv-0003jP-6g
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbXCZRLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXCZRLK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:11:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:20876 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbXCZRLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:11:08 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2813383muf
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:11:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Qi4KI2+9JPNKHrTMSL3cctfeK7c7z79RtP3GEkcxaqMPh6vTBSpp0LL2MFmmasK7eecNjm8iS1MOSvnq9UYmANP0XIwMogfHc0bH6hKm5JpwvdovsaMbCh+N3LS0gWJjok2BHf5pmd1OdVfLGOF+3iBw+JCPjFt+FE5u1ZdTWmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=QLAhblHJv2tC7p8uneDLPLWTKAvZIOSGqfxm0F3OXqX/2fUp5bb7JlWErCdqk7bkb3OpZDFt3JFoSlhJIrTYkNlQBc3DNHG+YNYq5VkT9HZM7UV/BZj+lpXixqSsVygfwi3jgCNo39hdENhNjG5UXfDiXjZBU2j6f7pOMmnvPhU=
Received: by 10.82.178.11 with SMTP id a11mr14142228buf.1174929066402;
        Mon, 26 Mar 2007 10:11:06 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e9sm22102910muf.2007.03.26.10.11.04;
        Mon, 26 Mar 2007 10:11:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43161>

Fix the bug that caused "blobdiff" view called with new style URI
(it means with $hash_base ('hb') and $hash_parent_base ('hpb') denoting
tree-ish, usually commit, which have blobs being compared) for
renamed files (it means with both $file_name ('f') and $file_parent ('fp')
parameters set) to be show as new (added) file diff.

It is done by adding $file_parent ('fp') to the path limiter, meaning
that diff command becomes:

	git diff-tree [options] hpb hb -- fp f

instead of finding hash of a blob using git_get_hash_by_path subroutine
or using extended SHA-1 syntax:

	git diff [options] hpb:fp hp:f

Currently code for "blobdiff" does not support well mixed style URI,
for example asking for diff between blob given by its hash only, or
by hash and filename (without hash of tree-ish / commit), and blob
given by hash base (hash of tree-ish / commit) and filename but without
hash of blob itself, and probably would never will.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Martin, sorry for the confusing suggestion about using tree-ish:path
syntax to compare (generate diff of) two file with different name.

This patch is less invasive and I think better solution.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5214050..c79bfeb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3885,7 +3885,7 @@ sub git_blobdiff {
 			# read raw output
 			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 				$hash_parent_base, $hash_base,
-				"--", $file_name
+				"--", (defined $file_parent ? $file_parent : ()), $file_name
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
 			close $fd
@@ -3935,7 +3935,7 @@ sub git_blobdiff {
 		# open patch output
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_base, $hash_base,
-			"--", $file_name
+			"--", (defined $file_parent ? $file_parent : ()), $file_name
 			or die_error(undef, "Open git-diff-tree failed");
 	}
 
-- 
1.5.0.5
