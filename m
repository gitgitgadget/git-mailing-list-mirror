From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-add--interactive: Preserve diff heading when splitting hunks
Date: Sun, 11 May 2014 16:09:56 +0000
Message-ID: <1399824596-4670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 18:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjWKO-0006RF-Mb
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 18:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbaEKQKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2014 12:10:04 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:45088 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbaEKQKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 12:10:02 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so3976637eei.0
        for <git@vger.kernel.org>; Sun, 11 May 2014 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Qg7qhoeIvFj5D7E2kXGpnnF3WtTDeqKXCbdbbWGhTv8=;
        b=QxqFwFnRzrpoaKV185kyyu3VjXvezyTAuHw3wzOCyZsGj0Kb1NSSntSYlpiLHsSqYz
         thMbPddhal17T5fVQZvF5kaupTTdIcopOEW0fAzjs8ZdEdW604ZhB7ayK9m+IBHYdvXM
         67yOObIoDR26GiO4FARi1Sb8993/YyIxq2IeFKKrU+n06gDRKvhyOoNL0JScu0P87wcE
         dcDHI4me7tKwoSuEGLCZ4+BFmAuH5Lp/ys750/Q6Q2eY5oFl1FSdWrDZABCO5VUqaNmd
         xA4WF0WB/fWMpQP600qRW/PkU6ZtQHMpr2K/sNldRiCfGgQQQMUFdnw2NERJ5jdZKR8y
         S7Cw==
X-Received: by 10.15.49.8 with SMTP id i8mr24051732eew.33.1399824600868;
        Sun, 11 May 2014 09:10:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by mx.google.com with ESMTPSA id w6sm26451271eej.7.2014.05.11.09.09.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 May 2014 09:09:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248674>

Change the display of hunks in hunk splitting mode to preserve the diff
heading, which hasn't been done ever since the hunk splitting was
initially added in v1.4.4.2-270-g835b2ae.

Splitting the first hunk of this patch will now result in:

    Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
    Split into 2 hunks.
    @@ -792,7 +792,7 @@ sub hunk_splittable {
    [...]

Instead of:

    Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
    Split into 2 hunks.
    @@ -792,7 +792,7 @@
    [...]

This makes it easier to use the tool when you're splitting some giant
hunk and can't remember in which function you are anymore.

The diff is somewhat larger than I initially expected because in order
to display the headings in the same color scheme as the output from
git-diff(1) itself I had to split up the code that would previously
color diff output that previously consisted entirely of the fraginfo,
but now consists of the fraginfo and the diff heading (the latter of
which isn't colored).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-add--interactive.perl | 40 ++++++++++++++++++++++++---------------=
-
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 1fadd69..ed1e564 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -792,11 +792,11 @@ sub hunk_splittable {
=20
 sub parse_hunk_header {
 	my ($line) =3D @_;
-	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =3D
-	    $line =3D~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/;
+	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt, $heading) =3D
+	    $line =3D~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@(.*)/;
 	$o_cnt =3D 1 unless defined $o_cnt;
 	$n_cnt =3D 1 unless defined $n_cnt;
-	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
+	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt, $heading);
 }
=20
 sub split_hunk {
@@ -808,8 +808,7 @@ sub split_hunk {
 	# If there are context lines in the middle of a hunk,
 	# it can be split, but we would need to take care of
 	# overlaps later.
-
-	my ($o_ofs, undef, $n_ofs) =3D parse_hunk_header($text->[0]);
+	my ($o_ofs, undef, $n_ofs, undef, $heading) =3D parse_hunk_header($te=
xt->[0]);
 	my $hunk_start =3D 1;
=20
       OUTER:
@@ -886,17 +885,26 @@ sub split_hunk {
 		my $o_cnt =3D $hunk->{OCNT};
 		my $n_cnt =3D $hunk->{NCNT};
=20
-		my $head =3D ("@@ -$o_ofs" .
-			    (($o_cnt !=3D 1) ? ",$o_cnt" : '') .
-			    " +$n_ofs" .
-			    (($n_cnt !=3D 1) ? ",$n_cnt" : '') .
-			    " @@\n");
-		my $display_head =3D $head;
-		unshift @{$hunk->{TEXT}}, $head;
-		if ($diff_use_color) {
-			$display_head =3D colored($fraginfo_color, $head);
-		}
-		unshift @{$hunk->{DISPLAY}}, $display_head;
+		my $fraginfo =3D join(
+			"",
+			"@@ -$o_ofs",
+			(($o_cnt !=3D 1) ? ",$o_cnt" : ''),
+			" +$n_ofs",
+			(($n_cnt !=3D 1) ? ",$n_cnt" : ''),
+			" @@"
+		);
+		unshift @{$hunk->{TEXT}}, join(
+			"",
+			$fraginfo,
+			$heading,
+			"\n"
+		);
+		unshift @{$hunk->{DISPLAY}}, join(
+			"",
+			$diff_use_color ? colored($fraginfo_color, $fraginfo) : $fraginfo,
+			$heading,
+			"\n"
+		);
 	}
 	return @split;
 }
--=20
2.0.0.rc0
