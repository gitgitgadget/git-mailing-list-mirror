From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH 0/5] Cure some format-patch wrapping and encoding issues
Date: Mon,  8 Oct 2012 19:33:24 +0200
Message-ID: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 19:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHNg-0004Jv-3J
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab2JHRoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 13:44:30 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:48284 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2JHRo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:44:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 4DE827D8B
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 19:34:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id 2cJNi7pGcuZu 02495-18;
	Mon,  8 Oct 2012 19:34:25 +0200 (CEST) 13707
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Mon,  8 Oct 2012 19:34:25 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207247>

Hi all.

The main point of this series is to teach git to encode my name
correctly, see patch 4, so that the decoded version is actually
my name, so that send-email does not insist on adding a wrong
superfluous From: line to the mail body.

But as always, you notice some other things going wrong. Here,
patches 1 and 2 make the wrapping of header lines more correct,
i. e., neither too early nor too late.

Patch 3 does some refactoring, which is too unrelated to be included
in patch 4 itself.

Patch 5 points out further problems, but leaves the actual fixing
to someone else.

The series is currently based on the maint branch, but it applies
to the others as well.



During the creation of this series, I came across the strbuf=20
wrapping functions, and I wonder if there is an off-by-one issue.

Consider the following excerpt from t4202:

cat > expect << EOF
 This is
  the sixth
  commit.
 This is
  the fifth
  commit.
EOF

test_expect_success 'format %w(12,1,2)' '

	git log -2 --format=3D"%w(12,1,2)This is the %s commit." > actual &&
	test_cmp expect actual
'

So this sets a maximum width of 12 characters. Is that 12 character lim=
it
supposed to include the final newline, or not? Because the test above a=
nd
my series are only correct if the final newline is included, i. e., at =
most
eleven visible characters.

If this should mean at most 12 visible characters instead, then the out=
put
should look like this:

 This is the
  sixth
  commit.
 This is the
  fifth
  commit.

(In that case, I would repost an updated version of this series.)

Regards
Jan


Jan H. Sch=C3=B6nherr (5):
  format-patch: do not wrap non-rfc2047 headers too early
  format-patch: do not wrap rfc2047 encoded headers too late
  format-patch: introduce helper function last_line_length()
  format-patch: fix rfc2047 address encoding with respect to rfc822
    specials
  format-patch: tests: check rfc822+rfc2047 in to+cc headers

 pretty.c                | 121 ++++++++++++++++++--------
 t/t4014-format-patch.sh | 227 ++++++++++++++++++++++++++++++----------=
--------
 2 Dateien ge=C3=A4ndert, 229 Zeilen hinzugef=C3=BCgt(+), 119 Zeilen en=
tfernt(-)

--=20
1.7.12
