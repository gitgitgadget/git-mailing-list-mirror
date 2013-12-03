From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 3/3] gitweb: Denote non-heads, non-remotes branches.
Date: Tue,  3 Dec 2013 15:56:43 +0100
Message-ID: <1386082603-8404-4-git-send-email-krzesimir@endocode.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 15:57:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnrQ6-0006xp-0x
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 15:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab3LCO5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 09:57:44 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:38267 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3LCO5l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 09:57:41 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so6105160bkh.31
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 06:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=e1hV9JCnA+27mQ8Y4Hx/+7UI2cQ2q47nwxNhCRUUEAQ=;
        b=NYM9udtKQ3MAkHJKxM4BNVSKuUezSKAaRXxmSgw9PDnPuio0b6dX2RiIXcMb7AbObz
         5TDvfCYiejDu8tYp71Hij5te79v3/LyG45qLF3jvmLdBFuT/bQqucppa3kMvJeT8ygdp
         0wBb/JworaubuI+QoYTq7RmV8H0AY8GH/dS8Me81Xy1Efo5Yjv84XWew4saBxHewW3Pp
         AwqG/1qgGZSqpzTsejfpBUduO6EzGg+Smq/lJtdiQqrFvQ08Y4P2GkIVNbPK9+9i61bX
         oz3T0DiDi5y/AuiZvY+h+Xn9vJCBSK8AoQKw6+kHnU6r+N8WgUfre3mlE1p9t4diQTit
         gWLA==
X-Gm-Message-State: ALoCoQnVQCCxwqzxaFc4nR/vtkE4z9Ve+Y9gu62Ni9XJ5mACkSfeNn7tiG9SSNtg9wK19kBf5czT
X-Received: by 10.204.100.130 with SMTP id y2mr415889bkn.122.1386082659890;
        Tue, 03 Dec 2013 06:57:39 -0800 (PST)
Received: from localhost.localdomain (p5792264C.dip0.t-ipconnect.de. [87.146.38.76])
        by mx.google.com with ESMTPSA id bf8sm30500407bkb.14.2013.12.03.06.57.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2013 06:57:39 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238694>

Given two branches residing in refs/heads/master and refs/wip/feature
the list-of-branches view will present them in following way:
master
feature (wip)

When getting a snapshot of a 'feature' branch, the tarball is going to
have name like 'project-wip-feature-<short hash>.tgz'.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
---
 gitweb/gitweb.perl | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6326075..eb8d962 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3723,8 +3723,14 @@ sub git_get_heads_list {
 		$ref_item{'fullname'}  =3D $name;
 		my $strip_refs =3D join '|', map { quotemeta } get_branch_refs();
 		$name =3D~ s!^refs/($strip_refs|remotes)/!!;
+		$ref_item{'name'} =3D $name;
+		# for refs neither in 'heads' nor 'remotes' we want to
+		# show their different ref dir
+		my $ref_dir =3D (defined $1) ? $1 : '';
+		if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes'=
) {
+		    $ref_item{'name'} .=3D ' (' . $ref_dir . ')';
+		}
=20
-		$ref_item{'name'}  =3D $name;
 		$ref_item{'id'}    =3D $hash;
 		$ref_item{'title'} =3D $title || '(no commit message)';
 		$ref_item{'epoch'} =3D $epoch;
@@ -7241,7 +7247,24 @@ sub snapshot_name {
 		# branches and other need shortened SHA-1 hash
 		my $strip_refs =3D join '|', map { quotemeta } get_branch_refs();
 		if ($hash =3D~ m!^refs/($strip_refs|remotes)/(.*)$!) {
-			$ver =3D $1;
+			my $ref_dir =3D $1;
+			$ver =3D $2;
+
+			if (defined $ref_dir) {
+				# this is going to be a part of
+				# filename, so lets stick to
+				# alphanumerics, dashes and underlines
+				# only - some filesystems do not like
+				# some punctuation symbols for
+				# example.
+				$ref_dir =3D~ s/[^[:alnum:]_-]//g;
+			}
+
+			# for refs not in heads nor remotes we want to
+			# add a ref dir to archive name
+			if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes=
') {
+				$ver =3D $ref_dir . '-' . $ver;
+			}
 		}
 		$ver .=3D '-' . git_get_short_hash($project, $hash);
 	}
--=20
1.8.3.1
