From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] convert: ce_compare_data() checks for a sha1 of a path
Date: Tue, 24 May 2016 11:36:26 -0700
Message-ID: <xmqqy46z482d.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
	<1463824909-10229-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue May 24 20:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HBy-0001Ez-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbcEXSgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 14:36:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752864AbcEXSga convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 14:36:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E89111DC46;
	Tue, 24 May 2016 14:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xhz/bBd+6Yvv
	7FMEtkhk/0pq94E=; b=lqtq3BZsgq/V5ah/skesgMgD9aAadlFP2iSxndh0lip8
	muh0dFmy+F5/+Bz36L6rm3C+u+XXnHorPMQpfLth+h884m2cJbCYHAM7tpEHhT8q
	ouJ2/6jyYUJdymC8+Vdoxo/9jFO0BMmjSPBP1qV4AD6uVq+/dzGQIAbZzbhfVIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EtSyGw
	RoxCQxEbOFoRC/GgxCT6HIpeLBNJozYiRs75mcrJKlarDBrtpKr+yByqQ2x1/uMH
	pbWOcHjDKYkrFOoqdqWgn2axxksJzSePMCDa33Hs0M776iwP9IqjcOx8Jfq9ILRJ
	cnVGzzRdqb4rft+M59E+nXvG3hVZzdf6koMYo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E030D1DC45;
	Tue, 24 May 2016 14:36:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C84B1DC44;
	Tue, 24 May 2016 14:36:28 -0400 (EDT)
In-Reply-To: <1463824909-10229-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Sat, 21 May 2016 12:01:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D7A55DA-21DE-11E6-9068-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295515>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> To compare a file in working tree with the index, convert_to_git() is=
 used,
> the result is hashed and the hash value compared with ce->sha1.
>
> Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
> are converted or not.
> The "new safer autocrlf handling" checks if CRLF had been in the inde=
x before,
> and if, the CRLF in the working tree are not converted.
>
> While in a merge, a file name in the working tree has different blobs
> in the index with different hash values.
> Forwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
> the would_convert_crlf_at_commit() looks at the appropriate blob.
>
> Add a new parameter index_blob_sha1 to convert_to_git(), and forward =
the
> sha1 from ce_compare_data() into convert_to_git(). Other callers use =
NULL
> for index_blob_sha1, and the sha1 is determined from path
> using get_sha1_from_cache(path). This is the same handling as before.
>
> In the same spirit, forward the sha1 into would_convert_to_git().
>
> While at it, rename has_cr_in_index() into blob_has_cr() and replace
> 0 with SAFE_CRLF_FALSE.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Assuming that it is sensible to pass an extra "no, no, do not look
at the index entry at path, but look at this blob to see if the CRLF
conversion must be disabled" parameter all the down the callchain,
this round looks good.

I really hate to say this this late in the reroll cycle, but this
part of the description makes me wonder:

    > While in a merge, a file name in the working tree has
    > different blobs in the index with different hash values.
    > Forwarding ce->sha1 from ce_compare_data() into crlf_to_git()
    > makes sure the would_convert_crlf_at_commit() looks at the
    > appropriate blob.

When we need content-level merges with help from the end user, we
would need to "convert-to-git" the result of conflict resolution by
the user left in the working tree, and that convert-to-git needs to
take our original contents into account, i.e. "did we have CR in the
blob already? if so, disable the CRLF thing".

But we would always have "our" original contents at stage #2 in the
index in such a case, and would_convert_to_git() eventually calls
into read_blob_data_from_cache(), which knows to read from stage #2

Even if we were in a renaming merge conflict, where they renamed
file F to G while we kept file F as file F, the conflicted working
tree file will be made in path G, and stage #2 of the index for path
G would have our original contents we had at path F.

So it is not clear why this "no, no, look at this blob instead" is
necessary in the first place.  What problem does this solve?  Is
this a fix for something that can be easily demonstrated with a new
test case?
