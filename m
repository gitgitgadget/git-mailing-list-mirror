From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Tue, 24 Aug 2010 23:31:31 -0600
Message-ID: <AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 07:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8aN-0005Hj-BX
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab0HYFbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 01:31:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33719 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab0HYFbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 01:31:32 -0400
Received: by fxm13 with SMTP id 13so97038fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AdP1b5YuUeXWdaUm99gNaVDvi043bzhmcNMyE6DdoBQ=;
        b=UuoVKxOanccfhMPalLtpuccQ8SLoVEEfbkjZKnO5XXvmf1eoH8g5U25Rvxjs0LpGjF
         FnOtBBRJ97SiXgqc1+5PdO+HHrL/NhMwir2lkI+9zuLLKsSenOCOnAh/1mCpN6haoo8d
         GHVpavueWU76hfAXDAwqfadAtGz82Vu9C95Jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M0NeNKq2ORlm3g+cStmshwFStjparJTD6S68ikWxARsEKEMNfJ05HtAsbXA+SU1ri5
         Np8A0Nm4oWxJYKQl6N5S/a82Uo5G6Qq/UF9QIj6SgijU2AM6XnZD4uaxmanV9Y3KqU5p
         fj9Djh7dsJRS8ufF3ZtXQaXF2jKrbYJFfPR68=
Received: by 10.223.113.12 with SMTP id y12mr6943928fap.36.1282714291649; Tue,
 24 Aug 2010 22:31:31 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 22:31:31 -0700 (PDT)
In-Reply-To: <AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154421>

Hi,

On Tue, Aug 24, 2010 at 11:21 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Wed, Aug 25, 2010 at 2:37 PM, Elijah Newren <newren@gmail.com> wro=
te:
<snip>
>> I'm not sure I follow. =C2=A0Are you allowing changes outside the na=
rrow
>> tree to occur? =C2=A0If you're not, I would have assumed that repeat=
ed
>> pulls just work, without any need to talk to the server, using a
>> resolve-like strategy (with no special rename detection).
>
> I don't. But I can't stop all other users (who use full repos) change
> outside the narrow tree and push their changes back upstream. When
> narrow user pulls from upstream again, the tree outside narrow tree
> might be not the same as before.

Sure, they will modify paths outside your subtree, but you know that
you didn't do so.  So if you neglect renames then the situation is
pretty simple:

Merge-side: ancestor    you         upstream
            --------    --------    --------------
Sha1sum:    ancestor    ancestor    new-stuff

Which could be true for either a file or a tree.  Either way, if you
ignore renames, then the trivial merge is 'new-stuff' for any such
blob/tree.  (Yeah, you'd have to create a new merge algorithm that
does 'trivial' merges at tree levels in addition to file levels, but
the concept is relatively simple at least.)

After your merge, a subsequent pull would look like this at the same
file/tree path:

Merge-side: ancestor    you         upstream
            --------    --------    --------------
Sha1sum:    new-stuff   new-stuff   newer-stuff

=46or which the resolution would be 'newer-stuff' (again, ignoring the
problems that renames could cause, which I discussed elsewhere).

Unless, of course, I'm missing something still...
