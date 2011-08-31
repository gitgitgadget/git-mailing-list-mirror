From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Clean termination of remote-helpers (was Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 16:53:20 +0200
Message-ID: <vpqty8x3a5b.fsf@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
	<vpqd3flzrow.fsf_-_@bauges.imag.fr>
	<CAGdFq_gSpFm8D1qHs5smUgsqyZXRjw73QFCCkBjTi0n4pwzmHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 16:54:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QymAx-0005rJ-9h
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 16:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab1HaOxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 10:53:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33419 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755870Ab1HaOxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 10:53:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7VEqdex030974
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 16:52:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QymAK-0002vD-DJ; Wed, 31 Aug 2011 16:53:20 +0200
In-Reply-To: <CAGdFq_gSpFm8D1qHs5smUgsqyZXRjw73QFCCkBjTi0n4pwzmHA@mail.gmail.com>
	(Sverre Rabbelier's message of "Wed, 31 Aug 2011 15:25:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Aug 2011 16:52:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VEqdex030974
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315407161.17336@/tLXokMZAFTM6WWsdDrcLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180473>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Wed, Aug 31, 2011 at 14:33, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> I was expecting this part to be more controversial, so I'm just
>> repeating it to draw more attention ;-).
>
> Eek! :)
>
>> # Inform Git that we're done, otherwise Git won't close it's stdin,
>> # and the next loop will be infinite.
>> close(STDOUT);
>> # Flush stdin before we terminate. If we don't, git fetch
>> # (transport-helper.c's sendline function) will try to write to our
>> # stdin, which may be closed, and git fetch will be killed. That's
>> # probably a bug in transport-helper.c, but in the meantime ...
>> while (<STDIN>) {};
>
> Is this caused by you not reading the terminating '\n' that git sends
> when all commands are done?

Indeed. The stream sent by git looks like

import HEAD
import refs/heads/master
\n <-- this one closes the sequence of import
\n <-- this one closes the sequence of commands.

and I was interpreting it as

import HEAD
import refs/heads/master
\n <-- this one closes the sequence of commands
\n <-- what's this??

So it seems the only bug I've found is insufficient documentation. A
patch follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
