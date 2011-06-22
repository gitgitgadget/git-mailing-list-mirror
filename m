From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] protobuf: minimal implementation for compact
 in-memory structures
Date: Wed, 22 Jun 2011 12:42:54 -0700
Message-ID: <7voc1p64ap.fsf@alter.siamese.dyndns.org>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
 <1308728011-14136-2-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 21:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZTKK-00073O-OP
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 21:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574Ab1FVTm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 15:42:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758550Ab1FVTm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 15:42:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E987E5D00;
	Wed, 22 Jun 2011 15:45:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ThOa12+fEVrhdEEwRVqBjtzJm9s=; b=HjCGnZ
	d4NvO5R6P0js+wt4FrMkAXp5AeXhVrzPkA+WMbB6VtvJPq+EXyQjB7IgPscZFKnt
	Uh3bnvx6HUETPjWTJ84dcGGB/kLH5CNzG+zohyvXN239kWvXzyoX8+5Bddyqs5OO
	idbQROHr8/Re8E4YbKvH8z5VVo4c6+YKiUyTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f60pACMIsVzfGN2XTGCzUmzwy55dEe15
	TG83O4+qr8j1znzWUz1QlFbpihK4/wGsNUoYTB6DGEC6j3/Z0DyCsPv8VP8bFjQE
	9X7PANVYAsb+f/F04uaLFFAHn2Kq/onlCMJS4UeCBREYEPh2IwVzsn2PM3KdfEkW
	EUrL7PQYPYw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0E4D5CFF;
	Wed, 22 Jun 2011 15:45:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD03A5CFE; Wed, 22 Jun 2011
 15:45:07 -0400 (EDT)
