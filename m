From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 1/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Fri, 10 Feb 2012 10:18:07 +0100
Message-ID: <1328865494-24415-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:19:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvmdJ-0005mv-HV
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889Ab2BJJS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:59 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57380 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757927Ab2BJJSV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:21 -0500
Received: by eekc14 with SMTP id c14so882738eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J/JKa1k3ZFYSnZC6Th7skv6Q25CUf3DCzN8bo7U7ZSY=;
        b=B+YcXZtVJnAuz1kbGHliuI4zORK8nII94Q7b9eKjj+7G/sypPpP6t0VzU+BS/c3HW6
         nNCCFj+IXdwgc6iHiqIYVln3CDri/B0FJGuksQLWnJH81UZAD1clojO1YOHfFoK4bb/C
         qWDlh0GQjafP6Ig2h/VpEoa5/XJaci8lLZ/9w=
Received: by 10.14.186.134 with SMTP id w6mr1722981eem.96.1328865500331;
        Fri, 10 Feb 2012 01:18:20 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o49sm20034783eei.0.2012.02.10.01.18.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:19 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190395>

Currently, print_sidebyside_diff_chunk() does two things: it
accumulates diff lines and prints them. Accumulation may be used to
perform additional operations on diff lines, so it makes sense to split
these two things. Thus, the code that prints diff lines in a side-by-si=
de
manner is moved out of print_sidebyside_diff_chunk() to a separate
subroutine.

The outcome of this patch is that print_sidebyside_diff_chunk() is now
much shorter and easier to read.

This change is meant to be a simple code movement. No behavior change i=
s
intended.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   97 ++++++++++++++++++++++++++++----------------=
--------
 1 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..1247607 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4861,6 +4861,53 @@ sub git_difftree_body {
 	print "</table>\n";
 }
=20
+# Print context lines and then rem/add lines in a side-by-side manner.
+sub print_sidebyside_diff_lines {
+	my ($ctx, $rem, $add) =3D @_;
+
+	# print context block before add/rem block
+	if (@$ctx) {
+		print join '',
+			'<div class=3D"chunk_block ctx">',
+				'<div class=3D"old">',
+				@$ctx,
+				'</div>',
+				'<div class=3D"new">',
+				@$ctx,
+				'</div>',
+			'</div>';
+	}
+
+	if (!@$add) {
+		# pure removal
+		print join '',
+			'<div class=3D"chunk_block rem">',
+				'<div class=3D"old">',
+				@$rem,
+				'</div>',
+			'</div>';
+	} elsif (!@$rem) {
+		# pure addition
+		print join '',
+			'<div class=3D"chunk_block add">',
+				'<div class=3D"new">',
+				@$add,
+				'</div>',
+			'</div>';
+	} else {
+		# assume that it is change
+		print join '',
+			'<div class=3D"chunk_block chg">',
+				'<div class=3D"old">',
+				@$rem,
+				'</div>',
+				'<div class=3D"new">',
+				@$add,
+				'</div>',
+			'</div>';
+	}
+}
+
 sub print_sidebyside_diff_chunk {
 	my @chunk =3D @_;
 	my (@ctx, @rem, @add);
@@ -4887,51 +4934,11 @@ sub print_sidebyside_diff_chunk {
 			next;
 		}
=20
-		## print from accumulator when type of class of lines change
-		# empty contents block on start rem/add block, or end of chunk
-		if (@ctx && (!$class || $class eq 'rem' || $class eq 'add')) {
-			print join '',
-				'<div class=3D"chunk_block ctx">',
-					'<div class=3D"old">',
-					@ctx,
-					'</div>',
-					'<div class=3D"new">',
-					@ctx,
-					'</div>',
-				'</div>';
-			@ctx =3D ();
-		}
-		# empty add/rem block on start context block, or end of chunk
-		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
-			if (!@add) {
-				# pure removal
-				print join '',
-					'<div class=3D"chunk_block rem">',
-						'<div class=3D"old">',
-						@rem,
-						'</div>',
-					'</div>';
-			} elsif (!@rem) {
-				# pure addition
-				print join '',
-					'<div class=3D"chunk_block add">',
-						'<div class=3D"new">',
-						@add,
-						'</div>',
-					'</div>';
-			} else {
-				# assume that it is change
-				print join '',
-					'<div class=3D"chunk_block chg">',
-						'<div class=3D"old">',
-						@rem,
-						'</div>',
-						'<div class=3D"new">',
-						@add,
-						'</div>',
-					'</div>';
-			}
-			@rem =3D @add =3D ();
+		## print from accumulator when have some add/rem lines or end
+		# of chunk (flush context lines)
+		if (((@rem || @add) && $class eq 'ctx') || !$class) {
+			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
+			@ctx =3D @rem =3D @add =3D ();
 		}
=20
 		## adding lines to accumulator
--=20
1.7.3.4
