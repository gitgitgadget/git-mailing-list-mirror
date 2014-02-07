From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with no-done cap
Date: Fri, 07 Feb 2014 10:01:08 -0800
Message-ID: <xmqqppmyvm3f.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 19:01:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpjs-00038c-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 19:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaBGSBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Feb 2014 13:01:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbaBGSBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 13:01:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 849B169295;
	Fri,  7 Feb 2014 13:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zIH5SKX6JawI
	+rqx0maYFU+1tpA=; b=kF9LKsRUSzwE1Eg0NUtaDM+Eml7n36v6g2LlnVcnYtde
	L5Leyg+JdR3H44IR+Gxu0Bt1VX/3gbNy2s5IEAc5vbMYiVoI3HPDbYt74jRAmADn
	Utld5IGy/UrLUBgvZZRZZlJIPEXkv1AHtyy33ib2ZyqRvuzE14ZElPW9Qvs3Uf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lUR7Wv
	y6D0t0QZC/lFbGzREwFHZH9lJWomRD8FvBxknX8obxsD/O0bfutGiYQ8KgQGE2pn
	v2o8v5eIPEMPxTgnLfZyBzRkfekh9QuXHed4kAlRJ4TKgRq7U/ri7YgTAn43dAk2
	JN+ywpIl2SpSXW7wINAVyNRivJ9Lg+9hG3zkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE4969294;
	Fri,  7 Feb 2014 13:01:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D9AA69293;
	Fri,  7 Feb 2014 13:01:12 -0500 (EST)
In-Reply-To: <1391699439-22781-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 6 Feb
 2014 22:10:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D45FFABC-9021-11E3-A9F6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241788>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index b0fa738..fb11073 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -200,5 +200,29 @@ EOF
>  	)
>  '
> =20
> +# This test is tricky. We need large enough "have"s that fetch-pack
> +# will put pkt-flush in between. Then we need a "have" the the serve=
r
> +# does not have, it'll send "ACK %s ready"
> +test_expect_success 'add more commits' '
> +	(
> +	cd shallow &&
> +	for i in $(seq 10); do
> +	git checkout --orphan unrelated$i &&
> +	test_commit unrelated$i >/dev/null &&
> +	git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" refs/heads/unrelat=
ed$i:refs/heads/unrelated$i
> +	git push -q ../clone/.git refs/heads/unrelated$i:refs/heads/unrelat=
ed$i

In addition to two problems Eric and Peff noticed, && chain is
broken between these two pushes.  I initially didn't notice it but
it became obvious after reformatting to fix the indentation.

Here is the difference between the posted series and what I queued
after applying the changes suggested during the review.

Thanks.

 Documentation/technical/pack-protocol.txt         |  4 +--
 Documentation/technical/protocol-capabilities.txt | 10 +++----
 t/t5537-fetch-shallow.sh                          | 34 +++++++++++++--=
--------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index eb0b8a1..39c6410 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -338,8 +338,8 @@ during a prior round.  This helps to ensure that at=
 least one common
 ancestor is found before we give up entirely.
=20
 Once the 'done' line is read from the client, the server will either
-send a final 'ACK obj-id' or it will send a 'NAK'. 'obj-id' is the
-last SHA-1 determined to be common. The server only sends
+send a final 'ACK obj-id' or it will send a 'NAK'. 'obj-id' is the obj=
ect
+name of the last commit determined to be common. The server only sends
 ACK after 'done' if there is at least one common base and multi_ack or
 multi_ack_detailed is enabled. The server always sends NAK after 'done=
'
 if there is no common base found.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index cb2f5eb..e174343 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -77,15 +77,15 @@ section "Packfile Negotiation" for more information=
=2E
=20
 no-done
 -------
-This capability should be only used with smart HTTP protocol. If
+This capability should only be used with the smart HTTP protocol. If
 multi_ack_detailed and no-done are both present, then the sender is
 free to immediately send a pack following its first "ACK obj-id ready"
 message.
=20
-Without no-done in smart HTTP protocol, the server session would end
-and the client has to make another trip to send "done" and the server
-can send the pack. no-done removes the last round and thus slightly
-reduces latency.
+Without no-done in the smart HTTP protocol, the server session would
+end and the client has to make another trip to send "done" before
+the server can send the pack. no-done removes the last round and
+thus slightly reduces latency.
=20
 thin-pack
 ---------
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index fb11073..1413caf 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -201,26 +201,30 @@ EOF
 '
=20
 # This test is tricky. We need large enough "have"s that fetch-pack
-# will put pkt-flush in between. Then we need a "have" the the server
+# will put pkt-flush in between. Then we need a "have" the server
 # does not have, it'll send "ACK %s ready"
 test_expect_success 'add more commits' '
 	(
-	cd shallow &&
-	for i in $(seq 10); do
-	git checkout --orphan unrelated$i &&
-	test_commit unrelated$i >/dev/null &&
-	git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" refs/heads/unrelated=
$i:refs/heads/unrelated$i
-	git push -q ../clone/.git refs/heads/unrelated$i:refs/heads/unrelated=
$i
-	done &&
-	git checkout master &&
-	test_commit new &&
-	git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
+		cd shallow &&
+		for i in $(test_seq 10)
+		do
+			git checkout --orphan unrelated$i &&
+			test_commit unrelated$i &&
+			git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+				refs/heads/unrelated$i:refs/heads/unrelated$i &&
+			git push -q ../clone/.git \
+				refs/heads/unrelated$i:refs/heads/unrelated$i ||
+			exit 1
+		done &&
+		git checkout master &&
+		test_commit new &&
+		git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
 	) &&
 	(
-	cd clone &&
-	git checkout --orphan newnew &&
-	test_commit new-too &&
-	git fetch --depth=3D2
+		cd clone &&
+		git checkout --orphan newnew &&
+		test_commit new-too &&
+		git fetch --depth=3D2
 	)
 '
=20