In-Reply-To: <1308728011-14136-2-git-send-email-davidbarr@google.com> (David
 Barr's message of "Wed, 22 Jun 2011 00:33:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 220F01E6-9D08-11E0-963D-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176252>

David Barr <davidbarr@google.com> writes:

> One struct to capture all types, just 4 methods:
> decode_message, encode_message, sizeof_message, hash_field.
>
> Signed-off-by: David Barr <davidbarr@google.com>
> ---
>
>  This is the first in a series of small patches to introduce some higher-level
>  constructs into the git toolbag.
>  The motivation is to empower a libfastimport implementation that is frugal
>  with memory, fast and scalable.
>
>  This version lacks any driver or tests.
>
>  Soon to come are:
>  * an efficient allocator that provides a mapping from an integer handle to
>   pointer and length
>  * a hash table that is time and memory effective for very numerous entries
>
>  protobuf.c |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  protobuf.h |   70 ++++++++++++++++++++++

How does this relate to http://code.google.com/p/protobuf/ which has a
very similar name?  If we do not intend to have any interoperability with
it, we should avoid such a confusing name, I think.

> diff --git a/protobuf.c b/protobuf.c
> new file mode 100644
> index 0000000..09223dd
> --- /dev/null
> +++ b/protobuf.c
> @@ -0,0 +1,193 @@
> +#include "git-compat-util.h"
> +#include "protobuf.h"
> +#include "varint.h"
> +
> +static int decode_binary(const char **buf, const char *end, const char **result, size_t len)
> +{
> +	if (end && *buf + len > end)
> +		return 1;

In low-level library-ish code, we tend to signal an error with a negative
value and success with zero, unless there is a compelling reason not to.

When this error is triggered, what does it tell us?  Programming error
(i.e. BUG())?  Incoming data stream error?

> +	*result = *buf;
> +	*buf += len;
> +	return 0;
> +}
> +
> +static int encode_binary(char **buf, const char *end, const char *value, size_t len)
> +{
> +	if (end && *buf + len > end)
> +		return 1;
> +	memcpy(*buf, value, len);
> +	*buf += len;
> +	return 0;
> +}
> +
> +static int decode_field(const char **buf, const char *end, struct protobuf_field *field)
> +{
> +	uint32_t u32;
> +	uint64_t key;
> +	bzero(field, sizeof(struct protobuf_field));

Please use memset(..., '\0', ...), as we use functions from memXXX()
family declared in <string.h>, just like you chose to use memcpy() over
bcopy() in encode_binary() above.

> +	if (decode_varint(buf, end, &key))
> +		return 1;
> +	field->tag = key >> WT_BITS,
> +	field->type = key & WT_MASK;
> +	switch (field->type) {
> +	case WT_VARINT:
> +		if (decode_varint(buf, end, &field->val.num))
> +			return 1;
> +		return 0;
> +	case WT_64BIT:
> +		field->val.bin.len = sizeof(uint64_t);
> +		break;
> +	case WT_STRING:
> +		if (decode_varint(buf, end, &field->val.bin.len))
> +			return 1;
> +		break;
> +	case WT_SHA1:
> +		field->val.bin.len = 20;
> +		break;
> +	case WT_32BIT:
> +		field->val.bin.len = sizeof(uint32_t);
> +		break;
> +	default:
> +		return 1;
> +	}
> +	if (decode_binary(buf, end, &field->val.bin.ptr, field->val.bin.len))
> +		return 1;
> +	switch (field->type) {
> +	case WT_64BIT:
> +		memcpy(&field->val.num, field->val.bin.ptr, field->val.bin.len);
> +		break;
> +	case WT_32BIT:
> +		memcpy(&u32, field->val.bin.ptr, field->val.bin.len);
> +		field->val.num = u32;

Is there any need for byte-order considerations, or an encoded "message"
is defined (by this library) to use host encoding, and will never be sent
over the wire to other systems in the future?

> +int decode_message(const char **buf, const char *end, struct protobuf_field *message, size_t fields)
> +{
> +	struct protobuf_field current;
> +	bzero(message, fields * sizeof(struct protobuf_field));
> +	while (*buf != end) {
> +		if (decode_field(buf, end, &current))
> +			return 1;
> +		if (current.tag < fields)
> +			message[current.tag] = current;

Is there any need to check the incoming *buf for duplicated tags, whose
payload may overwrite an element in message[] that was populated in the
previous iteration of this loop?

Could decode_field() move *buf beyond end (IOW, would it be an improvement
if we said "while (*buf < end)" instead)?

> +static size_t sizeof_field(const struct protobuf_field *field)
> +{
> +	size_t sizeof_key = sizeof_varint(field->tag << WT_BITS | field->type);
> +	switch (field->type) {
> +	case WT_VARINT:
> +		if (field->val.num)
> +			return sizeof_key + sizeof_varint(field->val.num);
> +		break;
> +	case WT_64BIT:
> +		if (field->val.num)
> +			return sizeof_key + sizeof(uint64_t);
> +		break;
> +	case WT_STRING:
> +		if (field->val.bin.len && field->val.bin.ptr)
> +			return sizeof_key + sizeof_varint(field->val.bin.len)
> +			       + field->val.bin.len;
> +		break;
> +	case WT_SHA1:
> +		if (field->val.bin.ptr)
> +			return sizeof_key + 20;
> +		break;
> +	case WT_32BIT:
> +		if (field->val.num)
> +			return sizeof_key + sizeof(uint32_t);
> +		break;
> +	}
> +	return 0;

Doesn't this function want to return an error when it does not understand
what is in field->type field? If yes, I would imagine that this function
needs to be of type ssize_t, you would return -1 here, and the callers
would check the return value.

> +static uint32_t x65599(const char *s, uint64_t len)
> +{
> +	uint32_t r = 0;
> +	while (len--)
> +		r = *s++ + (r << 6) + (r << 16) - r;
> +	return r;

Would it be an improvement if we made sure that each byte in s is taken as
unsigned (or signed if you really wanted to but I do not see why) char on
all platforms to guarantee reproducibility?

> +}
> +
> +uint32_t hash_field(const struct protobuf_field *field)
> +{
> +	uint32_t hc = 0;
> +	switch (field->type) {
> +	case WT_VARINT:
> +	case WT_64BIT:
> +		hc = (0x9e3779b97f4a7c15ull * field->val.num) >> 32;
> +		break;
> +	case WT_SHA1:
> +		memcpy(&hc, field->val.bin.ptr, sizeof(hc));
> +		break;
> +	case WT_STRING:
> +		hc = x65599(field->val.bin.ptr, field->val.bin.len);
> +		break;
> +	case WT_32BIT:
> +		hc = 0x9e3779b9ul * (uint32_t)field->val.num;
> +		break;
> +	}
> +	return hc;
> +}

Please make the magic Q64 and Q32 into symbolic constants somewhere in
this file, or at least give comment. Naming 65599 to SOMETHING_PRIME would
also be better.

> diff --git a/varint.h b/varint.h
> new file mode 100644
> index 0000000..48a3547
> --- /dev/null
> +++ b/varint.h
> @@ -0,0 +1,59 @@
> +#ifndef VARINT_H_
> +#define VARINT_H_
> +
> +#define VLI_CONTINUE	0x80
> +#define VLI_DIGIT_MASK	0x7f
> +#define VLI_BITS_PER_DIGIT 7
> +
> +static int decode_varint(const char **buf, const char *end, uint64_t *result)
> +{
> +	uint64_t rv = 0;
> +	int shift = 0;
> +	const char *pos;
> +	for (pos = *buf; pos != end && shift < 64; pos++) {
> +		unsigned char ch = *pos;
> +
> +		rv |= (ch & VLI_DIGIT_MASK) << shift;
> +		shift += VLI_BITS_PER_DIGIT;
> +		if (ch & VLI_CONTINUE)
> +			continue;
> +
> +		*result = rv;
> +		*buf = pos + 1;
> +		return 0;

This seems to be the same 7-bit-at-a-time encoding used to encode object
size in packfiles, which is slightly looser than the one used to express
the pack offset of base objects (Cf. eb32d23 -- introduce delta objects
with offset to base, 2006-09-21). Would it make more sense to use the
slightly tighter one?
