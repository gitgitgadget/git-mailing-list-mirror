From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too early
Date: Mon, 28 Jun 2010 19:45:16 +0700
Message-ID: <AANLkTilYQ_n6hQLC8C9qNtKa_-Jz6ec9FXlDL5NXe4Kc@mail.gmail.com>
References: <20100626192203.GA19973@burratino> <20100628094033.GA18629@coredump.intra.peff.net> 
	<20100628101335.GA5007@burratino> <20100628102201.GA24817@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 14:45:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTDih-0001Im-BP
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 14:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab0F1Mpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 08:45:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62892 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab0F1Mpo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 08:45:44 -0400
Received: by bwz1 with SMTP id 1so180019bwz.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VHo7UHzxQC52P9CIdO/nn/JSRPHGaWLS7h9eO94umOk=;
        b=K1coDlGzlzJOG9Zmt8ugM29VjqDw/E5lQFB9gkmKUUmarfe0iL2sc5ATpPTns31U8s
         /93j/7sZltrzaLMheG1PTx080vyR71oDQpaEHERy4LuMCoywzxVE4rfy/uC8UeJFFc0I
         pW8yZHoEM9YfbkvL0qSdC6FYLpiKCuzFpWjSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wt+4KqdTfrTFgwGwUjbwV9o7s57Oc4RyHb49FD23KG9gsnmZ92DiNarBu/WPNEEhrE
         Ds+blWJ3rCmvEQHit9QD/P1Jc7b4/y+0ehSREd45TZJZmFFo6DAS1DsI7ODEqt1xeZ+C
         XrYPZ8QV3xurR61Kh9fA2U3fPvU6DbRYEsra8=
Received: by 10.204.143.88 with SMTP id t24mr3583218bku.2.1277729139386; Mon, 
	28 Jun 2010 05:45:39 -0700 (PDT)
Received: by 10.204.61.70 with HTTP; Mon, 28 Jun 2010 05:45:16 -0700 (PDT)
In-Reply-To: <20100628102201.GA24817@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149830>

2010/6/28 Jeff King <peff@peff.net>:
> On Mon, Jun 28, 2010 at 05:13:35AM -0500, Jonathan Nieder wrote:
>
>> > But reading the message for patch 4/4, I can't help but wonder if =
the
>> > right way forward is for the git wrapper to _always_ find the repo=
sitory
>> > as the very first thing.
>> [...]
>> > the worst case should be a little bit of
>> > wasted effort.
>>
>> This is a very useful thought. =C2=A0Git without the chdir() to topl=
evel
>> would be pleasanter, I think. =C2=A0(Yes, I realize you weren=E2=80=99=
t necessarily
>> suggesting suppressing a chdir_to_toplevel() in place of
>> setup_git_repository() and friends.)
>
> I had just meant that we would not do the chdir() initially, but woul=
d
> do so right before running the actual command which wanted repository
> setup (and commands like init which do not do that setup would never
> chdir to the toplevel). But we must always run at least aliases and
> external sub-commands from the toplevel to keep backwards compatibili=
ty.

I think I'm missing something here. Looking up aliases means
repository search must be done in git wrapper anyway. Even if we don't
have to do repo search in git wrapper, the very first thing a sub
command does is likely git_config(), which will need repo again. As
long as repo search does not have any side effects, everything should
be fine, IMO.

> So yes, we are adding the extra lookup for commands like "git clone",
> but I suspect in practice nobody will care. If it is a big deal, we c=
an
> do something like:
>
> =C2=A0if (!strcmp(cmd, "clone") || !strcmp(cmd, "init"))
> =C2=A0 =C2=A0 ... don't do setup ...
>

If git wrapper does not need setup (i.e. aliases) at all, that should
happen without hacks. "clone" and "init" do not have RUN_SETUP (nor
RUN_SETUP_GENTLY in my series), so there should not be any setup
before cmd_{init,clone} is run.

PS. I haven't forgotten my cleanup series. Day job has been taking too
much of my energy unfortunately.
--=20
Duy
