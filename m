From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 17:36:48 +0200
Message-ID: <CABPQNSY=X8HG__vcEncdcgjT4fvqaC1gX_5_QH4n0+bX0tNT6g@mail.gmail.com>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org> <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vfr@lyx.org, git@vger.kernel.org, gitster@pobox.om
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 17:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeTA1-0004ou-4a
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 17:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab2FLPha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 11:37:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49965 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab2FLPh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 11:37:28 -0400
Received: by pbbrp8 with SMTP id rp8so963957pbb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=2E5gDTC+O0c/PQdit5Yv/nOh1EGUwd+B81WNylx2L6g=;
        b=Qjcn4CdQ9R75lusR+Dc0to7jVGwNypxYuPFAlf6O8+h6opVIVxXA/+/nBt/nCagGOL
         U8Q5AnI5xXMsOwYmgP14Y77dMTP4NJfhvOT41Ns6NBtTulHPqy9o8s2ijWG0465WmemK
         H+5lgDWBQhGQZwPM76qj25+4emEp+SzRwrzR1pRmi1hUeAyxaCAvWgb+J57EkNZN/BW3
         GkXSXLiNegh2ohlIrP4gfaolyAroNbOU7/2gwBFSfV9aLbHdASZHGAqiN0ttUG8yA8Km
         EtKTAQk/022h9oq27taHVW7y4hj7p2RZrt8zTq7omvZqg7Xiq0XbKLIa8AjBev3rnphI
         +I9w==
Received: by 10.68.194.105 with SMTP id hv9mr39638247pbc.126.1339515448290;
 Tue, 12 Jun 2012 08:37:28 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 12 Jun 2012 08:36:48 -0700 (PDT)
In-Reply-To: <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199804>

On Mon, Jun 11, 2012 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> vfr@lyx.org writes:
>
>> From: Vincent van Ravesteijn <vfr@lyx.org>
>>
>> GIT-BUILD-OPTIONS defines PERL_PATH to be used in the test suite. On=
ly a
>> few tests already actually use this variable when perl is needed. Th=
e
>> other test just call 'perl' and it might happen that the wrong perl
>> interpreter is used.
>>
>> This becomes problematic on Windows, when the perl interpreter that =
is
>> compiled and installed on the Windows system is used, because this p=
erl
>> interpreter might introduce some unexpected LF->CRLF conversions.
>>
>> This patch makes sure that $PERL_PATH is used everywhere in the test=
 suite
>> and that the correct perl interpreter is used.
>>
>> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
>> ---
>
> There was already this discussion:
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/132560/=
focus=3D132561
>
> which basically dismissed effort along this line with "If the perl
> in your PATH is so broken that it can't be used for simple helpers,
> then you should fix your PATH."
>

This way of looking at it has the flaw that it might not be the Perl
that is "broken", it could be that Git is the guilty one for creating
problems.

The reason in this case is that pipes are text-mode by default, which
means newlines get translated between LF and CRLF on Windows. However,
Git is largely written for Unixy systems where there's no
CRLF-translation going on.

Because a lot of the internal Git protocols assume they can send
binary data over stdin/stdout by default, we set these to binary mode
on startup in Git for Windows to avoid. This cause problems with
external tools like Perl, but we currently ship an MSYS version of
perl where text-mode means LF-newlines, and thus no translation.

Having an MSYS version of Perl in PATH is "broken" in the Windows
world, so it's THIS Perl that people might want to keep out of their
PATH.

That being said, it should be possible (and probably desirable) to
have a different PATH for the MSYS environment. But I'm not sure how
well this works for people who run Git for Windows from cmd, as
opposed to from MSYS.

In the long run, it would probably be better to default to text-mode,
and explicitly switch between text and binary-mode when needed. But
for now, the binary-pipe-hack "almost works" ;)
