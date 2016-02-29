From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 09:30:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602290912260.3152@virtualbox>
References: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com> <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 09:31:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJEh-0000N0-9K
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbcB2IbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:31:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:55012 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbcB2IbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:31:12 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MTkNU-1aRc360gJU-00QWKn; Mon, 29 Feb 2016 09:30:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:f9hbw7kuq/rS8owSa7p3NKKheXh12pychkoGkFmCtzwLxMkvA6N
 Lp97CZHjSV8dmuLVEzOeGVzgNf+gLixt8hPP64lR4opAnzm2/u1bFlaK0dQLnsR55Sz/x2m
 s0H1X8x+mS+4e709Wi6iZO+iePnuRhmwQCETtVc2RK3mg3W/VZf6QuivT12NYFQ7zf8efQ3
 yiPm1JAUaylrHlj5MZPyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MNpwr2aGySg=:I3HPAS6e1yQmVGefel1FIw
 trLXNOghKvwkzBjyQOfy5opb8/z61oKAcuPUwLF6diGNCCL+cPntTamulSb8dqWDcax0WKs12
 BNWHsK3ycvpnbVY51k0VQ585xeNbQNlPmaWIkSPoloKyBxizi0tBlAZPPYai+IQejsVHA4S62
 L5/fPjDb64D6GBfDM6ORRTWThy1nbT1LubPs90e3RDRTUeZteBsFKr/3sZRzRQXeaMoAIJaO+
 Pj+rYgClXUdZ7LrTqvU+ckaEnT0dGmv7woC4GSqikVb7KHdKVPih3giWcvBYC68qLJm28zCrC
 Rd719kr7HuGiQX2RgSQxU36bxV6Y/SIX71CPOjmeP1e+/U42XtU05nQjnxCGVlE2RftU59CRC
 VetDySIXHBqLhQ/TzWs06wlnDlRHSktwz49Lj5AQXgZK9dKN5cLoIuGnG80FnwLtH8mRmRUnI
 FaO17HDDZDVIyKVjxqNez3vgh4ZyXdO+/ta+fPOOnqYeDQk/w7iIit9riQS9vgcQ9RQhsT3yA
 N+/04Urxwp6wKHJXSF+jElGz+qGZ/X/IdME02457eviYYW2clVWyDtqr84qBE/DTrFU601mcm
 PobArv5WXG3epFqyFjywNH4TU4TOewXvSaTipwG6kKAAQ8krsXLltyJxHxrPrjLxSmChidIi2
 KUqRt1TJw6k5woftV1fMybAc2TazwMGvcnx0M9TcnQRHbiUDPUnToS1f7DRtog66SAc3ytE/S
 cLO4y0W9Si8ArKzrBSgDVz9+IYNmRga5eH8mTVw2auBtjyw+4yOITp4CWvI7++iQ8J/JnE3E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287803>

Hi Gabriel,

On Sun, 28 Feb 2016, Gabriel Souza Franco wrote:

> Not the cleanest conditional I've ever written, but it should handle
> all cases correctly.

It could be much worse:

> +	if (get_oid_hex(name, &oid) ||
> +			(name[GIT_SHA1_HEXSZ] != ' ' &&
> +			 name[GIT_SHA1_HEXSZ] != '\0'))

I know developers who would write this as

	if (get_oid_hex(name, &oid) || (name[GIT_SHA1_HEXSZ] & ' '))

and not even begin to realize that this is a problem.

So I'd say your conditional is good.

Having said that, this *might* be a good opportunity to imitate the
skip_prefix() function. If there are enough similar code constructs, we
could simplify all of them by introducing the function

	skip_oid_hex(const char *str, struct object_id *oid, const char **out)

that returns 1 if and only if an oid was parsed, and stores the pointer
after the oid in "out" (skipping an additional space if there is one)?

Ciao,
Dscho
