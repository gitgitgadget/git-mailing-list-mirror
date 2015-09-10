From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-svn: parse authors file more leniently
Date: Thu, 10 Sep 2015 14:32:13 +0200
Message-ID: <03f07c11135aef9e04a26e5b1018d726ba2fab5d.1441887195.git.git@drmicha.warpmail.net>
References: <5613050.3arVUQYvEz@granit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?q?Till=20Sch=C3=A4fer?= <till2.schaefer@tu-dortmund.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 14:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za11f-0008PU-58
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 14:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbbIJMcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 08:32:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57869 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753426AbbIJMcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 08:32:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8CCFE212B5
	for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:32:15 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 10 Sep 2015 08:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=WmZQUjrxMOiwoAEHOP1xXQrlR1g=; b=R275fr
	BWL7UqETyXuS7Q9O48V6A+omIXuZtTaE04I7yJ6UgW1ad8tDC9rz/845dx0g7+Hu
	lOe0/9EE2rjEZDKno8nzL0XC/8T3C/9UOa5Tav/zNkCpiN3MfqEVPr57DfKJjDbj
	947fa5rMLMlXKYTB6k+rZhDZiXbTCRUzVy8bs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=WmZQUjrxMOiwoAE
	HOP1xXQrlR1g=; b=A7/sTtjvkJdhnvqZ6x6X2Ekc63nZ5IUZykuwV4e3+Ws9GM+
	+Ae2OoJyHo//PGKOQDPvaCnM15Yn6A2GfZ+NbfuTsxDcqL48GshyY8F4nO3XicOv
	fjY4VlIuorOZIOl60bIRTPNdVUGvQB909RSzKTmqY2TXqkuqBEuYQpCvuiGk=
X-Sasl-enc: L7gydxFEn+G9xUwhwhlTEXxgSzsr/JbeIaLtBc96IVl3 1441888335
Received: from localhost (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1025468006C;
	Thu, 10 Sep 2015 08:32:14 -0400 (EDT)
X-Mailer: git-send-email 2.6.0.rc0.178.g4177fa5
In-Reply-To: <5613050.3arVUQYvEz@granit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277580>

Currently, git-svn parses an authors file using the perl regex

/^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.+)>\s*$/

in order to extract svn user name, real name and e-mail.
This does not match an empty e-mail field like "<>". On the other hand,
the output of an authors-prog is parsed with the perl regex

/^\s*(.+?)\s*<(.*)>\s*$/

in order to extract real name and e-mail.

So, specifying a trivial file grep such as

grep "$1" /tmp/authors | head -n 1 | cut -d'=3D' -f2 | cut -c'2-'

as the authors prog gives different results compared to specifying
/tmp/authors as the authors file directly.

Instead, make git svn uses the perl regex

/^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.*)>\s*$/

for parsing the authors file so that the same (slightly more lenient)
regex is used in both cases.

Reported-by: Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-svn.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 36f7240..fa5f253 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1924,7 +1924,7 @@ sub load_authors {
 	my $log =3D $cmd eq 'log';
 	while (<$authors>) {
 		chomp;
-		next unless /^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.+)>\s*$/;
+		next unless /^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.*)>\s*$/;
 		my ($user, $name, $email) =3D ($1, $2, $3);
 		if ($log) {
 			$Git::SVN::Log::rusers{"$name <$email>"} =3D $user;
--=20
2.6.0.rc0.178.g4177fa5
