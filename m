From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/16] merge-file --diff3: add a label for ancestor
Date: Wed, 17 Mar 2010 06:57:31 -0500
Message-ID: <20100317115731.GC25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 12:57:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrrsB-0000xN-P8
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 12:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab0CQL5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 07:57:10 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:57298 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab0CQL5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 07:57:08 -0400
Received: by qyk9 with SMTP id 9so492944qyk.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Pq7yYrFtYteFK3AWpt6NyfnWPmHFxNTGgCNTSdIJ9GU=;
        b=AUpybMnZWNasy8TP7PrTO8Woz6IgNWNF50sQKZsOw3nNK8pQHivux2sSethuDo3heE
         xj0IAOqAovv0OT9Bb7s7ND568o+qR5TOuQzU09zUVtpj2ufjxtI5caqQNAbNzCXCz0OI
         GcHX8EKe3I/dQdPXjnOlpoo7enfxXvzcmrlQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F+RQmhDZsxF4u8/I11KtODjBLm01ckJNQbCgFMvlt5T7XP/PIV+Q366L3EjoiogwVI
         aUlGHDep3gI8qgjDe+Slxz3qr3cS5VyjW8jI2uWqXzuR8+CdUyhSxBtIwz88rEqLPvUO
         6AfLLjygPcr/nBJ1u/Vrt/xi+1pB2SL8913Do=
Received: by 10.224.105.66 with SMTP id s2mr218578qao.254.1268827026943;
        Wed, 17 Mar 2010 04:57:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6278442iwn.11.2010.03.17.04.57.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 04:57:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142378>

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
t/t6023-merge-files.sh needs another change when merging to next.

@@ -225,7 +225,7 @@ et nihil mihi deerit;

 In loco pascuae ibi me collocavit;
 super aquam refectionis educavit me.
-||||||||||
+|||||||||| new5.txt
 et nihil mihi deerit.
 In loco pascuae ibi me collocavit,
 super aquam refectionis educavit me;

 builtin/merge-file.c  |    1 +
 t/t6023-merge-file.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index ade1e8b..04cb67a 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -72,6 +72,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 					argv[i]);
 	}
=20
+	xmp.ancestor =3D names[1];
 	xmp.file1 =3D names[0];
 	xmp.file2 =3D names[2];
 	ret =3D xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp,
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index d605024..16c3c69 100755
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
--=20
1.7.0
