From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 2/2] git-tag -s must fail if gpg is broken and cannot sign tags
Date: Sat, 8 Sep 2007 07:41:09 +0200
Message-ID: <1b46aba20709072241v2a6b071tdeb0e9fc35ea217d@mail.gmail.com>
References: <20070906042115.GA343@spearce.org>
	 <20070906042653.GQ18160@spearce.org>
	 <7vd4wwe2n5.fsf@gitster.siamese.dyndns.org>
	 <20070907045833.GZ18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 07:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITtFE-0003wk-R6
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 07:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXIHFlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 01:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbXIHFlL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 01:41:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:51763 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbXIHFlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 01:41:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so782148wah
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=d4YUJOdyxFLsHIay414vTeBSYUHxM3LSGoFTSo5QW08=;
        b=WtHKceEGSVJDzxYzjTVANiKZKINTY8CSJX7C9k9PYlb6gi7QmO/mDRuPiC7FcErzm3H5sa89kkGoXUquCbJN786Q8NbgO5mY7B/M9qWKi/Y9kPYcmwOyTtlq89ZIxZC1iATeqH6dPddgtASkUHS43B+5GfvmzhjsKGppDGdlCUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nEJN2SWzxIBPum/F4JHDciTVgxjJzG8NoxzK/w0SfCEiOWJZHS8WqlPdCbmZtB7NFmswHk1iWCMavYXkSFd0t1ECJbfsLUl7+r2aduq5n7i3RrLUxLM8eVE7T7dAApBluEvBIXTlO/dPzRtE6TiY0TIMdJ+E2o7YzcGnQeYN9vo=
Received: by 10.115.61.1 with SMTP id o1mr7153wak.1189230069611;
        Fri, 07 Sep 2007 22:41:09 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Fri, 7 Sep 2007 22:41:09 -0700 (PDT)
In-Reply-To: <20070907045833.GZ18160@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58102>

2007/9/7, Shawn O. Pearce <spearce@spearce.org>:
> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > >> If the user has misconfigured `user.signingkey` in their .git/config
> > >> or just doesn't have any secret keys on their keyring and they ask
> > >> for a signed tag with `git tag -s` we better make sure the resulting
> > >> tag was actually signed by gpg.
> >
> > This seems to fail the test depending on the order processes
> > happen to be scheduled.  I haven't looked at it closely yet.
>
> That's not good.  I noticed stepping through the code last night
> that if gpg is misconfigured (e.g. set a bad user.signingkey in
> .git/config) it will terminate and send SIGPIPE to git-tag, which
> makes it terminate.

I haven't tested it enough, but now I know that the program is terminated
in write_or_die(gpg.in, buffer, size), and it is passing the test or not
depending on the system, because I added some code before the test
and then it worked for me and if I remove that test, it is failing again.
These messages are printed:
   gpg: skipped "BobTheMouse": secret key not available
   gpg: signing failed: secret key not available
Just after start_command and before write_in_full.

Possibly the reason is that code in write_in_full() that makes exit(0)
without a warning when EPIPE is returned, or possibly is write()
in xwrite(), that dies directly when EPIPE is received like it was for
builtin-verify-tag.c. Catching the signal EPIPE doesn't worked for me,
so I will do some checks more to trace the code more exactly
in my system.

> All my change did was implement proper error handling.  So if you
> are seeing failures now then we probably have a problem with the
> code without my patch too...

The test seems to fail also without your patch, as you say.
