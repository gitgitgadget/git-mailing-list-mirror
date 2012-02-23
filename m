From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Thu, 23 Feb 2012 12:26:18 -0800
Message-ID: <7vlint2t5h.fsf@alter.siamese.dyndns.org>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
 <CABPQNSZVOjOKpqv4s1ZCEQRd_yT3us3mqC9aN-KK5PHqztYQQg@mail.gmail.com>
 <7vd3954ame.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 23 21:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0fFD-00025I-47
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab2BWU0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:26:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab2BWU0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 15:26:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA2356517;
	Thu, 23 Feb 2012 15:26:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JQfdgzKYboBuDbTH68wEIdfjEvk=; b=Xv4oQY
	w1tg/JKZo3saW/GYQg2yAcaNojrO0iD5f+XMM0GzORKKs9YCu8hXRnddREJbrfzE
	gfc8kGgQEeM/cqezqxnpTeeXxyJRMXZymN5rirrtvrl5evhrVM8fFudPuCbKAr8f
	XHXTyeyD+sFRB/6eDvBVO9vRPxFn/eFC1JUj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TijlnaDv8lQcOhqqnlH7pYGMTAfVLdx8
	bPyVbQB9PM52PdDksgsNl/93YPIbrJJSnb/ABCAzjIYQpe5s8VjZ5mZjloPbVCLC
	rXZ6V4dOWwkpVj1JWoR9cOHu1eshlXYq+pRGTJJkmCCFrkes+p7ESDL5Z6Qi9PBQ
	kvTHNiN/rUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0C2D6516;
	Thu, 23 Feb 2012 15:26:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F6F86515; Thu, 23 Feb 2012
 15:26:20 -0500 (EST)
In-Reply-To: <7vd3954ame.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 23 Feb 2012 11:23:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5653F5E-5E5C-11E1-9528-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191395>

Junio C Hamano <gitster@pobox.com> writes:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>> +       /* Use editor if stdin and stdout are the same and is a tty */
>>> +       return (!fstat(0, &st_stdin) &&
>>> +               !fstat(1, &st_stdout) &&
>>> +               isatty(0) &&
>>> +               st_stdin.st_dev == st_stdout.st_dev &&
>>> +               st_stdin.st_ino == st_stdout.st_ino &&
>>> +               st_stdin.st_mode == st_stdout.st_mode);
>>
>> I just stumbled over this code, and I got a bit worried; the
>> stat-implementation we use on Windows sets st_ino to 0, so
>> "st_stdin.st_ino == st_stdout.st_ino" will always evaluate to true.
>>
>> Perhaps we should add a check for isatty(1) here as well? ...
>> Or is there something I'm missing here?
>
> No, the intention was ...

s/No,/No, you are not missing anything./;

I'll queue it with this explanation:

    merge: do not trust fstat(2) too much when checking interactiveness
    
    The heuristic used by "git merge" to decide if it automatically gives an
    editor upon clean automerge is to see if the standard input and the
    standard output is the same device and is a tty, we are in an interactive
    session.  "The same device" test was done by comparing fstat(2) result on
    the two file descriptors (and they must match), and we asked isatty() only
    for the standard input (we insist that they are the same device and there
    is no point asking tty-ness of the standard output).
    
    The stat(2) emulation on Windows port however does not give a usable value
    in st_ino field, so even if the standard output is connected to something
    different from the standard input, "The same device" test may incorrectly
    return true. To accomodate it, add another isatty() check for the standard
    output stream as well.
    
    Reported-by: Erik Faye-Lund <kusmabite@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
