From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv2 6/8] gitweb: retrieve snapshot format from PATH_INFO
Date: Sun, 19 Oct 2008 16:24:28 +0200
Message-ID: <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 04:56:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrZDn-00062W-LZ
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 16:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbYJSOYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYJSOYL
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 10:24:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:50660 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbYJSOYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 10:24:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1048689fgg.17
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9B6UqOQyu687fUj/uSt7+0tY9/VRDu1XCdGwL2ZAfco=;
        b=K3t95SUYA3mfU+vo9qAbIzWwzdcYFJwFRCRC4x5fTcdtINJqCyG7RqYRQGRCOTKFT8
         5/JQwzRZJpfoEYkAkE7zZ/jR73mxfgiLw8JWLdqjxNEanNDmihNUK5QI25TWDBbM8TJy
         2bzaHv10ymdfMPC9SSEB0k+pEWtLVhMItWMic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dOMsUXgwH/hU616hLmq11BQABAXKP+YGk0d0teyGCOQu72R76HCv0mPw+tJnCtqOOt
         O+Ry8wAcauEG1z+IZ8mDqxnbVe5Lh6QAexUUCGymJKQg6OXGgbU8aiGoNwKykmyltCve
         Cn5z+U+Rv/ga2oDas9CLWlhXy9yu1jgKhV93k=
Received: by 10.181.147.3 with SMTP id z3mr2310374bkn.71.1224426246333;
        Sun, 19 Oct 2008 07:24:06 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 31sm12052736fkt.3.2008.10.19.07.24.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 07:24:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98606>

We parse requests for $project/snapshot/$head.$sfx as equivalent to
$project/snapshot/$head?sf=$sfx, where $sfx is any of the known
(although not necessarily supported) snapshot formats (or its default
suffix).

The filename for the resulting package preserves the requested
extensions (so asking for a .tgz gives a .tgz, and asking for a .tar.gz
gives a .tar.gz), although for obvious reasons it doesn't preserve the
basename (git/snapshot/next.tgz returns a file names git-next.tgz).

This introduces a potential case for ambiguity if a project has a head
that ends with a snapshot-like suffix (.zip, .tgz, .tar.gz, etc) and the
sf CGI parameter is not present; however, gitweb only produces URLs with
the sf parameter, so this is only a potential issue for hand-coded URLs
for extremely unusual project.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

I had second thoughts on this. Now we always look for the snapshot extension if
the sf CGI parameter is missing, even if the project has a head that matches
the full pseudo-refname $head.$sfx.

The reason for this is that (1) there is no ambiguity for gitweb-generated
URLs (2) the only URLs that could fail are hand-made URLs for extremely
unusual projects and (3) it allows us to set gitweb up to generate
(unambiguous) URLs without the sf CGI parameter.

This also means that I can add 3 patches to the series, instead of just one:
* patch #6 that parses the new format
* patch #7 that generates the new URLs
* patch #8 for some code refactoring

 gitweb/gitweb.perl |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 99c8c20..e9e9e60 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -609,6 +609,40 @@ sub evaluate_path_info {
 			$input_params{'hash_parent'} ||= $parentrefname;
 		}
 	}
+
+	# for the snapshot action, we allow URLs in the form
+	# $project/snapshot/$hash.ext
+	# where .ext determines the snapshot and gets removed from the
+	# passed $refname to provide the $hash.
+	#
+	# To be able to tell that $refname includes the format extension, we
+	# require the following two conditions to be satisfied:
+	# - the hash input parameter MUST have been set from the $refname part
+	#   of the URL (i.e. they must be equal)
+	# - the snapshot format MUST NOT have been defined already
+	if ($input_params{'action'} eq 'snapshot' && defined $refname &&
+		$refname eq $input_params{'hash'} &&
+		!defined $input_params{'snapshot_format'}) {
+		# We loop over the known snapshot formats, checking for
+		# extensions. Allowed extensions are both the defined suffix
+		# (which includes the initial dot already) and the snapshot
+		# format key itself, with a prepended dot
+		while (my ($fmt, %opt) = each %known_snapshot_formats) {
+			my $hash = $refname;
+			my $sfx;
+			$hash =~ s/(\Q$opt{'suffix'}\E|\Q.$fmt\E)$//;
+			next unless $sfx = $1;
+			# a valid suffix was found, so set the snapshot format
+			# and reset the hash parameter
+			$input_params{'snapshot_format'} = $fmt;
+			$input_params{'hash'} = $hash;
+			# we also set the format suffix to the one requested
+			# in the URL: this way a request for e.g. .tgz returns
+			# a .tgz instead of a .tar.gz
+			$known_snapshot_formats{$fmt}{'suffix'} = $sfx;
+			last;
+		}
+	}
 }
 evaluate_path_info();
 
-- 
1.5.6.5
