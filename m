From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 22:07:00 +0100
Message-ID: <4c8ef71001111307q6679039ajbef22f2e1748df56@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
	 <20100104064408.GA7785@coredump.intra.peff.net>
	 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
	 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
	 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
	 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
	 <4c8ef71001111119p253170f8q37bcd3708d894a62@mail.gmail.com>
	 <alpine.LFD.2.00.1001111124480.17145@localhost.localdomain>
	 <4c8ef71001111140j7e7d0081o7718d956104a2451@mail.gmail.com>
	 <alpine.LFD.2.00.1001111159270.17145@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f7d62418f16f047ce9ebc9
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NURTn-0002EV-DJ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 22:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab0AKVHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882Ab0AKVHE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 16:07:04 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:55512 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab0AKVHC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 16:07:02 -0500
Received: by fxm25 with SMTP id 25so32919fxm.21
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 13:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=iDxvEGjIS+lsBlGUJtimOAPMuil0IaGAIaYSVKCb3wA=;
        b=MChyldl2F0Gd00zFqEtXIifW1UDGQ/lQaFB3Y6xyasNtJqdjz/FC2DAujBxMg+OigZ
         g5L3G/CkPi4NDHo0gxdiIAs2ApadG90hazrl0x6HZmxm0wg7YC+ZU/fZ3mXpuO59PvIE
         CnvNrm3K5AL8FFKjhu6UDytMeETvbBpxhm1sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hbR9oyFSA5ms8cZaKNKwp718uBydk13tCg9qV38zkNOJeHNTW/3Y6bkaKnf6KlWDWk
         pnY7KtZWt7IZrrvmrBeiZwd49BiaKq7avYKi3s0KFzoDH00bcjFOZgROFEbEXpS5jzPQ
         jIUXJ8rgAmPtb46eI+LKeBonl26OwPwy3zaCs=
Received: by 10.239.149.196 with SMTP id k4mr156302hbb.1.1263244020346; Mon, 
	11 Jan 2010 13:07:00 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001111159270.17145@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136665>

--001485f7d62418f16f047ce9ebc9
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 11, 2010 at 21:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 11 Jan 2010, Fredrik Kuivinen wrote:
>> >
>> > Try a complex pattern ("qwerty.*as" finds the same line), and see if that
>> > too is slower than before. If that is faster than it used to be (with
>> > --no-ext-grep, of course), then it's strstr() that is badly implemented.
>>
>> Ah, yes, that's it. With the pattern "qwerty.*as" I get 2.5s with the
>> patch and 6s without.
>
> Ok, so on your machine, regcomp() is basically twice as fast as strstr().

Yes.

