From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with
 symlinks
Date: Sat, 18 Sep 2010 13:01:17 -0700
Message-ID: <7vpqwa254i.fsf@alter.siamese.dyndns.org>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Sep 18 22:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox3bZ-0002R6-Kq
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 22:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab0IRUBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 16:01:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab0IRUBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 16:01:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2919ED75BC;
	Sat, 18 Sep 2010 16:01:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5UgoQ7n5/+xAW1YGTRH/Dg/ryGw=; b=F+aMlg
	efNrXujjHOhRa4eDaazl6qmZ816bj0J1u084FRW8gca29N5l3D/h5S+jR+aX5MJh
	tbzPjLxJfhPU4oSvt6CWb4AXjxo+KBmoRfSgRGYoqrtjkIPdCBKkQd+LMBQp5m8m
	YwgZRDrJsw4jtzZ2waetpda1XQoPx2PiIMUBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhTphzkREV02Py0zw/zR63fV16a9AHf4
	tdOKcdN7TMJLW7JcCCe2+dLKV1o2Ex2NPrE91SidKX5CPTfMqBDjah+uyWdBNhMT
	VdGXNSZ8Zpc0FG252vksMqMcl+yD/E3Q/YKWRjttJevSyv9h/p/lQwCX7ZshQsCq
	MQo5JcZBPv0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9269DD75BA;
	Sat, 18 Sep 2010 16:01:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82C75D75A8; Sat, 18 Sep
 2010 16:01:19 -0400 (EDT)
In-Reply-To: <vpqhbhmx6tg.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 18 Sep 2010 20\:08\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 850959D2-C35F-11DF-8FCD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156473>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>
>> Recently I've spot a bug in git blame --textconv, which was wrongly
>> calling pdftotext (my *.pdf conversion program) on a symlink.pdf,
>
> No time for a detailed review now, but textconv is also called by diff
> (that's the original implementation). Does "git diff" work properly on
> symlinks in the same case?

diff knows symlinks and regular files are different, and produces "delete
old then add new" if you changed a regular file to a symlink.

That said, if you changed a symlink from pointing at A to pointing at B,
it does run the textual diff between the string we get from readlink(3).

I happen to think that textconv, if specified, for such a path should be
honored, so that people can keep doing whatever munging they have been
doing in their existing textconv filters.

I didn't look at the thread or problem description, but are we running the
textconv filter on the file that symlink points at, instead of the
pathname stored in the symlink?  If so I'd call that a bug.

On the other hand, if we are running the textconv filter on the pathname,
then I don't think we are doing anything wrong.  If you have a filter that
is meant to munge a PDF file to some other format, and if you do not want
to apply that filter to munge a pathname a symlink that happens to be
named "foo.pdf", either the filter itself or the attributes pattern you
are using to choose what paths to apply that filter might want to be
written more carefully, that's all.
