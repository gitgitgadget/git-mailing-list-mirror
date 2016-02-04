From: Junio C Hamano <gitster@pobox.com>
Subject: Re: parse_object does check_sha1_signature but not parse_object_buffer?
Date: Thu, 04 Feb 2016 09:40:54 -0800
Message-ID: <xmqq60y4jrvd.fsf@gitster.mtv.corp.google.com>
References: <20160202015701.GA30444@glandium.org>
	<xmqq60y7u7sj.fsf@gitster.mtv.corp.google.com>
	<20160202043628.GA10253@glandium.org>
	<xmqqwpqmsymf.fsf@gitster.mtv.corp.google.com>
	<20160204071919.GA14032@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:41:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRNtv-0008VI-4w
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 18:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbcBDRk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 12:40:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbcBDRk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 12:40:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78C16403B0;
	Thu,  4 Feb 2016 12:40:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EXmGgtfldr00/EXZJ7Fxx1h9+nA=; b=Mr9Mc3
	MICqmhppRoxXrO73ySiOhyO50Wt8h0n0d8VWQaoobaKot+8nWDU1kwPYA7iTZIbx
	ph8SEYw/mu8BxYpXygZI5ii17MYM2iqk5AHAszL9EOKTDS7uxdkWj8LK82cUknXY
	OfQv3AR269+h1OC87MHvzDYmMz1s1I8CUgR9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKTr5mst6yy+QDEIYUY636Lbq2/0DVua
	clypx2YiIlRFclojCfZjpjSOOvX5tYzg9hr1JMth73B5NHmaiLoplGEjL/oBI2uP
	A8YYzTG2G/m3SRc6XQjEA9KjqsyS0vM+pZHO0CPivisO9D0DJt2GgjxYCBCSBRGC
	dGBI7So4Uz0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F5BE403AF;
	Thu,  4 Feb 2016 12:40:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D8DC3403AE;
	Thu,  4 Feb 2016 12:40:55 -0500 (EST)
In-Reply-To: <20160204071919.GA14032@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 4 Feb 2016 02:19:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71AE7286-CB66-11E5-874C-BE4D6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285469>

Jeff King <peff@peff.net> writes:

> For local repository operations, most of them are about reading data.
> And there I generally favor performance over extra validation, with the
> caveat that we should always be aware of the tradeoff. An extra
> comparison to make sure we are not going out-of-bounds on a pack .idx
> pointer is cheap. Loading a blob just to make sure its sha1 is valid
> before we mention it in `diff --raw` output is stupid. Checking the sha1
> on objects we are otherwise accessing is somewhere in between. :)
>
> For local write operations, like repacking, we should err on the careful
> side. And I think we do a good job of balancing performance and
> validation there (e.g., we reuse deltas without reconstructing the
> object, but _with_ a crc check on the delta data itself).

OK, that is a reasonable set of rules.  We can say "checkout" is
writing out the contents to the filesystem, and make the "somewhere
in between" be closer to the "error on the careful side".

>> In fact, we do this, which is quite suboptimal:
>> 
>>         static int fsck_sha1(const unsigned char *sha1)
>>         {
>>                 struct object *obj = parse_object(sha1);
>>                 if (!obj) {
>>                         errors_found |= ERROR_OBJECT;
>>                         return error("%s: object corrupt or missing",
>>                                      sha1_to_hex(sha1));
>>                 }
>>                 obj->flags |= HAS_OBJ;
>>                 return fsck_obj(obj);
>>         }
>> 
>> This function is called for each loose object file we find in
>> fsck_object_dir(), and there are a few problems:
>> 
>>  * The function parse_object() called from here would issue an error
>>    message and returns NULL; then you get another "corrupt or
>>    missing" error message, because this code cannot tell from the
>>    NULL which is the case.
>> 
>>  * The intent of the callchain to fsck_sha1() is to iterate over
>>    loose object files xx/x{38} and validate what is contained in
>>    them, but that behaviour is not guaranteed because it calls
>>    parse_object(), which may get the object data from a packfile
>>    if the loose object is also in the packfile.
>> 
>> This function should instead take "path" (the only caller of this
>> function fsck_loose() has it), read the data in the file, hash the
>> data to validate that it matches "sha1" and then create the object
>> out of that data it read by calling parse_object_buffer().
>
> Yeah, I agree. I think as it is written, we also end up loading the
> loose objects twice (once in parse_object, and then later again in
> fsck_object to do the real work). Your solution would fix that, too.
> ...
> I guess nobody has really noticed either issue, because repositories
> large enough for it to make a difference will usually be packed.

I'll throw it in the leftover-bits list, then ;-)
