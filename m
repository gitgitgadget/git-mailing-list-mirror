From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool --dir-diff: always use identical working tree file
Date: Tue, 28 May 2013 12:31:14 -0700
Message-ID: <7vtxlmzyt9.fsf@alter.siamese.dyndns.org>
References: <20130526154429.GK27005@serenity.lan>
	<1369668697-1016-1-git-send-email-nitoyon@gmail.com>
	<7vbo7v0yju.fsf@alter.siamese.dyndns.org>
	<20130528181525.GA17475@serenity.lan>
	<7v7gij0w6z.fsf@alter.siamese.dyndns.org>
	<20130528190829.GB17475@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenichi Saita <nitoyon@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 28 21:31:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhPcA-00015G-CP
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 21:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab3E1TbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 15:31:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468Ab3E1TbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 15:31:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 769ED2353C;
	Tue, 28 May 2013 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mQx78+AgyeHYU9nK8RHXkbACMvk=; b=Yhw5iq
	BjEVtSfUgIS8yjlkuOC9pCVXDpuiAFIODhcdsdKyhUWT35gpWDrsHlhiYy9gZ3sZ
	ezRqw5NYgJjDIfcj0pGyMkeVQJjCzJqpUgKGpeTY8HOblzAD1eybv6zLDMWSbGH9
	GwW0ReDVFBWforVpxdpE6o1gJTRYyHMElKtCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mA+Ww4s45PmE8PZWD1g4y9qrZtLJjIea
	QeMKFWD4sQ7nioYHO4RT+yv+1s3yTGoJMve3ut8HaEfr+YBxir5QYMkJx4mIfMC8
	k0+JuxoHJgdIAbCwVDM5E4jDw8+v4IfUj5OK6zR96hGgplNyr4Xt+BXtyL+K5YuO
	wXS3Blnw9Dk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 699742353B;
	Tue, 28 May 2013 19:31:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E03F52353A;
	Tue, 28 May 2013 19:31:15 +0000 (UTC)
In-Reply-To: <20130528190829.GB17475@serenity.lan> (John Keeping's message of
	"Tue, 28 May 2013 20:08:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29DFF744-C7CD-11E2-87F9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225682>

John Keeping <john@keeping.me.uk> writes:

>>  - When comparing two revisions, e.g. "--dir-diff HEAD^^ HEAD^",
>>    that checks out (via $rsha1 to "checkout -f" codepath) a blob
>>    that does not match what is in the working tree of HEAD to the
>>    temporary directory, we still allow modifications to the copy in
>>    the temporary directory, but what can the user do with these
>>    changes that are _not_ based on HEAD, short of checking out HEAD^
>>    and apply the difference first?
>> 
>> I still cannot shake this nagging feeling that giving a writable
>> temporary directory might have been a mistake in the first place.
>> Perhaps it may be a better design to make the ones that the user
>> shouldn't touch (or will lead to the above confusion) read-only,
>> while the ones that match the working tree read-write?
>
> My ideal scenario would be that we only allow users to edit files when
> they are comparing against the working tree, but that would require
> git-difftool to fully understand all git-diff options since it just
> passes through any it doesn't recognise.  I don't think there's an easy
> way to do that, which leaves us with this confusing situation.

Not necessarily.

Let's assume that changing files in "diff" tool is a sensible thing
to do, as long as we make sure such a change is not lost (which I
may not 100% agree with, but let's put it aside for now).

When you are viewing a file F in "--dir-diff HEAD^^ HEAD^", if there
is no change for F in between HEAD^ and HEAD and you notice a typo
that may or may not be related to the differences between HEAD^^ and
HEAD^, it would be tempting to fix that right there.  And as long as
F in the working tree matches that of HEAD^ and the modification you
make in the temporary directory gets copied back to the working tree,
your typofix will end up to be in the working tree.

Which I _think_ is what people, who want to change files in "diff"
tool, want to do.

Of course, your working tree may have been in the middle of doing
something entirely different and you may have to "add [-p]" to
separate such a typofix with other changes you were working on, but
that is a separate issue.

And for that to work, the only think you need is "does the blob we
show on the RHS temporary tree match what is in the working tree?"
check.  You do not need to know or care if you are comparing two old
revisions, etc.
