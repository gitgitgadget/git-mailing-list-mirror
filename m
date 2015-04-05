From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sun, 05 Apr 2015 13:49:53 -0700
Message-ID: <xmqqpp7icnbi.fsf@gitster.dls.corp.google.com>
References: <20150405010611.GA15901@peff.net>
	<20150405011110.GC30127@peff.net> <20150405045614.GA12053@peff.net>
	<20150405052732.GA14771@peff.net> <20150405053535.GB14771@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:50:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YerUX-0000Pd-Qf
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 22:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbbDEUt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 16:49:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010AbbDEUt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 16:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A65F645EE8;
	Sun,  5 Apr 2015 16:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ySodbjPCCfq9h+8rMeejCVah1w=; b=umVZoG
	ic6vIpR3SkJPmfnCJX6ukeWNqQr0Jq4LW7GztYwYW+jRBYVgnMygLZRAzKf2YbKW
	oQOjqf3D2Oi0LYiVTOeLWPQfH2TN5BI+Rj1syVRjk85ZnYu3xMKH1ONX9sxzvonH
	e3FXI0xxKmfoThAbPKAS08w3VAKsewsOyYmYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=puMeK6tfTlZf6D1XnznXJIo+JQgt0Bqy
	JkCe9fWY998n6UwYXqxgEtJV/g7fQUpiuthivtsM1LgDcxIp5DOHUfnKKON/2jOx
	FnSVl0dGORrToJx24QHlMMgpBjIuPjBi2m0I5OByr3B1FuMoKHMBa/URn68KDePc
	2yiE9kA6eXc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FBDA45EE7;
	Sun,  5 Apr 2015 16:49:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A0B945EE4;
	Sun,  5 Apr 2015 16:49:54 -0400 (EDT)
In-Reply-To: <20150405053535.GB14771@peff.net> (Jeff King's message of "Sun, 5
	Apr 2015 01:35:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5059ADE8-DBD5-11E4-ADCF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266819>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 05, 2015 at 01:27:32AM -0400, Jeff King wrote:
>
>> On Sun, Apr 05, 2015 at 12:56:14AM -0400, Jeff King wrote:
>> 
>> > The big downside is that our input strings are no longer NUL-clean
>> > (reading "foo\0bar\n" would yield just "foo". I doubt that matters in
>> > the real world, but it does fail a few of the tests (e.g., t7008 tries
>> > to read a list of patterns which includes NUL, and we silently truncate
>> > the pattern rather than read in the NUL and barf).
>> 
>> So there is this trick:
>> 
>> diff --git a/strbuf.c b/strbuf.c
>> index f319d8d..5ceebb7 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -445,12 +445,13 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>>  	strbuf_reset(sb);
>>  
>>  	if (term == '\n') {
>> +		long pos = ftell(fp);
>>  		strbuf_grow(sb, 256);
>>  		if (!fgets(sb->buf, sb->alloc - 1, fp)) {
>>  			strbuf_release(sb);
>>  			return EOF;
>>  		}
>> -		sb->len = strlen(sb->buf);
>> +		sb->len = ftell(fp) - pos;
>>  		if (sb->buf[sb->len - 1] == '\n')
>>  			return 0;
>>  	}
>> 
>> but much to my surprise it actually runs slower than the strlen version!


The later loop you have "oops, the thing turns out to be longer than
we thought, so let's do byte-by-byte" is protected with locking, but
this part is not, and that suggests me that the ftell-fgets-ftell
sequence we see here may have its own locking cost built-in in the
stdio library, too, perhaps?

>> It also has a 32-bit overflow issue. There's fgetpos() as an
>> alternative, but fpos_t is an opaque type, and we might not be able to
>> do arithmetic on it (for that matter, I am not sure if arithmetic is
>> strictly guaranteed on ftell() results). POSIX gives us ftello(), which
>> returns an off_t. That would probably be fine.
>
> Actually, scratch that idea. ftell() always returns 0 on a non-seekable
> file, so we can't use it in the general case. And that probably explains
> the performance difference, too, if it is not keeping its own counter
> and relies on lseek(fileno(fp)) or similar.

Looked so promising, though ;-) X-<.
