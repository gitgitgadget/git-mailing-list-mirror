From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: request-pull with signed tag lacks tags/ in master
Date: Thu, 15 May 2014 12:13:18 -0700
Message-ID: <xmqqr43uetyp.fsf@gitster.dls.corp.google.com>
References: <20140515163901.GA1403@redhat.com>
	<xmqqzjiiev1a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:13:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl15u-0006Rz-4q
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbaEOTN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:13:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52132 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbaEOTNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:13:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F00DC16872;
	Thu, 15 May 2014 15:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxASwK2Q33IQb6/1IlgwM98TfeU=; b=aHm1ZN
	2AkOZNIvzS0mKrkV5tYOAWbBMwcuDq4aO7W9hpv9b2+vy8d4XAKLfIzgkCrKVmSE
	vMLh6+dBt4RjJokX2Ykd8CzilMSoCJwx7sNpuYPphzIAX7D4Y2j/qCWed+RbKqDf
	iUdrSqiH9uP7XtRouDvQz1slEHeaHQaOCkQTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZBuWuAH0cOUWy/u2NmCLxRizo//wT+B
	htOiP69tWbgHibSjYiBMyNrADWZsn5HP3cD/1EADQR8dyqTVNSPFaJ44Si4rfc4D
	3Pdce3V1JqGVJt5twZA+AuLsz2/yWRdYPJ083CLg3ttZxx39w1h+E/ojwNj9JSom
	AqmI3s3CnB0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5DD616871;
	Thu, 15 May 2014 15:13:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED1A91686B;
	Thu, 15 May 2014 15:13:19 -0400 (EDT)
In-Reply-To: <xmqqzjiiev1a.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 15 May 2014 11:50:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9F761AE-DC64-11E3-9656-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249186>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> looks like pull requests with signed git got broken in git master:
>>
>> [mst@robin qemu]$ /usr/bin/git --version
>> git version 1.8.3.1
>> [mst@robin qemu]$ git --version
>> git version 2.0.0.rc1.18.gac53fc6.dirty
>> [mst@robin qemu]$ 
>> [mst@robin qemu]$ /usr/bin/git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>>
>> [mst@robin qemu]$ git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream
>>
>> this for_upstream syntax is a problem because it does not work
>> for older git clients who might get this request.
>>
>> Didn't bisect yet - anyone knows what broke this?
>
> Linus ;-)  The series that ends with ec44507, I think.

My reading of the earlier parts of the series is that Linus wanted
us never dwim "for-upstream" to "tags/for-upstream" or any other ref
that happens to point at the same commit as for-upstream you have.
The changes done for that purpose covered various cases a bit too
widely, and "request-pull ... tags/for_upstream" were incorrectly
stripped to a request to pull "for_upstream", which was fixed by
5aae66bd (request-pull: resurrect "pretty refname" feature,
2014-02-25).

But that fix does not resurrect the dwimming forbid by the earlier
parts of the series to turn "for_upstream" into "tags/for_upstream".

What would you get if you do this?

    $ git request-pull origin/master \
      git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git \
      tags/for_upstream | grep git.kernel.org
