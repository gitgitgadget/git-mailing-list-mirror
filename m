From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: done feature in remote-helpers (was Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 14:05:28 +0200
Message-ID: <vpq1uw13hx3.fsf_-_@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v4o14dppz.fsf@alter.siamese.dyndns.org>
	<CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
	<7v4o1092hn.fsf@alter.siamese.dyndns.org>
	<CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 14:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyjY6-0005FO-5h
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 14:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab1HaMFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 08:05:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41727 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab1HaMFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 08:05:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7VC4m7v001525
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 14:04:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QyjXs-0006Xl-MT; Wed, 31 Aug 2011 14:05:28 +0200
In-Reply-To: <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
	(Sverre Rabbelier's message of "Mon, 29 Aug 2011 08:41:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Aug 2011 14:04:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VC4m7v001525
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315397090.20807@SNobAoro2rl4yWbk4WjFGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180461>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Aug 29, 2011 at 08:05, Junio C Hamano <gitster@pobox.com> wrote:
>> Does this exchange suggest that at least we would need an update to
>> documentation around "done", as Matthieu's "why is 'done' needed even
>> though I am not calling with --done?" sounds like a very fair question.
>
> No I think the documentation for fast-import is correct. If you pass
> --use-done-feature or print 'feature done' in the stream the use of
> 'done' is required, otherwise it isn't. We did recently changed git to
> pass '--use-done-feature' to the fast-import process though :).

That doesn't help much someone writting a remote helper.

The documentation for remote-helpers neither talks about "done" nor
about "--use-done-feature" or whatever way Git uses this feature when
using remote-helpers.

The current state is particularly confusing: git seems to expect one and
only one "done" feature, even when multiple "import" commands are
issued. That's very strange, and I'm not sure whether it's the expected
behavior (I can try a documentation patch, but I need to understand
better what's expected and what's not).

It would be natural to write remote-helpers like

while ($cmd = <read command>) {
    if ($cmd eq "import") {
       <write fast-import stream>
       print "done\n";
    } ...
}

but in the current state, it doesn't work since we'll get a first
"import HEAD", issue a "done", then get a "import refs/heads/master" and
write to a dead pipe.

Then, it would be very tempting to write it like

while ($cmd = <read command>) {
    if ($cmd eq "import") {
       <write fast-import stream>
    } ...
}
print "done\n";

but this doesn't work either, because when calling "git push", no
"import" command is involved, no fast-import is started, and the "done"
breaks everything.

That's why I had to make it like

my $import_started;
while ($cmd = <read command>) {
    if ($cmd eq "import") {
       $import_started = 1;
       <write fast-import stream>
    } ...
}
if ($import_started) {
    print "done\n";
}

and I really had the feeling I was working around a mis-feature of Git
here.

So, is this the expected behavior? Wouldn't it be more sensible to allow
the remote-helper to issue a "done" after each "import" command? Right
now, my understanding is that after an "import" command is issued, it's
no longer possible to output anything other than fast-import stream on
stdout, and I guess it'd be more future-proof to allow closing the
fast-import with a "done", and allow any dialog between git and the
remote helper afterwards.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
