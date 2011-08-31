From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: done feature in remote-helpers (was Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 14:55:05 +0200
Message-ID: <vpqk49tviza.fsf@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v4o14dppz.fsf@alter.siamese.dyndns.org>
	<CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
	<7v4o1092hn.fsf@alter.siamese.dyndns.org>
	<CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
	<vpq1uw13hx3.fsf_-_@bauges.imag.fr>
	<CAGdFq_jyVK3_THYXzCOLDpNww0Npn2qzZ1qv-BMuLbg1vgVjZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 14:55:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QykKG-0005yO-7w
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 14:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab1HaMzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 08:55:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48573 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab1HaMzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 08:55:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7VCsR0k002313
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 14:54:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QykJt-0008Dg-FF; Wed, 31 Aug 2011 14:55:05 +0200
In-Reply-To: <CAGdFq_jyVK3_THYXzCOLDpNww0Npn2qzZ1qv-BMuLbg1vgVjZw@mail.gmail.com>
	(Sverre Rabbelier's message of "Wed, 31 Aug 2011 14:17:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 31 Aug 2011 14:54:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VCsR0k002313
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315400072.52281@SM8qL+hdfry7ECgJ2jnQVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180464>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Wed, Aug 31, 2011 at 14:05, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> So, is this the expected behavior? Wouldn't it be more sensible to allow
>> the remote-helper to issue a "done" after each "import" command? Right
>> now, my understanding is that after an "import" command is issued, it's
>> no longer possible to output anything other than fast-import stream on
>> stdout, and I guess it'd be more future-proof to allow closing the
>> fast-import with a "done", and allow any dialog between git and the
>> remote helper afterwards.
>
> Wow, no that's not the intended behavior. We meant to make it exactly
> as you describe, after each import command you end with a done. This
> is (should) also be what the testgit implementation does currently,

Err, no, it isn't. From git-remote-testgit.py:

def do_import(repo, args):
[...]
    while True:
        line = sys.stdin.readline()
[...]
        # strip of leading 'import '
        ref = line[7:].strip()
        refs.append(ref)

    repo = update_local_repo(repo)
    repo.exporter.export_repo(repo.gitdir, refs)

    print "done"

What it does is that it reads multiple "import" commands, and process
them all at once, with a single "print done" at the end. Actually,
testgit would die("Expected import line.") if Git sent another command
after "import".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
