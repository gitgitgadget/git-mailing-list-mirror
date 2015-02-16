From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Mon, 16 Feb 2015 11:06:06 -0800
Message-ID: <xmqqsie565i9.fsf@gitster.dls.corp.google.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 16 20:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNR03-0001U3-96
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 20:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbbBPTGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 14:06:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753336AbbBPTGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 14:06:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B29DC367BD;
	Mon, 16 Feb 2015 14:06:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WtQTNZBL7ZzTH89GPsqTG4lU2gA=; b=vUvSBM
	PFUcYCb4Pp+mAcenCCZdhhepwPXp3ls0SvmmVzV3DZbu4qvQpL2QNHWmGVpyO6VT
	S9lEK1a1YscqqbM5l9RKSGUKzy1VAdJzaP1vVQSjUzGuyXWj/YCcU3baV68AFP7l
	xD2hZABRpZpz1YKlCg73zuMx7j2qqexkV+TCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ltEwjQ1ZnlYpglOorTpSdagnDsX56N3q
	e1anSu7YnXJw0/s75MmuLh93TJ4BLoDfGn6GsLU5ncjm5BM8yI1aE3o5Y5AyXO5P
	CpHFY5s313B6mVD6FWfpID80s8PHsHMSUaU+pBBbiSNmb9efiDknXQTZtnql71v3
	VyxOFeE37t8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A906D367BB;
	Mon, 16 Feb 2015 14:06:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16E5B367A7;
	Mon, 16 Feb 2015 14:06:08 -0500 (EST)
In-Reply-To: <vpqtwyl90mx.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	16 Feb 2015 19:23:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DCF8A85E-B60E-11E4-A317-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263913>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The issue is that having object and pack files read-only on the
> filesystem is a safety feature to prevent accidental modifications (even
> though it's actually not that effective, since brute-force "sed -i" or
> "perl -i" still accept to modify read-only files).

I did not see it as a "safety feature", and instead saw it as a
reminder to me that I am not supposed to write into them when I
check them with "ls -l".

> So, I'd be a bit reluctant to remove this safety feature for all users
> if it's only for the benefit of a minority of users. Not that I think
> the problem shouldn't be fixed, but I'd rather investigate alternate
> solutions before using this mode = 0644.

I fully agree with you that this should not be unconditional.
However, I am not sure if there is an effective workaround to a
filesystem that pays attention to the mode bits of the file when
doing an operation on the directory the file is sitting within.  It
may be OK to introduce a new configuration variable, perhaps call it
core.brokenFileSystemNeedsWritableFile or something, and probe and
enable it inside init_db().

But I suspect that the single "mode = 0444" under discussion may not
cover all places we create files, as the assumption that the we get
a sane semantics from the filesystem permeates throughout the code.

What other glitches does AFP have?  Does it share Windows' "you
cannot rename a file you have an open file descriptor on?"  Anything
else?
