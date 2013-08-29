From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: The gitweb author initials feature from a36817b doesn't work with
 i18n names
Date: Thu, 29 Aug 2013 16:26:29 +0200
Message-ID: <CACBZZX4i-Tu1G07e9=5DYFjY9EtRGO8gLJf71d5aLeaE-cj-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 16:26:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF3BW-00048Q-W7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab3H2O0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 10:26:50 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:47113 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3H2O0t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 10:26:49 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so644817oag.17
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DFXYJ2w2wmrZxMOpCSTaT8Md4qkoMtbf9sH4T2qvRaA=;
        b=JulylOauYWqsVG0wwhBVJAUNaG/tn1vLeTu1Z2BNwzbG/o9xDbdihbmCozfwkjvMkd
         gmiB7hcUosO/nmTFqGiNXAPmSyX8jBxyPSZLDrRgB6qbcXhjp8rG3OhGDBMHYp0O/l4f
         ijbgvUXbH010txagPkolv7a8JWiq5rQGGrgTwSMXoTZJgMpSwhLFrruFaBwA1SWN6dif
         oqp7mHEb3pTKQqbq2eCvNmWlagqrYop5npS28GM23G03CIxqYuW6mzMl3Y27hz7ctws1
         iz3z6C/6fi3mgtwV/0MzIs0AHMHyOjSeTKFoAUIw1KS8ejJC1i/EU7sRAiamPNh7pI0n
         bxVA==
X-Received: by 10.60.80.167 with SMTP id s7mr2729693oex.38.1377786409497; Thu,
 29 Aug 2013 07:26:49 -0700 (PDT)
Received: by 10.76.173.201 with HTTP; Thu, 29 Aug 2013 07:26:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233265>

The @author_initials feature Jakub added in a36817b claims to use a
i18n regexp (/\b([[:upper:]])\B/g), but in Perl this doesn't actually
do anything unless the string being matched against has the UTF8 flag.

So as a result it abbreviates me to "AB" not "=C3=86AB". Here's somethi=
ng
that demonstrates the issue:

$ cat author-initials.pl
#!/usr/bin/env perl
use strict;
use warnings;

#binmode STDOUT, ':utf8';
open my $fd, "-|", "git", "blame", "--incremental", "--", "Makefile"
or die "Can't open: $!";
#binmode $fd, ":utf8";
while (my $line =3D <$fd>) {
        next unless my ($author) =3D $line =3D~ /^author (.*)/;
        my @author_initials =3D ($author =3D~ /\b([[:upper:]])\B/g);
        printf "%s (%s)\n",  join("", @author_initials), $author;
}

With those two binmode commands commented out:

$ perl author-initials.pl |sort|uniq -c|sort -nr|head -n 5
     99 JH (Junio C Hamano)
     35 JN (Jonathan Nieder)
     35 JK (Jeff King)
     20 JS (Johannes Schindelin)
     16 AB (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason)

And uncommented:

$ perl author-initials.pl |sort|uniq -c|sort -nr|head -n 5
     99 JH (Junio C Hamano)
     35 JN (Jonathan Nieder)
     35 JK (Jeff King)
     20 JS (Johannes Schindelin)
     16 =C3=86AB (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason)

Jakub, do you see a reason not to just apply this:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f429f75..29b3fb5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6631,6 +6631,7 @@ sub git_blame_common {
                        $hash_base, '--', $file_name
                        or die_error(500, "Open git-blame --porcelain f=
ailed");
        }
+       binmode $fd, ":utf8";

        # incremental blame data returns early
        if ($format eq 'data') {

I haven't gotten an env where I can test gitweb running, but that
looks like it should work to me.
