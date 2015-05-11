From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] Fix atomicity and avoid fd exhaustion in ref transactions
Date: Sun, 10 May 2015 21:30:47 -0700
Message-ID: <xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 06:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrfMl-0007RG-In
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 06:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbbEKEav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 00:30:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbbEKEau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 00:30:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45317517BD;
	Mon, 11 May 2015 00:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=exGBRjb4H1cVy33ENZOvymy1/ls=; b=SFwaiA
	iKrw4ToKI7CbioW7vObFADk6f7L0v/2gZbaZbms4Wt1jxbMYnE1IUsF/+1ERicfM
	y5gvdx4XZnQiYRP7Dfj+EPKBHVA7S6/PaDmu0JkxUtIvv2j/ed90I5cje9Nstoia
	U7+GhxSS3lsleM7betb7Wyc3ivEuI9elsoRp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iuSZVY1HRFRMYSaajvaESrz4d5bRKRmN
	vbyCNIBycKUNf/RdtBnCIWv8UDSFL4IXnScDb+vHu+LvRRncvpz/B4WFXaE7GnrG
	mfbFHEu1MkGLk0KXe6eFdOWBVAhXcM2ye1zTdQQPGroNt8jpBk2HtGrfLwKrWGyT
	POBLCpQgVR4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B596517BC;
	Mon, 11 May 2015 00:30:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5CD5517BB;
	Mon, 11 May 2015 00:30:48 -0400 (EDT)
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 10 May 2015 04:45:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FB39DB0-F796-11E4-A537-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268754>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The following other branches, also from my GitHub repo, might be
> useful:
>
> * 'write-refs-sooner-2.3' -- suggested merge of the change to 'maint'.
>
> * 'write-refs-sooner-master' -- suggested merge of the change to
>   'master'.
>
> * 'write-refs-sooner-rebased-2.3' and
>   'write-refs-sooner-rebased-master' -- rebases of 'write-refs-sooner'
>   onto 'maint' and 'master' respectively, in case anybody is
>   interested to see how the individual patches would look if
>   implemented natively on these branches.

Thanks, that indeed is very helpful and instructive.

A mechanical merge of sooner-2.2 to maint trivially gave sooner-2.3,
so I am happy with that one.

Even though I manually resolved it and the resulting tree pretty
much matched with your suggested merge, I am hesitant to record the
change of sooner-2.3 as a single large merge to master.  I am
tempted to record this as somewhat a wicked merge, e.g.

 - apply posted patches on maint-2.2, which is your sooner-2.2;

 - branch sooner-2.3 from maint, merge sooner-2.2;

 - branch sooner-master from v2.4.0, apply the patches in your
   sooner-rebased-master on top, and then merge sooner-2.3, possibly
   with "-s ours"

And then sooner-master would record both "if built naturally on 2.4"
progression, which would explain what was done much better than a
huge merge of sooner-2.3 into 'master', and "what is to be done on
older codebase".

I dunno.

Anyway, these patches looked good both on 2.2 and on 2.4.  Thanks.
