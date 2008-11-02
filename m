From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATHv3 2/3] gitweb: retrieve snapshot format from PATH_INFO
Date: Sun,  2 Nov 2008 10:21:38 +0100
Message-ID: <1225617699-30004-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1225617699-30004-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1225617699-30004-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:22:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZA8-0002pv-MG
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYKBJU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYKBJUz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:20:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYKBJUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:20:52 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1532303ugf.37
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 01:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ByXOQ3iMJHZoK9S+9REGOjju+26qoGPTTgxnpXelZKY=;
        b=rHmZmW67pGc448SMFMuH3IXVznLcBwOEZ4vUDuyNK3j4B/YYigWDpm8XOF11o9eIr7
         l3EHt9ykDqpCTttLWkBql83eGpgvOvNayx8LtJq7DcoC3GfSRqlartoP4pU566ADNDm2
         B6Iti+9XR67Q5Tk50h1+A4BmMsJBRZMWZ6yD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eDEMIXheZiClbggLGAkh/dY1xlR292rNtTWFh4J/fjHUCWT1xD6CgmQlfIZKGoxuoq
         RvVVeBaKM6ktWdUajpxaJE92XPjvpntkDm+NZe36P/SKv9zEMA+RGrwhP4YOTvnfuA9e
         /fV05jlhWLkghvLe310bd9NLeNfCVYAAfib+w=
Received: by 10.67.92.17 with SMTP id u17mr1187497ugl.75.1225617651458;
        Sun, 02 Nov 2008 01:20:51 -0800 (PST)
Received: from localhost ([94.37.26.217])
        by mx.google.com with ESMTPS id b35sm17051804ugd.33.2008.11.02.01.20.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 01:20:50 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225617699-30004-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99828>

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
the sf parameter currently, so this is only a potential issue for
hand-coded URLs for extremely unusual project.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8441912..0a41be5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -616,6 +616,44 @@ sub evaluate_path_info {
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
+	# - the snapshot format MUST NOT have been defined already (e.g. from
+	#   CGI parameter sf)
+	# It's also useless to try any matching unless $refname has a dot,
+	# so we check for that too
+	if ($input_params{'action'} eq 'snapshot' &&
+		defined $refname && index($refname, '.') != -1 &&
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
