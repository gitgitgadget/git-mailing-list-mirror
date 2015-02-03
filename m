From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] apply: do not touch a file beyond a symbolic link
Date: Mon, 02 Feb 2015 17:56:55 -0800
Message-ID: <xmqq61bjsqoo.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-5-git-send-email-gitster@pobox.com>
	<20150203011139.GC31946@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 02:57:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YISje-0004BR-Go
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 02:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbbBCB46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 20:56:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754866AbbBCB45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 20:56:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE39F353C1;
	Mon,  2 Feb 2015 20:56:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hxdf5G9gj2SwpmWFFJCAFM7ECFU=; b=Rw2vBZ
	6sALWW7Lziyc3AFElZ4usJRqEszixqm7bcUjJ318S5QECv60K0+mCCOSvuSGN/7i
	CNvBqtJuKRsY6WRSBuY7/5szNXw+hNNnR4U4MANAFCGs0e3oNBZfgJ/OozQe90LD
	s1ZAfmXkxtikgO/tcilrtuqvgtjyZIvH5Zm8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rB+EiB9WpBXLGSrL2IEVacRxEmD9zt6U
	7j9xgEs9ajinTGUvhUTxRtEMKswsRoe7RIPgUxLX2ARI2W+OHcqxvB8jS/R/NYs2
	+7lfa+UkEr6UVlWm17rjqjwzcF0+V1VZTGPV6en+8eXCiVC8wgvdgakCdDMo2FeE
	RzStFhHVOBM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5F2C353C0;
	Mon,  2 Feb 2015 20:56:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47060353BC;
	Mon,  2 Feb 2015 20:56:56 -0500 (EST)
In-Reply-To: <20150203011139.GC31946@peff.net> (Jeff King's message of "Mon, 2
	Feb 2015 20:11:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEA88564-AB47-11E4-A808-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263300>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 02, 2015 at 03:27:30PM -0800, Junio C Hamano wrote:
>
>> +static struct string_list symlink_changes;
>
> I notice we don't duplicate strings for this list. Are the paths we
> register here always stable? I think they should be, as they are part of
> the "struct patch".

Yeah, and I also forgot to free this string-list itself.  Needs
fixing.

> I think this means we'll be
> overly cautious with a patch that does:
>
>   1. add foo as a symlink
>
>   2. remove foo
>
>   3. add foo/bar
>
> which is perfectly OK

No, such a patchset is broken.

A valid "git apply" input must *not* depend on the order of patches
in it.  The consequence is that "an input to 'git apply' must not
mention the fate of each path at most once."

"create B by copying A" and "modify A in-place" can appear in the
same patchset in any order, and the new file B will have the
contents from the original A, not the result of modifying A
in-place, which is what will be in the resulting A.  That is how
"git diff" expresses renames and copies, and that is why rearranging
the patchset using "git diff -Oorderfile" is safe.

> but we'll reject. I suspect this is making things
> much simpler for you, because now we don't have to worry about order of
> application that we were discussing the other day.

It is not "now this new decision made things simpler".  "git diff"
output and "git apply" application have been designed to work that
way from day one.  At least from day one of rename/copy feature.

We probably should start thinking about ripping out the fn_table[]
crud.  It fundamentally cannot correctly work on an input that
concatenates more than one "git diff" outputs that have renames
and/or copies of the same file, and it never will, and that is not
due to a bug in the implementation.

The reason why the incremental application is a fundamentally flawed
concept in the context of "git apply" is because you cannot tell the
boundary between the original "git diff" outputs.

Imagine that you have three versions, A, B and C, and the original
two "git diff -M A B" and "git diff -M B C" output said this:

    (A -> B)
    edit X in place and add two lines at the beginning
    create Z by copying X

    (B -> C)
    create Y by renaming X and add a line at the end

If you take "git diff -M A C", it should say:

    (A -> C)
    edit X in place and add two lines at the beginning
    create Y by copying X and add two lines at the beginning
        and a line at the end
    create Z by copying X

Now, if you concatenate two "git diff" outputs and feed it to "git
apply", you would want it to express a patchset that goes from A to
C, but think if you can really get such a semantics.

    edit X in place and add two lines at the beginning
    create Z by copying X
    create Y by renaming X and add a line at the end

You fundamentally cannot tell that Z needs to be a copy of X before
the change to X (which is what the usual "git apply" does), but Y
needs to start from a copy of X after the change to X.  There is no
clue to tell "git apply" that there is a boundary between the first
two operations and the third one.  It is impossible for the
concatenated patch to express the same thing as "(A -> C)" patch
does, without inventng some "I am now switching to a new basis"
marker in the "git apply" input stream.

>> +	/*
>> +	 * An attempt to read from or delete a path that is beyond
>> +	 * a symbolic link will be prevented by load_patch_target()
>> +	 * that is called at the beginning of apply_data().  We need
>> +	 * to make sure that the patch result is not deposited to
>> +	 * a path that is beyond a symbolic link ourselves.
>> +	 */
>> +	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
>> +		return error(_("affected file '%s' is beyond a symbolic link"),
>> +			     patch->new_name);
>
> Do we need to check the patch->is_delete case here (with patch->old_name)?

> I had a suspicion that the new patch 3/4 to check the reading-side might
> help with that, but the comment here sounds like we do need to check
> here, too

Hmm, the comment above was meant to tell you that we do not have to
worry about the deletion case (because load_patch_target() will try
to read the original to verify we are deleting what we expect to
delete at the beginning of apply_data(), and it will notice that
old_name is beyond a symbolic link), but we still need to check the
non-deletion case.  Strictly speaking, modify-in-place case does not
have to depend on this code (the same load_patch_target() check will
catch it because it wants to check the preimage).

May need rephrasing to clarify but I thought it was clear enough.
