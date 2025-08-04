Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBF1E0E14
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326870; cv=none; b=Ul44PuvQ/uRb0G3nnj5HwzkZlJ5QlaBCMB4mK6XrGSNfttqfLcGrg6EYfdNm9d6lA6pegEkRfxvuOC/vEEgr8zDRYSoCSxIi3cJBDWIGwGX0jwgXe3vsq12fu9Emc1HL/KpMyIqECVUUo5tUnCM/cOcBtgFVP9vF44LvyY991Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326870; c=relaxed/simple;
	bh=HsO0rBiLtpncOrNuXJVuI0NSvhNahAjKdHhD62KLw+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FBzDo3EFJ9i9dpb8RBzCZwUM0KDhm783QoORFCgvc2hdYiFCpix4rpdpBCE00+maxI16yBThSCzDWg67ors66gvuf71jjTUR8IVyRh3qu4w9HjCE/o1ITqYZ1be3MYRuYJ99uVKuTCF76QM7C+O9jVTGdOgTXs4xXhIY/5ZnMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=39hRgij7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="39hRgij7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754326862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lO0ACRCcfO9LATTbJ6tvV6t8O5mNkKh1hervv1wY0xo=;
	b=39hRgij7rhHAfkVymhcYcOjqao4Xis8MojafJxQZd3mnKd6lDmaNtiej8HwiLbTxPghZPa
	n8MkO+c1o7CWIRXErEXsnyK/a3Ia6LPb0KQKnBQOcqRWPwDOEgbMnaZr/serHMY+4qGqOI
	bZoDkqlBC6EZzFOjkV/zndzcwmGnnpQ=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] archive: flush deflate stream until Z_STREAM_END
In-Reply-To: <t4rkigpst2h42r7iouwli7lj74lydz6nmehojzajt6impibpui@kvgu7pfkuf6k>
References: <20250802220803.95137-1-jltobler@gmail.com>
 <5817e9ed-5b5c-4539-85ea-07c601c0ac7e@web.de>
 <t4rkigpst2h42r7iouwli7lj74lydz6nmehojzajt6impibpui@kvgu7pfkuf6k>
Date: Mon, 04 Aug 2025 19:00:53 +0200
Message-ID: <87cy9buim2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> On 25/08/03 11:52AM, Ren=C3=A9 Scharfe wrote:
>> On 8/3/25 12:08 AM, Justin Tobler wrote:
>> > I've tested the patch against this specific file, and it fixes the
>> > issue, but I'm uncertain how to reproduce and test this issue more
>> > generically. I'm open to suggestions if anyone has some ideas :)
>>=20
>> Not sure how to fill up zlib's pending buffer most efficiently.
>> Reducing the size of the output buffer would make the bug easier to
>> trigger, though.

Yes, in my local testing I also have been reducing the size of the
output buffer.

> Ya, I was able to trigger this issue more frequently by making the
> output buffer smaller than the input buffer. I was really hoping though
> to find a way to reproduce this without code changes so we could add a
> test. Not sure if that is really feasible though in this case.

I think it's really nice you were able find a repository that reproduces
this issue. Having an existing example in the "wild" is better proof to
verify this fix work.

>> > I've so far only been able to reproduce this issue in the chromium.git
>> > repository with a specific file:
>> >
>> >         git clone --depth=3D1 https://github.com/chromium/chromium.git
>> >         cd chromium
>> >         git -c core.bigFileThreshold=3D1 archive -o foo.zip --format=
=3Dzip HEAD -- \
>> >                 ui/events/ozone/evdev/touch_filter/palm_model/onedevic=
e_train_palm_detection_filter_inference.cc

Weird, for me this file didn't trigger the error, but the following file
did:

    chrome/test/data/third_party/kraken/tests/kraken-1.1/imaging-darkroom-d=
ata.js

But also with this file, I can confirm this fix works.

>> > diff --git a/archive-zip.c b/archive-zip.c
>> > index df8866d5bae..29e7c9f5e3f 100644
>> > --- a/archive-zip.c
>> > +++ b/archive-zip.c
>> > @@ -492,14 +492,22 @@ static int write_zip_entry(struct archiver_args =
*args,
>> >=20=20
>> >  		zstream.next_in =3D buf;
>> >  		zstream.avail_in =3D 0;
>> > -		result =3D git_deflate(&zstream, Z_FINISH);
>> > -		if (result !=3D Z_STREAM_END)
>> > -			die("deflate error (%d)", result);
>> > +
>> > +		do {
>> > +			result =3D git_deflate(&zstream, Z_FINISH);
>> > +			if (result !=3D Z_OK && result !=3D Z_STREAM_END)
>> > +				die("deflate error (%d)", result);
>> > +
>> > +			out_len =3D zstream.next_out - compressed;
>> > +			if (out_len > 0) {
>> > +				write_or_die(1, compressed, out_len);
>> > +				compressed_size +=3D out_len;
>> > +				zstream.next_out =3D compressed;
>> > +				zstream.avail_out =3D sizeof(compressed);
>> > +			}
>> > +		} while (result !=3D Z_STREAM_END);
>> >=20=20
>> >  		git_deflate_end(&zstream);
>> > -		out_len =3D zstream.next_out - compressed;
>> > -		write_or_die(1, compressed, out_len);
>> > -		compressed_size +=3D out_len;
>>=20
>> Looks good.  Could probably rolled into the first loop, but that just
>> would make this fix more complicated.
>
> I was also considering rolling this into the first loop, but ultimately
> went with the minimal patch to fix the issue. I don't mind rerolling if
> we prefer it the other way though. :)

When I was researching, I have been working on a version that rolls the
changes into the first loop, but that diff is a lot more substantial.
The thing is, you cannot seem to avoid introducing another (nested)
loop.

My refactoring is based on the zlib example page[1] page and example
source code[2], and also there two nested loops are used. Ideally, we'd
modify our code so it follows the example code more closely, but I'm
worried this might introduce new breakage, so it's probably not worth
it.

On the other hand, I was able to trigger failure when I made the output
buffer equally large as the input buffer. In this case git-archive
completes successfully, but when inflated, the content is mangled.
It seems my version is protected against that.

I've submitted my version too[3]. I'm on the fence which solution is
better, so I'd love to get input from the both of you. So I'm happy to
hear any thoughts.

[1]: https://zlib.net/zlib_how.html
[2]: https://zlib.net/zpipe.c
[3]: https://lore.kernel.org/git/20250804-toon-archive-zip-fix-v1-0-ca89858=
e5eaa@iotcl.com/

--=20
Cheers,
Toon
