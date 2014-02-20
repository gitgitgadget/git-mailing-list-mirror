From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/25] Convert git_snpath() to strbuf_git_path()
Date: Wed, 19 Feb 2014 19:41:52 -0800
Message-ID: <xmqqa9dm78n3.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-3-git-send-email-pclouds@gmail.com>
	<xmqqeh2y7jff.fsf@gitster.dls.corp.google.com>
	<CACsJy8BJ=OKzGDFwWQF_k_Gp9XeNwf7pe7c6_ebduJXN=xeOxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 04:42:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGKWR-0003Na-65
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 04:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbaBTDl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 22:41:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbaBTDl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 22:41:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 381006EF35;
	Wed, 19 Feb 2014 22:41:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VCMdxwF/4IT8ypMAmKL0UnD6l/U=; b=txdK55
	J+K+p3MZHPvX9h0wrCDmnzl5otYV9pPYQQb8eTJ1VGfFXoOhIrbMybhYJN3tS0KW
	OOtEh9a1e/TN2czH/zZWtXVGVy36vK+kmPKZ6EXt6wbktdSB+2H/OXGpZWZdC7K+
	oH/e3nIMT9vFPuwRlyiRqllDdm7teRZaac90s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ueOerKInwPOHbKpGaNdQe+IKO0+EgvWc
	w3BljU2Hx1lgLzUdbwg7G6ryvQZWJEOGfxrDyh6+NHKiNFTmP0j9+uSMVkD000Fs
	/7bugXXhQl1PwkQYHlAdj0Ne7MfEcq8CnfCYU98BUf47NyuZ8JHRqbY77SKC3Qr+
	zN4fVGvdJXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3786EF33;
	Wed, 19 Feb 2014 22:41:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C5F96EF28;
	Wed, 19 Feb 2014 22:41:54 -0500 (EST)
In-Reply-To: <CACsJy8BJ=OKzGDFwWQF_k_Gp9XeNwf7pe7c6_ebduJXN=xeOxw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 20 Feb 2014 06:54:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F0D1757C-99E0-11E3-A4AF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242422>

Duy Nguyen <pclouds@gmail.com> writes:

>>> -             }
>>> +             if (old->path && old->name &&
>>> +                 !file_exists(git_path("%s", old->path)) &&
>>> +                  file_exists(git_path("logs/%s", old->path)))
>>> +                     remove_path(git_path("logs/%s", old->path));
>>
>> Hmph.  Is this conversion safe?
>>
>> This adds three uses of the round-robin path buffer; if a caller of
>> this function used two or more path buffers obtained from
>> get_pathname() and expected their contents to remain stable across
>> the call to this, it will silently break.
>
> three round-robin buffers but not all required at the same time, once
> the first file_exists() returns the first round-robin buffer could be
> free, and remove_path() calls git_path again, not reusing the result
> from the second file_exists, so the second buffer is free to go too.

I know these three callers to git_path() will not step on each
other's toes.  But that is not the question I asked.
