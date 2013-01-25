From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Fri, 25 Jan 2013 11:00:39 -0800
Message-ID: <7vpq0t3x60.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com>
 <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyoWO-0002HP-MC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 20:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab3AYTAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 14:00:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab3AYTAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 14:00:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26679BDE7;
	Fri, 25 Jan 2013 14:00:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8RBkYjqX9WjqxsQ68tiwxE26xUs=; b=fmzt5b
	agM8F29bROcThz2gCEF7e7BRKMtG5ytaRO1ZDOB4Lj2S+6TEfIq/G+kAVsNpNXTJ
	2Vo3AuCYhD/ZGeygR409b6d3FFGdbirUoXozqV8SOcbl6dL5IiLnRugLtX9a1WvI
	yY3NrgfN/vE8jxeay7SwfEBZZ98vNVG8S6sPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rJefh/SCr1YZje/4wXeq5QoYAxH3VUdF
	1nUTaFZAjDZRWUM/95UMVNzLUwMEa58lSDl/o+XwBSuguG4ULsx6sPvVV3H3COWL
	TqQ6jwA4+vRujoXlt9+XzG0QqKm92kkAXCgUAVYNri2+PxTdZ3xK9xojNHdlCoFw
	+F17ALuxNFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1932CBDE6;
	Fri, 25 Jan 2013 14:00:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7036DBDDF; Fri, 25 Jan 2013
 14:00:41 -0500 (EST)
In-Reply-To: <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 25 Jan 2013 09:00:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83A3E54A-6721-11E2-875A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214568>

Duy Nguyen <pclouds@gmail.com> writes:

> .... Even
> when cache-tree is not involved, I do not want the index to point to
> an non-existing SHA-1 ("git diff --cached" may fail next time, for
> example).

I think we have tests that explicitly add SHA-1 that names an object
that does not exist to the index and check failures; you may have to
think what to do with them.

>> This is a tangent, but in addition, you may want to add an even
>> narrower variant that checks the same but ignoring _all_ alternate
>> object databases, "external" or not:
>>
>>         int has_sha1_file_local(const unsigned char *sha1);
>>
>> That may be useful if we want to later make the alternate safer to
>> use; instead of letting the codepath to create an object ask
>> has_sha1_file() to see if it already exists and refrain from writing
>> a new copy, we switch to ask has_sha1_file_locally() and even if an
>> alternate object database we borrow from has it, we keep our own
>> copy in our repository.

This is not a tangent, but if you want to go this "forbid making our
repository depend on objects we do not have but we know about after
we peek submodule odb" route [*1*], write_sha1_file() needs to be
told about has_sha1_file_proper().  We may "git add" a new blob in
the superproject, the blob may not yet exist in *our* repository,
but may happen to already exist in the submodue odb.  In such a
case, write_sha1_file() has to write that blob in our repository,
without the existing has_sha1_file() check bypassing it.  Otherwise
our attempt to create a tree that contains that blob will fail,
saying that the blob only seems to exist to us via submodule odb but
not in our repository.


[Footnote]

*1* which I do not necessarily agree with---I am in favor of getting
rid of add_submodule_odb() to fix these issues at the root cause of
them.
