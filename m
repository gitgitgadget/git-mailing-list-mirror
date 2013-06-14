From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] recover from "failed to apply delta"
Date: Fri, 14 Jun 2013 14:51:35 -0700
Message-ID: <7vsj0kmkd4.fsf@alter.siamese.dyndns.org>
References: <20130613232608.GA9844@sigill.intra.peff.net>
	<alpine.LFD.2.03.1306132004090.18597@syhkavp.arg>
	<20130614214943.GA29138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnbuJ-0007tB-80
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab3FNVvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:51:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3FNVvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:51:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B725728E97;
	Fri, 14 Jun 2013 21:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzQ51Bki4dHHXWCcfpZPJ4Gf408=; b=ZTxK4R
	MPuyZyHeH5K7YgRfUd9mRLGKddDTeEp8Y1H4HvI54I5uIFS31vuWWmBTOPoj8tnk
	X/OvL2q5YLa5OBcgoLp0eE5WJA1P+K7VtdawA1VuhomEnCq2gVsa7cJ38vxn5yph
	F3/VceY2GnWKzxpERNhZ+6IYgUkgltnzO187U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uJlUYa0KIJtsqiJHarCgU1r1kEqqABuu
	aD7RbhGA58jgQVa4CNOmQ1IW5eC2E1bZ0D+Jxd74gBLmo+xwZBAdUK4USmB5Ipgv
	hoh2KTpH4KAF3Fc6eET6pQUs4jSpDgxutNhzca6sZ0Xkzm8g/530hhLAsujNHkA7
	O0PXyv448pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AADE628E96;
	Fri, 14 Jun 2013 21:51:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A068228E95;
	Fri, 14 Jun 2013 21:51:36 +0000 (UTC)
In-Reply-To: <20130614214943.GA29138@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Jun 2013 17:49:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 960C6FFC-D53C-11E2-938F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227921>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 13, 2013 at 08:05:21PM -0400, Nicolas Pitre wrote:
>
>> > We already handle the case where we were not able to read
>> > the delta from disk. However, when we find that the delta we
>> > read does not apply, we simply die.  This case is harder to
>> > trigger, as corruption in the delta data itself would
>> > trigger a crc error from zlib.  However, a corruption that
>> > pointed us at the wrong delta base might cause it.
>>
>> That makes sense.
>> 
>> Could you produce a test case to go along with this change?
>
> Yes. I was a little worried I would have trouble doing it without
> relying on a lot of pack internals, but the infrastructure you set up in
> t5303 makes it relatively easy (and we do not have to make any
> assumptions that t5303 does not already make).
>
> Here is a re-roll; the first patch is a small cleanup in t5303 that is
> required for the new tests to work.

Heh, I was doing the same, but I cheated ;-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5b1250f..57436db 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -51,7 +51,7 @@ do_corrupt_object() {
     ofs=`git show-index < ${pack}.idx | grep $1 | cut -f1 -d" "` &&
     ofs=$(($ofs + $2)) &&
     chmod +w ${pack}.pack &&
-    dd of=${pack}.pack count=1 bs=1 conv=notrunc seek=$ofs &&
+    dd of=${pack}.pack count=${3-1} bs=1 conv=notrunc seek=$ofs &&
     test_must_fail git verify-pack ${pack}.pack
 }
 
@@ -276,6 +276,30 @@ test_expect_success \
      git cat-file blob $blob_3 > /dev/null'
 
 test_expect_success \
+    'corrupt delta-part of a packed object, fall back to loose' \
+    'create_new_pack &&
+     path=$(echo "$blob_3" | sed -e "s|^\(..\)|\1/|") &&
+     cat ".git/objects/$path" >saved &&
+     git prune-packed &&
+
+     dd if=${pack}.idx bs=1 count=20 skip=1032 >blob1-bin &&
+     dd if=${pack}.pack bs=1 count=20 skip=2233 >blob3-delta-base-bin &&
+
+     # At the beginning of the REF_DELTA representation of $blob_3,
+     # write 20-byte base object name for $blob_1, instead of $blob_2.
+     # The binary representation of object name for $blob_1 is found
+     # at offset 4 + 4 + 256*4 = 1032 for 20 bytes.
+     dd if=${pack}.idx bs=1 count=20 skip=1032 | do_corrupt_object $blob_3 2 20 &&
+     test_must_fail git cat-file blob $blob_3 >/dev/null &&
+
+     # Resurrect the loose object for $blob_3
+     mkdir -p .git/objects/$(echo "$path" | sed -e "s|^\(..\).*|\1|") &&
+     cat saved >".git/objects/$path" &&
+
+     git cat-file blob $blob_3 >/dev/null
+'
+
+test_expect_success \
     'corrupting header to have too small output buffer fails unpack' \
     'create_new_pack &&
      git prune-packed &&
