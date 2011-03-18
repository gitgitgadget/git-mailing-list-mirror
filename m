From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-rename: don't consider unmerged path as source
Date: Thu, 17 Mar 2011 23:49:46 -0700
Message-ID: <7vmxkszzw5.fsf@alter.siamese.dyndns.org>
References: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0TVb-0005lA-II
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 07:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab1CRGt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 02:49:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab1CRGt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 02:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA9F62165;
	Fri, 18 Mar 2011 02:51:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=750NENqVh5V+A9w9HLTyG3/noBU=; b=jNGJ70
	L+B2qG8d7Dv7jGnf2JEnvAQfyJ+vZJ0Osk034qWaq9qCsZMpaeQrfuaS2GffBkIq
	4iJY+jxqthnPiADjypN938T+qCqgnz52ECDyY7H2K2eV/8Xhxk0blW/oe+WaaK66
	draI0x/7hg84Nd5uuUd80VwFgwdiFBBPOHUMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AK8wb1asSF+FTtIL3mI3madQ2OI+NQPw
	M1Dn5yyz2sku2i3KH1PkStUgdWgk2ske8mb2KFcMGH4IphZNnf8/BWRhN5aVJkA6
	KgQUsCC1bJMfE09upMlfvbvpVip8CrB++qghGBRJ+bDDWZsIemlraCyyHPiOzK7r
	WfWu9WOrhoY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A256A2164;
	Fri, 18 Mar 2011 02:51:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A8592163; Fri, 18 Mar 2011
 02:51:21 -0400 (EDT)
In-Reply-To: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 17 Mar 2011 21:42:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 252C3F06-512C-11E0-A25F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169292>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> The output from 'git status' and 'git diff-index --cached -M' is
> broken when there are unmerged files as well as new files similar to
> the unmerged file (in stage 1).
>
> When two copies have been created the output is:
>
> $ git status -s
> C  original -> exact-copy
> R  original -> modified-copy
>  U original

I think the above actually sort-of makes sense.  The first column of
status output is about comparing the HEAD and the index, and the second
column is about comparing the index and the working tree, but I'll begin
by explaining the latter.

When comparing an unmerged index with the working tree, the comparison
itself does not make much sense.  When producing textual diff,
"diff-index" tends to give the difference between stage #2 and the working
tree in order to show the difference from "our" version and the result of
the incomplete merge, but when we need to show the result concisely in the
"status -s" output, the fact that the index is unmerged is more important
than the incomplete merge result in the working tree is different from the
original, so we show "U".

So I think "U" is perfectly good there.

About the comparison between HEAD and index, "original" in HEAD is copied
to "exact-copy" in the index, and "modified-copy" in the index has a very
similar contents as "original" in HEAD. It may be a bug that the latter is
shown as "R" and I suspect that is because the code mistook the unmerged
entry in the index as missing.  Turning that "R" to "C" may be worth
doing. Change the code that says "ah, the index is unmerged at this path,
so treat it as if it is not there" to "if the unmerged path does not have
stage #2 entry, it is missing".

> There are several errors here: 1) "original" has invalid status " U",
> 2) "modified-copy" is listed as a rename, even though its source
> ("original") still exists, and 3) "exact-copy" is detected as a copy,
> even though 'git status' is only supposed to show renames

The prose is good but if you illustrated a bug with a command output,
please follow it up with another command output that you think is the
right output.  It becomes easier to point out potential flaws in the
design and the thought behind it, like I just did above about "U".

I don't think anybody said "only supposed to show renames", but I suspect
that the recent lt/diff-rename topic may affect this part of the output.

> Fix these problems by making diffcore-rename not consider unmerged
> paths as source for rename detection. For simplicty, don't consider
> the path independent of the type of merge conflict, even if the path
> is deleted on at least one side. Still consider unmerged paths as
> source for copy detection.

I don't think the part after "Still..." is justified enough.

For that matter, everything after "For simplicity..." is not justified
enough. What are you sacrificing in return for that simplicity?  "Ideally
we should show X but because we don't consider these we end up getting Y
but that still is better than what we get today which is Z" is missing.

> Also not sure about the "while at it" stuff...

Because "while at it" is by definition stuff that is not essential, don't
do "white at it" if you are not sure, if it adds unnecessary noise and
burden on reviewers.
