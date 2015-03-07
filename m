From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] daemon: use strbuf for hostname info
Date: Sat, 07 Mar 2015 01:20:22 +0100
Message-ID: <54FA4446.5050103@web.de>
References: <54F96BF2.5000504@web.de> <20150306210627.GA24267@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:21:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU2Ub-0006nv-PD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 01:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbbCGAVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 19:21:17 -0500
Received: from mout.web.de ([212.227.15.14]:52795 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019AbbCGAVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 19:21:16 -0500
Received: from [192.168.178.27] ([79.253.128.80]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MGzFy-1YGLN10Kn4-00DokU; Sat, 07 Mar 2015 01:20:37
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150306210627.GA24267@peff.net>
X-Provags-ID: V03:K0:bwzBK05fi++4c9WyniBEgRST9hMTs+p8MVXzpGZHqDGAUKT1E9u
 h4TCzPE9CvQxhT53Pib+Zc14jH9NX6Z4FtK3MWjbVJ5/+p6XOJQa2CVfjjdhhRwalso0O/3
 U6IXS7UGNRefiutOwBWcAMXL5GvzrK18ddum73h9CyH0QATzEPLi/FTaC5W8sKZnFd4B38l
 cnjnltT5+J/PSDGqxasLQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264979>

Am 06.03.2015 um 22:06 schrieb Jeff King:
> On Fri, Mar 06, 2015 at 09:57:22AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>> Convert hostname, canon_hostname, ip_address and tcp_port to strbuf.
>> This allows to get rid of the helpers strbuf_addstr_or_null() and ST=
RARG
>> because a strbuf always represents a valid (initially empty) string.
>> sanitize_client() becomes unused and is removed as well.
>=20
> Makes sense. I had a feeling that we might have cared about NULL vers=
us
> the empty string somewhere, but I did not see it in the patch below, =
so
> I think it is fine.
>=20
>> -static char *sanitize_client(const char *in)
>> -{
>> -	struct strbuf out =3D STRBUF_INIT;
>> -	sanitize_client_strbuf(&out, in);
>> -	return strbuf_detach(&out, NULL);
>> -}
>=20
> Not a big deal, but do we want to rename sanitize_client_strbuf to
> sanitize_client? It only had the unwieldy name to distinguish it from
> this one.

A patch would look like this.  The result is shorter, but no win in
terms of vertical space (number of lines).

-- >8 --
Subject: daemon: drop _strbuf suffix of sanitize and canonicalize funct=
ions

Now that only the strbuf variants of the functions remain, remove the
"_strbuf" part from their names.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index c04315e..0412f8c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -534,7 +534,7 @@ static void parse_host_and_port(char *hostport, cha=
r **host,
  * trailing and leading dots, which means that the client cannot escap=
e
  * our base path via ".." traversal.
  */
-static void sanitize_client_strbuf(struct strbuf *out, const char *in)
+static void sanitize_client(struct strbuf *out, const char *in)
 {
 	for (; *in; in++) {
 		if (*in =3D=3D '/')
@@ -549,12 +549,12 @@ static void sanitize_client_strbuf(struct strbuf =
*out, const char *in)
 }
=20
 /*
- * Like sanitize_client_strbuf, but we also perform any canonicalizati=
on
+ * Like sanitize_client, but we also perform any canonicalization
  * to make life easier on the admin.
  */
-static void canonicalize_client_strbuf(struct strbuf *out, const char =
*in)
+static void canonicalize_client(struct strbuf *out, const char *in)
 {
-	sanitize_client_strbuf(out, in);
+	sanitize_client(out, in);
 	strbuf_tolower(out);
 }
=20
@@ -579,10 +579,10 @@ static void parse_host_arg(char *extra_args, int =
buflen)
 				parse_host_and_port(val, &host, &port);
 				if (port) {
 					strbuf_reset(&tcp_port);
-					sanitize_client_strbuf(&tcp_port, port);
+					sanitize_client(&tcp_port, port);
 				}
 				strbuf_reset(&hostname);
-				canonicalize_client_strbuf(&hostname, host);
+				canonicalize_client(&hostname, host);
 				hostname_lookup_done =3D 0;
 			}
=20
@@ -620,8 +620,8 @@ static void lookup_hostname(void)
=20
 			strbuf_reset(&canon_hostname);
 			if (ai->ai_canonname)
-				sanitize_client_strbuf(&canon_hostname,
-						       ai->ai_canonname);
+				sanitize_client(&canon_hostname,
+						ai->ai_canonname);
 			else
 				strbuf_addbuf(&canon_hostname, &ip_address);
=20
@@ -645,7 +645,7 @@ static void lookup_hostname(void)
 				  addrbuf, sizeof(addrbuf));
=20
 			strbuf_reset(&canon_hostname);
-			sanitize_client_strbuf(&canon_hostname, hent->h_name);
+			sanitize_client(&canon_hostname, hent->h_name);
 			strbuf_reset(&ip_address);
 			strbuf_addstr(&ip_address, addrbuf);
 		}
--=20
2.3.1
