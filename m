From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Fri, 07 Mar 2014 10:33:59 -0800
Message-ID: <xmqq4n39vox4.fsf@gitster.dls.corp.google.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
	<1394095783-24402-1-git-send-email-pclouds@gmail.com>
	<CACsJy8AYWBKwUCB=pC0istGvNCNor0i-Ntp1nY5NbJGW+c2fVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:34:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLzbA-0002VQ-HY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 19:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbaCGSeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 13:34:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbaCGSeI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 13:34:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19A2D7113E;
	Fri,  7 Mar 2014 13:34:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1vzoc28zxDc2
	B3I/XWQ2az3RKBo=; b=v8tQClKTVHDNKEXmfd9tkP7I7M652STiPPI/hR9Ljbtg
	xKjgQLnXX9R+SATxhxccj1gEZculd+Mim71CRQT0D6Qq5nywoJp+WBMnb0af9RW7
	+VgNmwx0h6rU4A+T6g9AmvA9dKGj1hdAbg6e6kNH4Z/tz8JICHzz15j7e185i80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qv6uON
	Gg0lkjNO07F1oiYndqdvR0GJZ4RwwUJ8xaKj1sdzRFJTFjQlZbl7J3MSaNHexB1F
	qx5Gh/NdixLn2Cti/uspDnpZoZntHATP5HW4tkCJYCzz35fPVtUR3aK2OtP3Hnoh
	9GXb6TyjpwsxPPzgMdbwYG1VJ2ajzKzSNNYQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D297113C;
	Fri,  7 Mar 2014 13:34:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7971671138;
	Fri,  7 Mar 2014 13:34:01 -0500 (EST)
In-Reply-To: <CACsJy8AYWBKwUCB=pC0istGvNCNor0i-Ntp1nY5NbJGW+c2fVw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 7 Mar 2014 08:24:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0DB445C8-A627-11E3-8E92-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243622>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 6, 2014 at 3:49 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
>> index 3ae9092..a980574 100755
>> --- a/t/t5537-fetch-shallow.sh
>> +++ b/t/t5537-fetch-shallow.sh
>> @@ -173,4 +173,17 @@ EOF
>>         )
>>  '
>>
>> +test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-onl=
y repo' '
>> +       cp -R .git read-only.git &&
>> +       find read-only.git -print | xargs chmod -w &&
>> +       test_when_finished "find read-only.git -type d -print | xarg=
s chmod +w" &&
>> +       git clone --no-local --depth=3D2 read-only.git from-read-onl=
y &&
>> +       git --git-dir=3Dfrom-read-only/.git log --format=3D%s >actua=
l &&
>> +       cat >expect <<EOF &&
>> +add-1-back
>> +4
>> +EOF
>> +       test_cmp expect actual
>> +'
>> +
>>  test_done
>
> It's a separate issue, but maybe we should add a similar test case fo=
r
> non-shallow clone from a read-only repo too. Are there any other
> operations that should work well on read-only repos?

Any read-only operation ;-)?

On the object-transfer front, that would mean fetching from,
archive-r from, and perhaps creating bundle from.

Locally, log, grep, blame, gitk (but only the browsing part), etc.

If a read-write borrower borrows from a read-only location via the
objects/info/alternates mechanism, anying operation to the borrower
should also work without modifying the borrowee.
