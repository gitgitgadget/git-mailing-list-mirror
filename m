From: Elijah Newren <newren@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Tue, 27 Jul 2010 21:59:25 -0600
Message-ID: <AANLkTikoOL0jYi4kD0L1uLU=UCmG9p0Rc3VLOU-djQnY@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikvhi-Bm-eV9ZfjoZdugRpiCwg8n-TQ4oOVvC=G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 06:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdxoK-0006xZ-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 06:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0G1D75 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 23:59:57 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58115 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0G1D74 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 23:59:56 -0400
Received: by qyk8 with SMTP id 8so3210935qyk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 20:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c0CNnC8Z6H2HTgmJlwW7nsmPW0uD1oTyGgZsUI4ipvM=;
        b=Z9HcBFv9NEls2DHBD9ZTiwToy6SRyaFADCkQAvHaF6j2H3DiT9oiCkeQttzMMsvCaF
         BSfn+i4yPdrwf8qvSkLk4bI292Y9D8pDYRY67PfX1OvauEJmqymkuAS2MxGuXSZIbxwv
         2R/0X2HcCvYm2Z/bl0R/u5IOM6fDPp4xtsLHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JcfZZ+TUmorz/b7/lnj3poRNlPDGqRedikZxEgXuA3eMI0Bxhc/5GIqE1GcDJmf4vQ
         CE6yFVvt4rr40DLZfo6YKkQLzep6MfnX/u5fEcHLPl7AcQDwFdEw6/ccSLXekgDRM5UY
         thuTuLxNXKOsWg0LmzB+b27DBJxEIOty4jx4U=
Received: by 10.224.67.81 with SMTP id q17mr8123128qai.276.1280289595814; Tue, 
	27 Jul 2010 20:59:55 -0700 (PDT)
Received: by 10.220.97.15 with HTTP; Tue, 27 Jul 2010 20:59:25 -0700 (PDT)
In-Reply-To: <AANLkTikvhi-Bm-eV9ZfjoZdugRpiCwg8n-TQ4oOVvC=G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152036>

On Tue, Jul 27, 2010 at 9:36 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> 2010/7/28 Elijah Newren <newren@gmail.com>:
>> 1) A user controls sparseness by passing rev-list arguments to clone=
=2E
<snip>
>> For example,
>> =C2=A0$ git clone ssh://repo.git dst -- Documentation/
>
> Does pathspec is supported to in addition to prefix?

Basically, whatever git log or git rev-list accepts.  I think I saw
some other discussion about making those adopt some of the
code/capability of git grep, which would automatically benefit sparse
clones.  But until then, no, because I need to be able to take these
arguments and automatically pass them on to log, rev-list, etc.

> So you basically kill off shallow clone too, with "master~6..master".

Yes, that was part of the plan...extend the capabilities of shallow
clones in two ways: allowing the user to specify a cutoff via a
revision identifier as well as a number of commits, and allow people
to clone (and fetch-from/push-to) other "shallow" clones.

> I wonder what happens if user does "git clone ... master~6..master~3"=
?

Currently, that'd break -- just like it similarly does for fast-export
(see t/t9350-fast-export.sh, 'no exact-ref revisions included').  I
had been thinking of trying to get that fixed for both cases by making
it result in a "master" branch that is "three commits behind" what you
clone/fast-export from.  You'd have to look for and disallow other
special cases like "git fast-export ... master^1 master^2" or "git
clone ... :/searchstring".

I'm not sure how this interacts with Avery's suggestion to just ignore
branch/tag limiting.

> Revision walking is not the only gate to access objects. Others like
> diff machinery needs also be taught about rev-list limits.

Right, good point.  Are there others than the diff machinery (and the
fsck special case) that you know of?

> What information would you send to the server to request new pack in
> sparse clone? Currently we send all commit tips. rev-list has a notio=
n
> to subtract commit trees. I don't know if it can "add" or "subtract"
> tree prefix though.

When "densifying" a sparse clone, I was (initially at least) just
going to treat it like an initial clone and re-download _everything_
(even if sparsifying rather than densifying).  I assumed it'd be rare
to want to do such an operation, but yeah, in the future someone might
want a smarter way to handle it.
