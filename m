From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] streaming_write_entry(): support files with holes
Date: Mon, 16 May 2011 22:23:59 -0700
Message-ID: <7v7h9pj3ww.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-9-git-send-email-gitster@pobox.com>
 <BANLkTi=VKb44yYuXdKLxrvFCVkfsDZSb4Q@mail.gmail.com>
 <7v62pan207.fsf@alter.siamese.dyndns.org>
 <BANLkTimF4zpNewcwsw=3pkt467p6Psq2Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 07:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMClS-0005vb-Fj
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1EQFYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:24:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1EQFYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:24:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3627C3539;
	Tue, 17 May 2011 01:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CxllcK4fvhzHnJFlqQhKCN9d7Vk=; b=YWBWJ4
	TfV1UuJ/Leote4hBKCZkrwgjNYSORPvHfZJdBBcMSl+2TDRVXb7JD3F5q/wc4FNz
	Kxt3bgkg32YamGaiBzyUk6j8N5ORXm/G2eFEIbgmvoYf9oj7oF/JISvt47WXWMXS
	WDXDvvTbMqr+CKoXoyVlkJoqau2xTeevJotY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HRwj+x3XBUZmTGvFg0avv2KgnUqbuRxR
	N72RiZGMBWv7OrF9TuYs+TOhEYNnro48ns6nRF9S+GrF7974bSujvZ1rp6Wi134O
	R6lZ6MAHVezD9QVTrHjALhZzphDMOX1bYVot0cIhNBFPsqSPdX4bSli7eTbOZmX3
	B/mJ957LpdU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12F653535;
	Tue, 17 May 2011 01:26:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD0863533; Tue, 17 May 2011
 01:26:07 -0400 (EDT)
In-Reply-To: <BANLkTimF4zpNewcwsw=3pkt467p6Psq2Dw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 17 May 2011 08:18:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CDE2A90-8046-11E0-9BE4-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173784>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, May 16, 2011 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Mon, May 16, 2011 at 7:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> One typical use of a large binary file is to hold a sparse on-disk hash
>>>> table with a lot of holes. Help preserving the holes with lseek().
>>>
>>> Should that be done only with big enough holes? Random zeros may
>>> increase the number of syscalls unnecessarily.
>>
>> I think that is a valid concern, but doesn't the code do that already?
>
> Ahh I see you only increase kept when the the whole buf is zero. I was
> looking for an explicit threshold, but it's implicitly the buffer
> size.

Because the code works on 10k chunks and read_istream() does not give you
a short-read, most of the time "kept" will only grab contiguous stream of
NULs in 10k increment.  At the very end of the file, however, the code can
seek by less than the chunksize, as the check is done by comparing the
holdto with readlen, not with sizeof(buf).

We might want to make sizeof(buf) a multiple of typical file block size
(e.g. 16k) to get a better alignment.

Seeking to 10k and writing 2k on a filesystem with 4k pagesize will only
make two blocks of hole, not two and half, and we would be wasting a seek
in that case.

Also we may want to omit seeking for the last chunk that is smaller than
the chunk size.

Like this...

 entry.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/entry.c b/entry.c
index e063e72..f751c60 100644
--- a/entry.c
+++ b/entry.c
@@ -137,18 +137,20 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 		goto close_and_exit;
 
 	for (;;) {
-		char buf[10240];
+		char buf[1024 * 16];
 		ssize_t wrote, holeto;
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
 
 		if (!readlen)
 			break;
-		for (holeto = 0; holeto < readlen; holeto++)
-			if (buf[holeto])
-				break;
-		if (readlen == holeto) {
-			kept += holeto;
-			continue;
+		if (sizeof(buf) == readlen) {
+			for (holeto = 0; holeto < readlen; holeto++)
+				if (buf[holeto])
+					break;
+			if (readlen == holeto) {
+				kept += holeto;
+				continue;
+			}
 		}
 
 		if (kept && lseek(fd, kept, SEEK_CUR) == (off_t) -1)
