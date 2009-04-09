From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 4/5] make get_short_ref a public function
Date: Thu, 9 Apr 2009 11:05:06 +0200
Message-ID: <36ca99e90904090205g8a6a5a6nea96f8c5f44e076a@mail.gmail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
	 <20090407071420.GD2924@coredump.intra.peff.net>
	 <36ca99e90904070039m15869c34jc9e12d5ccc48d82@mail.gmail.com>
	 <20090409081857.GC17221@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 11:06:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrqDf-0000K5-U8
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 11:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272AbZDIJFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 05:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbZDIJFL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 05:05:11 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:34121 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbZDIJFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 05:05:09 -0400
Received: by bwz17 with SMTP id 17so480249bwz.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0DsAQ4HRSXFELwxBu4O8TgfUxiZENYSWImuZGVcD3D4=;
        b=tjb4fkT57IB3RNJR4NBW/JEAjPJ0eZKC/WbacUdT65+h9Wadp1CV/bMD443cYESHC+
         blROfFVfrXggbnJWik84zCsql9oTFi83cWTKYFgNDhRAuVOD3IOqLm3Y/iTdXq4ZeUry
         GSLENRlHjLvClnGqjf1YbzAreqjw+er8bFsPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tmvMqzgbp/QyQoduRGUzgxF/Bxal5lc96nCGYrgTEA3ZCtutc/6dfROOHQsxoQ3QXN
         yaFq5y0QGL9HNSFXoEUTH3QyqMIs4uoYo/gYwiiC3o2EiQEfBgnoI5PQ0Xs+FrmtJoEg
         Lr39PoaOWyDcA2AkNYdnedIVr12vA74En2cks=
Received: by 10.223.107.68 with SMTP id a4mr623031fap.104.1239267906315; Thu, 
	09 Apr 2009 02:05:06 -0700 (PDT)
In-Reply-To: <20090409081857.GC17221@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116157>

On Thu, Apr 9, 2009 at 10:18, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 07, 2009 at 09:39:58AM +0200, Bert Wesarg wrote:
>
>> > Actually, I am not quite sure that this function is "more correct"=
=2E It
>> > looks at the rev-parsing rules as a hierarchy, so if you have
>> > "refs/remotes/foo" and "refs/heads/foo", then it will abbreviate t=
he
>> > first to "remotes/foo" (as expected) and the latter to just "foo".
>> >
>> > This is technically correct, as "refs/heads/foo" will be selected =
by
>> > "foo", but it will warn about ambiguity. Should we actually try to=
 avoid
>> > reporting refs which would be ambiguous?
>> Back than, there was the idea that the core.warnAmbiguousRefs config
>> could be used for this.
>
> I'm not quite sure what you mean. Using this function, we may shorten=
 an
> unambiguous name to one that will complain if core.warnAmbiguousRefs =
is
> set. So what I'm wondering is if it should use a different algorithm
> that produces a shortened ref which will not cause a warning.
>
> E.g., right now if we have:
>
> =C2=A0refs/heads/master
> =C2=A0refs/remotes/master
>
> showing %(refname:short) gets you:
>
> =C2=A0master
> =C2=A0remotes/master
>
> but "git show master" will warn about the ambiguous ref (but still sh=
ow
> you the one you want). An alternative would be to show:
>
> =C2=A0heads/master
> =C2=A0remotes/master
>
> in this case.
Right, and the idea was to choose the alternatives based on the
core.warnAmbiguousRefs setting, i.e. the former for false, the latter
for true.

=46or what I posted a patch some time ago:

http://thread.gmane.org/gmane.comp.version-control.git/96464

(which I read though now)

Bert
>
> -Peff
>