> Which is not entirely unexpected: I was actually surprised by strstr()
> being apparently so good on my machine. I do not generally expect things
> like that to be at all optimized for bigger working sets. Most common uses
> of strstr() are in short strings - not "strings" that are many kilobytes
> in size (the whole file).
>
> In fact, I suspect it works so well for me because in my version of glibc
> it's not just SSE-optimized: judging by the naming it's SSE4.2 optimized -
> so the case I see on my machine will _only_ happen on Nehalem-based cores
> (ie the new "Core i[357]" cpu's).
>
> It is entirely possible that strstr in general is a disaster.

Another option is to use memmem instead. As we know the length of the
buffer already it should be a slight improvement over strstr for
everyone. memmem may cause some portability problems though as it is a
GNU extension.

I get these results: (git-grep --no-ext-grep qwerty, best of five)

Junio's patch: 0:04.84
memmem (attached patch on top of Junio's): 0:02.91
regcomp/regexec (I changed is_fixed to always return 0, also on top of
Junio's): 0:02.02

- Fredrik

--001485f7d62418f16f047ce9ebc9
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4bqrf3x0

ZGlmZiAtLWdpdCBhL2dyZXAuYyBiL2dyZXAuYwppbmRleCA5NDBlMjAwLi5kMzQyNDdmIDEwMDY0
NAotLS0gYS9ncmVwLmMKKysrIGIvZ3JlcC5jCkBAIC0yNjQsMTMgKzI2NCwxNCBAQCBzdGF0aWMg
dm9pZCBzaG93X25hbWUoc3RydWN0IGdyZXBfb3B0ICpvcHQsIGNvbnN0IGNoYXIgKm5hbWUpCiB9
CiAKIAotc3RhdGljIGludCBmaXhtYXRjaChjb25zdCBjaGFyICpwYXR0ZXJuLCBjaGFyICpsaW5l
LCBpbnQgaWdub3JlX2Nhc2UsIHJlZ21hdGNoX3QgKm1hdGNoKQorc3RhdGljIGludCBmaXhtYXRj
aChjb25zdCBjaGFyICpwYXR0ZXJuLCBjaGFyICpsaW5lLCBjaGFyICplb2wsCisJCSAgICBpbnQg
aWdub3JlX2Nhc2UsIHJlZ21hdGNoX3QgKm1hdGNoKQogewogCWNoYXIgKmhpdDsKIAlpZiAoaWdu
b3JlX2Nhc2UpCiAJCWhpdCA9IHN0cmNhc2VzdHIobGluZSwgcGF0dGVybik7CiAJZWxzZQotCQlo
aXQgPSBzdHJzdHIobGluZSwgcGF0dGVybik7CisJCWhpdCA9IG1lbW1lbShsaW5lLCBlb2wgLSBs
aW5lLCBwYXR0ZXJuLCBzdHJsZW4ocGF0dGVybikpOwogCiAJaWYgKCFoaXQpIHsKIAkJbWF0Y2gt
PnJtX3NvID0gbWF0Y2gtPnJtX2VvID0gLTE7CkBAIC0zMzMsNyArMzM0LDcgQEAgc3RhdGljIGlu
dCBtYXRjaF9vbmVfcGF0dGVybihzdHJ1Y3QgZ3JlcF9wYXQgKnAsIGNoYXIgKmJvbCwgY2hhciAq
ZW9sLAogCiAgYWdhaW46CiAJaWYgKHAtPmZpeGVkKQotCQloaXQgPSAhZml4bWF0Y2gocC0+cGF0
dGVybiwgYm9sLCBwLT5pZ25vcmVfY2FzZSwgcG1hdGNoKTsKKwkJaGl0ID0gIWZpeG1hdGNoKHAt
PnBhdHRlcm4sIGJvbCwgZW9sLCBwLT5pZ25vcmVfY2FzZSwgcG1hdGNoKTsKIAllbHNlCiAJCWhp
dCA9ICFyZWdleGVjKCZwLT5yZWdleHAsIGJvbCwgMSwgcG1hdGNoLCBlZmxhZ3MpOwogCkBAIC02
NDYsNyArNjQ3LDcgQEAgc3RhdGljIGludCBsb29rX2FoZWFkKHN0cnVjdCBncmVwX29wdCAqb3B0
LAogCQlyZWdtYXRjaF90IG07CiAKIAkJaWYgKHAtPmZpeGVkKQotCQkJaGl0ID0gIWZpeG1hdGNo
KHAtPnBhdHRlcm4sIGJvbCwgcC0+aWdub3JlX2Nhc2UsICZtKTsKKwkJCWhpdCA9ICFmaXhtYXRj
aChwLT5wYXR0ZXJuLCBib2wsIGJvbCArICpsZWZ0X3AsIHAtPmlnbm9yZV9jYXNlLCAmbSk7CiAJ
CWVsc2UKIAkJCWhpdCA9ICFyZWdleGVjKCZwLT5yZWdleHAsIGJvbCwgMSwgJm0sIDApOwogCQlp
ZiAoIWhpdCB8fCBtLnJtX3NvIDwgMCB8fCBtLnJtX2VvIDwgMCkK
--001485f7d62418f16f047ce9ebc9--
