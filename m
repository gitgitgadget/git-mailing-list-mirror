From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git add -u nonexistent-file
Date: Tue, 9 Feb 2010 09:43:19 -0500
Message-ID: <a038bef51002090643g23b35bb6xaa765ff13b80f5bb@mail.gmail.com>
References: <20100208182929.GB14355@neumann>
	 <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
	 <20100209003958.GA4065@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 15:43:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NerJG-0002tn-BN
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 15:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab0BIOnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 09:43:21 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:54953 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0BIOnU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 09:43:20 -0500
Received: by pzk17 with SMTP id 17so449836pzk.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZAUMHBoqxXjSOPbIQFfdGnVPnHSk/hGg9o42peRYYDE=;
        b=tc1NA5M8kZIXi4x7qaO6Ae5mCyjhfPJKuMB50gS9l7sOAIscudkuXFrcsUe1ripQ2I
         SpSVDc+4YHi3xCoS+a5CcV172kCCV/vMx6mQS0rXJrxfGDz6JAW6+0KtUce3+PriuLxH
         YPh1O/rPGEUreOyTxKULDv3ZaC4YsZvxwSBLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D5/pFcTHSoW2ZKA2ifMW29OHw3iqTWPTq4xxOu4+FEKo3r8imIlBxAdKpYKyr0enfT
         cUgiCV/iehBhl2psf90Mw5MXvu3klb+/6efMsOYSZajDu9opN4g6dEko1+PnTlxuWm1H
         /0JwA+QZxBvITPh69DoSPfUeJZoAwGnP++B1s=
Received: by 10.114.189.27 with SMTP id m27mr5487538waf.221.1265726599190; 
	Tue, 09 Feb 2010 06:43:19 -0800 (PST)
In-Reply-To: <20100209003958.GA4065@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139406>

On Mon, Feb 8, 2010 at 7:39 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 08, 2010 at 02:12:41PM -0500, Chris Packham wrote:
>
>> > $ git add -u nonexistent-file
>> > $ echo $?
>> > 0
>> [...]
>> It looks like in the case you've highlighted git is ignoring the ext=
ra
>> non-option parameters on the command line. I'll let other people arg=
ue
>> whether this is by design or omission.
>
> It's not ignoring the extra parameters. They limit the scope of the
> operation. So:
>
> =C2=A0$ git init
> =C2=A0$ touch file && mkdir subdir && touch subdir/file
> =C2=A0$ git add . && git commit -m one
> =C2=A0$ echo changes >file && echo changes >subdir/file
> =C2=A0$ git add -u subdir
> =C2=A0$ git status
> =C2=A0# On branch master
> =C2=A0# Changes to be committed:
> =C2=A0# =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 subdir/file
> =C2=A0#
> =C2=A0# Changed but not updated:
> =C2=A0# =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 file
> =C2=A0#

Yep my bad. I tried the non-existent case but not the "normal" case.
Re reading the man page it makes sense it just happens that the
<filepattern> part scrolls off the top when I get to the -u part.

> That being said, you noticed that the regular add case notes unused
> pathspecs on the command line:
>
> =C2=A0$ git add bogus
> =C2=A0fatal: pathspec 'bogus' did not match any files
>
> We could probably do the same here.

I think so. By not having this error it led me to think "OK it just
throws away the pathspec". Gabor rightly thought that it does use it
so shouldn't it be giving an error.

If I get brave enough I could attempt a patch but I wouldn't let that
dissuade anyone that actually knows what they're doing from jumping in
with a patch.
