Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6D1C685
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3587D42
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 09:01:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A3FwIAJ009921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Nov 2023 15:58:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com> <007101da0e65$13e3c170$3bab4450$@nexbridge.com> <20231103155220.GA1470570@coredump.intra.peff.net>
In-Reply-To: <20231103155220.GA1470570@coredump.intra.peff.net>
Subject: RE: [BUG] Git 2.43.0-rc0 - t4216 unpack(Q) invalid type
Date: Fri, 3 Nov 2023 12:01:22 -0400
Organization: Nexbridge Inc.
Message-ID: <007c01da0e6f$014e2c30$03ea8490$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD7DCRlNB6JVkDxYXTNZcIxUfS2M7ImxVoQ
Content-Language: en-ca

On Jeff King <peff@peff.net> wrote:
>On Fri, Nov 03, 2023 at 10:50:19AM -0400, rsbecker@nexbridge.com wrote:
>> In RC0, the following tests are failing (with verbose). They look =
like
>> the same root cause. Unpack("Q>".... What version does git now =
require for perl?
>> I have v5.30.3 available, nothing more recent.
>
>The perl used in the test suite is supposed to be vanilla enough to =
support any
>ancient version. The perl5 Git import doesn't have version tags that go =
back that far,
>but the quadwords in pack/unpack go back at least to a commit from =
1998.
>
>So I suspect this is not a version issue, but rather a build-time =
config one. The docs
>say:
>
>  Q  An unsigned quad value.
>      (Quads are available only if your system supports 64-bit integer
>      values _and_ if Perl has been compiled to support those.  Raises
>      an exception otherwise.)
>
>It would probably be possible to rewrite the use of "Q" here to grab =
two 32-bit
>values instead. But I'd guess that on your system it is not as simple =
as a shift-and-
>add to then treat them as a 64-bit value, since presumably the problem =
is that perl's
>ints are all strictly 32-bit.
>
>What does this script produce for you:
>
>  perl -e '
>    my $bytes =3D "\1\2\3\4\5\6\7\8";
>    my $q =3D eval { unpack("Q>", $bytes) };
>    print "Q =3D ", defined($q) ? $q : "($@)", "\n";
>    my ($n1, $n2) =3D unpack("NN", $bytes);
>    print "n1 =3D $n1\n";
>    print "n2 =3D $n2\n";
>    print "computed quad =3D ", ($n1 << 32) | $n2, "\n";
>  '
>
>I get:
>
>  Q =3D 72623859790382904
>  n1 =3D 16909060
>  n2 =3D 84281144
>  computed quad =3D 72623859790382904
>
>but I'm guessing you get an exception report for Q, and that the =
computed quad is
>probably equal to n2 (the shift of n1 goes totally off the end).
>
>We may not be without hope, though. These 64-bit values are file =
offsets we're
>reading from the chunk files. The format naturally uses 64-bit values =
here to
>accommodate arbitrarily large files. But in our tests, the offsets are =
all going to be
>relatively small. So our "$n1" in practice will always be 0.
>
>> This same problem also happens in t5318, t5319, t5324
>
>Yep. The offending code is in lib-chunk.sh, so the new tests added in =
all of those
>scripts which use it will run into the same problem.

Explains a lot. We are only able to build git in 32-bit mode because of =
OS dependencies (only available in 32-bit). I did not know that 64-bit =
was now required for git. We will get there, but it will probably take =
years.

