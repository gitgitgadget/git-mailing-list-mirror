From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-merge-one-file: revise merge error reporting
Date: Mon, 25 Mar 2013 10:17:24 -0700
Message-ID: <7vfvzjz9ej.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
 <1364127985-13366-1-git-send-email-kevin@bracey.fi>
 <1364127985-13366-4-git-send-email-kevin@bracey.fi>
 <7vk3ovz9zb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKB1x-0000jh-5K
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703Ab3CYRR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:17:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543Ab3CYRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:17:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE3ADBAD0;
	Mon, 25 Mar 2013 13:17:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r/5pIRzFa9FLQAuqJc7nogUYmQw=; b=fMmlBp
	tNLzoESnPOxfX1/x0yFPl/zE0LWOC+iEa2EbsohXgarNdLnId+w0Nb7B6ZG74yVi
	sV4zzgIxSE9Jv33gUVXu+pkXelWXNKzC93nQiTGnhQJZAM1PVBMObUBO8hYSoC2A
	kanI6ugnDlwzK3Ia1fJOghuIg8rYJK8lR5rRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VueppDYSowmJWtr3FsEZFtNANesxtIDL
	vLo8EpQhuNJqfswvDckZDrBKJkf0ft/ISXEvvPi/8cD3zVN4Kp1sAOFnCIYy2YLQ
	8IG6vwJPWgJTenqMnVTVJv8lrJBeJTN7zN54ukMCjl9ezXrSvdBshQ7UDzMd1m9f
	1j87Q4Zphm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1B43BACF;
	Mon, 25 Mar 2013 13:17:26 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E578FBACD; Mon, 25 Mar 2013
 13:17:25 -0400 (EDT)
In-Reply-To: <7vk3ovz9zb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 25 Mar 2013 10:04:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD320764-956F-11E2-B1FC-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219047>

Junio C Hamano <gitster@pobox.com> writes:

> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Commit 718135e improved the merge error reporting for the resolve
>> strategy's merge conflict and permission conflict cases, but led to a
>> malformed "ERROR:  in myfile.c" message in the case of a file added
>> differently.
>>
>> This commit reverts that change, and uses an alternative approach without
>> this flaw.
>>
>> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
>
> We used to treat "Both added differently" as a separate "info"
> message, just like the "Auto-merging" message, and let "content
> conflict" that is an "error" to happen naturally by doing such a
> merge, possibly followed by permission conflict which is another
> kind of "error".  We coalesced these two into a single message.
>
> And this patch breaks them into separate messages.  I am not sure if
> that aspect of the change is desirable.
>
> The source of "malformed" message seems suspicious.  Isn't the root
> cause of $msg being empty that merge-file can (sometimes) cleanly
> merge two files using the phoney base in the "both added
> differently" codepath?
>
> If you resolve that issue by forcing a "conflicted" failure when we
> handle "add/add" conflict, I think the behaviour of the remainder of
> the code is better in the original than the updated one.
>
> Perhaps something like this (I am applying these on 'maint')?

Actually, this one is even better, I think.  Again on top of your
two patches applied on 'maint'.

Alternatively, we can remove the whole "if $1 is empty, error the
merge out" logic, which would be more in line with the spirit of
f7d24bbefb06 (merge with /dev/null as base, instead of punting
O==empty case, 2005-11-07), but that will be a change in behaviour
(a "both side added, slightly differently" case that can cleanly
merge will no longer fail), so I am not sure if it is worth it.

-- >8 --
Subject: [PATCH] merge-one-file: force content conflict for "both side added" case

Historically, we tried to be lenient to "both side added, slightly
differently" case and as long as the files can be merged using a
made-up common ancestor cleanly, since f7d24bbefb06 (merge with
/dev/null as base, instead of punting O==empty case, 2005-11-07).
This was later further refined to use a better made-up common file
with fd66dbf5297a (merge-one-file: use empty- or common-base
condintionally in two-stage merge., 2005-11-10), but the spirit has
been the same.

But the original fix in f7d24bbefb06 to avoid punging on "both sides
added" case had a code to unconditionally error out the merge.  When
this triggers, even though the content-level merge can be done
cleanly, we end up not saying "content conflict" in the message, but
still issue the error message, showing "ERROR:  in <pathname>".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-merge-one-file.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 25d7714..62016f4 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -155,6 +155,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	fi
 	if test -z "$1"
 	then
+		msg='content conflict'
 		ret=1
 	fi
 
-- 
1.8.2-297-g51e0fcd
