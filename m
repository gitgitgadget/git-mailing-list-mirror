From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Tue, 14 Apr 2009 20:18:45 +0200
Message-ID: <36ca99e90904141118w425a059v6bd22a7e6400f78f@mail.gmail.com>
References: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net>
	 <20090410171458.GA26478@sigill.intra.peff.net>
	 <7vprff41lf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtnFh-0007ua-CJ
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbZDNSSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbZDNSSs
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:18:48 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39011 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbZDNSSr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 14:18:47 -0400
Received: by bwz17 with SMTP id 17so2560461bwz.37
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yzwipV5iipSKtJEJkPK1eDFntYZ362Q46bOyjRw+7r4=;
        b=taMXdPe5LAYbIW+7RKAAKBsl3k7jDyzSoNoxnRSWx6a8K7oIWpZWiEXuqnjvdKOngy
         BSHgxge1ekAbFGjsSlTiWYPRCNjMQnNdys3DGC19PV82z0ybv1QAKh0lUwf+fmrDZ8y4
         YatYZe4bsUuCKoSvQ/emR9W5GL8BwdFYnaZb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dFzNoJcKw84A7tewTeH0aKXh1n4K3M5JjcE2D5ks9We+UFTHsfYTK0aI382T84fbE0
         uR6bBl1tJ7OJ77lghVpnTAJw3yb+6RpTanPFlCMFDRTLpwYihZZ6SYMA+vsvfLryXtOH
         B+pN4g3vQx3VNeiiYhnbWWOsK9ZUsOoxY4lAo=
Received: by 10.223.107.199 with SMTP id c7mr2129461fap.31.1239733125376; Tue, 
	14 Apr 2009 11:18:45 -0700 (PDT)
In-Reply-To: <7vprff41lf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116550>

On Tue, Apr 14, 2009 at 18:55, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jeff King <peff@peff.net> writes:
>
>> Hmm. I was thinking we might be able to just do away with prettify_r=
ef,
>> but I didn't consider the fact that we need to prettify remote thing=
s. I
>> think you could still unambiguously prettify the local half of those
>> callsites, though.
>>
>> Given that the two functions are closely related, should we perhaps
>> rename them to
>>
>> =C2=A0 const char *shorten_ref(const char *);
>> =C2=A0 const char *shorten_ref_unambiguous(const char *);
>>
>> ? The implementations are quite different, with prettify_ref not rea=
lly
>> respecting the ref lookup rules, but rather just considering a few
>> pre-determined bits of the hierarchy as uninteresting. It shouldn't =
be
>> that hard to have them both use the same implementation, like:
>>
>> =C2=A0 const char *shorten_ref(const char *, int unambiguous);
>
> I was hoping that a single "shorten" function that does not even take
> "unambiguous" parameter would be used by almost everybody. =C2=A0As f=
ar as I
> can see, Bert's "rev-parse --abbrev-ref" RFC is the only caller that =
might
> need to use a value different from warn_ambiguous_refs, and all the o=
ther
> existing callers (including fill_tracking_info() for "upstream" repor=
t by
> git-branch) do not have to pass "0" but can use the default. =C2=A0IO=
W, we can
> have:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *shorten_ref_unambiguous(const =
char *ref, int strict);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *shorten_ref(const char *ref)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return shorten=
_ref_unambiguous(ref, warn_ambiguous_refs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
There's too much confusion: Whatever input you gave to
shorten_unambiguous_ref(), if you pass the result to dwim_ref() you
get the input again. That is, all return values are unambiguous. The
only small different (and here comes a little word-confusion) is, that
in strict mode you wont get any warning for 'ambiguous' refs. So the
names "shorten_ref_unambiguous" and "shorten_rer" are misleading,
because it looks like the former returns unambiguous refs and the
latter not. Which is wrong.

I can't think about this further, no time sorry.

Bert
