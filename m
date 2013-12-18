From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Tue, 17 Dec 2013 21:47:44 -0800
Message-ID: <xmqqvbymk8vz.fsf@gitster.dls.corp.google.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
	<CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
	<xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
	<CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
	<xmqq4n67m8og.fsf@gitster.dls.corp.google.com>
	<CAJYzjmdscmEVuT29wMVoeUoUag=0H-XDq2tkLPRtHEr51kOk5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 06:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt9z6-0003wT-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 06:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab3LRFrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 00:47:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3LRFrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 00:47:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58826513B0;
	Wed, 18 Dec 2013 00:47:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9R3mAMofU4XVjP+yx50yfof2NAI=; b=WL168Q
	U9cs9Zo2sDcTXzmep8/aVmCnN+PlTBmC0fhBAsLhJ+rEbvO2oh/PSIZjdXcf/8Mx
	NluGgxU1zvEj0FXiCKpYkxzFhC813lRjsTcsAYRkNiVpnoc+EYtmsAL9cOA4b3zB
	DzTzjsAn+gvonzol1r/CVZ03tP8U+HEE6NA9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fWCmTZ9gpGD895AxsJ/odng4wSB2hg2p
	AZpr134jzBrmuHGvtEXGIM3yIU7i238kVHyIv2NHT1e+q/30lAVblGOer8nliRXN
	IIzMVVXDQ3vHOed4sD/PBxsXQyA2BpkUkcR052viwmjcJTCb0YtFIDRx7LpQjyBi
	I2Eff3BLZ6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44E82513AF;
	Wed, 18 Dec 2013 00:47:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97296513AE;
	Wed, 18 Dec 2013 00:47:46 -0500 (EST)
In-Reply-To: <CAJYzjmdscmEVuT29wMVoeUoUag=0H-XDq2tkLPRtHEr51kOk5Q@mail.gmail.com>
	(Samuel Bronson's message of "Tue, 17 Dec 2013 23:28:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBE7FF92-67A7-11E3-BC66-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239423>

Samuel Bronson <naesten@gmail.com> writes:

> On Tue, Dec 17, 2013 at 5:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> My point was that I did not see much value in reading the orderfile
>> data from anything but a file.  At that point, you are not testing
>> the "diff -O" orderfile option, but if strbuf_readline() reads from
>> a non-regular file.
>
> Oh, good point, now that you state it explicitly.  I'll remove it.

Or you can study the fix-up I (tentatively) queued on top of your
series in 'pu'.  Also see $gmane/239409.

Thanks.

24331790 (FIXUP! tests, 2013-12-17)

diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index f906dea..db0e427 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -22,14 +22,12 @@ test_expect_success 'setup' '
 	*Makefile
 	*.txt
 	*.h
-	*
 	EOF
 
 	cat >order_file_2 <<-\EOF &&
 	*Makefile
 	*.h
 	*.c
-	*
 	EOF
 
 	cat >expect_none <<-\EOF &&
@@ -77,27 +75,30 @@ test_expect_success 'orderfile is a directory' '
 for i in 1 2
 do
 	test_expect_success "orderfile using option ($i)" '
-	git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
-	test_cmp expect_$i actual
-'
+		git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
+		test_cmp expect_$i actual
+	'
 
 	test_expect_success PIPE "orderfile is fifo ($i)" '
-	rm -f order_fifo &&
-	mkfifo order_fifo &&
-	cat order_file_$i >order_fifo &
-	git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
-	test_cmp expect_$i actual
-'
+		rm -f order_fifo &&
+		mkfifo order_fifo &&
+		{
+			cat order_file_$i >order_fifo &
+		} &&
+		git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
+		wait &&
+		test_cmp expect_$i actual
+	'
 
 	test_expect_success "orderfile using config ($i)" '
-	git -c diff.orderfile=order_file_$i diff --name-only HEAD^..HEAD >actual &&
-	test_cmp expect_$i actual
-'
+		git -c diff.orderfile=order_file_$i diff --name-only HEAD^..HEAD >actual &&
+		test_cmp expect_$i actual
+	'
 
 	test_expect_success "cancelling configured orderfile ($i)" '
-	git -c diff.orderfile=order_file_$i diff -O/dev/null --name-only HEAD^..HEAD >actual &&
-	test_cmp expect_none actual
-'
+		git -c diff.orderfile=order_file_$i diff -O/dev/null --name-only HEAD^..HEAD >actual &&
+		test_cmp expect_none actual
+	'
 done
 
 test_done
-- 
1.8.5.2-297-g3e57c29
