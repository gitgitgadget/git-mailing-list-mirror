From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short
 option name
Date: Thu, 04 Sep 2014 08:13:09 +0200
Message-ID: <540802F5.1070708@web.de>
References: <1409753034-9459-1-git-send-email-johan@herland.net>	<1409753034-9459-3-git-send-email-johan@herland.net>	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>	<xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>	<54077A3E.20703@web.de> <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>	<54078C2C.5020503@web.de> <xmqqbnqwwds2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 08:13:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPQIa-0005Yf-WE
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 08:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbaIDGNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 02:13:32 -0400
Received: from mout.web.de ([212.227.15.14]:53885 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932426AbaIDGNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 02:13:31 -0400
Received: from [192.168.178.27] ([79.253.178.126]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MRTzc-1XnjUp0KCm-00SbOo; Thu, 04 Sep 2014 08:13:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqbnqwwds2.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:mU15vO5rkz2FOVk2TXwRC/WQCP9rZJp1stJAPylMQE26HF6Ztd/
 KfNAg5xkT/JV1ymtZi1plNW3unBdmsI/OcAX5jgKAv2gqOG8xsvoDTjuFgNKLKD5yQCAYaX
 ZgeLzqmIxdAFWd1BfazWnWdutq85omBqqiEsUlZfCQ1wcvI7Wbe5mt96FYTCmMYfowE96wM
 MbiR8VYQmzcOCicqOBG4A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.2014 um 00:16 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>>> It bugged me enough that we didn't identify which short option
>>> letter we were complaining about
>>
>> The old code did report the short option.  E.g. for t1502 it said:
>>
>> 	error: BUG: switch 'b' short name already used
>>
>> You can leave that to optbug(), no need for the strbuf.
>=20
> Not quite, as an opt with long name is reported with the long name
> only, which is not very nice when the problem we are reporting is
> about its short variant.

Perhaps something like the patch below helps, here and in general?

>> Space is allowed as a short option by the code; intentionally?
>=20
> I didn't think of a strong reason to declare either way, so, yes it
> was deliberate that I didn't tighten to disallow.

OK.  I don't think it's easy to come up with a usable way for having
space as a short option, but maybe it's possible.

---
 parse-options.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index b7925c5..f1c0b5d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -14,8 +14,12 @@ static int parse_options_usage(struct parse_opt_ctx_=
t *ctx,
=20
 int optbug(const struct option *opt, const char *reason)
 {
-	if (opt->long_name)
+	if (opt->long_name) {
+		if (opt->short_name)
+			return error("BUG: switch '%c' (--%s) %s",
+				     opt->short_name, opt->long_name, reason);
 		return error("BUG: option '%s' %s", opt->long_name, reason);
+	}
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
=20
--=20
2.1.0
