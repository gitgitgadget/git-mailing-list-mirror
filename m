From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/10] merge-file --diff3: add a label for ancestor
Date: Mon, 15 Mar 2010 02:51:21 -0500
Message-ID: <20100315075121.GB8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 08:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr55B-00073L-Ik
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 08:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935686Ab0COHvV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 03:51:21 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:58718 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904Ab0COHvU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 03:51:20 -0400
Received: by gxk27 with SMTP id 27so388711gxk.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 00:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UQabFc2RTcs8t2MXr9oTXR1N1FoUZPerMBQrAs2ZQUI=;
        b=EKB6gZLFQ3g2Q2fsk8vGYVQa/T1HAxOp5/7ukPt+tfHQUSvinDpd0mkNq1jP1+8eYB
         Pm5vG3MsnFv1vKiBfdTQtJZ6CUg9zhOtFhybLjpsIwuQb/jaaK3ZzxdAFAmGdTizKLkt
         P0JN65NAZFRRKSj7hGQRJOsYjLE8Pd2Z2nYhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LQVxgBqgQXUl7k8iFdjuP9CWnuJ175GJPjg0cDr8uzpJ0n8o0gW1RpH7HYYOHt4SJp
         /i/a4SqrOWiNvJ23cyq02XpfAg4pLeBxAHsGH4SCUnSZnCXzlTv6MKCp3gdJ4OIwJEcz
         zTjveHm2c4zpS9oM51Eney/Im48vkzH23588Y=
Received: by 10.150.65.18 with SMTP id n18mr2911426yba.136.1268639479789;
        Mon, 15 Mar 2010 00:51:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3975308iwn.11.2010.03.15.00.51.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 00:51:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142178>

git merge-file --diff3 can be used to present conflicts hunks
including text from the common ancestor.

The added information can be very helpful for resolving a merge by
hand, and merge tools can usually grok it because it looks like output
from diff3 -m.  Unfortunately, some cannot reportedly, because =E2=80=98=
diff3=E2=80=99
includes a label for the merge base on the ||||||| line and some tools
cannot parse conflict hunks without such a label.  So write the
base-name as passed in a -L option (or the name of the =E2=80=9Cancesto=
r=E2=80=9D file
by default) on that line.

git rerere will not have trouble parsing this output, since instead of
looking for a newline, it looks for whitespace after the |||||||
marker.  No other code in git tries to parse conflict hunks.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This requires a slight change when merging with next.  A test was
added to t6023-merge-file.sh for the longer conflict markers;
the corresponding line in that new test needs to have new5.txt
added as well.

 builtin/merge-file.c  |    1 +
 t/t6023-merge-file.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 1e70073..0ff8b03 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -72,6 +72,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 					argv[i]);
 	}
=20
+	xmp.ancestor =3D names[1];
 	ret =3D xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
 			&xmp, XDL_MERGE_FLAGS(level, style, favor), &result);
=20
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
