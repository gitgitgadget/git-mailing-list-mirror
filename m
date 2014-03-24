From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 04/10] t4209: use helper functions to test --grep
Date: Mon, 24 Mar 2014 22:42:58 +0100
Message-ID: <5330A6E2.2040607@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de> <1395508560-19893-5-git-send-email-l.s.r@web.de> <xmqq38i7qwvx.fsf@gitster.dls.corp.google.com> <20140324211412.GB13728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:44:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCf8-0001Cr-DH
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbaCXVoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:44:01 -0400
Received: from mout.web.de ([212.227.15.14]:63567 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaCXVoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:44:00 -0400
Received: from [192.168.178.27] ([79.250.180.170]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MUnuu-1WZxW51Jc4-00Y7kF; Mon, 24 Mar 2014 22:43:33
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140324211412.GB13728@sigill.intra.peff.net>
X-Provags-ID: V03:K0:oYE0onvx8k9YISd1sxyoBXsLFvgK9PbTI2opaGYXa3esOhSl2Jc
 IQienFxL3k1w1hRgzvHt+IiNH0cUllTGcKZchS3v7IYOKm2dwirRB2b/4U8CMGhLLX/B6ZH
 Q3n+IaFhDGr87F1G6bdBseW4mQCWIfvN8F6/+Rw+rME/PDWc/bTekcAeip09cEpXvWSIHNO
 6EHdBkCMyT3zRkS/pV6SA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244881>

Am 24.03.2014 22:14, schrieb Jeff King:
> On Mon, Mar 24, 2014 at 11:22:58AM -0700, Junio C Hamano wrote:
>=20
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> -test_expect_success 'log --grep -i' '
>>> -	git log -i --grep=3DInItial --format=3D%H >actual &&
>>> -	test_cmp expect_initial actual
>>> -'
>>> +test_log	expect_initial	--grep initial
>>> +test_log	expect_nomatch	--grep InItial
>>
>> This, and the next --author one, assumes that we will never break
>> "--grep=3Dfoo" without breaking "--grep foo".  That should be OK, bu=
t
>> we might want to add separate tests e.g.
>>
>> 	test_log expect_initial --grep=3Dinitial
>>
>> perhaps?  I dunno.
>=20
> Yeah, I I'd prefer "--grep=3D" here (and in all scripts).  In general=
, I
> think our attitude should be that "--foo=3Dbar" is guaranteed to work
> forever, but "--foo bar" is not. The latter only works if the argumen=
t
> is non-optional, so that leaves us room to "break" compatibility to m=
ake
> an argument optional in a future version.
>=20
> Now, whether the rest of the world and its script-writers are aware o=
f
> this fact, I don't know. So it may be too late already (but it does l=
ook
> like we mention it in gitcli(7)).

OK, then the following should be squashed into patch 2 (t4209: factor o=
ut
helper function test_log()):

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 9f3bb40..f47231a 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -10,6 +10,14 @@ test_log() {
 	shift 3
 	rest=3D$@
=20
+	case $kind in
+	--*)
+		opt=3D$kind=3D$needle
+		;;
+	*)
+		opt=3D$kind$needle
+		;;
+	esac
 	case $expect in
 	expect_nomatch)
 		match=3Dnomatch
@@ -20,7 +28,7 @@ test_log() {
 	esac
=20
 	test_expect_success "log $kind${rest:+ $rest} ($match)" "
-		git log $rest $kind $needle --format=3D%H >actual &&
+		git log $rest $opt --format=3D%H >actual &&
 		test_cmp $expect actual
 	"
 }
