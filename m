From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 3/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Fri, 23 Mar 2012 23:56:52 +0100
Message-ID: <1332543417-19664-4-git-send-email-michal.kiedrowicz@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQM-0006K1-RM
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323Ab2CWW5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:14 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41594 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198Ab2CWW5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:07 -0400
Received: by wgbdr13 with SMTP id dr13so2424286wgb.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=642AhT95cNZYqpjXeb5dKBNPtsWCPPE1B7lfEo9DrM0=;
        b=uYateYaiQGH4JPx2a7NeC07nS9YYwt/e+KyEKiAxS7FFZPwReWmn6sopyypryuCryb
         KmfDzB4p5vl2Riu2CYLlIR/qOercGrG5EYb+qCtEhEQ4/XtLVE0DbMYMPhkAubvuADwm
         aONRuSYDKtUSJgaZ8DCu2ggS6n4/uc3ynt1jIORPDJAMJyVx+2lb/T58TpB0YOh1uQGi
         vlmJ2Vqy9Yg8mDfilzXnIR79X2ql/1NrT0Mi3YMBRvD3qrrmKtYEz7ZAbns+Tu1F3QrI
         0UDeTONvgvIHZkQ5g8t2TSrQ06C6uuX5GdM1HL5PZ/eJqMQMYH1KaElhzo8XeQQb3gVq
         kiJQ==
Received: by 10.180.81.37 with SMTP id w5mr711621wix.16.1332543426503;
        Fri, 23 Mar 2012 15:57:06 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id fz9sm17666815wib.3.2012.03.23.15.57.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193811>

Currently, print_sidebyside_diff_chunk() does two things: it
accumulates diff lines and prints them.  Accumulation may be used to
perform additional operations on diff lines,  so it makes sense to spli=
t
these two things.  Thus, the code that prints diff lines in a side-by-s=
ide
manner is moved out of print_sidebyside_diff_chunk() to a separate
subroutine.

The outcome of this patch is that print_sidebyside_diff_chunk() is now
much shorter and easier to read.

This is a preparation patch for diff refinement highlightning.  It shou=
ld
not change the gitweb output, but it slightly changes its behavior.
Before this commit, context is printed on the class change. Now, it'it
printed just before printing added and removed lines.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   97 ++++++++++++++++++++++++++++----------------=
--------
 1 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1744c40..86d5a02 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4998,6 +4998,53 @@ sub git_difftree_body {
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
@@ -5024,51 +5071,11 @@ sub print_sidebyside_diff_chunk {
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
1.7.8.4
