From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Veryfing signatures in git log fails when language is not
 english
Date: Thu, 14 Feb 2013 11:55:04 +0100
Message-ID: <511CC288.30607@drmicha.warpmail.net>
References: <20130214011837.04880b3e@hydra.devrandom.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: XANi <xani666@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 11:55:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5wTS-0007qH-6w
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 11:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933945Ab3BNKzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2013 05:55:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37710 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757350Ab3BNKzD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 05:55:03 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2274F209F0;
	Thu, 14 Feb 2013 05:55:03 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 14 Feb 2013 05:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Dsz+A31SYOLj50KxqfVrP3
	UEe6c=; b=oyn8qAc72dYsOZpDYNMl0KSqEzidUnay/yR7c7gnqX9ufdLBxMshQP
	4OQWZ0ys3sg7VWx5Qaend/o14NXPdc7hx81FzD8mQnxSfMdxYHSPvNlW1WovUF3t
	7c15xM8aGKOtRJLvjOr3B9PGEuw/wrovaRb7sYrRJ3IRS37lrzDH0=
X-Sasl-enc: a7WjfsWowp6BkKaYjkzfTTYqsfsUHJuXSO5fkwZZwyS/ 1360839302
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 984F348255E;
	Thu, 14 Feb 2013 05:55:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130214011837.04880b3e@hydra.devrandom.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216304>

XANi venit, vidit, dixit 14.02.2013 01:18:
> Hi,
>=20
> any functionality that depends on exact exit msg of program
>  can potentially fail because of that
> =E1=9B=AF export |grep LANG
> declare -x LANG=3D"pl_PL.UTF-8"
>=20
> =E1=9B=AF ~/src/os/git/git log --format=3D"%G? %h" |head -2=20
>  0d19377
>  5b9d7f8
>=20
> =E1=9B=AF unset LANG
> =E1=9B=AF ~/src/os/git/git log --format=3D"%G? %h" |head -2
> G 0d19377
> G 5b9d7f8
>=20
> tested against maint (d32805d) and master (5bf72ed)
>=20
> maybe git should set up some output-changing variables before calling
> external programs? I think setting LC_ALL=3DC should be enougth.
>=20

There are really multiple problems here:

1. git calls gpg without setting LANG but expects output in LANG=3DC

2. git looks at the textual output from gpg to check the validity.

3. In fact, it does so only for %G and the display of signed merge
commits, in all other cases it checks the return code only.

gpg is not supposed to be used like that.

Since the callers of verify_signed_buffer do that craziness there is
some refactoring to be done.

A false hotfix would be to set LANG=3DC when calling gpg from git, but
that wouldn't solve the real problem. Besides, we do want LANG dependen=
t
output for the user.

I'll have a closer look.

BTW: Thanks for the clear report :)

Michael
