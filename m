From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Tue, 25 Aug 2009 16:50:29 -0700
Message-ID: <7vprajmp16.fsf@alter.siamese.dyndns.org>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 01:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg5nD-0002au-Ve
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 01:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbZHYXul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 19:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbZHYXuk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 19:50:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484AbZHYXuk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 19:50:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D774183AB;
	Tue, 25 Aug 2009 19:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7L7mHyjl7xia00QnfCQmYLiin0o=; b=DHc1UF
	2MNo2UCO/Y31226UxB43ABogkYRYmtB5cfRAHx1GOAj7pc0F4q8tKSzLPGgvlc1I
	7CK94wkexAtpvG7vRWTBRRKk8wUyyVGcvymnPQBwNT4f5hLl5/ZGwc9/ALjKlfT5
	pRoGYF8WlLj4hdOTqcmjgbJlHYx/I2LDrG2Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q9+QmKaVxJHvydNTp3qiRRD16Jk9NbDH
	F3uMm/kMJIjrwiQof5aRtAyj64TvUvvmHtmaGdqt32maodNJs0/N3/ngcBQCg4BV
	25CZxu8Peymno9k7can2jaRFux6Sb0T4nP8uiWRVyvI1ki5fZsrTmnsAJGBCpDdC
	JxW3ZdumMks=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 251CD183AA;
	Tue, 25 Aug 2009 19:50:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F688183A9; Tue, 25 Aug
 2009 19:50:31 -0400 (EDT)
In-Reply-To: <20090825184525.GC23731@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 25 Aug 2009 14\:45\:25 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15B8273A-91D2-11DE-A3FB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127056>

Jeff King <peff@peff.net> writes:

>> +static void run_post_upload_pack_hook(int create_full_pack)
>> +{
>> +	const char *fetch_type;
>> +	fetch_type = (create_full_pack) ? "clone" : "fetch";
>> +	run_hook(get_index_file(), "post-upload-pack", fetch_type);
>> +}
>
> Does it really need an index file? This operation in question seems to
> be totally disconnected from the index (and indeed, most bare
> repositories won't even have one). Probably it should pass NULL as the
> initial argument to run_hook.

Very good point; a bare repository does not have to have (and typically
shouldn't have) the index, and a bare repository is what upload-pack
typically serves.

A short-and-sweet:

	run_hook(NULL, "post-upload-pack",
        	 create_full_pack ? "clone" : "fetch,
                 NULL);

would be sufficient.  Notice that run_hook() is variadic and its argument
list needs to be terminated with NULL (iow, the original patch is buggy
and risks reading random places on the stack---I would recommend against
using it on your production site yet).

> Is there any other information that might be useful to other non-GitHub
> users of the hook? The only thing I can think of is the list of refs
> that were fetched.

I do not think that information is available.  "want" will tell you what
object they want, but that does not necessarily uniquey translate to a
ref.

If we are allowed to talk about asking for the moon, and if one of the
primary reason for this new hook is statistics, it would be useful to see
the number of bytes given, where the fetch-pack came from, and if we are
using git-daemon virtual hosting which of our domain served the request.
