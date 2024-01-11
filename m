Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F519256D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40B1eVXB1724430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 01:40:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Dragan Simic'" <dsimic@manjaro.org>, <git@vger.kernel.org>
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org> <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com> <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com> <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com>
In-Reply-To: <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com>
Subject: RE: [DISCUSS] Introducing Rust into the Git project
Date: Wed, 10 Jan 2024 20:44:15 -0500
Organization: Nexbridge Inc.
Message-ID: <008701da442f$b2dfe420$189fac60$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQNL0k5wzhXZATyUnQ76Vxjn4eCV+QKEQ1wBALH7sDwDPprtZwK9Rr3fAtB2bewByXD01q2CVhCg

On Wednesday, January 10, 2024 7:59 PM, Elijah Newren wrote:
>On Wed, Jan 10, 2024 at 3:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> On Wednesday, January 10, 2024 5:26 PM, Taylor Blau wrote:
>> >On Wed, Jan 10, 2024 at 05:15:53PM -0500, rsbecker@nexbridge.com =
wrote:
>> >> Just a brief concern: Rust is not broadly portable. Adding another
>> >> dependency to git will remove many existing platforms from future =
releases.
>> >> Please consider this carefully before going down this path.
>> >
>> >I was hoping to hear from you as one of the few (only?) folks who
>> >participate on the list and represent HPE NonStop users.
>> >
>> >I'm curious which if any of the compiler frontends that I listed in
>> >my earlier email would work for you.
>>
>> Unfortunately, none of the compiler frontends listed previously can =
be built for
>NonStop. These appear to all require gcc either directly or =
transitively, which cannot
>be ported to NonStop. I do not expect this to change any time soon - =
and is outside
>of my control anyway. An attempt was made to port Rust but it did not =
succeed
>primarily because of that dependency. Similarly, Golang is also not =
portable to
>NonStop because of architecture assumptions made by the Go team that =
cannot be
>satisfied on NonStop at this time. If some of the memory/pointer =
issuese the
>primary concern, c11 might be something acceptable with smart pointers. =
C17 will
>eventually be deployable, but is not available on most currently =
supported OS
>versions on the platform.
>
>Would you be okay with the following alternative: requiring that all =
Rust code be
>optional for now?
>
>(In other words, allow you to build with USE_RUST=3D0, or something =
like that.  And
>then we have both a Rust and a C implementation of anything that is =
required for
>backward compatibility, while any new Rust-only stuff would not be =
included in
>your build.)

To address the immediate above, I assume this means that platform =
maintainers will be responsible for developing non-portable =
implementations that duplicate Rust functionality, which arguably may =
not be possible. We do have $DAYJOBS and the expectation that duplicate =
implementation are cost effective or even viable is a huge assumption =
that may not be attainable.

One of the key benefits of git is the ability to deploy it virtually =
anywhere on virtually any platform - and mirror repositories anywhere =
for resiliency purposes. It currently runs on (almost) every current =
platform because it does not have dependencies on Linux-only compilers =
and tools. Except for LFS, which is Golang, and I do not have access to =
that functionality, anyone with a C compiler can deploy git processes in =
their environment. By adding Rust (or any other gcc-only dependency), it =
eliminates the primary benefit of git. I am honestly very disappointed =
with this direction and think this detracts significantly from the =
primary value proposition that git offers: specifically, that we can =
take any developer from any platform and move them anywhere else without =
having to design new processes or teach them new processes for their =
workflows (this comes up at every major customer with whom I interact). =
I think this direction is a fundamental mistake and will rapidly limit =
(or eliminate) git's long-term viability. To be honest, if I saw this =
direction when deciding which VCS to deploy, I would reconsider git and =
start looking around for another more portable option. It hurts to even =
contemplate this direction. Please do not do this.

