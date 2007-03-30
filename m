From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (resend)] gitweb: Support comparing blobs (files) with different names
Date: Fri, 30 Mar 2007 23:41:26 +0200
Message-ID: <200703302341.27225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 00:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXPt0-0000QI-Tn
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 00:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXC3Wrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbXC3Wrz
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 18:47:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:23242 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXC3Wry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2007 18:47:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so958684uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 15:47:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QFqZOSP4Ze0oANoQaa60bRZKZEIqDNB8fTanTjq3u7suJtVRfX1xKScHQPN4iKD1fm2B5baRjt3587/60g2DkBYK4fJgsvxBkhY4rezzEtcj1L7WoyGT5ZmRhDPqljw8V6BVqoKfOMenhdatfakG5bdbx2YGr5GXbbyASjqpDCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a4iR0N4qwF+YAhd4/y8EC7DCuLyXuIBuMi7mY4S0d8tLemDmqXMIGZMgyEKag+eNDbEWR/ydTpU5gCGz+IpZIiuFMakuruGvm17+p7JQrUcp3ov8idqsLLHdIXPTp8TclKbgVXCJo38OB9yhoXTcADAVjmAwIS/MsfbB3me202M=
Received: by 10.67.26.7 with SMTP id d7mr2534649ugj.1175294873352;
        Fri, 30 Mar 2007 15:47:53 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g8sm9805373muf.2007.03.30.15.47.51;
        Fri, 30 Mar 2007 15:47:52 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43505>

Fix the bug that caused "blobdiff" view called with new style URI
for a rename with change diff to be show as new (added) file diff.

New style URI for "blobdiff" for rename means with $hash_base ('hb') and
$hash_parent_base ('hpb') paramaters denoting tree-ish (usually commit)
of a blobs being compared, together with both $file_name ('f') and
$file_parent ('fp') parameters.

It is done by adding $file_parent ('fp') to the path limiter, meaning
that diff command becomes:

	git diff-tree [options] hpb hb -- fp f

Other option would be finding hash of a blob using git_get_hash_by_path
subroutine and comparing blobs using git-diff, or using extended SHA-1
syntax and compare blobs using git-diff:

	git diff [options] hpb:fp hp:f

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio, could you apply this? It looks like it was lost in the noise.

This patch is least invasive, and it solves bug with "blobdiff" for
rename with change. It is not a complete solution for comparing two
arbitrary blobs (which takes longer than expected, and it looks like
it would be a while till it is ready), but it covers AFAICT all the
URL (all the situations) for "blobdiff" currently _generated_ by gitweb.

>From the lack of bugreports concerning this bug in "blobdiff" it looks
like "blobdiff" view is not often used. By the way: "commitdiff" view
works fine in the presence of renames, and renames with modification.

This version has slightly changed commit message.

Bug was noticed by Martin Koegler <mkoegler@auto.tuwien.ac.at>


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
