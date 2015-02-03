From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 03 Feb 2015 13:40:12 -0800
Message-ID: <xmqqpp9qptc3.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-2-git-send-email-gitster@pobox.com>
	<20150203005005.GB31946@peff.net>
	<xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
	<20150203210140.GA20594@peff.net>
	<xmqqtwz2pu4c.fsf@gitster.dls.corp.google.com>
	<20150203212450.GC20594@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:40:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIlCm-0003u3-K3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbbBCVkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:40:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753881AbbBCVkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:40:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 130973423B;
	Tue,  3 Feb 2015 16:40:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e3M+lYIkLh++LnKQLgqxR99xACY=; b=IOozzi
	ehtuG0Pb5w7DNUEjVe+HAquR2X9so0ZVggmMwox7O8FVPppEuLfUI5UX11s1oO65
	rDvc1pXxxLs38zAEibTsIhQvJLTDQwMAhhDaRh+GCigB0s9lkypSzonPtXOu18rB
	twf0gbF2AuS4F5OvDVx9eew+NdFJqlytl2lZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDZnB+GKXidRIu2E/FqnBC3HluWCBeZz
	gBX9aXmG3FJrgxLhmocNgwxvMcIVNPE8cDMmIFr6IN+jOQU2iPev0SidWoc7qJ3k
	LfgUOD8cSljq/GDNH6voHTzCwE1AhEfjx/FW8DMAz6dXvahdjWIizYO858nKFsM5
	0AlSYm69pxc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06C0B34238;
	Tue,  3 Feb 2015 16:40:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5795934236;
	Tue,  3 Feb 2015 16:40:13 -0500 (EST)
In-Reply-To: <20150203212450.GC20594@peff.net> (Jeff King's message of "Tue, 3
	Feb 2015 16:24:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C355384-ABED-11E4-8DC7-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263336>

Jeff King <peff@peff.net> writes:

> But wouldn't we still fail writing "foo/bar" at that point if "foo" is a
> regular file (again, we should never do this, but that is the point of
> the test).

The point of the test is not to create foo, whether it is a symlink
or an emulating regular file, in the first place.

In this piece:

>> +test_expect_failure 'symlink escape via ..' '
>> +	{
>> +		mkpatch_symlink tmp .. &&

This is a patch to create "tmp" that points at ".."

>> +		mkpatch_add tmp/foo ../foo

And this is a patch to create "tmp/foo", and make sure ../foo does
not exist in the filesystem to prepare for the test.

>> +	} >patch &&
>> +	test_must_fail git apply patch &&

And this patch, if the rejection logic were to be broken in the
future, might create "tmp" and then try to follow it to affect
"../foo".

>> +	test_path_is_missing ../foo

So if this test makes sure if "tmp" is missing, then it would be
alright, no?  The "follow the symlink to affect ../foo" may not
happen on a filesystem without symlinks, but verifying that "tmp"
is missing will assure us that the patch application is atomic,
i.e. if we see "tmp" on the filesystem after seeing "git apply"
failed, that is a sign that "git apply" failed to be atomic.
