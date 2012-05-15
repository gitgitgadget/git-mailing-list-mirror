From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pack-objects: use streaming interface for reading
 large loose blobs
Date: Tue, 15 May 2012 08:27:26 -0700
Message-ID: <7vhavhforl.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1205121220070.21030@xanadu.home>
 <1336883862-9013-1-git-send-email-pclouds@gmail.com>
 <7v62byh7l4.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bk5=X8hQAHKXCArfq57o2tLBv0RN641N3-ws69S3GghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 17:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUJfB-0005eF-AW
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 17:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123Ab2EOP1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 11:27:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab2EOP1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 11:27:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 973956E0A;
	Tue, 15 May 2012 11:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X2JGq5rncd5/
	+cRYjh1lADJk47k=; b=MYpi/KCn1RS+NnvFDaIVHe03OZf13qO23aYTOqYJxFXk
	IrtUp7nMCmI/h/LHuy2/nDtQUDv4dCUY4yyvr11duYecB6ZJR89uNBqU0jCxWHLB
	7cCTHvvh6Lm97LKvJRl7ip3c5qqcmyTNNdepuw0/IDvX2PvZvgta/HhQiS+XRFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cDyRU8
	uVMZQHfUdBLt/WLfXFqL4Ypr9pQeTzF1XitgtTopfxlb1zhZcxUMvrBxSuYssw3p
	Hw2mkwB/4rpi2eC/nnMBNDxB11+kiU4IIHYUYGKFhdFQJ3UihZK67nENyhgZSDPd
	O6QhZ5/t9zyxdv9QSX5r+cyuQxEhlYKQXhHic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA2A6E09;
	Tue, 15 May 2012 11:27:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA3A46E07; Tue, 15 May 2012
 11:27:41 -0400 (EDT)
In-Reply-To: <CACsJy8Bk5=X8hQAHKXCArfq57o2tLBv0RN641N3-ws69S3GghQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 15 May 2012 18:18:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8321100E-9EA2-11E1-A027-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197838>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, May 15, 2012 at 2:43 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> git usually streams large blobs directly to packs. But there are ca=
ses
>>> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
>>> index 55ed955..7fbd2e1 100755
>>> --- a/t/t1050-large.sh
>>> +++ b/t/t1050-large.sh
>>> @@ -134,6 +134,22 @@ test_expect_success 'repack' '
>>> =C2=A0 =C2=A0 =C2=A0 git repack -ad
>>> =C2=A0'
>>>
>>> +test_expect_success 'pack-objects with large loose object' '
>>> + =C2=A0 =C2=A0 echo Z | dd of=3Dlarge4 bs=3D1k seek=3D2000 &&
>>> + =C2=A0 =C2=A0 OBJ=3D9f36d94e145816ec642592c09cc8e601d83af157 &&
>>> + =C2=A0 =C2=A0 P=3D.git/objects/9f/36d94e145816ec642592c09cc8e601d=
83af157 &&
>>
>> I do not think you need these hardcoded constants; you will run
>> hash-object later, no?
>>
>> Also, relying on $P to exist after hash-object -w returns is somewha=
t
>> flaky, no?
>
> I need it to be a loose object to test this code path.

No you don't.  You only need it to be something istream_read() will rea=
d
from, iow, it could come from a base representation in a packfile.

In short, what I was hinting at was to do something like this instead:

	create a large file "large4"
        BLOB=3D$(git hash-objects -w "large4")
        PACK=3D$(echo "$BLOB" | git pack-objects pack)
        create a new empty repository "check"
        move pack-$PACK.{pack,idx} to "check" repository
        in "check" repository, try to see if you can read $BLOB correct=
ly

>> In any case, the patch when applied on top of cd07cc5 (Update draft
>> release notes to 1.7.11 (11th batch), 2012-05-11) does not pass this=
 part
>> of the test on my box.
>
> Interesting. It passes for me (same base). I assume rm failed?

No, reading the resulting pack dies with an error message that says the
object could not be read at offset 12, implying that the pack writer wr=
ote
something bogus.
