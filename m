From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Tue, 26 Jan 2016 09:44:51 -0800
Message-ID: <xmqqsi1kck18.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<56A7850D.6060805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 18:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO7fm-0000QK-T1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 18:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965562AbcAZRoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 12:44:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932586AbcAZRoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 12:44:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 73DCB3E252;
	Tue, 26 Jan 2016 12:44:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Vr5eXauB97mU
	Ah1dOF3QrikMeJo=; b=ofOYU02yYeQQseZkMMDo6UOLLOOyn0jSgHpLI5Qw5tJv
	qHPk39QOUyWFzJISfRuuGEWU7KoeVowiyQcBcGBo2BLbqj6E74Lnjk07lNKZR0k+
	6vf8/k+NH9Tl6UpjbwKXt/k4CLoRA7+K5oGEmFvWc69htmR2jjyyeO0E4/uNpHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vR4ygW
	nX18OUEJMfJ2QRbgh6lGMKYl/yOTaTcPtG0sZtyynN8+KKryJC1BxRE3FjU2kqou
	y/tj4z5BCDpkDu4TgoQd3LqLn8G+pvn0WtFlRvEAWP83Jsg4PCB+MYVqWuVWGvmk
	h0qgHmqsiPinZVmz0Sql+/b+FiKUcweLddN3U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6ABBA3E251;
	Tue, 26 Jan 2016 12:44:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2C023E250;
	Tue, 26 Jan 2016 12:44:52 -0500 (EST)
In-Reply-To: <56A7850D.6060805@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 26 Jan 2016 15:39:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8135EC84-C454-11E5-984D-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284845>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 26.01.2=
016 14:26:
>> Commit 57ea712 (git.c: make sure we do not leak GIT_* to alias scrip=
ts -
>> 2015-12-20) does not realize that handle_alias() can be called multi=
ple
>> times because of the forever loop in run_argv(). The commit breaks a=
lias
>> chains.
>>=20
>> Suppose you have an alias "abc" that resolves to another alias "def"=
,
>> which finally resolve to "git status". handle_alias() is called twic=
e.
>> save_env() and restore_env() are also called twice. But because of t=
he
>> check save_env_before_alias in save_env(), we save once while trying=
 to
>> restore twice. Consequences are left for the reader's imagination.
>>=20
>> Fortunately, you cannot make an alias of another alias. At least not
>> yet. Unfortunately it can still happen with help.autocorrect, where =
your
>> alias typo is treated as the first "alias", and it can be resolved t=
o
>> the second alias. Then boom.
>>=20
>> Make sure we call save_env() and restore_env() in pairs. While at th=
ere,
>> set orig_cwd to NULL after freeing it for hygiene.
>>=20
>> Reported-by: Michael J Gruber <git@drmicha.warpmail.net>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> The patch fixes it for me, thanks!
>
> Michael

Thanks for noticing, and thanks for describing the problem very
clearly and fixing it quickly.
