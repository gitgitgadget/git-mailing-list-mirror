From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Sat, 09 May 2015 10:39:24 -0700
Message-ID: <xmqqlhgxhcqb.fsf@gitster.dls.corp.google.com>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
	<1431124726-22562-2-git-send-email-dturner@twopensource.com>
	<xmqq7fsiifcz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat May 09 19:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr8iq-0007pg-9f
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 19:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbbEIRj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 13:39:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbbEIRj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 13:39:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB9CD4F48A;
	Sat,  9 May 2015 13:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYQHCvBuHvVFn5XDJxqrkS3IZJA=; b=RC3Tjv
	9Y5h1RiZqK7YmBriGZp80+IbU6Xbw14yBrY0SL7eVLXwtL0fvIXaEj202yGq/aef
	UpsF0owS091V68YOn39SEStH1Ka34OwF9z7m4uHyXGCyWiilazUWbIkEqg/9ZtPe
	6z3ocC0PVEI64pjb2F+f+PrEnuALhto6vmtwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycKWy02SJTACEdTcS5xnyryxteq0p5jA
	JhO+aOeR415tvgzb32awFOkpMGj9//0HdBYAU+7Uj9JCq35R3T4rQOZNXuU90ZkB
	q4xvfi7W+veXUqCDgyMBpOENDIaYx8NwPd5KUrALQN2n1dZRhTUgAS/MHSaE8vwb
	FdeQcqlc5qk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3BCB4F489;
	Sat,  9 May 2015 13:39:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E46B4F487;
	Sat,  9 May 2015 13:39:25 -0400 (EDT)
In-Reply-To: <xmqq7fsiifcz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 May 2015 20:45:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55B6DFBA-F672-11E4-BB98-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268708>

Junio C Hamano <gitster@pobox.com> writes:

> dturner@twopensource.com writes:
>
>> From: David Turner <dturner@twitter.com>
>>
>> Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
>> when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
>> is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
>> ONLY_TO_DIE triggers does not consider symlinks.
>
> Is "does not consider" something fundamental, or it just happens to
> be that way right now?

Regardless of the answer to this question, I find the last part of
this hunk puzzling.


> +			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
> +				ret = get_tree_entry_follow_symlinks(tree_sha1,
> +					filename, sha1, oc->path, &oc->mode);
> +			} else {
> +				ret = get_tree_entry(tree_sha1, filename,
> +						     sha1, &oc->mode);
> +				if (ret && only_to_die) {
> +					diagnose_invalid_sha1_path(prefix,
> +								   filename,
> +								   tree_sha1,
> +								   name, len);
> +				}
> +				hashcpy(oc->tree, tree_sha1);
> +				strlcpy(oc->path, filename, sizeof(oc->path));
>  			}
> -			hashcpy(oc->tree, tree_sha1);
> -			strlcpy(oc->path, filename, sizeof(oc->path));
> -

Both variants of get_tree_entry() receive tree_sha1 and &oc->mode as
places to store the discovered results and that is why we do hashcpy
and strlcpy in the original codepath.

 - With your patch, the new codepath discards tree_sha1[] because it
   lost the copy back to oc->tree[]; is this change intended?  As we
   are not passing oc itself to the function, there is no way for it
   to return the object name directly to oc->tree[], no?

 - In the new codepath, oc->path[] is also not copied but I can
   sort-of guess why (you want to return something other than
   "filename" from get-tree-entry-follow-symlinks in it, or
   something).  But then the caller is losing the result of parsing
   the extended SHA-1.

You explain why "if (ret && only_to_die)" part is skipped, but these
two differences are equally, if not more, important differences
between the two codepaths.  I do not think I saw it explained.

In any case, I would think that get_sha1_with_context() should have
an external interface that is as close as the original, with
enhancement (i.e. not with modification of what existing fields
mean) [*1*].

That is, if oc->path[] is meant to store filename parsed from the
end-user input, it should keep doing so with or without
follow-symlinks.  And if follow-symlinks feature needs to return
extra information to the caller, it should add a new field to return
that information.

And my gut feeling is that such a correction to the way how the
updated get_sha1_with_context() behaves would mean you can (and need
to) keep hashcpy() and strlcpy() common to both codepaths in this
patch.

Thanks.


[Footnote]

*1* The reason is simple.  On a user input without any symbolic
link, a caller (not just the caller you are adding in patch 3/3)
should be able to expect to get the identical outcome from
get_sha1_with_context(), with or without GET_SHA1_FOLLOW_SYMLINKS.
