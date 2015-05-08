From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0005-signals.sh fails with ksh
Date: Fri, 08 May 2015 13:34:49 -0700
Message-ID: <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
References: <31108626.20150508231514@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: evgeny <illumsoft.org@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqoz3-0003mW-81
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbbEHUew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:34:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932219AbbEHUew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:34:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 940C1411CE;
	Fri,  8 May 2015 16:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HjetEllF8cjiTQwfwJicLSu+4sk=; b=aqTqBn
	MeOmM0U2nc5D1keo3I2dyfY0Le/hs9DqdfUYm5JV2A1ewixOv27QtNBBm+imsysA
	ykbYUdr6DmJRKi0PX+FqBnuspRTqS3WoYynflcAYF8ojvBusCZs4cy/xiSorigr2
	LUywm6/ZX7i3WW4IEVhwfzvDMNob4uqlaTJ5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YIamWVVUsr0fYfg6sVhb5v9hbQT1JAUd
	N/zmmnGEssaQAsa9XjFWPCWI0ebScxSo/l2G9ei1DNIM77VNDqPVIyUKWul0jZSg
	VVZkjE++DiNYUp5oZ6DKG1qhm5/Udaax3MWuNLrZRkps50PWBA7D/go5NGbx4Dc6
	ddvNMCiP37k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D6E6411CD;
	Fri,  8 May 2015 16:34:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08565411CC;
	Fri,  8 May 2015 16:34:50 -0400 (EDT)
In-Reply-To: <31108626.20150508231514@gmail.com> (evgeny's message of "Fri, 8
	May 2015 23:15:14 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD2742BE-F5C1-11E4-8ADA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268662>

evgeny <illumsoft.org@gmail.com> writes:

> expecting success: 
>         OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
>         test "$OUT" -eq 141
>
> t0005-signals.sh[499]: eval: syntax error at line 4: `(' unmatched
> Memory fault

Does this work if you did

	OUT=$( ( (large_git ; echo $? 1>&3) | : ) 3>&2 ) &&

instead?

> 'man ksh' reads:
>   (list)
>     Execute  list  in  a  separate environment.
>     Note, that if two adjacent open parentheses are needed for nesting,
>     a space must be inserted to avoid evaluation as an arithmetic command as
>     described above.

Hmm, I cannot see "as described above" in your message, but isn't
that talking about a common mistake of turning cmd1 in this pipeline

	x=$(cmd1 | cmd2)

into a series of two commands, e.g. (cmd1a && cmd1b) and saying

	x=$((cmd1a && cmd1b) | cmd2)

which does make "$((" interpreted as the beginning of arithmetic
expansion?

And the "OUT=$( ((large..." construct seems to be written in order
to avoid that exact issue (notice the SP after "$(").

Puzzled....
