From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 00:51:14 +0200
Message-ID: <vpq7gfnj38d.fsf@anie.imag.fr>
References: <520BAF9F.70105@googlemail.com>
	<1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
	<CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	git <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	iveqy@iveqy.com, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 00:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9juc-00045f-M9
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 00:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933376Ab3HNWv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 18:51:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37628 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933372Ab3HNWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 18:51:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7EMpC59012918
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Aug 2013 00:51:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9juN-0003vW-7z; Thu, 15 Aug 2013 00:51:15 +0200
In-Reply-To: <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 14 Aug 2013 18:49:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Aug 2013 00:51:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7EMpC59012918
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377125476.28527@vpsbYdcnQz7Yhd3ZghPJ1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232317>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>>  builtin/repack.c               | 410 +++++++++++++++++++++++++++++++++++++++++
>>  contrib/examples/git-repack.sh | 194 +++++++++++++++++++
>>  git-repack.sh                  | 194 -------------------
>
> I'm still not sure I understand the trade-off here.
>
> Most of what git-repack does is compute some file paths, (re)move
> those files and call git-pack-objects, and potentially
> git-prune-packed and git-update-server-info.
> Maybe I'm wrong, but I have the feeling that the correct tool for that
> is Shell, rather than C (and I think the code looks less intuitive in
> C for that matter).

There's a real problem with git-repack being shell (I already mentionned
it in the previous thread about the rewrite): it creates dependencies on
a few external binaries, and a restricted server may not have them. I
have this issue on a fusionforge server where Git repos are accessed in
a chroot with very few commands available: everything went OK until the
first project grew enough to require a "git gc --auto", and then it
stopped accepting pushes for that project.

I tracked down the origin of the problem and the sysadmins disabled
auto-gc, but that's not a very satisfactory solution.

C is rather painfull to write, but as a sysadmin, drop the binary on
your server and it just works. That's really important. AFAIK,
git-repack is the only remaining shell part on the server, and it's
rather small. I'd really love to see it disapear.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
