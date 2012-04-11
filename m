From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 5/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Wed, 11 Apr 2012 23:18:41 +0200
Message-ID: <1334179124-14258-6-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wh-0005Cb-QS
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933379Ab2DKVTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:19:08 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47230 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab2DKVTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:19:06 -0400
Received: by wibhq7 with SMTP id hq7so1293795wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UGEorDkX4o2Nm52LqZi5wfZTCox0xwgIvbT9z0x5o1k=;
        b=coe+mrqEtmj9CfrFJ1+BYBK1l3KFFo74DAyZyua2X/k3AUS+rMbJjGNS0X84rw/I0e
         svQJ38XO5N3tjRnztKum6JkRoy1T/QGX+bu5MBqSMa/caRNeVP3wOxOeo7wiCd62FZy6
         RTxS9NrfKHVs2fi7tHAXV8oQJoaqL2tfuJkx0IA25ZtrtjKciQNP4WXLhTcWrisE0bWf
         i+nqkIQjWb+L94bz+ztruK5yk+1Qh3E6TdO6NGoCcox6N/Qv/G/EHnlrKqHhCgC+wq1n
         ljbDU0GmZQREL1ljrzfb8oCi7qYLPQb/uAso1tufiCW1Ios45JVe0ytSOjrlO+AmoVJV
         +PLQ==
Received: by 10.180.101.8 with SMTP id fc8mr19678083wib.12.1334179145239;
        Wed, 11 Apr 2012 14:19:05 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e6sm47592245wix.8.2012.04.11.14.19.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:19:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195261>

This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
makes use of it for both side-by-side and inline diffs.  Now diff lines
are always accumulated before they are printed.  This opens the
possibility to preprocess diff output before it's printed, which is
needed for diff refinement highlightning (implemented in incoming
patches).

If print_diff_chunk() was left as is, the new function
print_inline_diff_lines() could reorder diff lines.  It first prints al=
l
context lines, then all removed lines and finally all added lines.  If
the diff output consisted of mixed added and removed lines, gitweb woul=
d
reorder these lines.  This is true for combined diff output, for
example:

	 - removed line for first parent
	 + added line for first parent
	  -removed line for second parent
	 ++added line for both parents

would be rendered as:

	- removed line for first parent
	 -removed line for second parent
	+ added line for first parent
	++added line for both parents

To prevent gitweb from reordering lines, print_diff_chunk() calls
print_diff_lines() as soon as it detects that both added and removed
lines are present and there was a class change, and at the end of chunk=
=2E

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   55 ++++++++++++++++++++++++++++++++++++--------=
-------
 1 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8271749..90836e6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5048,10 +5048,32 @@ sub print_sidebyside_diff_lines {
 	}
 }
=20
-sub print_sidebyside_diff_chunk {
-	my @chunk =3D @_;
+# Print context lines and then rem/add lines in inline manner.
+sub print_inline_diff_lines {
+	my ($ctx, $rem, $add) =3D @_;
+
+	print @$ctx, @$rem, @$add;
+}
+
+# Print context lines and then rem/add lines.
+sub print_diff_lines {
+	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
+
+	if ($diff_style eq 'sidebyside' && !$is_combined) {
+		print_sidebyside_diff_lines($ctx, $rem, $add);
+	} else {
+		# default 'inline' style and unknown styles
+		print_inline_diff_lines($ctx, $rem, $add);
+	}
+}
+
+sub print_diff_chunk {
+	my ($diff_style, $is_combined, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
+	# The class of the previous line.
+	my $prev_class =3D '';
+
 	return unless @chunk;
=20
 	# incomplete last line might be among removed or added lines,
@@ -5075,9 +5097,13 @@ sub print_sidebyside_diff_chunk {
 		}
=20
 		## print from accumulator when have some add/rem lines or end
-		# of chunk (flush context lines)
-		if (!$class || ((@rem || @add) && $class eq 'ctx')) {
-			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
+		# of chunk (flush context lines), or when have add and rem
+		# lines and new block is reached (otherwise add/rem lines could
+		# be reordered)
+		if (!$class || ((@rem || @add) && $class eq 'ctx') ||
+		    (@rem && @add && $class ne $prev_class)) {
+			print_diff_lines(\@ctx, \@rem, \@add,
+		                         $diff_style, $is_combined);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -5094,6 +5120,8 @@ sub print_sidebyside_diff_chunk {
 		if ($class eq 'ctx') {
 			push @ctx, $line;
 		}
+
+		$prev_class =3D $class;
 	}
 }
=20
@@ -5220,22 +5248,17 @@ sub git_patchset_body {
 			$diff_classes .=3D " $class" if ($class);
 			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
=20
-			if ($diff_style eq 'sidebyside' && !$is_combined) {
-				if ($class eq 'chunk_header') {
-					print_sidebyside_diff_chunk(@chunk);
-					@chunk =3D ( [ $class, $line ] );
-				} else {
-					push @chunk, [ $class, $line ];
-				}
-			} else {
-				# default 'inline' style and unknown styles
-				print $line;
+			if ($class eq 'chunk_header') {
+				print_diff_chunk($diff_style, $is_combined, @chunk);
+				@chunk =3D ();
 			}
+
+			push @chunk, [ $class, $line ];
 		}
=20
 	} continue {
 		if (@chunk) {
-			print_sidebyside_diff_chunk(@chunk);
+			print_diff_chunk($diff_style, $is_combined, @chunk);
 			@chunk =3D ();
 		}
 		print "</div>\n"; # class=3D"patch"
--=20
1.7.8.4
