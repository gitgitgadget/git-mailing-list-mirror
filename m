From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] push: heed user.signingkey for signed pushes
Date: Wed, 22 Oct 2014 16:47:28 -0700
Message-ID: <xmqq38afu0of.fsf@gitster.dls.corp.google.com>
References: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>
	<7b3546cd125d1ad92dd62297ecbe624a78c6079b.1413989799.git.git@drmicha.warpmail.net>
	<xmqq7fzru5do.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 01:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh5cu-0000nU-35
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 01:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbaJVXrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 19:47:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753598AbaJVXrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 19:47:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEF851906E;
	Wed, 22 Oct 2014 19:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twD+btir3b0tDUcg7IUJkFGGvX0=; b=Wz4zVO
	LjlbgLqgLfhGRTCY3XRryIEM0ppksodFWcpgcLA0/GdXCEEAbyxi+3EWqq4px9aQ
	lvyqaI1t/nf7yis4uO0VWVF8vl4/nQ3vBL2ro3b9CmPBik+reGvXX9/O3Crqp8Wd
	VvtrtWcwA2GfOEG/LIs1Bx9RMVdPQMY3Vfm1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sMoa29L557253AWHJnzS0Wx4EzNPtvKU
	lfY0kOIbZjJxClAFfoo/J7W7xnisBYUlnk6XtBIKs8KN2TJtL/4IGVpkzgYItIMl
	hQDOmYfVDjAOHRiAHmYwcAciubvVgkqrg1hqHXe37eqwH5VUjpG68tPgP8DXMWob
	AcwcH8pN0cU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C038B1906D;
	Wed, 22 Oct 2014 19:47:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DA271906C;
	Wed, 22 Oct 2014 19:47:29 -0400 (EDT)
In-Reply-To: <xmqq7fzru5do.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 22 Oct 2014 15:05:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8980A8C-5A45-11E4-A422-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> push --signed promises to take user.signingkey as the signing key but
>> fails to read the config.
>>
>> Make it do so.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Okay, I guess this is nicer. We do have the committer info in the env. Sorry.
>>
>>  builtin/push.c         |  13 ++++++++++++-
>>  t/lib-gpg/trustdb.gpg  | Bin 1360 -> 1360 bytes
>>  t/t5534-push-signed.sh |  44 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
>
> Hmph, I simply forgot about that configuration, I guess.
>
> What is this change to trustdb about, though?  The log message does
> not say anything about it.

This is a related tangent, but I just tried this:

    $ git clone ... git.git
    $ cd git.git
    $ chmod a-w t/lib-gpg/* t/lib-gpg
    $ make test

which makes GPG related tests to fail, as running GPG with the GNUPGHOME
set there involves writing into the files in the directory (or
removing and recreating).

Perhaps GPG tests should create their own copy in the playpen (aka
"trash directory") and use that as GNUPGHOME so that we do not have
to write into the single shared directory?  I wonder if automated
parallel tests can intermittently fail because of this...
