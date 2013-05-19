From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 17:27:06 +0700
Message-ID: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pA-0006XP-FR
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab3ESK0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:16 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35187 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3ESK0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:13 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so2837765pbc.2
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=LqFNYju84n7uV2g9TOJNLOEELuDSbGDA3a9w7W3iBYc=;
        b=ZKY6Lzd05Ee/eLdg3/nPJ0p8VR4RBBZ+yvQwIMS5exO6bMJpOPj+dOHdG+iddljcnH
         7rtCTKFpwYAKjeeyZUjFRp6U6Ac32OYg+csgjaShjkrwofmEDg/p5F1tMpGh+abYQQPZ
         tDDv0ixEBNZGSdDALHfv8Ua9LiQ+OY8JXs62w/9yWYaSZMdmbIGBLkrIA3vo6JirBau9
         q5MZOtbchxmB9K4X+tXQChLXwKE9572OxzU0uly02UQlcGI7NWa1bJsDtNNrWkOoZ/Yw
         jwuR1FaJiPPMNLUsTmho1XM6Fn9Vg1+W/dDI7biWC3jP7F16TOC56kyA7kM5Hpw+wqiD
         EGSw==
X-Received: by 10.68.197.2 with SMTP id iq2mr56939475pbc.33.1368959172875;
        Sun, 19 May 2013 03:26:12 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id vu10sm19214542pbc.27.2013.05.19.03.26.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224837>

The purpose of this series is to make "for-each-ref --format" powerful
enough to display what "branch -v" and "branch -vv" do so that we
could get rid of those display code and use for-each-ref code instead.

The benefits are clear: share more code, branch can also borrow
--sort and --format from for-each-ref, which should satisty users who
are not happy with what -v and -vv provides.

This version has not gotten there yet. I just want to post quick and
dirty changes and try to address some design issues.

Originally I wanted to introduce --pretty with git-log's pretty syntax
to for-each-ref, deprecating --format. But because --format has to be
there forever, we cannot remove its code, and the code change to make
pretty code ready for displaying refs may not be small. So I went with
enhancing --format syntax instead.

This series introduces:

 - %(current), which either shows "*" if the ref is pointed by HEAD
   or a space. Junio called it %(headness). I don't like that.
   I don't like %(current) either but we have to start somewhere.
   Name suggestion? %(marker)??

 - %(tracking[:upstream]) gives us the exact output that branch -v[v]
   does. %(upstream) does not include []. We can't change its
   semantics.
=20
 - %(color:...) is pretty much the same as %C family in pretty code.
   I haven't added code for %(color:foo) =3D=3D %C(foo) yet. There's a
   potential ambiguity here: %C(red) =3D=3D %Cred or %C(red)??

 - %(...:aligned) to do left aligning. I'm not entirely sure about
   this. We might be able to share code with %>, %< and %>< from
   pretty.c. But we need improvements there too because in
   for-each-ref case, we could calculate column width but %< would
   require the user to specify the width.

   Do people expect fancy layout with for-each-ref (and branch)? If so
   we might need to have %(align) or something instead of the simple
   left alignment case in %(...:aligned)
=20
 - We may need an equivalent of the space following % in pretty
   format. If the specifier produces something, then prepend a space,
   otherwise produce nothing. Do it like %C( tracking) vs
   %C(tracking)??

You can try this after applying the series, which should give you the
about close to 'branch -v'. %(tracking) coloring does not work though.

git for-each-ref --format=3D'%(current) %(color:auto)%(refname:short:al=
igned)%(color:reset) %%(objectname:short) %(tracking) %(subject)' 'refs=
/heads/*'

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  quote.c: make sq_quote_print a slight wrapper of sq_quote_buf
  for-each-ref: convert to use *_quote_buf instead of _quote_print
  for-each-ref: avoid printing each element directly to stdout
  for-each-ref: add %(current) for current branch marker
  for-each-ref: add %(tracking[:upstream]) for tracking info
  for-each-ref: add %(color:...)
  for-each-ref: prepoplulate all atoms before show_ref()
  for-each-ref: merge show_ref into show_refs
  for-each-ref: support %(...:aligned) for left alignment

 branch.h               |  11 ++++
 builtin/branch.c       |  16 ++----
 builtin/for-each-ref.c | 146 +++++++++++++++++++++++++++++++++++++++++=
+-------
 quote.c                |  61 +++++++++------------
 quote.h                |   6 +-
 5 files changed, 170 insertions(+), 70 deletions(-)

--=20
1.8.2.83.gc99314b
