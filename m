From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] cherry-pick: do not dump core when iconv fails
Date: Sat, 8 May 2010 18:17:29 -0500
Message-ID: <20100508231729.GA6718@progeny.tock>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
 <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
 <20100428233758.GA1654@progeny.tock>
 <20100429191150.GA10526@inner.home.ulmdo.de>
 <20100429194936.GA31941@progeny.tock>
 <20100429202139.GW10879@inner.home.ulmdo.de>
 <20100430133228.GA1620@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 09 01:17:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAtGo-0001wv-WA
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 01:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab0EHXQb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 19:16:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46722 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0EHXQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 19:16:29 -0400
Received: by gwj19 with SMTP id 19so1322182gwj.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3D5of97p6deLgvsjmWyeAtxQvTBWbpfKgmZJKRIWvAo=;
        b=MxfQ0KTr4n73I5/cEoYfuNCWoKHc//3plCGwTK+BewwHimqffQYdSmOzb3UswJpMlV
         NiDzzYJ8dIiOerieiJ6w/KOP8lQQ8uVqPNys/+GSkjViMDjr92agmdpbtmpTUhHtidKz
         hRsDGGp7cLV3GmUjytfOUlv52QryjScqdNS/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LgaU03In6cmqNOwWQQTQALAqB4JWfUz0pqU3Wde8vX6SHSQGtEBzJU2vojadsuWWj6
         52z5P/WFnQEYjWp9VpuAa53IHy0tNWnmyYvSh1k6BAnhHtHr/V3UV1Tijsg7K4DMz7QX
         JxofriUzEi+VesD4fCy/7AX9+Cpi+5O1VOHp8=
Received: by 10.150.62.13 with SMTP id k13mr5325859yba.133.1273360589048;
        Sat, 08 May 2010 16:16:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2448963yxe.11.2010.05.08.16.16.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 16:16:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100430133228.GA1620@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146686>

When cherry-picking, usually the new and old commit encodings are both
UTF-8.  Most old iconv implementations do not support this trivial
conversion, so on old platforms, out->message remains NULL, and later
attempts to read it segfault.

=46ix this by noticing the input and output encodings match and skippin=
g
the iconv step, like the other reencode_string() call sites already do.
Also stop segfaulting on other iconv failures: if iconv fails for some
other reason, the best we can do is to pass the old message through.

This fixes a regression introduced in v1.7.1-rc0~15^2~2 (revert:
clarify label on conflict hunks, 2010-03-20).

Reported-by: Andreas Krey <a.krey@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Andreas reported this cherry-pick regression about a week ago, and a
patch similar to this one seemed to fix it.  The only question that
made me stall was what to do if iconv just doesn=E2=80=99t understand a=
n
encoding:

 - from a certain point of view it might make sense to pass through
   the message and note the old encoding

 - but on the other hand, that would not respect the user=E2=80=99s pre=
ference
   as expressed in i18n.commitencoding, and it would deny the caller
   the chance to fix the encoding problem in a text editor before
   commiting.

That second point was driven home when I tried to implement this: it
required teaching =E2=80=98git commit=E2=80=99 to respect a new GIT_COM=
MIT_ENCODING
variable, but this was a pain (there is a sizeable amount of code
paying attention to i18n.commitencoding) and the result would have
been cherry-pick ignoring the $GIT_COMMIT_ENCODING preference,
creating encoding mismatches between ident and commit message to boot.

Everyone should be using utf8 anyway. :)

Anyway, this minimal fix should be safe (it just restores the old
behavior, except we do not use iconv for trivial conversions any
more).  Patch is against v1.7.1-rc0~15^2~2.

Thanks to Andreas for the help.

 builtin/revert.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5a5b721..5adaf27 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -97,8 +97,13 @@ static int get_message(const char *raw_message, stru=
ct commit_message *out)
 		encoding =3D "UTF-8";
 	if (!git_commit_encoding)
 		git_commit_encoding =3D "UTF-8";
-	if ((out->reencoded_message =3D reencode_string(raw_message,
-					git_commit_encoding, encoding)))
+
+	out->reencoded_message =3D NULL;
+	out->message =3D raw_message;
+	if (strcmp(encoding, git_commit_encoding))
+		out->reencoded_message =3D reencode_string(raw_message,
+					git_commit_encoding, encoding);
+	if (out->reencoded_message)
 		out->message =3D out->reencoded_message;
=20
 	abbrev =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
--=20
1.7.1
