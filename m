From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Sat, 18 Apr 2015 18:14:17 -0700
Message-ID: <xmqqfv7wor6e.fsf@gitster.dls.corp.google.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 03:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjdog-0005EQ-JC
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 03:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbbDSBOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 21:14:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342AbbDSBOT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2015 21:14:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38A2D49E47;
	Sat, 18 Apr 2015 21:14:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dtj1+ZgEqc2n
	+n4pzTl0s4QAP68=; b=jbgFHCcLjfSgeV401wO0d66VAeKOqltNzRFHeyRuSF0b
	8Q6heDFGYI12zbvbg1Q0gAadzixOEkqpOJ1EOb3tmetMeMKlPDH5jBZISTKmaUNC
	k6yOaBWflCLqF4TG3fzMKPmYyEoCsUvE9qR4AzFHHec43wT+TVVTe/2GE1xqOl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vySN8v
	Wmd8itU6LQoYecSDexVibYeuRL2ycA3XueS5/pIi88/iRSZywtRvUKFwV2m23HEr
	mVBWMa8b5I5KyY+qPJHTe0nzZnz1M/SF/C0YkpiC1qlO5bnKsvt6tMY2T2Tp5NCS
	1ZKstZBA6RN5swoO2GhZzN5OvwhZJyc2xaFEw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FECB49E46;
	Sat, 18 Apr 2015 21:14:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA46F49E45;
	Sat, 18 Apr 2015 21:14:18 -0400 (EDT)
In-Reply-To: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
	("Erik =?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sat, 18 Apr 2015 22:41:08
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6732F6D0-E631-11E4-BF98-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267431>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> Known Problems:
> * Unsure about the setup.c:read_gitfile refactor, feels a bit
>   messy?

The interface indeed feels somewhat messy.  I suspect that a better
interface might be more like setup_git_directory_gently() that is a
gentler version of setup_git_directory().  The function takes an
optional pointer to an int, and it behaves not-gently-at-all when
the optional argument is NULL.  The location the optional pointer
points at, when it is not NULL, can be used to return the error
state to the caller.  That function pair only uses the optional
argument to convey one bit of information (i.e. "are we in any git
repository or not?") back to the caller, but the interface could be
used to tell the caller a lot more if we wanted to.

If you model read_gitfile_gently() after that pattern, I would
expect that

 - The extra pattern would be "int *error";
 - The implementation of read_gitfile() would be

       #define read_gitfile(path) read_gitfile_gently((path), NULL)

   and the _gently() version will die when "error" parameter is set
   to NULL and finds any error.

 - The caller of the gentle variant can use the error code to
   determine what went wrong, not just the fact that it failed.  I
   do not think your caller does not have an immediate need to tell
   between "invalid gitfile format" and "No path in gitfile", but
   such an interface leaves that possibility open.

Thanks.
