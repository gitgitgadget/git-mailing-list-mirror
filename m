From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/9] git-clean: refactor git-clean into two phases
Date: Wed, 15 May 2013 08:03:29 -0700
Message-ID: <7vbo8ce14u.fsf@alter.siamese.dyndns.org>
References: <cover.1368518327.git.worldhello.net@gmail.com>
	<7c551bf22bc45cfcdd62d1baf6300f3f86244312.1368518327.git.worldhello.net@gmail.com>
	<7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
	<CANYiYbF3AC=iHaOkj96yhBSj8caC2SdZDygrxV43+mzAd-wGJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 17:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcdF5-0002t8-Da
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854Ab3EOPDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:03:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab3EOPDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:03:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6BD51FC17;
	Wed, 15 May 2013 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4r8NpCbBYGM6tWXP3d1EhvV767c=; b=SeJaD9
	3jVNy/dnbWta6zcg5DD53b3nV8F1DWbORAXAAz/EDExLUpl34qT8U3R1t7oiXQlP
	xKSK2b15XnpTjvzmWd+9bLmnpQlIbUyhK8tRPjnJC3D+6tYv6z2URA/QLrqwq8J1
	iawhabxHy7aILC7UMJ8gz+9iginjrpQtBa31A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B6aFWP+i/3QyXdKwdRcFvVZzSB+5eAtO
	/PsfL0HXWJEreAqNssc7sn4dFltvI/ycnOeGOxuLcedSwFpaWcYLuH2OptyP3/Wz
	rnSBQqjnrKhfpPFQpVdIrEIta2rWpjWCL7aTYdqyWTmLDjs1b1IRyMHhM2R42In6
	IVci8oZXhLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9BAB1FC16;
	Wed, 15 May 2013 15:03:32 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D9121FC14;
	Wed, 15 May 2013 15:03:32 +0000 (UTC)
In-Reply-To: <CANYiYbF3AC=iHaOkj96yhBSj8caC2SdZDygrxV43+mzAd-wGJA@mail.gmail.com>
	(Jiang Xin's message of "Wed, 15 May 2013 08:40:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BBBB0C2-BD70-11E2-B908-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224411>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/5/15 Junio C Hamano <gitster@pobox.com>:
>>> @@ -242,11 +287,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>>                               continue; /* Yup, this one exists unmerged */
>>>               }
>>>
>>> -             /*
>>> -              * we might have removed this as part of earlier
>>> -              * recursive directory removal, so lstat() here could
>>> -              * fail with ENOENT.
>>> -              */
>>>               if (lstat(ent->name, &st))
>>>                       continue;
>>
>> I am guessing that the reason why you removed the comment is because
>> during this phase there is no way we "might have removed".  But if
>> that is the case, does it still make sense to run lstat() and ignore
>> errors from the call?
>>
>
> Run lstat() here is necessary, because we need to check whether
> ent->name points to a file or a directory. If ent points to a directory,
> only add to del_list when user provides '-x' option to git-clean.

Sorry, but that was not the question; we can see st is used
immediately below so somebody needs to fill it.

I was pointing out that the "lstat() is expected to fail with ENOENT
but it is not an error worth reporting" justification the original
code had to silently ignore an error, because you no longer remove
anything immediately in this part of the code.  Is "if () continue"
still valid thing to do here, not "if () die()"?
