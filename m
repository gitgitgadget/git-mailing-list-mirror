From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_write: omit system call when length is zero
Date: Thu, 25 Feb 2016 15:04:54 -0800
Message-ID: <xmqqk2lsmlwp.fsf@gitster.mtv.corp.google.com>
References: <1456439678-5433-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:05:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4xy-0005Ya-6M
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbcBYXE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:04:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751268AbcBYXE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:04:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7823347151;
	Thu, 25 Feb 2016 18:04:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ve0zmzgCarBIx8kpNlyAifF0gFg=; b=Qrj4S0
	2QegMoTj43GDwVf1UGTHrS5/6mDcDvKcb66hyqXN7Lcjd1mSwP6KuOnVYToZNfEw
	hxeJ7z108nq2VIaBu/uLku9jA8pQdSFUhe4Mk3gK/I82PwpHig1Am4CkMdgVoqBG
	TS3JlHrjpfSwQ5JUrJYfhDtmp/2+ceiYR7rnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hEvDm98qrNNIusSJpsFfnVYtAPfgjDgF
	VnF69gZYOOPhct8WmfN/L6IqWIZKuZMKRAIZRDtDvEqel/4dvoYU/OmgP1hHfDj5
	wiAST2RNpn8R4Wz+3+EGvLoB4hG/k23NnD0IX2PPqHUX/s7iDfWL36HpNhw2Coxw
	83dkjupRJgs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DBD147150;
	Thu, 25 Feb 2016 18:04:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D39E74714F;
	Thu, 25 Feb 2016 18:04:55 -0500 (EST)
In-Reply-To: <1456439678-5433-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 25 Feb 2016 14:34:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F8725D8-DC14-11E5-8F6E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287471>

Stefan Beller <sbeller@google.com> writes:

> In case the length of the buffer is zero, we do not need to call the
> fwrite system call as a performance improvement.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  This applies on top of v17 for origin/sb/submodule-parallel-update.
>  
>  In case there are other reasons for origin/sb/submodule-parallel-update
>  to need a reroll I'll squash it in. But as this is a pure performance
>  optimization in a case we are not running into with that series and that
>  series is clashing with Davids refs backend series, I figure we may not
>  want to have a reroll for this fix alone.

Yeah, I tend to agree that this change by itself is probably not
worth much.

While I agree with the idea of passing the output from children thru
with as little modification as possible, I think that goal does not
have to be incompatible with the idea you and Jonathan had to ensure
that the output is safe in the presence of incomplete last line.

I think the output made from pp_collect_finished() for "other
finished processes" is known to have the very last part from
finished child, so it would be easy to make sure by calling
strbuf_complete_line() that pp->children[i].err is terminated.

I haven't thought it through how the output from CP_WORKING process
in pp_output() should be kept track of, though.

It might be just a matter of adding a bit "incomplete_last_line" to
the parallel_process.children struct and maintain it every time
pp_output() writes something out (we cannot add an extra newline in
pp_output() because we don't know if the process will have further
output, but we can keep track of the fact that the last output did
not have the final newline).  In pp_collect_finished(), we can use
the bit and the contents of pp->children[i].err to decide if we need
to call strbuf_complete_line() if we did so.

Or something like that ;-)
