From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Thu, 29 Aug 2013 15:18:44 -0700
Message-ID: <xmqqvc2o16pn.fsf@gitster.dls.corp.google.com>
References: <201308300118.19166.vkrishn4@gmail.com>
	<20130829211034.GB4110@google.com>
	<201308300305.10440.vkrishn4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: vkrishn4@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 30 00:18:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFAYH-0002Ul-7U
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861Ab3H2WSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:18:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133Ab3H2WSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 18:18:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59C643DD82;
	Thu, 29 Aug 2013 22:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mObTNJe2x+d6AjgIuNrPf7DgylM=; b=MuOhfc
	pj0MxAt+Jr6fUyb/BURUk0mVC9WLFegin8H1zvKICB4oEYGcoc+OrMqcpFmmCPeN
	cFybdj0VmLod5wKA3eJrjDctVjNDJPSTUVCEeHstMkMLVJvGFNR/5rmNXaVxtJWN
	WPb9DruCln+NtH1rrMnRz6J9nNX+3fyNBwHZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uHm9FXMy72osinZ1YokaZa/6vag67PKq
	igQBPYkpj8jS1SupMUTLye2LfhtQxoNGLh1Oao8UIQxCJ9o/ldJKdCp4AfPYiHSO
	u0eMO/yBAMMGLetqNJlQBnKh7lbOV0BHiXV9odIG8O+KvDt6j+v98g3kEfnCnyGE
	pXkWq8jT/Tk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1A33DD81;
	Thu, 29 Aug 2013 22:18:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 852063DD7C;
	Thu, 29 Aug 2013 22:18:46 +0000 (UTC)
In-Reply-To: <201308300305.10440.vkrishn4@gmail.com> (V. Krishn's message of
	"Fri, 30 Aug 2013 03:05:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8EE57C8-10F8-11E3-9C71-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233375>

"V.Krishn" <vkrishn4@gmail.com> writes:

> On Friday, August 30, 2013 02:40:34 AM you wrote:
>> V.Krishn wrote:
>> > Quite sometimes when cloning a large repo stalls, hitting Ctrl+c cleans
>> > what been downloaded, and process needs re-start.
>> > 
>> > Is there a way to recover or continue from already downloaded files
>> > during cloning ?
>> 
>> No, sadly.  The pack sent for a clone is generated dynamically, so
>> there's no easy way to support the equivalent of an HTTP Range request
>> to resume.  Someone might implement an appropriate protocol extension
>> to tackle this (e.g., peff's seed-with-clone.bundle hack) some day,
>> but for now it doesn't exist.
>
> This is what I tried but then realized something more is needed:
>
> During stalled clone avoid  Ctrl+c. 
> 1. Copy the content .i.e .git folder some other place.
> 2. cd <new dir>
> 3. git config fetch.unpackLimit 999999
> 4. git config transfer.unpackLimit 999999

These two steps will not help, as negotiation between the sender and
the receiver is based on the commits that are known to be complete,
and an earlier failed "fetch" will not (and should not) update refs
on the receiver's side.

>> What you *can* do today is create a bundle from the large repo
>> somewhere with a reliable connection and then grab that using a
>> resumable transport such as HTTP.

Yes.

Another possibility is, if the project being cloned has a tag (or a
branch) that points at a commit back when it was smaller, do this

	git init x &&
        cd x &&
        git fetch $that_repository $that_tag:refs/tags/back_then_i_was_small

to prime the object store of a temporary repository 'x' with a
hopefully smaller transfer, and then use it as a "--reference"
repository to the real clone.
