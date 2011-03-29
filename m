From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Minor cosmetic defect in git-pack-objects output
Date: Tue, 29 Mar 2011 22:13:13 +0200
Message-ID: <4D923D59.3070301@lsrfire.ath.cx>
References: <20110329121040.de22bd56.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:13:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fI4-0008TV-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab1C2UNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 16:13:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:47091 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab1C2UNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:13:18 -0400
Received: from [192.168.2.103] (p4FFDA467.dip.t-dialin.net [79.253.164.103])
	by india601.server4you.de (Postfix) with ESMTPSA id 495AD2F8072;
	Tue, 29 Mar 2011 22:13:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110329121040.de22bd56.ospite@studenti.unina.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170316>

Am 29.03.2011 12:10, schrieb Antonio Ospite:
> Hi,
>=20
> in some cases, on git-pack-objects failure, there is a small defect i=
n
> the output, see:
>=20
> # git gc --aggressive
> Counting objects: 1954118, done.
> Delta compression using up to 2 threads.
> warning: suboptimal pack - out of memory02)
> Compressing objects: 100% (1936802/1936802), done.
> Writing objects: 100% (1954118/1954118), done.
> Total 1954118 (delta 1618716), reused 0 (delta 0)
>=20
> The defect is here:
> warning: suboptimal pack - out of memory02)
>                                          ^^^
> the trailing chars are from the replaced line which was ending in
> 1936802)
>=20
> AFAICS this is basically what is happening:
> #include "git-compat-util.h"
> fprintf(stderr, "Compressing objects:  15% (296661/1936802)\r");
>                   warning("suboptimal pack - out of memory");
>=20
> I can think to a dumb workaround for this particular path but maybe
> there are other places when this can happen as well.

The following patch should avoid it by clearing the the rest of the
line after warnings, error messages, usage notes etc. if stderr is a
terminal.

Ren=E9

---
 usage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/usage.c b/usage.c
index b5e67e3..36f1968 100644
--- a/usage.c
+++ b/usage.c
@@ -9,7 +9,7 @@ void vreportf(const char *prefix, const char *err, va_l=
ist params)
 {
 	char msg[4096];
 	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	fprintf(stderr, "%s%s%s\n", prefix, msg, isatty(2) ? "\033[K" : "");
 }
=20
 static NORETURN void usage_builtin(const char *err, va_list params)
