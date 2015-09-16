From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/7] git-p4: add support for large file systems
Date: Wed, 16 Sep 2015 08:20:20 -0700
Message-ID: <xmqqzj0ms85n.fsf@gitster.mtv.corp.google.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
	<1442237194-49624-7-git-send-email-larsxschneider@gmail.com>
	<55F92A1E.1090002@diamand.org>
	<5329966D-1A0C-42A1-9099-AC449D50AA52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 17:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcEVd-0001L5-Q5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 17:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbbIPPU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2015 11:20:29 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34109 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbbIPPUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 11:20:22 -0400
Received: by padhy16 with SMTP id hy16so212102845pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=+HematL4MHck/N/APhCULXxalJRN9xex5OHnpFzcFJ8=;
        b=ka8v7f6AIisaqE2QoebLHW+jl72qlE+aVFff7cpxBlES6U1+Jd8fmIv6cbTTLLXnaS
         J5cA66v+3Yu7/kziwO+fisdYgirC0MzLIvg7rHRxb9rH/OOEbWkJblCo/nF/W5EZyuh1
         mVw5LAelHvHGAGtYKATAooeCKLJDnmNNR6VMNCvL33/4Bq75fG1GQIfPB6yiF9VmXf0r
         JsiAfoTnfrrdvESQym1LTP0dhnJbo8Vh/nOdvQJB/WSw8SIN9z/8Rp1zMoBp7k4oD2X5
         2mnG7HTdB5gNJMU88SNuxXXU/f8tBRM9KdqX+DJmObwjCYs37o/EBq+/tnqdfAuamja1
         Ygtg==
X-Received: by 10.66.254.201 with SMTP id ak9mr59930063pad.151.1442416822391;
        Wed, 16 Sep 2015 08:20:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id gv1sm25287464pbc.38.2015.09.16.08.20.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 08:20:21 -0700 (PDT)
In-Reply-To: <5329966D-1A0C-42A1-9099-AC449D50AA52@gmail.com> (Lars
	Schneider's message of "Wed, 16 Sep 2015 14:05:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278032>

Lars Schneider <larsxschneider@gmail.com> writes:

>>> +git-p4.largeFileSystem::
>>> +	Specify the system that is used for large (binary) files. Please =
note
>>> +	that large file systems do not support the 'git p4 submit' comman=
d.
>>=20
>> Why is that? Is it just that you haven't implemented support, or
>> is it fundamentally impossible?
>
> If we detect LFS files only by file extension then we could make
> it work. But then we must not use any git-p4 settings. We would
> need to rely only on the =E2=80=9C.gitattributes=E2=80=9D file that i=
s stored in
> the P4 repository. My implementation also looks at the file size
> and decides on a individual file basis if a file is stored in
> LFS. That means all clients need the same file size threshold.
>
> Junio explained the problem in the v4 thread:
>> ...

Hmm, I am not sure if Luke's question was answered with the above,
and I do not think I explained anything, either.  I did point out
that with _your_ code I didn't see how "submit" would not work, but
that is quite different from the problem being fundamentally not
solvable.

>>> +test_file_in_mock () {
>>> +	FILE=3D"$1"
>> Missing &&
>> Plus the next few lines

> Are they strictly necessary? I believe you can define variables all i=
n =E2=80=9Cone line=E2=80=9D

Absolutely.  Making multiple assignments as a single statment like

	X=3DA Y=3DB Z=3DC &&
        ...

is fine, but do not break &&-chain.

>>=20
>>> +	CONTENT=3D"$2"
>>> +	LOCAL_STORAGE=3D".git/mock-storage/local/$CONTENT"
>>> +	SERVER_STORAGE=3D".git/mock-storage/remote/$CONTENT"

=2E.. and to be sure, these 'echo' also must not break &&-chain.

>>> +	echo "pointer-$CONTENT" >expect_pointer
>>> +	echo "$CONTENT" >expect_content

>>> +test_file_count_in_dir () {
>>> +	DIR=3D"$1"
>>> +	EXPECTED_COUNT=3D"$2"
>>> +	find "$DIR" -type f >actual

=2E.. so are these.

>>> +	test_line_count =3D $EXPECTED_COUNT actual
>>> +}


Thanks.
