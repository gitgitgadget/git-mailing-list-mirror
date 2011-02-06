From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 21:28:51 +0100
Message-ID: <vpqaai8oqkc.fsf@bauges.imag.fr>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102050218.44325.johan@herland.net>
	<20110205214045.GA15668@dpotapov.dyndns.org>
	<201102060104.37146.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:29:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBEP-0005gJ-Kh
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab1BFU3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:29:08 -0500
Received: from mx2.imag.fr ([129.88.30.17]:60749 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab1BFU3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:29:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p16KSnBe008963
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Feb 2011 21:28:50 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmBE4-0000JZ-84; Sun, 06 Feb 2011 21:28:52 +0100
In-Reply-To: <201102060104.37146.johan@herland.net> (Johan Herland's message of "Sun\, 06 Feb 2011 01\:04\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Feb 2011 21:28:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p16KSnBe008963
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297628933.21493@uy0Ml5wEYu8P+OJkOHYIFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166198>

Johan Herland <johan@herland.net> writes:

> I don't see how the separate namespaces cause problems here. Also, I don't 
> know what you're proposing instead, or indeed what other organization of 
> tags would lead to less confusion.

I'm not against the idea, but one drawback of the separate namespace
is that it introduces complexity for the user. In the common case,
where the user may fetch the same tag from various sources, there 
will still be several refs (probably listed by "git tag" ?), and this
may confuse the user.

Another question is what happens when you push. With branches,
fetching XXX fetches in origin/XXX, but pushing YYY does push to YYY.
This asymetry between push and pull works well because most of the
time, if we have a origin/XXX branch, we also have XXX (with
origin/XXX as upstream).

For tags, it's clearly different. If I have origin/v1.7.4, I don't see
much reason to have _also_ v1.7.4 as a local tag. And if I have only
origin/v1.7.4 and push it as origin/v1.7.4, then someone pulling from
it will get origin/origin/v1.7.4, and so on.

So, my feeling is that the "separate namespace" should not be
automatic.

For example, today, git.git repo contains tags like v1.7.4 and others
like gitgui-0.13.0, which is clearly a handmade namespace, where a
real namespace would be better. That would make a lot of sence to me
if Junio had something like

[remote "git-gui"]
	url = ...
	fetch = +refs/heads/*:refs/remotes/git-gui/*
	fetch = +refs/tags/*:refs/tags/remotes/git-gui/*

or whatever other syntax, so that git-gui's tags be automatically
fetched into the right namespace (with no warning in case of
duplicate).

But OTOH, I don't want to have several namespaces in my git repo even
if I configure several remotes to fetch from. In this case, duplicate
tags are just redundancy if they point to the same object, and a real
conflict I want to know about immediately otherwise.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
