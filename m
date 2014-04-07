From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: do not trust stat info if lstat() fails
Date: Mon, 07 Apr 2014 10:13:31 -0700
Message-ID: <xmqqzjjxm5ac.fsf@gitster.dls.corp.google.com>
References: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
	<1396012689-22480-1-git-send-email-pclouds@gmail.com>
	<xmqq38hvvbr7.fsf@gitster.dls.corp.google.com>
	<CACsJy8DBixHTeqitcAcQRAqY3b4prkwQGgJGuw7hbT7BQAZt9w@mail.gmail.com>
	<xmqqvbuqqstn.fsf@gitster.dls.corp.google.com>
	<CACsJy8CTv5jZKjqq6fAJeVj-sqJHAF761V6TofVWs-V5GPnbcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 19:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXD76-0006Au-FK
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 19:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbaDGRNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 13:13:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbaDGRNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 13:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE537AE28;
	Mon,  7 Apr 2014 13:13:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=szP+vhoKR30knjTBAxxksi+gA1o=; b=P0t04P
	WKxjDrP8CTkG+vHMep8NWq694yGJtcMFkcXR6DULyO9PH90hELH/KQhuQYryCCQc
	pOW7iwIRcqdMkjB+bcMGlqOKptknK6DxIH3xdfEMSUTTV8lBwyI93iEU3sr9PIIy
	hVpO6zPdlsXHLSEBayBIVJfNblW+IwaK1iiD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KvQHmYN4p65h+kESNG20oN9ByZOuGOTo
	p/zkF2RD19jqs8sOfAevfKNqnIU4LkaDqyNWXdz9miTeMQXVJtFSDLqYTlPU3Hze
	OYREpH1ab5F91wTFdKpgu1cIQMCBgzxeYarjbezXG1G722JyxwrKV9kl3Zv3PzpK
	LjL8f3MD+RQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48FFA7AE26;
	Mon,  7 Apr 2014 13:13:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 305027AE24;
	Mon,  7 Apr 2014 13:13:33 -0400 (EDT)
In-Reply-To: <CACsJy8CTv5jZKjqq6fAJeVj-sqJHAF761V6TofVWs-V5GPnbcA@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 5 Apr 2014 15:03:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F29E4E82-BE77-11E3-A6AB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245867>

Duy Nguyen <pclouds@gmail.com> writes:

>>> Or even better to show an error message when the error code is
>>> unexpected? The unkown tag '!' says "there are problems" but if it
>>> shows up sort of permanently, '!' won't help much, I think.
>>
>> I am OK with that approach, but then one question remains: should we
>> say it is deleted, modified, both, or neither?
>
> The question is moot if the user does not ignore stderr because they
> should just ignore those error-reported entries. If they do
> 2>/dev/null, I think we should err on the safe side and say modified.
> We only say deleted if lstat() returns ENOENT or ENOTDIR like in your
> patch.

Doesn't the same reasoning behind "when we do not know for sure that
a path is not modified, it would be safe if we said the path may be
modified" also tell us that it is safer to say a path may be lost if
we cannot tell?

One likely case where we cannot tell if it is modified would be when
we cannot read the path (perhaps the parent directory accidentally
lost its x-bit).  Saying "it may be modified" would be one way to
have the user take notice, for an interactive user.  A script that
runs ls-files may be using the paths to drive "git add", "tar cf -",
etc. and emitting such an unreadable path is one way to make these
downstream commands signal that something fishy is going on by
erroring out.

So, I am not sure if we should be silent on an unexpected error when
we are asked to report deletes when we would be vocal when we are
asked to report modifications.
