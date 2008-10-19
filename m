From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 6/6] gitweb: retrieve snapshot format from PATH_INFO
Date: Sun, 19 Oct 2008 14:11:55 +0200
Message-ID: <1224418315-26164-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 07:40:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrX9L-0001lO-T6
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 14:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYJSMLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 08:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYJSMLf
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 08:11:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:38838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYJSMLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 08:11:34 -0400
Received: by ug-out-1314.google.com with SMTP id k3so462432ugf.37
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5gafuSS0OFaK4AOYxfDBbME9F+jyd62pU1LGXepUACE=;
        b=a8V7jd6rgseEG1tkzdRn0fgRE96YXR0mSs4Kj0Qvoe3KEdXAHfIQv8XsBhgNiTJZUM
         lkOLPkJlRT2fi15Y6kc06mIlobRhggzMtu4RzltieFq4JHU5MFO2SUb3lI6K2+6Yza9Q
         3Opkdh6WBNEzRCoddmDdV6zGUrQXCx2fhhg5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QztE5ULPwsuFuEADKEUjuW2+Z/Ig0EvvoElKhZOsKZUaZx3phzq4qgUO2KtJL7X3CV
         Li1YDyi4McjlPh20CfZX6ZbnnWRu9FnOeEruWrZU7qdCY0v8cix6qWBgEceX03Fq5Ooo
         gP3uT05XREehFOSxnbA1QSZSXrNFndGtwF6mQ=
Received: by 10.67.116.18 with SMTP id t18mr1390545ugm.58.1224418291026;
        Sun, 19 Oct 2008 05:11:31 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id k2sm2519899ugf.18.2008.10.19.05.11.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 05:11:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98615>

We parse requests for $project/snapshot/$head.$sfx as equivalent to
$project/snapshot/$head?sf=$sfx, where $sfx is any of the known
(although not necessarily supported) snapshot formats (or its default
suffix).

The filename for the resulting package preserves the requested
extensions (so asking for a .tgz gives a .tgz, and asking for a .tar.gz
gives a .tar.gz), although for obvious reasons it doesn't preserve the
basename (git/snapshot/next.tgz returns a file names git-next.tgz).

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Ok, I lied, there's a 6th patch ready. Its purpose is to allow embedding of
the snapshot format parameter in the URL, in the form of an extension
appended to the refname.

I have not prepared the corresponding URL generation code yet, because of
potential ambiguity that might arise: even though at URL generation time
the project does not have a head named $head.$sfx, it is possible (although
extremely unlikely) that such head is created later on, and the PATH_INFO
generation code cannot therefore guarantee the permalink nature of the
embedded snapshot format URL.

 gitweb/gitweb.perl |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 99c8c20..7ffd10b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -609,6 +609,41 @@ sub evaluate_path_info {
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
+	# require some conditions to be satisfied:
+	# - the hash input parameter MUST have been set from the $refname part
+	#   of the URL (i.e. they must be equal)
+	# - the snapshot format MUST NOT have been defined already
+	# - the $refname itself MUST NOT be a valid refname
+	if ($input_params{'action'} eq 'snapshot' && defined $refname &&
+		$refname eq $input_params{'hash'} &&
+		!defined $input_params{'snapshot_format'} &&
+		!parse_commit($refname)) {
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
+		}
+	}
 }
 evaluate_path_info();
 
-- 
1.5.6.5
