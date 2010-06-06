From: Jay Soffian <jaysoffian@gmail.com>
Subject: branch --set-upstream considered harmful
Date: Sun, 6 Jun 2010 15:21:57 -0400
Message-ID: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 21:22:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLLQh-0007qk-IF
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 21:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0FFTV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 15:21:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63848 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0FFTV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 15:21:57 -0400
Received: by iwn37 with SMTP id 37so2676056iwn.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=iV/sBmQlDb/rVc5LiFrc6RRC3aOGUIDLT31yX/c7A4s=;
        b=Jxc2qQuHrGUqgcHiLRswpIe6JYGZaEbQJEljDPBqCWa61uvE+fIfq4UtcNMdAwx9fH
         q/0dEH39EkEH+mIh5vTNPZ4fewXEIPb0ux7nP9lxslGSHehl9onD8yXiFmx1JJbuGOAm
         tkG+7N9Y7CLhZmK/f7jAiPkxGHUHbFHX/N4UI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=m1apfa4nLtlRq2wOY8fEmzHPl81koZZB1l8sBAlkwYjpEUMW6VKRVaPRohS3tqi81J
         5rFPyoLr2GKA7vxiy8SVYz+ZCrnDTq+sHmT2TWOH7HbzNUIEefUdNS2yCZygRwRihC1k
         Y7qkYdq6ssp9A9fTioINnGBWF5rCZc8rHu50s=
Received: by 10.231.119.71 with SMTP id y7mr3488815ibq.158.1275852117141; Sun, 
	06 Jun 2010 12:21:57 -0700 (PDT)
Received: by 10.231.16.134 with HTTP; Sun, 6 Jun 2010 12:21:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148536>

Say I have an existing branch and it doesn't have a tracking config.
(My local users often just do "checkout -b topic" instead of "checkout
-b topic origin/master".)

I would naively expect this to work, while on that branch:

  (topic)$ git branch --set-upstream origin/master

But, um no:

  (topic)$ git branch --set-upstream origin/master
  Branch origin/master set up to track local branch topic.

Doh!

Well, maybe this works:

  (topic)$ git branch --set-upstream origin/master topic
  Branch origin/master set up to track local branch topic.

Doh!^2

Well, maybe we can say "HEAD" since that seems to mean "the current
branch" everywhere else in gitland:

  (topic)$ git branch --set-upstream HEAD origin/master
  Branch HEAD set up to track remote branch master from origin.

(Aside, being able to create a branch named HEAD is surely a bug, right?)

Finally after exhausting all other possibilities (or finally making
sense of --set-upstream in the man page), we realize:

  (topic)$ git branch --set-upstream topic origin/master
  Branch topic set up to track remote branch master from origin.

Trying to make myself feel better, I realize that this works:

  (topic)$ git branch topic --set-upstream origin/master

So here's how I'm thinking about fixing it, but maybe I'm just making
it even more confusing. What say you:

  (topic)$ git branch --set-upstream=origin/master
  Branch topic set up to track remote branch master from origin.

--track would be similarly enhanced, which allows a little more
flexibility in creating a branch thusly:

  $ git branch --track=origin/master topic

Which creates topic, starting from HEAD, but tracking origin/master.
(And I'd do the same for checkout's --track option.)

I recognize that having both positional and non-positional forms of
--track/--set-upstream  may be confusing, but I think it's less
confusing than set-upstream's current semantics, I'm loathe to
introduce yet another option, and I don't want to break backward
compatibility.

Flames?

j.
