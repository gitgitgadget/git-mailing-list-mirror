From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision
 <tree-ish> option
Date: Tue, 09 Oct 2012 14:48:31 -0700
Message-ID: <7va9vve2q8.fsf@alter.siamese.dyndns.org>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
 <7v8vbgi3yz.fsf@alter.siamese.dyndns.org>
 <7v4nm4i37u.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dw1iXJfgkmA2V-L11xCOOxO57U4Dh7=h7AzkFUqLc55=w@mail.gmail.com>
 <7vr4p7fqr2.fsf@alter.siamese.dyndns.org> <5074956E.3060909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:48:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLhfR-0005KV-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 23:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047Ab2JIVsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 17:48:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756954Ab2JIVse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 17:48:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 159C48911;
	Tue,  9 Oct 2012 17:48:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H3C4M7kUNAX69QBGRnFduJPhaks=; b=OfvNfy
	VjfdnAO27RAxnncLcHViyk2iyaG9WQ0qJLu+hWw26mU6YA65ZJ9TGlUSI6xpLyqK
	B4DA3BhlN1EZ3jvGvJcCkOTtgL8hq7GVbook4E7I1u/xdrxQOArWcuLBDK3hmtCY
	gWulELSIRHEHPxorizqtvenRn+M/jL5U9VGng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0glf2e5NNK1P06rAbzRFZPFwRcV0/Pd
	a0ahtvJpVRDq7U7edk7Mf6KK9J/av51XlBCakDCcqcBMN2He3ohBId5jWguqFu1x
	H/PonWhmLw2vmzRYDKyByKqdjL5QuJJt96MP+xOPH+bH7s6n/95P0kUmiM8JKFvJ
	rVxe0UbGi3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03B2E8909;
	Tue,  9 Oct 2012 17:48:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 394088906; Tue,  9 Oct 2012
 17:48:33 -0400 (EDT)
In-Reply-To: <5074956E.3060909@web.de> (Jens Lehmann's message of "Tue, 09
 Oct 2012 23:21:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1245D216-125B-11E2-90BE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207351>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 09.10.2012 20:24, schrieb Junio C Hamano:
> ...
>> I think the right approach to implement this "recurse foreach in the
>> superproject tree that is not checkout out to the working tree"
>> feature should be:
>> 
>>  - Advertise it so that it is crystal clear that the command run by
>>    "foreach" may have to run in a bare repository of submodule to
>>    look at submodule's commit bound to the historical tree of the
>>    superproject;
>
> I think we should even try to enforce that the user shouldn't use
> the work tree at all (although at the moment I can't come up with
> an idea how we could do that), as the work tree *will* be out of
> sync almost always when you need this option.

Very good point.

>>  - Locate submodule's $GIT_DIR in $GIT_DIR/modules/$sm_name of the
>>    superproject that corresponds to the submodule found in the
>>    historical tree in the superproject (or if it is the same
>>    repository as that is currently checked out, use $sm_path/.git),
>>    and error out when it is not available.
>
> Looking in $GIT_DIR/modules/$sm_name could make sense to tag even
> those submodules which aren't currently populated. But IIRC the
> tags in such repositories could not be pushed using current git
> even when you use the "--recurse-submodules" option because that
> only honors populated submodules. So for now it would suffice to
> only recurse into populated submodules.

There are million reasons why we shouldn't lightly think "recurse
submodules is a good idea", and I think this may be one of them.

But you can always go to $GIT_DIR/modules/$sm_name and push from
there, so I do not see it as a huge problem.

>> Jens, anything I missed?
>
> Nothing I can think of right now, the above is a pretty good summary.
> My gut feeling is that having "git submodule foreach --revision ..."
> recurse through submodules whose work trees are out of sync is pretty
> fragile and could easily lead to inconsistencies. So I tend to think
> adding a custom script to the release process Jay uses which does the
> tagging itself might be a better solution here. Opinions?

Well, I am not a good judge for that, as I've never been a big fan
of "submodule recurse" myself anyway.  But I think an addition that
works only when the user never uses commands that use the working
tree or the index is still a good thing to have.

We could export a magic environment while running foreach script and
make NEED_WORK_TREE check fail when it is set, or something, but we
need to be careful about performance implications.  "foreach" is not
something that is worth sacrificing the general performance over.
