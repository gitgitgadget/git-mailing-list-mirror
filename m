From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 4/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Wed, 11 Apr 2012 23:18:40 +0200
Message-ID: <1334179124-14258-5-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wW-00053U-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933374Ab2DKVTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:19:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63166 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab2DKVTC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:19:02 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1311420wgb.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ssjUR81SHEdf0TopO8XswTpgf0uiOsdcpa7HoQt9WzU=;
        b=vsDiQ2r8H6KfQUD/5SbZO0+ef8N91lf5YeHL40xbrs25Fcezv15u7VcQFNu+Cxq+wG
         iQg5NQWjVi45I+frj3XA9QjEjtAnF1jq1A8JLV9DOSxH/8LeY+VhM/NXm17RR/RL/dn0
         8dz7fhHfTylEGSxUxAYAfYXUFh/ymhgOIAlCM5AP7SkriX6BAdce8MJK5Yx39bHvKQh3
         N4p+tdR7LeaKzywmRVSgns5NqN5lObl/nAR0ErqgqiPq9hhhow20d5ghAgaWeCg5KyVt
         pT3TVpFS8SnKVJDcZG+sP5hDxFB4Nxu0SlyLizEeC924zTryYoioQZ2xfEopaOgJN1m4
         IQhg==
Received: by 10.180.91.165 with SMTP id cf5mr45921wib.2.1334179142091;
        Wed, 11 Apr 2012 14:19:02 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id ex2sm13731444wib.8.2012.04.11.14.19.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:19:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195260>

Currently, print_sidebyside_diff_chunk() does two things: it
accumulates diff lines and prints them.  Accumulation may be used to
perform additional operations on diff lines, so it makes sense to split
these two things.  Thus, whole code that formats and prints diff lines
in the 'side-by-side' manner is moved out of print_sidebyside_diff_chun=
k()
to a separate subroutine and two conditions that control printing
diff liens are merged.

Thanks to that, we can easily (in later patches) replace call to that
subroutine with a call to more generic print_diff_lines() that will
control whether 'inline' or 'side-by-side' diff should be printed.

As a side effect, context lines are printed just before printing added
and removed lines, and at the end of chunk (previously, they were
printed immediately on the class change).  However, this doesn't change
gitweb output.

The outcome of this patch is that print_sidebyside_diff_chunk() is now
much shorter and easier to read.

While at it, drop the '# assume that it is change' comment.  According
to Jakub Nar=C4=99bski:

	What I meant here when I was writing it that they are lines that
	changed between two versions, like '!' in original (not unified)
	context format.

	We can omit this comment.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   96 +++++++++++++++++++++++++++-----------------=
-------
 1 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index db1f698..8271749 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5002,6 +5002,52 @@ sub git_difftree_body {
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
@@ -5028,51 +5074,11 @@ sub print_sidebyside_diff_chunk {
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
+		if (!$class || ((@rem || @add) && $class eq 'ctx')) {
+			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
+			@ctx =3D @rem =3D @add =3D ();
 		}
=20
 		## adding lines to accumulator
--=20
1.7.8.4
