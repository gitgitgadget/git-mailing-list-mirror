From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] pathspec: get non matching arguments without reporting.
Date: Thu, 05 May 2016 16:22:33 -0700
Message-ID: <xmqq37pw84zq.fsf@gitster.mtv.corp.google.com>
References: <1462489197-30616-1-git-send-email-sbeller@google.com>
	<xmqq7ff885hj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:22:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySbS-0000qn-9i
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbcEEXWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:22:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755380AbcEEXWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:22:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F298B19ED4;
	Thu,  5 May 2016 19:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+UrTtOirj/p8AOad51+4uVMA86Y=; b=PAuRUs
	IOxQSNiyvOPDS9iDdNN9Q96QFiqaOEM45JlFQsNapFidQDymFHhTxr8c+psq7YXx
	l9n2JTKMRIlSx4b2hhqN36uu9BgQChDaZG1B82uxyK0grIwsSa2y9wEg1DHhsBeE
	RWKPOlqFewYz4axGEtDetoXxCEt20q14Rkt9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1qug7T2zJGp/vxLV2OO/zdmZppIyhro
	gp+UoRYTnaeody5CzWtcBlu7YuGP/Al+3h8QGZrHbNQN/T4G9hZjoQ96uv/+aCwu
	M+BzsyvPZ2MrxFJO22hQzzXL7TBTkKrRQlI06BSDNKRbQHlNWnuUPuQPw/eWe7Q2
	MfJ4KRwCOFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E99C519ED3;
	Thu,  5 May 2016 19:22:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DF6519ED2;
	Thu,  5 May 2016 19:22:35 -0400 (EDT)
In-Reply-To: <xmqq7ff885hj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 May 2016 16:11:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FF68720-1318-11E6-A87C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293725>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> When giving more than just pathspec arguments (e.g. submodule labels),
>> we need a way to check all non-matching arguments for the pathspec parsing
>> if these are the submodule labels or typos.
>>
>> This patch prepares for that use case by splitting up `report_path_error`
>> into a new checking function `unmatched_pathspec_items` and a
>> reporting callback.
>
> I seem to recall that there is a longstanding plan to move the
> "seen[]" array that is separate and outside from the pathspec
> structure into the pathspec structure.  Wouldn't that be a more
> sensible approach to solve the same thing?

Even with such a refactoring, the need to split the "preprocessing"
(mainly "dedup") still remains if you want to silence this codepath,
so I think this is OK from pathspec/dir.c point of view.

But I do not agree with the first paragraph at all.  You'd be using
separate syntax like '*label', ':name', etc. for the purpose of
enumerating submodules, so instead of blindly passing argv[] to
pathspec code, I expected you to do a preprocessing of argv[]
upfront, sifting them into three bins (labels, names and paths), and
giving only the last ones to the pathspec machinery.

And if you did that, report_path_error() would never have to worry
about "ah, this thing does not exist in the working tree or in the
index but that is natural because it is a submodule label" at all,
no?
