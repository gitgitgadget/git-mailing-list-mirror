From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] count-objects: report garbage files in
 .git/objects/pack directory too
Date: Mon, 04 Feb 2013 09:06:39 -0800
Message-ID: <7vy5f42elc.fsf@alter.siamese.dyndns.org>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1359982145-10792-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:07:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PVX-000795-V4
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 18:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab3BDRGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 12:06:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754276Ab3BDRGm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 12:06:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8716B178;
	Mon,  4 Feb 2013 12:06:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R+DgEKFSbIBt
	+HVOyYE6ngTVf/8=; b=F5Wd7Q2QrgWgyzntw00DJr5LM1AUMa4Fjh/IZikgPSzo
	w8kpO+bOHjTIjOGQIA9DOBoOOUyvYjjlgdW3Ot2p+s2EP8ls4nAtIROd6JLDQJy3
	syy2sy1O4qqR+Bh3w5g1LpL+Qyi1v3zs411+HrH8uN8zH/kWvFHKxN4rpxL8SF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BEVFrP
	ui8PdynZM0AWKYVByrxEP9tpwnJeH5l6MolKNsQl3mzjiqaevWK3BT/3wsLRZf+K
	y0Sbmh8SaUOJI33XLuHhWESz9Sq+28r7fewsjoZn7TXFZ/6aHFsVccfdCPV80ooO
	Q747kCZEleUjtytRAzkC2S+G+D3OGrl+0l6lo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE08B177;
	Mon,  4 Feb 2013 12:06:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45C36B16F; Mon,  4 Feb 2013
 12:06:41 -0500 (EST)
In-Reply-To: <1359982145-10792-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 4 Feb
 2013 19:49:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EB5BC32-6EED-11E2-82E6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215398>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  The hook in prepare_packed_git_one is ugly, but I don't want to
>  duplicate the search file logic there in count-objects. Maybe I'm
>  wrong.

In this particular case I do not think you are completely wrong;
you are probably only two thirds wrong ;-)

The idea to use a customizable function pointer to allow it do extra
work is probably fine, but adding three identical calls and continue
is a bad taste.  Just have one callsite for the error path and do
not hesitate to jump to it with 'goto'.

I do not think failure to add_packed_git() should be treated the
same way as other cases where the files readdir() found are truly
garbage, by the way.

I also wonder, especially because you are enumerating the temporary
pack files in .git/objects/pack/, if it make more sense to account
for their sizes as well.  After all, you would end up doing stat()
for a common case of files with ".pack" suffix---doing so for all of
them shouldn't be too bad.
