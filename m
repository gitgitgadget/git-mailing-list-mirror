From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Don't implictly stomp pending sequencer operation
Date: Wed, 27 Jul 2011 15:29:06 +0530
Message-ID: <CALkWK0mhAc4TtSzN5DW8OX91QBvosbbKsYfB5QPFy563qg7KRQ@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-18-git-send-email-artagnon@gmail.com> <20110727051947.GL18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:59:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0ts-0000xI-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab1G0J72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 05:59:28 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56140 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1G0J71 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 05:59:27 -0400
Received: by wwg11 with SMTP id 11so2905748wwg.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D8ku4sEnApXsctD9WJw4Iz+7UiFMgQ908xF9MJudS4s=;
        b=djgSHTtuePcbvyT52oSgpRcFsklt2MxTDVRsKGp49LaPjZflfAy9Nh/K8UoiJl9Ujm
         FpqVnIoWYqMV2zFqkNOkSQ8M5ZeS2XWtZE7jdy98YlOSpmC7z3eihYYqCmf+Pc6KN0nw
         iI8ozSusbBeV5iQft4uIkKQ8DqgAtf/kYZcZg=
Received: by 10.216.9.134 with SMTP id 6mr2760998wet.111.1311760766170; Wed,
 27 Jul 2011 02:59:26 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 02:59:06 -0700 (PDT)
In-Reply-To: <20110727051947.GL18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177958>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> [...]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (create_seq_dir() < 0=
) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 advise(_("A cherry-pick or revert is in progress."));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 advise(_("Use --reset to forget about it"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> The usual formula is:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error(... description of error ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (advice_foo_bar [i.e., if the user is n=
ot tired of the advice already]) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0advise(... how=
 to recover from error ...);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0advise(... mor=
e lines ...);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

I think you're trying to say two things here:
1. Put the error() call in the caller.  Why is this a good idea?  The
error is very specific to the create_seq_dir functionality, and has
nothing to do with the caller.  The advice on the other hand, can be
quite caller-specific, which is why I put it in the caller in the
first place.
2. Guard the advice using a variable.  I have to invent a new
configuration variable; can't that wait*?

Thanks.

* Ideally, I'd do these things immediately if I didn't fear picking a
stupid variable name, and implementing it in a daft manner the first
few times.  More delays will result in me doing less post midterm work
(the more interesting bits).

-- Ram
