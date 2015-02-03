From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 03 Feb 2015 12:23:28 -0800
Message-ID: <xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-2-git-send-email-gitster@pobox.com>
	<20150203005005.GB31946@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:24:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIk18-0008G3-0l
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 21:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966355AbbBCUYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 15:24:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752543AbbBCUYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 15:24:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3120349CE;
	Tue,  3 Feb 2015 15:24:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIkBqI2NclbpHcUAVtjyW2/6n4w=; b=Ob3DGB
	84b8t5YO0V7fZGJGvU8bVsCjnKUFQFnz2xf/rmtHq7iDl/1fN7KY2wCeDY9f0IQJ
	ZrkveHu2Hcg8kSpysqzLH3N/jK+rdP5vJ/4FLlUT659fdf1xo7CUqHShGZPqRM+o
	sGFHBrqTi3XECR73sU5SSUXszDI0yDCa8gBn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kn/+QYlOa1QDLzW6pK47kYjBOYq+9flw
	8ECVKQQQ68i1ksQdcX0BFI4JyrWvCLyoyvFqLHTvWBwRsrnPRIuL1yWS+0Mmk1JX
	AbrOzShu9AsoUdIjiBC5GeTykqepsdsSJ7zIoFsaqrRoq/80T+8wAfWd4YK3QKtq
	GuboGbfoBIY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A84D0349CC;
	Tue,  3 Feb 2015 15:24:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B6073492E;
	Tue,  3 Feb 2015 15:23:29 -0500 (EST)
In-Reply-To: <20150203005005.GB31946@peff.net> (Jeff King's message of "Mon, 2
	Feb 2015 19:50:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84054878-ABE2-11E4-B445-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263330>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 02, 2015 at 03:27:27PM -0800, Junio C Hamano wrote:
>
>> +test_expect_failure 'symlink escape via ..' '
>> +	{
>> +		mkpatch_symlink tmp .. &&
>> +		mkpatch_add tmp/foo ../foo
>> +	} >patch &&
>> +	test_must_fail git apply patch &&
>> +	test_path_is_missing ../foo
>> +'
>
> By the way, does this patch (and the other symlink-escape ones) need to
> be marked with the SYMLINKS prereq? For a pure-index application, it
> should work anywhere, but I have a feeling that this "git apply patch"
> may try to write the symlink to the filesystem, fail, and report failure
> for the wrong reason.  I don't have a SYMLINK-challenged filesystem to
> test on, though.

We check the links to be created by the patch itself in-core before
going to the filesystem, and the symbolic links you are creating
using mkpatch_symlink should be caught before we invoke symlink(2),
I think.

In other words, this series attempts to stick to the "verify
everything in-core before deciding that it is OK to touch the
working tree or the index".

A few new tests in t4122 do try to see that the command is not
fooled by existihng symbolic links on the filesystem and they need
to be marked with SYMLINKS prerequisite.
