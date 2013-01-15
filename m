From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep performance regression
Date: Mon, 14 Jan 2013 18:48:11 -0800
Message-ID: <7v622z6u1g.fsf@alter.siamese.dyndns.org>
References: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 03:48:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuwZr-0003t1-OH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 03:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab3AOCsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 21:48:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756137Ab3AOCsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 21:48:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B18A124;
	Mon, 14 Jan 2013 21:48:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/dSXnRENO8h1
	ml4fvFUZe4HRIQY=; b=FUNoyhMaG2uPmA5tzFJ7+FtDDIQDdX4ttHXObOkas2/6
	CVNEi0+Rc8Ux12W+vCjtu27nGGhXx7imrmyo48Hreo4nRitZsiGOYLq1VYbZPvv1
	aDqCdH/5tfCxkKC0xms31TidvGlVdFIda4HXJHjrwoZw1qEkfQS0111o6SYIX1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iSWwpq
	FCUt6lAIAzzHNWAj0OlA5eMZAZI1xQvKrQr7UEf0qTvBxZ83nY1GnWN4dPhwr+qV
	2LzATyuSnSX85sxMCJPeX4eF44Qa2xUBpVyr4XHM/yfCDO+G2P5qiBxRVF5cUCfS
	YDSkR/g7/KA2L/fLNdzQjYf33O4zVSsIO7OuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4114A123;
	Mon, 14 Jan 2013 21:48:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 292B1A11E; Mon, 14 Jan 2013
 21:48:13 -0500 (EST)
In-Reply-To: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk> (Ross
 Lagerwall's message of "Mon, 14 Jan 2013 22:38:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0137BF5C-5EBE-11E2-9CB1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213569>

Ross Lagerwall <rosslagerwall@gmail.com> writes:

> I have noticed a performance regression in git grep between v1.8.1 an=
d
> v1.8.1.1:
>
> On the kernel tree:
> For git 1.8.1:
> $ time git grep foodsgsg
>
> real   0m0.158s
> user   0m0.290s
> sys    0m0.207s
>
> For git 1.8.1.1:
> $ time /tmp/g/bin/git grep foodsgsg
>
> real   0m0.501s
> user   0m0.707s
> sys    0m0.493s
>
>
> A bisect seems to indicate that it was introduced by 94bc67:
> commit 94bc671a1f2e8610de475c2494d2763355a99f65
> Author: Jean-No=C3=ABl AVILA <avila.jn@gmail.com>
> Date:   Sat Dec 8 21:04:39 2012 +0100
>
>     Add directory pattern matching to attributes
>    =20
>     The manpage of gitattributes says: "The rules how the pattern
>     matches paths are the same as in .gitignore files" and the gitign=
ore
>     pattern matching has a pattern ending with / for directory matchi=
ng.
>    =20
>     This rule is specifically relevant for the 'export-ignore' rule u=
sed
>     for git archive.
>    =20
>     Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Hmph, that looks really bad, especially given that in the normal
codepath like "git grep", we would never care about directories (the
attributes are normally applied to real paths with contents, and the
use by archive is an anomaly) and the implementation should be done
in a way not to impose such excess and useless overhead.

We may end up reverting that patch for the time being X-<.

Jean-No=C3=ABl, ideas?
