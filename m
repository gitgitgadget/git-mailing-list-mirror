From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] Fix bundle --stdin
Date: Sat, 26 Jun 2010 01:28:11 -0500
Message-ID: <20100626062811.GG15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:28:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOsV-0000dK-5L
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab0FZG20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 02:28:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57889 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZG2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:28:25 -0400
Received: by iwn41 with SMTP id 41so2714716iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o/PSeIxmNbPQHF+CDH3/CbafIvqTBQcMuWRS1NRkTyA=;
        b=YfdOZLOEzNc0sDSGAd0YCED2On/dAlV5EdDy1Vw4IVJPd76kQ1HTv+HSf5PWeqhWHt
         t0XcA4MD9PrCKCvrui2JBbOmtNTF8MeZPebM69ePRHmRME0CeHa9ddiQFNai+yc6D7ZD
         1aiA6K/iEUIMkEEdMtPDMGAtBlIP/P05RPc04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DvX78mzk5w9N8ijiY0b5PMiNJ4HQMMLOG8KaYrmnJh+4mCszLIzJh38SWBoRXi80NZ
         NeJO2oCj3Sttyz47P+pz6vQhTC1oUsgzbwbrzz/QhnPWD1yDYU17EdVEv3h+tjv9Uh0/
         y52IOK0dHsqElYPLWxwwgZOnimUbUvaSLGvEA=
Received: by 10.231.124.40 with SMTP id s40mr1872681ibr.172.1277533702769;
        Fri, 25 Jun 2010 23:28:22 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v23sm4327586ibp.15.2010.06.25.23.28.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:28:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149734>

To write a bundle=E2=80=99s table of contents, the name passed on the c=
ommand
line for each ref is needed.  Unfortunately, names passed through
stdin are put in a temporary buffer and then freed; the random
gibberish that tends to replace them does not look like a meaningful
ref name to bundle_list_refs(), so no valid toc entries are found and
=E2=80=98git bundle --stdin=E2=80=99 thinks it has been asked to create=
 an empty
bundle.

So teach the revision walker to keep rev names after reading them from
stdin.  This fixes =E2=80=98git bundle --stdin=E2=80=99 at the cost of =
a memory leak.

Reported-by: Joey Hess <joey@kitenet.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 revision.c        |    2 +-
 t/t5704-bundle.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index f4b8b38..cf86af3 100644
--- a/revision.c
+++ b/revision.c
@@ -1022,7 +1022,7 @@ static void read_revisions_from_stdin(struct rev_=
info *revs, const char ***prune
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0, 1))
+		if (handle_revision_arg(xstrdup(sb.buf), revs, 0, 1))
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index ddc3dc5..cc463f3 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -30,7 +30,7 @@ test_expect_success 'tags can be excluded by rev-list=
 options' '
=20
 '
=20
-test_expect_failure 'bundle --stdin' '
+test_expect_success 'bundle --stdin' '
=20
 	echo master | git bundle create stdin-bundle.bdl --stdin &&
 	git ls-remote stdin-bundle.bdl >output &&
@@ -38,7 +38,7 @@ test_expect_failure 'bundle --stdin' '
=20
 '
=20
-test_expect_failure 'bundle --stdin <rev-list options>' '
+test_expect_success 'bundle --stdin <rev-list options>' '
=20
 	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
 	git ls-remote hybrid-bundle.bdl >output &&
--=20
1.7.1.198.g8d802
