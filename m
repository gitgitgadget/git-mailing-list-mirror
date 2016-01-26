From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Tue, 26 Jan 2016 15:39:09 +0100
Message-ID: <56A7850D.6060805@drmicha.warpmail.net>
References: <56A72235.9080602@drmicha.warpmail.net>
 <1453814801-1925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 15:39:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4m5-0006kN-U9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966082AbcAZOjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 09:39:14 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43583 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965285AbcAZOjM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 09:39:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EDB7120BD3
	for <git@vger.kernel.org>; Tue, 26 Jan 2016 09:39:11 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 26 Jan 2016 09:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=73zEPpVFw999puMOG5qvBZnwJA8=; b=bveS/S
	h15p5RPtTxxJUZ9d2M3J/HPzQIQ0V6uY6v9gn0rnDtPnM0D1OOGhkLU1nU5TP/DF
	inkaiTz5TrjOnpKtRComiIiGpU1V8z4oyRIUnqJ6xwAGzJ+0Vj84HUvMh0cDy2Au
	MJnk1P2J5avawMHR2Fo6CV06squqp/P20EJ/Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=73zEPpVFw999puM
	OG5qvBZnwJA8=; b=g7DtXfitINiBkAI3rDySV/JEtouMnzSuLyKhG+W//A+Z0mw
	2sY9/KgJZZWMJDbkL4z3TI4NrWKbI5aA4NMhE8b99WQuLUqgW8KX4D24IOcDDIhM
	Yf1Mk8qcBvGkVI0S9Fu3quRa4GHfCuvK7G1jTzfUV6cUMM8Ihjagn0HHAG0I=
X-Sasl-enc: I7KYpw3GCLeYYN/UfkKqVnu2/FzpGhvzNxZ3pJjC3cVO 1453819151
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5E47368015E;
	Tue, 26 Jan 2016 09:39:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1453814801-1925-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284835>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 26.01.201=
6 14:26:
> Commit 57ea712 (git.c: make sure we do not leak GIT_* to alias script=
s -
> 2015-12-20) does not realize that handle_alias() can be called multip=
le
> times because of the forever loop in run_argv(). The commit breaks al=
ias
> chains.
>=20
> Suppose you have an alias "abc" that resolves to another alias "def",
> which finally resolve to "git status". handle_alias() is called twice=
=2E
> save_env() and restore_env() are also called twice. But because of th=
e
> check save_env_before_alias in save_env(), we save once while trying =
to
> restore twice. Consequences are left for the reader's imagination.
>=20
> Fortunately, you cannot make an alias of another alias. At least not
> yet. Unfortunately it can still happen with help.autocorrect, where y=
our
> alias typo is treated as the first "alias", and it can be resolved to
> the second alias. Then boom.
>=20
> Make sure we call save_env() and restore_env() in pairs. While at the=
re,
> set orig_cwd to NULL after freeing it for hygiene.
>=20
> Reported-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The patch fixes it for me, thanks!

Michael
