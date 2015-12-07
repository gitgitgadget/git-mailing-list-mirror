From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
Date: Mon, 07 Dec 2015 10:33:02 -0800
Message-ID: <xmqq4mfunm75.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
	<1449166676-30845-1-git-send-email-pclouds@gmail.com>
	<1449166676-30845-2-git-send-email-pclouds@gmail.com>
	<CACsJy8BKbzzE7D0a2HqjU3kvz1SitcJyVxZH=aWAc+bBd8MmQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 19:33:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a60b2-0006V2-C3
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 19:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089AbbLGSdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 13:33:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005AbbLGSdG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 13:33:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A83973123F;
	Mon,  7 Dec 2015 13:33:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iGU1vFm1rtmF
	8xf6V2gY/FRFeco=; b=yCbfUjWLZLG5q9JY1NlEF3NECSNyPyEcAJ6aGDBqjBsW
	3MJBVtvgOQNACDGgxIxdgS47M0ZpZwx0J4eEiN2VuJIhrbHPsWAt+7rAvXaXoDSE
	YII0WsLPtyvC7ZPhSevyOvDOmQBdbHklGwEhK+HBcSJ+FAQh4NU0m+YlbV5KDqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZIId7+
	bWTaWIex4Suu7xjHYd5pKgWZXiCKVmzRz897tbI3GvPRysUzy+E6fCfwZa7rf8ax
	MDKNlfafanExmYhH4Hcm6EzCtIX5Z13YAEnOgRXwlfOro1cGGa5QnqTTMuyByXXU
	ihWeeqHEHMdafGo+W7D7NkpQTQXFdEkugnN6I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FA6A3123E;
	Mon,  7 Dec 2015 13:33:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 018CE3123B;
	Mon,  7 Dec 2015 13:33:03 -0500 (EST)
In-Reply-To: <CACsJy8BKbzzE7D0a2HqjU3kvz1SitcJyVxZH=aWAc+bBd8MmQg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 5 Dec 2015 20:12:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3D06D20-9D10-11E5-AACC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282102>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Dec 3, 2015 at 7:17 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> The solution in d95138e is reverted in this commit. Instead we reuse=
 the
>> solution from c056261 [4]. c056261 fixes another setup-messed-up-by-=
alias
>> by saving and restoring env for git-clone and git-init. Now I conclu=
de
>> that setup-messed-by-alias is always evil. So the env restoration is
>> done for _all_ commands  whenever aliases are involved. It fixes wha=
t
>> d95138e tries to fix. And it does not upset git-clone-inside-hooks.
>
> (Reviewer hat on) I wrote env restoration is done for all commands,
> but the patch is actually about all _builtin_ commands. External ones
> do not receive this treatment. FIx is in the next reroll.

Thanks for being careful.
