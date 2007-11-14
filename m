From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 11:19:05 +0100
Message-ID: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 11:20:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsFLE-00037q-Jt
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 11:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbXKNKTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 05:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbXKNKTL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 05:19:11 -0500
Received: from wincent.com ([72.3.236.74]:35255 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982AbXKNKTJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 05:19:09 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAEAJ6xL009180;
	Wed, 14 Nov 2007 04:19:07 -0600
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64978>

Help new contributors by providing some advice about line-wrapping; the
advice basically boils down to "use 80-characters minus some slop as a
rule of thumb", but also "use common sense", and "avoid gratuitous
rewrapping".

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

The advice is based on the following post by Junio:

El 14/11/2007, a las 10:27, Junio C Hamano escribi=F3:

> I did not mean to say 70 was the official limit.  Indeed, there
> is no hard official limit (and there shouldn't be any "hard"
> limit).  But 70 should certainly be lower than the limit anybody
> around here would want to impose, and that was why I said 70.
>
> Some considerations:
>
> - Many of us read the unformatted ASCII version, as AsciiDoc
>   was designed to be very readable, and mixing excessively long
>   and short lines will make the document harder to read.
>
> - We tend to exchange patches over e-mail and assume everybody
>   has at least 80-column wide terminals, so although we say a
>   line should be less than 80-chars, in practice the limit is
>   somewhat lower. to accomodate diff change marks [-+ ] and
>   quoting ">> " in e-mails.
>
> - But "80-chars minus a bit of slop" is not a very hard limit.
>
> Please apply some common sense to decide when to re-wrap and
> when not to within these constraints.


I also whipped up this quick Ruby script to print a histogram of line =20
widths in the tree. You would run it like this to get a feel for the =20
typical line lengths of the different types of file in the tree:

check-column-widths.rb *.c *.h
check-column-widths.rb *.sh
check-column-widths.rb *.perl
check-column-widths.rb Documentation/*.txt

A statistician could probably make some interesting comments about the =
=20
results, but the basic trend is that, while there are plenty of =20
examples of isolated long lines in the source tree (the longest is a =20
287-character line in one of the perl scripts), the frequency starts =20
to drop off pretty rapidly once you pass 70 columns and start climbing =
=20
towards 80.

#!/usr/bin/env ruby

extensions =3D {}

# count frequency of line widths
ARGV.each do |arg|
   f =3D File.new arg
   extname =3D File.extname arg
   unless file_type =3D extensions[extname]
     extensions[extname] =3D file_type =3D {}
   end
   f.readlines.each do |line|
     len =3D line.chomp.length
     count =3D (file_type[len] or 0)
     file_type[len] =3D count + 1
   end
end

# print results
extensions.each do |file_type, frequencies|
   puts "Frequencies for #{file_type} files"

   # find longest line, most frequent line width, total line count
   longest       =3D frequencies.max { |a, b| a[0] <=3D> b[0] }[0]
   most_frequent =3D frequencies.max { |a, b| a[1] <=3D> b[1] }[1]
   total_lines   =3D frequencies.inject(0) { |sum, a| sum + a[1] }

   # draw histogram
   for i in 0..longest
     next if frequencies[i].nil?
     puts "%4d [%4d]: %s" % [i, frequencies[i], '.' * (frequencies[i] =20
* 60 / most_frequent)]
   end
   puts "Maximum length: #{longest}"
   puts "   Total lines: #{total_lines}"
end

  Documentation/CodingGuidelines |   22 ++++++++++++++++++++++
  1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/=20
CodingGuidelines
index 3b042db..3fd698e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -110,3 +110,25 @@ For C programs:
     used in the git core command set (unless your command is clearly
     separate from it, such as an importer to convert random-scm-X
     repositories to git).
+
+Line wrapping:
+
+ - While there are no official hard limits for line wrapping, we
+   generally try to keep shell scripts, C source files and AsciiDoc
+   documentation within the range of "80-characters minus some
+   slop".
+
+ - We assume that everyone has terminals that are at least 80
+   columns wide.
+
+ - In practice, we try to keep lines somewhat narrower than 80
+   columns to accommodate diff change marks [-+ ] and quoting ">> "
+   in emails.
+
+ - In the case of documentation, mixing excessively long and short
+   lines may make the AsciiDoc source harder to read, so try to
+   keep line lengths consistent.
+
+ - When submitting patches use common sense to decide whether to
+   rewrap, avoiding gratuitous changes.
+
--=20
1.5.3.5
