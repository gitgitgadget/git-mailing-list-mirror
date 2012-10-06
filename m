From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Fri, 05 Oct 2012 22:36:16 -0700
Message-ID: <7vk3v4rwkv.fsf@alter.siamese.dyndns.org>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com>
 <7vy5jku549.fsf@alter.siamese.dyndns.org>
 <CACsJy8BWJg0sr-6iG4LwJjkSM46=CBgddDac4dDR2o3HZ8_25g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 07:36:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKN3t-0002W4-38
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 07:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab2JFFgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 01:36:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab2JFFgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 01:36:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 680BE4472;
	Sat,  6 Oct 2012 01:36:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bKFPAUDACJQK
	WA9vmO7Ct0+krxM=; b=QpMVtpGZOnRfXAquaCnuscvZYWRHaAb18US6AJ5PB+nW
	brTEMPNgiYsUhVY+eWmDlEqU08burYTQZG8EnVTkbK3qdoAcRgdQyoQSSyedFrV3
	Dvs8wxK8Frr9dOowMDa4+fOG4AZCQTYntv/oWcFygjypWrAaLW/N+ggyk5o9a8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m70/9+
	PJKXTa/L8ryCh6ajE/+Hns7nLhK4s1ACTnnMcysxE1UC7fqkNgNZ12MrK1BYdZih
	gKl/gQB4X6f7Y3J/HR/ywMFRcqrPXHgrPFm7mLB22LPHmofh8w1VQlbGYcexJdKE
	VXs6lM+fyj9q/DNcDg2Iho59FVd2Tez9YsrVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55CCD4471;
	Sat,  6 Oct 2012 01:36:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9FA04470; Sat,  6 Oct 2012
 01:36:17 -0400 (EDT)
In-Reply-To: <CACsJy8BWJg0sr-6iG4LwJjkSM46=CBgddDac4dDR2o3HZ8_25g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 6 Oct 2012 12:02:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C057D408-0F77-11E2-9FFC-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207130>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Oct 6, 2012 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> +Unlike `.gitignore`, negative patterns are not supported.
>>> +Patterns that match directories are also not supported.
>>
>> Is "are not supported" the right phrasing?
>>
>> I think it makes perfect sense not to forbid "!path attr1", because
>> it is unclear what it means (e.g. "path -attr1" vs "path !attr1").
>> So I would say "Negative patterns are forbidden as they do not make
>> any sense".
>
> OK
>
>> But for the latter, I think it makes a lot more sense to just accept
>> "path/ attr1" and doing nothing.  The user requests to set an
>> attribute to "path" that has to be a directory, and there is nothing
>> wrong in such a request in itself.  But nothing in git asks for
>> attributes for directories (because we do not track directories),
>> and such a request happens to be a no-op.
>
> Or the user might think "path/ attr1" sets attr1 for all files under
> "path/" because it does not make sense to attach attributes to a
> directory in git.

Hrm, isn't that reasoning flawed at least for two reasons?

 - One reasonable way to conceptually unify excludes and attributes
   is to consider "being ignored" as just one kind of attribute. If
   you imagine an ideal world where we did not have any .gitignore,
   an entry "path/" in .gitignore would be "path/ excluded", and an
   entry "!path/" in .gitignore would be "path/ -excluded".  Realize
   that on the exclude side, we are already assigning an "attribute"
   to a directory.

 - Setting attr1 to everything in path is spelled "path1/**/* attr1"
   if we are to adopt "/**/ is zero or more intermediate levels"
   enhancement.

   We may not have a need to assign a real attribute to a directory
   right now, because nothing in Git asks for an attribute for a
   directory. But that does not necessarily mean we would never need a
   way to give an attribute to a directory but not to its contents.

If one does not think it through, the "path/ excluded" example might
appear that there is no difference between setting exclude to the
path itself and setting it to path and everything underneath it, but
that comes largely from the nature of "exclude" attribute (think of
"exclude" attribute as "exclude itself and everything under it).

There is no reason to assume other attributes we may want to give to
a directory share the same "recursive" kind of semantics.
