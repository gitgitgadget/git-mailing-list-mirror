From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Fri, 10 Aug 2012 14:47:22 -0700
Message-ID: <7v7gt6ifmd.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
 <7v1ujrkc9p.fsf@alter.siamese.dyndns.org> <50253A1E.20706@web.de>
 <7vsjbuk3v3.fsf@alter.siamese.dyndns.org> <50257906.1010606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:47:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szx3L-000750-3G
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758908Ab2HJVr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Aug 2012 17:47:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758889Ab2HJVrZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 17:47:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC3190AA;
	Fri, 10 Aug 2012 17:47:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3v2pklir/63A
	VToG/N3lS/NNcAI=; b=WqEeLee/3qJ83S59ByyeU0otRw6K8iCl5rcu9aABXtcz
	tNFNvIabqzAQB7U9zhLLeH2y0ipE7ChmBCzYcGWIfB4r9y/KqY/dJ2RO9BSL/vxz
	AqFuOWDTvE8J9+U4bJdUC7cBlhv+xpkhlaCyOgFfNNGWxzq5TNCoJT2rknrgshE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g5pQVO
	dckmXn3OCAkt6HmmRwTGkRfxiUDkhQ1TJHEUTppIMgQNphoKCrdC2JH1xTX09vLU
	p3o1PjZRP0IZ37htbjXUD5nBEeTXsFgXeImVmlxLTmiEyZr6aWEQrd5UOedscU/L
	LsJz0lfXLGmJAWqYw/euzlEUbrCz8AQz0an9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B77AB90A9;
	Fri, 10 Aug 2012 17:47:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E3D690A7; Fri, 10 Aug 2012
 17:47:24 -0400 (EDT)
In-Reply-To: <50257906.1010606@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Fri, 10 Aug 2012 23:11:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F84B6B28-E334-11E1-835C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203269>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> After cloning, I set "git config core.precomposeunicode true".
>
> git is v1.7.12.rc2,
> git_git/git is with your patch.
>=20
> git v1.7.12.rc2:
> tb@birne:~/projects/git/linux-2.6> for f in 1 2 3 4 5; do time git st=
atus  ; done 2>&1 | egrep "^user|^real|^sys"
> real    0m0.460s
> user    0m0.283s
> sys     0m0.176s
>
> With lazy init of iconv:
> tb@birne:~/projects/git/linux-2.6> for f in 1 2 3 4 5; do time ~/proj=
ects/git/git_git/git status  ; done 2>&1 | egrep "^user|^real|^sys"
>
> real    0m0.462s
> user    0m0.281s
> sys     0m0.177s

Thanks.

So in short, even in a tree that theoretically should benefit from
lazy initialization, it does not make things better in any measuable
way.
