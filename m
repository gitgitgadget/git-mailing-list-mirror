From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 03 Feb 2015 14:11:41 -0800
Message-ID: <xmqqh9v2prvm.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-2-git-send-email-gitster@pobox.com>
	<20150203005005.GB31946@peff.net>
	<xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
	<20150203210140.GA20594@peff.net>
	<xmqqtwz2pu4c.fsf@gitster.dls.corp.google.com>
	<20150203212450.GC20594@peff.net>
	<xmqqpp9qptc3.fsf@gitster.dls.corp.google.com>
	<20150203215043.GA21357@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 23:11:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIlhE-0002FU-VT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 23:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbBCWLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 17:11:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752601AbbBCWLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 17:11:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59D7034DAD;
	Tue,  3 Feb 2015 17:11:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PjNzyfUwK7IxRB27/VsKsjimE7U=; b=SMN5rV
	gLlxqVgIn8GlTJhd4Vp64mM6Kpu5ICLHTrDLi2deJD0ntmZQlAV1oqXThHh4gE48
	KVh0IJINiN/3+ec5ChJ4XnDhKEcfRkK5uKG+35YgRNBHSxMkMNUcWivQRK5fh/Uq
	F3RI5nUShUJ4GgcvVHvrIPyW5JiuKTgo30bWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2GDiBiCNA/euEk5bZyjJUqYrdU1Lxn2
	KLBsL16UOi0LM5NOlMYiMWakk04VoccOUZ/BDS1/yGxsQo7yotkLSnhJvTv0mzYV
	poT1TQ5EswVT+U0iwnXJCQxhlGZ4inAUVz9pYzP4m/4CwYAZBCN8H5llwYUeCBhi
	US+clJPdADw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50DE834DAC;
	Tue,  3 Feb 2015 17:11:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3C2334DAB;
	Tue,  3 Feb 2015 17:11:42 -0500 (EST)
In-Reply-To: <20150203215043.GA21357@peff.net> (Jeff King's message of "Tue, 3
	Feb 2015 16:50:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2673DF8-ABF1-11E4-834B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263339>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 03, 2015 at 01:40:12PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > But wouldn't we still fail writing "foo/bar" at that point if "foo" is a
>> > regular file (again, we should never do this, but that is the point of
>> > the test).
>> 
>> The point of the test is not to create foo, whether it is a symlink
>> or an emulating regular file, in the first place.
>
> I thought the point was not to create "../bar", when "foo" points to
> "..".

That is not what the new test you added was doing, though.  You are
calling "tmp" in that test "foo" and "../foo" in the test is called
"../bar" in the message I am responding to, so that is confusing,
but in these tests you added, I do not see anything that prepares a
symbolic link ON the filesystem and wait for "git apply" to get
fooled.

> I agree that the way you have implemented it is that we would
> never even write "foo", and the test checks for that, but to me that is
> the least interesting bit of what is being tested.

They are both interesting.  When rejecting an input, "git apply"
must be atomic.  When checking an input, "git apply" should notice
and reject a patch that tries to follow a symbolic link.

Taken together:

 (1) If a patchset tries to create a symbolic link and then tries to
     follow it, the latter principle should make "git apply" to
     reject the patchset, and the former should make sure there is
     no external effect.

 (2) If a patchset tries to affect a path, and the target of the
     patch application has a symlink that may divert the operation
     to the original path the patchset wants to affect, the latter
     principle should make "git apply" to reject the patchset, too.

And my observation is that the new tests that are not protected by
SYMLINKS prerequisite (i.e. all of them) in your new test 4139, are
all the former kind.  As "git aplly" must be atomic, rejection must
be decided without touching the filesystem at all.  Hence there is
no need for the filesystem to even support symbolic links.

But some bozo may try to break "git apply" in the future and try to
incrementally apply the patch in a patchset, and at that point, the
existing "test_must_fail git apply" may pass not because we
correctly decide not to follow symbolic links but because his broken
version of "git apply" would try to create a symbolic link (which we
would turn into a regular file) and then the filesystem would fail
to follow that symbolic link mimic, and as the result the test may
still pass.

In order to prevent that from happening, we may want to make sure
that

 - "test_must_fail git apply"

 - There is no "foo" (or "tmp"); the input to 'git apply' is the
   only thing that could create, as you do not create symlinks as
   traps before running 'git apply', so this will catch the 'make it
   incremental and then break the do-not-follow logic'.

 - There is no "../bar" (or "../foo").

The second one is missing from your tests, I think, and it would be
a very good addition, even on a platform with SYMLINKS prerequisite
satisfied.  The future change might be trying to make it incremental
and impelent do-not-follow logic by observing what is in the
filesystem, and we do want to catch such a broken implementation.




	
