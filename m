From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/14] merge-file --diff3: add a label for ancestor
Date: Sat, 20 Mar 2010 19:37:33 -0500
Message-ID: <20100321003733.GF23681@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt99k-0000Dh-9D
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab0CUAgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:36:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54746 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab0CUAge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:36:34 -0400
Received: by gyg8 with SMTP id 8so2111553gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DunjrQOjS4QxTTZIEVXZVVJ2VyCdWMbgfNBeCT2ERB0=;
        b=qfbw0PSjz1LNA+kCOvV97rjcIRgJDcRJ+HBzLiZxtpqeINXhX+ExbhgaHxSs60PDY3
         f20CIrf5qdSHd1xq+RjEtWNJootQ5VKXj7uSkdoZ6yQ/O2bmFVNQYoy1iZxRmDqrh/xt
         31LEijtFCtxOnuLSJazSuaL3hYXyc5YX/tm8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qbZCyhy/IzjV74S/66+9o74x/yUHChohF9uy0vyZkjOibvxw78ZycDCbAKhGH7jo8L
         R30UdavsG96ZCJUN7UWSL9efQu7kWW5lgnd944pUxLy8vjMkLul/E+qhOyC4qF8+D8Fd
         jnpK5omKyOlGMGB1lKAQS9NDxsn8ACRLpIG5o=
Received: by 10.150.120.15 with SMTP id s15mr9627369ybc.143.1269131793287;
        Sat, 20 Mar 2010 17:36:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1865028iwn.11.2010.03.20.17.36.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:36:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142773>

git merge-file --diff3 can be used to present conflicts hunks
including text from the common ancestor.

The added information is helpful for resolving a merge by hand, and
merge tools can usually grok it because it looks like output from
diff3 -m.  However, =E2=80=98diff3=E2=80=99 includes a label for the me=
rge base on the
||||||| line and some tools cannot parse conflict hunks without such a
label.  Write the base-name as passed in a -L option (or the name of
the ancestor file by default) on that line.

git rerere will not have trouble parsing this output, since instead of
looking for a newline, it looks for whitespace after the |||||||
marker.  Since rerere includes its own code for recreating conflict
hunks, conflict identifiers are unaffected.  No other code in git tries
to parse conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Adapts test for 11f3aa23 (merge-file: add option to specify the marker
size, 2010-03-01) as described at
<http://thread.gmane.org/gmane.comp.version-control.git/142374/focus=3D=
142378>.

 builtin/merge-file.c  |    1 +
 t/t6023-merge-file.sh |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 65eb790..610849a 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -77,6 +77,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 					argv[i]);
 	}
=20
+	xmp.ancestor =3D names[1];
 	xmp.file1 =3D names[0];
 	xmp.file2 =3D names[2];
 	ret =3D xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 5034dd1..d486d73 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -181,7 +181,7 @@ et nihil mihi deerit;
=20
 In loco pascuae ibi me collocavit;
 super aquam refectionis educavit me.
-|||||||
+||||||| new5.txt
 et nihil mihi deerit.
 In loco pascuae ibi me collocavit,
 super aquam refectionis educavit me;
@@ -225,7 +225,7 @@ et nihil mihi deerit;
=20
 In loco pascuae ibi me collocavit;
 super aquam refectionis educavit me.
-||||||||||
+|||||||||| new5.txt
 et nihil mihi deerit.
 In loco pascuae ibi me collocavit,
 super aquam refectionis educavit me;
--=20
1.7.0.2
