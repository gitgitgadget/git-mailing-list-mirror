From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] tree-walk: micro-optimization in
 tree_entry_interesting
Date: Tue, 30 Aug 2011 13:40:26 -0700
Message-ID: <7v62le1vlx.fsf@alter.siamese.dyndns.org>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
 <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
 <7vaag7dv0z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=yVrS9MsBF1YR9D-QWej-n1uDQyQ@mail.gmail.com>
 <CAEik5nOKrpFycZYVnSu4_5LYWxn0JS_hVXyiQH-80Bu-C4k8VQ@mail.gmail.com>
 <CAEik5nNaDkAa2+63g1z3c1JUB8sLuTLfYP3jLKZJg2=yKqyzDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 22:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyV6o-00012a-W6
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 22:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab1H3Uk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 16:40:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568Ab1H3Uk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 16:40:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 886FC4437;
	Tue, 30 Aug 2011 16:40:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f8frKSi+nQgkk8UfPjiE4RFNJZE=; b=AouP0n
	HUU20nZEfvsPCjfDXD8e97NLlGjWdVL0zZbXKa3lO2TSnWNiW4LFe96lf0EfmZ/J
	afHf8wcXXIeStJFcXu+BAHlaLsbC0xEyvlG+AWpFVKEXmC4PNQ1z9nP9YjG8iXxp
	ZVn892XjVI13C3jrjQUv6LXFYKWNuA5jQdbFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UOWFlOOveUeDA0nEFMugY+KfiDKx/3mf
	fVjdvoTNvvNQrIqPVoN/ew6OSVExmMzBANtz7oBMVyqDscjajHmaxDjHHUoUg4K3
	UK8zHqgtbzGNMmCzIe7sj5MJ0e1R7fatIRewK1YfcOqcvl8OCouWH2HOu9uX84jL
	DXbqiVoDq50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 803364436;
	Tue, 30 Aug 2011 16:40:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 071D04435; Tue, 30 Aug 2011
 16:40:27 -0400 (EDT)
In-Reply-To: <CAEik5nNaDkAa2+63g1z3c1JUB8sLuTLfYP3jLKZJg2=yKqyzDg@mail.gmail.com> (Dan
 McGee's message of "Tue, 30 Aug 2011 14:51:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B96E332-D348-11E0-8435-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180442>

Dan McGee <dpmcgee@gmail.com> writes:

>> dmcgee@galway ~/projects/linux-2.6 (master)
>> $ time ../git/git-log -- zzzzz_not_exist > /dev/null
>>
>> real    0m0.945s
>> user    0m0.857s
>> sys     0m0.083s
>>
>>> There is nothing wrong in the patch per-se, but I really wish we didn't
>>> have to do this; it feels like the compiler should be helping us in this
>>> case.
>
> If I resurrect this with an updated commit message reflecting concerns
> raised, can it be merged? Given that it is a noticeable performance
> boost on real-life repositories and I can show it has little (<1%) to
> no impact on most repos, it is a definite win.

I do not see anything wrong in this particular patch per-se, but I really
wish we didn't have to do this.

Please include a few lines of benchmarking result in the updated commit
log message as well if you are rerolling this patch, perhaps like I did
in:

  http://thread.gmane.org/gmane.comp.version-control.git/179926/focus=180361

i.e., before and after comparison.

Thanks.
