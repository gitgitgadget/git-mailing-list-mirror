From: David Barr <davidbarr@google.com>
Subject: Re: [RFC/PATCH 1/3] protobuf: minimal implementation for compact
 in-memory structures
Date: Fri, 24 Jun 2011 09:04:11 -0700
Message-ID: <BANLkTim3WeCHp=ECDBcbHjT=Guv_epL90Q@mail.gmail.com>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
	<1308728011-14136-2-git-send-email-davidbarr@google.com>
	<7voc1p64ap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 18:04:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qa8rl-0001g5-D5
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 18:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759679Ab1FXQEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jun 2011 12:04:16 -0400
Received: from smtp-out.google.com ([216.239.44.51]:45725 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759603Ab1FXQEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2011 12:04:15 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p5OG4DFT026904
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 09:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308931454; bh=x2Ed76d0W4Kd+nqiJjk5P8uUNH8=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=RnQlwiIlx1S0yUglqoStJ/28V1nsFL1A/0+fU/pgNP+I6yxv7PLPX0jbiutfDdrUo
	 BHfpaRbIXgx6B+Xy+DBaQ==
Received: from yia25 (yia25.prod.google.com [10.243.65.25])
	by hpaq12.eem.corp.google.com with ESMTP id p5OG48eZ001582
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 09:04:12 -0700
Received: by yia25 with SMTP id 25so1695459yia.18
        for <git@vger.kernel.org>; Fri, 24 Jun 2011 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y6wnlIcsGvUdhKUv5EsspuChMl7ZbhHEB199NASyzpM=;
        b=JqQsv1R45F6oyI2GPeXYrZwD6By0pVBtSM372rugmAKHvcR44YGaoI3e812WRMzjcx
         dvsY/tyRmHy+grwllO6w==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HzkTO5L/626+D7AbVZmSUu2+BB/1Q+E8Rk7LdcnyY0unv8HCQMzRVCxPS2Tf/wUfFK
         5yaz36g16TNp/jSafHAA==
Received: by 10.101.39.15 with SMTP id r15mr3755712anj.91.1308931451893; Fri,
 24 Jun 2011 09:04:11 -0700 (PDT)
Received: by 10.101.29.2 with HTTP; Fri, 24 Jun 2011 09:04:11 -0700 (PDT)
In-Reply-To: <7voc1p64ap.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176309>

Hi,

On Wed, Jun 22, 2011 at 12:42 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> David Barr <davidbarr@google.com> writes:
>> =A0protobuf.c | =A0193 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A0protobuf.h | =A0 70 ++++++++++++++++++++++
>
> How does this relate to http://code.google.com/p/protobuf/ which has =
a
> very similar name? =A0If we do not intend to have any interoperabilit=
y with
> it, we should avoid such a confusing name, I think.

The relationship is that the design is shamelessly copied.
The reason for going with this particular design is that it very closel=
y mirrors
my though experiments on the subject but is supported by heavy use for
real workloads. This is of course offset by introducing git-specific tw=
eaks
and removing network order constraints.

>> diff --git a/protobuf.c b/protobuf.c
>> new file mode 100644
>> index 0000000..09223dd
>> --- /dev/null
>> +++ b/protobuf.c
>> @@ -0,0 +1,193 @@
>> +#include "git-compat-util.h"
>> +#include "protobuf.h"
>> +#include "varint.h"
>> +
>> +static int decode_binary(const char **buf, const char *end, const c=
har **result, size_t len)
>> +{
>> + =A0 =A0 if (end && *buf + len > end)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>
> In low-level library-ish code, we tend to signal an error with a nega=
tive
> value and success with zero, unless there is a compelling reason not =
to.
>
> When this error is triggered, what does it tell us? =A0Programming er=
ror
> (i.e. BUG())? =A0Incoming data stream error?

This would be a programming error, since the interface provides a metho=
d
to calculate the required buffer size before persisting it.

>> +static int decode_field(const char **buf, const char *end, struct p=
rotobuf_field *field)
>> +{
>> + =A0 =A0 uint32_t u32;
>> + =A0 =A0 uint64_t key;
>> + =A0 =A0 bzero(field, sizeof(struct protobuf_field));
>
> Please use memset(..., '\0', ...), as we use functions from memXXX()
> family declared in <string.h>, just like you chose to use memcpy() ov=
er
> bcopy() in encode_binary() above.

Will do.
>> + =A0 =A0 case WT_64BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&field->val.num, field->val.bin.ptr=
, field->val.bin.len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_32BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&u32, field->val.bin.ptr, field->va=
l.bin.len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 field->val.num =3D u32;
>
> Is there any need for byte-order considerations, or an encoded "messa=
ge"
> is defined (by this library) to use host encoding, and will never be =
sent
> over the wire to other systems in the future?

Host encoding is intentional but only because network encoding is a lit=
tle
messy to write for 64-bit values. I don't think its prohibitive to impl=
ement.

>> +int decode_message(const char **buf, const char *end, struct protob=
uf_field *message, size_t fields)
>> +{
>> + =A0 =A0 struct protobuf_field current;
>> + =A0 =A0 bzero(message, fields * sizeof(struct protobuf_field));
>> + =A0 =A0 while (*buf !=3D end) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (decode_field(buf, end, &current))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (current.tag < fields)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message[current.tag] =3D c=
urrent;
>
> Is there any need to check the incoming *buf for duplicated tags, who=
se
> payload may overwrite an element in message[] that was populated in t=
he
> previous iteration of this loop?

This feature comes from the original protobuf design.
It allows values to be updated by appending to the buffer.

> Could decode_field() move *buf beyond end (IOW, would it be an improv=
ement
> if we said "while (*buf < end)" instead)?

The contract is that decode_field() will not move *buf beyond end.
However for clarity, "while (*buf < end)" is better.

>> +static size_t sizeof_field(const struct protobuf_field *field)
>> +{
>> + =A0 =A0 size_t sizeof_key =3D sizeof_varint(field->tag << WT_BITS =
| field->type);
>> + =A0 =A0 switch (field->type) {
>> + =A0 =A0 case WT_VARINT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (field->val.num)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sizeof_key + sizeof=
_varint(field->val.num);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_64BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (field->val.num)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sizeof_key + sizeof=
(uint64_t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_STRING:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (field->val.bin.len && field->val.bin.p=
tr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sizeof_key + sizeof=
_varint(field->val.bin.len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ field->va=
l.bin.len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_SHA1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (field->val.bin.ptr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sizeof_key + 20;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_32BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (field->val.num)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sizeof_key + sizeof=
(uint32_t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>
> Doesn't this function want to return an error when it does not unders=
tand
> what is in field->type field? If yes, I would imagine that this funct=
ion
> needs to be of type ssize_t, you would return -1 here, and the caller=
s
> would check the return value.

Yes, just to be clear, something like:
  break;
+ default:
+   return -1;
  }

>> +static uint32_t x65599(const char *s, uint64_t len)
>> +{
>> + =A0 =A0 uint32_t r =3D 0;
>> + =A0 =A0 while (len--)
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D *s++ + (r << 6) + (r << 16) - r;
>> + =A0 =A0 return r;
>
> Would it be an improvement if we made sure that each byte in s is tak=
en as
> unsigned (or signed if you really wanted to but I do not see why) cha=
r on
> all platforms to guarantee reproducibility?

Although it shouldn't affect hash distribution, reproducibility is good=
=2E

>> +}
>> +
>> +uint32_t hash_field(const struct protobuf_field *field)
>> +{
>> + =A0 =A0 uint32_t hc =3D 0;
>> + =A0 =A0 switch (field->type) {
>> + =A0 =A0 case WT_VARINT:
>> + =A0 =A0 case WT_64BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 hc =3D (0x9e3779b97f4a7c15ull * field->val=
=2Enum) >> 32;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_SHA1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&hc, field->val.bin.ptr, sizeof(hc)=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_STRING:
>> + =A0 =A0 =A0 =A0 =A0 =A0 hc =3D x65599(field->val.bin.ptr, field->v=
al.bin.len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case WT_32BIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 hc =3D 0x9e3779b9ul * (uint32_t)field->val=
=2Enum;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return hc;
>> +}
>
> Please make the magic Q64 and Q32 into symbolic constants somewhere i=
n
> this file, or at least give comment. Naming 65599 to SOMETHING_PRIME =
would
> also be better.

Maybe some documentation ought to be attached describing why 65599.
Its not just any prime [1], it has very good mixing characteristics mod=
 2^32.
Also its form, 2^a +/- 2^b +/- 1, enables multiplication using just 2
shift operations.
It produces less collisions than 31 for short strings.

>> +#define VLI_CONTINUE 0x80
>> +#define VLI_DIGIT_MASK =A0 =A0 =A0 0x7f
>> +#define VLI_BITS_PER_DIGIT 7
>> +
>> +static int decode_varint(const char **buf, const char *end, uint64_=
t *result)
>> +{
>> + =A0 =A0 uint64_t rv =3D 0;
>> + =A0 =A0 int shift =3D 0;
>> + =A0 =A0 const char *pos;
>> + =A0 =A0 for (pos =3D *buf; pos !=3D end && shift < 64; pos++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned char ch =3D *pos;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 rv |=3D (ch & VLI_DIGIT_MASK) << shift;
>> + =A0 =A0 =A0 =A0 =A0 =A0 shift +=3D VLI_BITS_PER_DIGIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ch & VLI_CONTINUE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 *result =3D rv;
>> + =A0 =A0 =A0 =A0 =A0 =A0 *buf =3D pos + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> This seems to be the same 7-bit-at-a-time encoding used to encode obj=
ect
> size in packfiles, which is slightly looser than the one used to expr=
ess
> the pack offset of base objects (Cf. eb32d23 -- introduce delta objec=
ts
> with offset to base, 2006-09-21). Would it make more sense to use the
> slightly tighter one?

I'm inclined to use the tighter encoding but it does have implications =
for the
complexity of encoding. Decoding remains simple.

--
David Barr

[1] http://www.cse.yorku.ca/~oz/hash.html#sdbm
