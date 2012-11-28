From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Add option to transpose parents of merge commit
Date: Wed, 28 Nov 2012 08:52:52 -0800
Message-ID: <7vr4ndhdp7.fsf@alter.siamese.dyndns.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
 <1354057217-65886-4-git-send-email-draenog@pld-linux.org>
 <50B5B599.3020105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Aaron Schrab <aaron@schrab.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdkt3-0001gs-RY
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 17:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab2K1QxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 11:53:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198Ab2K1Qwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 11:52:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7A049C69;
	Wed, 28 Nov 2012 11:52:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOtHVDWN19ok8bIJ0Pz6ufp3+ms=; b=iNuGyT
	gQ1qqtv+sLcCLgXUauIkgPUp+NUC+TgGXUt0yRn1r7reZeW5cmCpWlL8L1wNR6/F
	vWh/mS31h0l3N1Tg0LqpY1Fz1CWWoor2gGKeGL2oUTF12db8p7rYDir3T3c9ORX9
	N9wesR7dW4gPmm1c4E+5Ts/+pYDaAEou5gXhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1D6cwNqJLrvc2CUhfKyOWVvkSA0GlRD
	35k8gmRS9xh52DGhozuZrhsfUK04OCdiQxtR477CkvoI+zXPt+e9JVK7+gCrXUDF
	R0yIqVsDkPpfGhhVxYg/smyN9zNVm50BMbEBdwxViCafyb8LiTXOyUBibEOF/vNx
	ven9tz0tmOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 944219C68;
	Wed, 28 Nov 2012 11:52:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECFF49C66; Wed, 28 Nov 2012
 11:52:53 -0500 (EST)
In-Reply-To: <50B5B599.3020105@viscovery.net> (Johannes Sixt's message of
 "Wed, 28 Nov 2012 07:56:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D80835A-397C-11E2-AA6A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210739>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 11/28/2012 0:00, schrieb Kacper Kornet:
>> When the changes are pushed upstream, and in the meantime someone else
>> updated upstream branch git advises to use git pull. This results in
>> history:
>> 
>>      ---A---B---C--
>>          \     /
>>           D---E
>
> The commit message will say:
>
>   Merge branch 'master' of /that/remote
>
>   * 'master' of /that/remote:
>     E
>     D
>
>> where B is the local commit. D, E are commits pushed by someone else
>> when the developer was working on B. However sometimes the following
>> history is preferable:
>> 
>>     ---A---D---C'--
>>         \     /
>>          '-B-'
>
> Better:
>
>      ---A--D--E--C'
>          \      /
>           `----B

Yup, that topology is what Kacper's workflow wants.

Stepping back a bit, however, I am not sure if that is really true.
The goal of this topic seems to be to keep one integration branch
and always merge *into* that integration branch, never *from* it,
but for what purpose?  Making the "log --first-parent" express the
integration branch as a linear series of progress?  If so, I suspect
a project with such a policy would dictate that D and E also be on a
side branch, i.e. the history would look more like this:

      D---E
     /     \
  --A-------X---C---
     \         /
      `-------B

with X being a --no-ff merge of the topic that consists of these two
commits.

> In this case, the commit message should say... what? Certainly not the
> same thing. But I do not see that you changed anything in this regard.

True.  If the goal is to emulate a merge of B from a side branch
into _the_ integration branch, the summary should also emulate the
message that would be given when the remote pulled from your current
branch.
