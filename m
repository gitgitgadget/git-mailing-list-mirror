From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] fast-import: be strict about formatting of raw dates
Date: Sat, 24 Apr 2010 15:50:36 -0500
Message-ID: <20100424205036.GB24948@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock>
 <20100424190419.GA7502@spearce.org>
 <20100424203827.GA24948@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 24 22:50:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5mIt-0002kg-T0
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 22:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab0DXUuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 16:50:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38354 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0DXUt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 16:49:59 -0400
Received: by gyg13 with SMTP id 13so5690158gyg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pcB443e5AgBsmPPH+PsPBugfZMQb4DqdKy/QP8Zju/s=;
        b=pyeKJ8Tl2AQr7/ipTTnhIOX3iebMmm/OsR4HcJ/r0jiyBCYfJ9w5pX7pGo4uwrNNDu
         obnFO6Zb3VVUoDANpTJDxgybPaa775yexqj/iE5fOkJ/ARVRpmEuOYIfvrh7q2Id92E9
         1ZEjG+svsCMpiVgRhN+LASwu54wTMmmYo/TCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UJPsmD2a+3ozJtkR+o+6XY3rDWzjkUYhqIAKyifqc3kymUwj/s1EpC9AQIZrnJ0UxP
         38KO2x/P4FjNDFY6NMc7DlQwdgZGKOBgoZcPVxR8MEQqE8ZWt/JevbpeXaItsRJL/wFG
         Qcym/Em8hXuQBv4lZtacnCw6uN8mwxFW3hEOA=
Received: by 10.150.244.9 with SMTP id r9mr1925943ybh.24.1272142198989;
        Sat, 24 Apr 2010 13:49:58 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1758980iwn.12.2010.04.24.13.49.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 13:49:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424203827.GA24948@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145703>

git proper never zero- or space-pads its dates and its time zones are
always 4 digits long.  Require fast-import front-ends to behave
likewise to avoid generating puzzling objects.

Since this makes the input format more strict, some front-ends may not
be happy.  But they were warned:

   This is the Git native format and is <time> SP <offutc>. It is also
   fast-import=E2=80=99s default format, if --date-format was not speci=
fied.

   Unlike the rfc2822 format, this format is very strict. Any variation
   in formatting will cause fast-import to reject the value.

Aside from ensuring the format is predictable so tools like git can
handle it, making the date format this strict ensures that there is
only one valid representation for a given date and time zone, which
would be useful for round-trip conversion of objects to and from other
formats (for storage by other version control systems, for example).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Is -0000 the same time zone as +0000?  I wasn=E2=80=99t sure so I erred=
 on the
side of not worrying about it.

 fast-import.c          |    9 +++++++--
 t/t9300-fast-import.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 74f08bd..1701cf1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1906,6 +1906,8 @@ static int validate_raw_date(const char *src, cha=
r *result, int maxlen)
=20
 	errno =3D 0;
=20
+	if ((*src =3D=3D '0' && isdigit(src[1])) || !isdigit(*src))
+		return -1;
 	num =3D strtoul(src, &endp, 10);
 	/* NEEDSWORK: perhaps check for reasonable values? */
 	if (errno || endp =3D=3D src || *endp !=3D ' ')
@@ -1915,8 +1917,11 @@ static int validate_raw_date(const char *src, ch=
ar *result, int maxlen)
 	if (*src !=3D '-' && *src !=3D '+')
 		return -1;
=20
-	num =3D strtoul(src + 1, &endp, 10);
-	if (errno || endp =3D=3D src + 1 || *endp || (endp - orig_src) >=3D m=
axlen ||
+	src++;
+	if (*src !=3D '0' && *src !=3D '1')
+		return -1;
+	num =3D strtoul(src, &endp, 10);
+	if (errno || endp !=3D src + 4 || *endp || (endp - orig_src) >=3D max=
len ||
 	    1400 < num)
 		return -1;
=20
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 131f032..ed653a7 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -348,6 +348,36 @@ test_expect_success \
=20
 cat >input <<INPUT_END
 commit refs/heads/branch
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170783301 -  0500
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 117078330 -0500
+data <<COMMIT
+Malformed time zone
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: blanks in raw time zone' '
+    test_must_fail git fast-import --date-format=3Draw <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 01170783301 -0500
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 117078330 -0500
+data <<COMMIT
+Malformed date
+COMMIT
+
+from refs/heads/branch^0
+
+INPUT_END
+test_expect_success 'E: leading zero in raw date' '
+    test_must_fail git fast-import --date-format=3Draw <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/branch
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0=
500
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:0=
2 2007 -0500
 data <<COMMIT
--=20
1.7.1.rc1
