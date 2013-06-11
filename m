From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH 2/2] [submodule] Replace perl-code with sh
Date: Wed, 12 Jun 2013 01:04:14 +0200
Message-ID: <1370991854-1414-3-git-send-email-iveqy@iveqy.com>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, git@vger.kernel.org, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Wed Jun 12 01:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmXZW-0001SI-WA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 01:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333Ab3FKXBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 19:01:38 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42867 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab3FKXBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 19:01:36 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so5992699lbi.19
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wRmA4wA0xulgnmhaa9tcmGr/24ohBdr4I76dXzxrZvU=;
        b=HlDoSfsu1digxeLaYAv6mWtIEjz6hDwjNCe50DHJxSX4H7ajY9C7zEgUWg8ZFUxLlW
         3AxVJeY7+IrEYSgXvmm5vA8GDdveIRyjn6AMZzatHQgymhlE2VD+mJLftR/55YrIF7d/
         QuGyWt6g8YYDy4lEQ+azfQfFW+eJf3tf3pZg+bfJVDfituxqyN9RA4EwyBPjhOdtjzVW
         siQ/5kNnNcQNLWBjD2DsCERbPy1oK3TvknkTVkEtBj1R0ribRmp4tehwNGPaHNKHGhBl
         bNlkQ1ag13zPh4TB2HtfCexhu66dRy0/26pdNcMFC4vfN/8CfW3iKEitum/59DTxOT1l
         uqYg==
X-Received: by 10.152.121.73 with SMTP id li9mr8517457lab.42.1370991694520;
        Tue, 11 Jun 2013 16:01:34 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id 9sm8164084lbz.16.2013.06.11.16.01.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 16:01:34 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmXc4-0000NZ-6m; Wed, 12 Jun 2013 01:04:28 +0200
X-Mailer: git-send-email 1.8.3.253.g20b40b5.dirty
In-Reply-To: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227574>

This is a work built on
http://thread.gmane.org/gmane.comp.version-control.git/198873/focus=198930

Basically git-submodule.sh needs to use something else than sh to handle
newline in filenames (and therefore needs to use a language that accepts
\0 in strings).

However, since we're not there yet. I've thrown out the only
perl-dependency for git-submodule.sh. It decreases the number of
lines of code and uses the same solution as the rest of the script
already do.

This would lead to less forks and faster code. A simple testrun of
t7400-submodule-basic.sh before this patch resulted in:
real    0m8.359s
user    0m8.921s
sys     0m3.888s

real    0m9.062s
user    0m9.025s
sys     0m3.784s

real    0m8.490s
user    0m9.065s
sys     0m3.740s

After this patch was applied:
real    0m7.417s
user    0m8.717s
sys     0m3.804s

real    0m7.873s
user    0m8.821s
sys     0m3.692s

real    0m8.950s
user    0m8.765s
sys     0m3.760s

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh | 52 +++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 31524d3..1652781 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -112,39 +112,33 @@ resolve_relative_url ()
 #
 module_list()
 {
+	null_sha1=0000000000000000000000000000000000000000
+	unmerged=
 	(
 		git ls-files --error-unmatch --stage -z -- "$@" ||
-		echo "unmatched pathspec exists"
+		echo "#unmatched"
 	) |
 	sed -e 's/\x00/\n/g' |
-	perl -e '
-	my %unmerged = ();
-	my ($null_sha1) = ("0" x 40);
-	my @out = ();
-	my $unmatched = 0;
-	while (<STDIN>) {
-		if (/^unmatched pathspec/) {
-			$unmatched = 1;
-			next;
-		}
-		chomp;
-		my ($mode, $sha1, $stage, $path) =
-			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
-		next unless $mode eq "160000";
-		if ($stage ne "0") {
-			if (!$unmerged{$path}++) {
-				push @out, "$mode $null_sha1 U\t$path\n";
-			}
-			next;
-		}
-		push @out, "$_\n";
-	}
-	if ($unmatched) {
-		print "#unmatched\n";
-	} else {
-		print for (@out);
-	}
-	'
+	while read mode sha1 stage path
+	do
+		if test $mode = "#unmatched"
+		then
+			echo "#unmatched"
+		fi
+		if test $mode = "160000"
+		then
+			if test $stage != "0"
+			then
+				if test "$unmerged" != "$path"
+				then
+					echo "$mode $null_sha1 U $path"
+				fi
+				unmerged="$path"
+			else
+				echo "$mode $sha1 $stage $path"
+			fi
+		fi
+	done
 }
 
 die_if_unmatched ()
-- 
1.8.3.253.g20b40b5.dirty
