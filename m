From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix calling parse_pathspec with no paths nor PATHSPEC_PREFER_* flags
Date: Tue, 22 Oct 2013 11:16:15 -0700
Message-ID: <xmqqd2mxtbm8.fsf@gitster.dls.corp.google.com>
References: <CALWbr2zTZzGZ9fkUonQr77Vn_dfzP57CZR1vNxNJW_touxNstQ@mail.gmail.com>
	<1382150484-13207-1-git-send-email-pclouds@gmail.com>
	<xmqq38ntusq6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 20:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYgVK-0000kw-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 20:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab3JVSQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 14:16:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab3JVSQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 14:16:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA6A4CAEB;
	Tue, 22 Oct 2013 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lIN6CozV0tDv
	/EJOk6UHKR6hp8U=; b=CrLiaAXgq6E2/YP2WPsC/766nRL0sA6kTEg37TTKV49Q
	pSTA/lo3t5SbB+iZa4mDYQnJCC7QPdICsAWaSAkwyFF4U0uDT6Ak563YSdBttn+L
	I5qW0RTxSu6llnq7AaNF3OYEGnzn6QtZZLhpWsKeKwcJnT1BLzKc89uhBmW4SLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Re9RaU
	52OkjWzpLCXG5qim5O1e0ly6Cf8U2jzxEa6AyfxJn1aV5jySU/7U48WDqqR7qO0/
	CJKmra+jFPuT0KQji85MIsoY8nmCkRXspLbU3psLjgjxaZ8rNJbRpaPYBI7WbE/f
	v7oYELX4FhDx6DR7ACKNSWui5BjJZb5Sx+iHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B32B4CAEA;
	Tue, 22 Oct 2013 18:16:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD0EE4CAE6;
	Tue, 22 Oct 2013 18:16:16 +0000 (UTC)
In-Reply-To: <xmqq38ntusq6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Oct 2013 10:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0AE5AD1A-3B46-11E3-B64A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236482>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> When parse_pathspec() is called with no paths, the behavior could be
>> either return no paths, or return one path that is cwd. Some command=
s
>> do the former, some the latter. parse_pathspec() itself does not mak=
e
>> either the default and requires the caller to specify either flag if
>> it may run into this situation.
>>
>> I've grep'd through all parse_pathspec() call sites. Some pass
>> neither, but those are guaranteed never pass empty path to
>> parse_pathspec(). There are two call sites that may pass empty path
>> and are fixed with this patch.
>>
>> Reported-by: Antoine Pelisse <apelisse@gmail.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> Thanks.

I've amended it with the following taken from Antoine's initial
report.

diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec=
=2Esh
index 72300b5..d8f23f4 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -46,4 +46,19 @@ test_expect_success 'git log HEAD -- :/' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'command line pathspec parsing for "git log"' '
+	git reset --hard &&
+	>a &&
+	git add a &&
+	git commit -m "add an empty a" --allow-empty &&
+	echo 1 >a &&
+	git commit -a -m "update a to 1" &&
+	git checkout HEAD^ &&
+	echo 2 >a &&
+	git commit -a -m "update a to 2" &&
+	test_must_fail git merge master &&
+	git add a &&
+	git log --merge -- a
+'
+
 test_done
