From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 11:07:38 -0700
Message-ID: <xmqqd2ow5q1h.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<201308290932.18199.mfick@codeaurora.org>
	<521F6CF0.6040905@kitware.com>
	<xmqq7gf479jm.fsf@gitster.dls.corp.google.com>
	<521F8033.6070302@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6dG-0004Uj-BL
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab3H2SHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:07:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3H2SHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:07:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F21A03D198;
	Thu, 29 Aug 2013 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkuj2bYL/jP1TuMyF+a0mnVBtoQ=; b=jHFXIl
	aphMWgg5L4DnCLNXPMA++FFRvf0Z1XFZKEM6Tn4Q/lGQ3lIwvxghKR7Hkbou/3ys
	w6NqZxip5ILjD4SQn4UymIQFxIIx36is3b/uTMM3UCgwEZ+IN3NH19OGsZp2WKQu
	Mgv982G2Yg7zFvVdplYTTN1KRz35sT6qQYvss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRkjQb8chF+s31uEMOzN/AFV7TPIjDe1
	B2uM+P7iukU/f87Lx9or4gIDcw6wy5XYGDOzH7RfT0FQzRwLj+x3nMuUlD3e5E+E
	1UnrDJcANlInseS3BNzDl0kD5fj3shJjBYMUDBnJfLeiTNHh8cq4GbG1wj5S75K5
	t5wQufje6F4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6EA63D197;
	Thu, 29 Aug 2013 18:07:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A1843D195;
	Thu, 29 Aug 2013 18:07:40 +0000 (UTC)
In-Reply-To: <521F8033.6070302@kitware.com> (Brad King's message of "Thu, 29
	Aug 2013 13:09:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E4B65C06-10D5-11E3-8DDA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233296>

Brad King <brad.king@kitware.com> writes:

> On 08/29/2013 12:21 PM, Junio C Hamano wrote:
>> Brad King <brad.king@kitware.com> writes:
>>> needs to reject duplicate ref names from the stdin lines before
>>> trying to lock the ref twice to avoid this message.
>> 
>> How about trying not to feed duplicates?
>
> Sure, perhaps it is simplest to push the responsibility on the user
> to avoid duplicates.

I didn't mean to force the caller of new "update-ref --stdin"; the
new code you wrote for it is what feeds the input to update_refs()
function, and that is one place you can make sure you do not lock
yourself out.

Besides, if you get two updates to the same ref from --stdin, you
would need to verify these are identical (i.e. updating to the same
new object name from the same old object name; otherwise the requests
are conflicting and do not make sense), so the code to collect the
requests from stdin needs to match potential duplicates anyway.

One clean way to do so may be to put an update request (old and new
sha1) in a structure, and use a string_list to hold list of refs,
with the util field pointing at the update request data.

> The lock file may exist because:
> - another running git process already has the lock, or
> - this process already has the lock because it was asked to
>   update the same file multiple times simultaneously, or
> - a stale lock is left from a git process that crashed earlier.
> In the last case, make sure no other git process is running and
> remove the file manually to continue.

The second case is like left hand not knowing what right hand is
doing, no?  It should not happen if we code it right.

> --------------------------------------------------------------------
>
> IIUC the message cannot say anything about a 'ref' because it is
> used for other file type lock failures too.
>
> Comments?
> -Brad
