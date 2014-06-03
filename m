From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: optionally deny case-clone refs
Date: Tue, 03 Jun 2014 15:13:31 -0700
Message-ID: <xmqq61khwsj8.fsf@gitster.dls.corp.google.com>
References: <1401822896-816-1-git-send-email-dturner@twitter.com>
	<xmqqioohwud5.fsf@gitster.dls.corp.google.com>
	<1401832959.18134.120.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrwxk-00035I-OY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbaFCWNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:13:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57642 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965147AbaFCWNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:13:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ADED01DCBF;
	Tue,  3 Jun 2014 18:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WgYxLBv7Pci6ESsNKdj9ocRnm40=; b=tFcsXM
	+Mpt9kZd7MzJsqOpyIoQ7f3S5+PGUbsSScRDxPlmyge0z0tw3ejmbH6TBhaYqZOL
	ZDXt92MfqeyYB6mFzg8l/C+mS9nK7KHuOLi65BqE+34DEMkNjJsqUTZt0f7diBRm
	BVWgKecmwcp3TJD27Ox5c6XIO9uOY0GeGZlIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYoGfr4Qs662MVQO58ej+CzYV0QNyO/w
	Iqc5Jwy2Z2JH1Al0OKgsQewMBMtC72ejU5P3EbSx1uPSRQvTAG7stFOameQtg7CT
	SXmVWBiRDpIhlvyrEBZkLbFNBF+vNCudUVh36jPvw3ociDCSNUKeqgG95OzRVX0k
	CcpmiYu1q6Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2FE41DCBE;
	Tue,  3 Jun 2014 18:13:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 00EC61DCBA;
	Tue,  3 Jun 2014 18:13:32 -0400 (EDT)
In-Reply-To: <1401832959.18134.120.camel@stross> (David Turner's message of
	"Tue, 03 Jun 2014 18:02:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CE27B18-EB6C-11E3-9629-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250693>

David Turner <dturner@twopensource.com> writes:

> I would be happy to add "case-clone" to the glossary -- would that be OK
> with you?  I do not immediately think of the better term.

Somehow "case-clone" sounds strange, though X-<.

>> (Mental note to the reviewer himself) This returns true iff there is
>> an existing ref whose name is only different in case, and cause
>> for-each-ref to return early with true.  In a sane case of not
>> receiving problematic refs, this will have to iterate over all the
>> existing refnames.  Wonder if there are better ways to optimize this
>> in a repository with hundreds or thousands of refs, which is not all
>> that uncommon.
>
> My expectation is that on average a push will involve a small number of
> refs -- usually exactly one.

It does not matter that _you_ push only one, because the number of
existing refs at the receiving end is what determines how many times
the for-each-ref loop spins, no?

> Yes, but it's harder to test on case-insensitive filesystems because we
> cannot have coexisting local case-clone branches.

You do not have to (and you should not) do "git checkout -b" to
create various local branches in the first place.  For example:

	git send-pack ./victim HEAD^1:refs/heads/caseclone &&
	test_must_fail git send-pack ./victim HEAD:refs/heads/CaseClone

would let you push the parent of the current tip to caseclone and
then attempt to push the current tip to CaseClone.  If the receiving
end could incorrectly fast-forwards caseclone, you found a bug ;-)
