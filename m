From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Fri, 30 Aug 2013 08:37:01 +0000
Message-ID: <1377851821-5412-1-git-send-email-avarab@gmail.com>
References: <20130829163935.GA9689@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 10:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFKCi-00064z-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 10:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab3H3IhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 04:37:10 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:54841 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab3H3IhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 04:37:07 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so759229eek.12
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BtwT+xxvie/ZIUdORk+oYv+TQzJItLs+WaPexe4fJdQ=;
        b=pPnrCiNFIWjc8qq+yNAMzKkgV/tLUp+Jgd2OLxqCXVyeUJ2InefAqjnajwjFSpBMIY
         g8ImpKCXLeumKjjF888xxyBeUFgzmxRTEKeFsZ9z8xa4IaUoFk5VR2EefE53b/ilYHlJ
         CVuY2pdC7QlCjIWwvUs2cpJhrMtESs5cYxYH8CsUyiywpX/6SmIq5Bat7Ir9OdmVCUfL
         d/bSahPL/DuYDIsHngeQgD6X32MUbaTPtfzskvgleQsmSTx0HicBYV6O+ZX/GKBD1bH9
         S0BlySFZgrsBBNVAzkKyKbAM4F+czVMnXU98eZGw6YG63FbdFXw6M7z4RI2CQqF4+djg
         UZIg==
X-Received: by 10.14.111.9 with SMTP id v9mr10776614eeg.35.1377851826254;
        Fri, 30 Aug 2013 01:37:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by mx.google.com with ESMTPSA id z12sm52721997eev.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 01:37:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
In-Reply-To: <20130829163935.GA9689@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233433>

Change the @author_initials feature Jakub added in
v1.6.4-rc2-14-ga36817b to match non-ASCII author initials as intended.

The regexp Jakub added was intended to match
non-ASCII (/\b([[:upper:]])\B/g). But in Perl this doesn't actually
match non-ASCII upper-case characters unless the string being matched
against has the UTF8 flag.

So when we open a pipe to "git blame" we need to mark the file
descriptor we're opening as utf8 explicitly.

So as a result it abbreviates me to "AB" not "=C3=86AB", entirely becau=
se "=C3=86"
isn't /[[:upper:]]/ unless the string being matched against has the UTF=
8
flag.

Here's something that demonstrates the issue:

    #!/usr/bin/env perl
    use strict;
    use warnings;

    binmode STDOUT, ':utf8' if $ENV{UTF8};
    open my $fd, "-|", "git", "blame", "--incremental", "--", "Makefile=
" or die "Can't open: $!";
    binmode $fd, ":utf8" if $ENV{UTF8};
    while (my $line =3D <$fd>) {
    	next unless my ($author) =3D $line =3D~ /^author (.*)/;
    	my @author_initials =3D ($author =3D~ /\b([[:upper:]])\B/g);
    	printf "%s (%s)\n",  join("", @author_initials), $author;
    }

When that's run with and without UTF8 being true in the environment it
gives, on git.git:

    $ UTF8=3D0 perl author-initials.pl | sort | uniq -c |
    sort -nr | head -n 5
         99 JH (Junio C Hamano)
         35 JN (Jonathan Nieder)
         35 JK (Jeff King)
         20 JS (Johannes Schindelin)
         16 AB (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason)
    $ UTF8=3D1 perl author-initials.pl | sort | uniq -c |
    sort -nr | head -n 5
         99 JH (Junio C Hamano)
         35 JN (Jonathan Nieder)
         35 JK (Jeff King)
         20 JS (Johannes Schindelin)
         16 =C3=86AB (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason)

Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Tested-by: Simon Ruderich <simon@ruderich.org>
---
 gitweb/gitweb.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f429f75..ad48a5a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6631,6 +6631,7 @@ sub git_blame_common {
 			$hash_base, '--', $file_name
 			or die_error(500, "Open git-blame --porcelain failed");
 	}
+	binmode $fh, ':utf8';
=20
 	# incremental blame data returns early
 	if ($format eq 'data') {
--=20
1.8.4.rc2
