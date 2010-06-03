From: Simo Melenius <simo.melenius@iki.fi>
Subject: Re: Bug? "git branch" failing to list all branches
Date: Thu, 3 Jun 2010 09:00:14 +0300
Message-ID: <AANLkTinCNgsIf_MsiysfphKm3MCW2Uio_xiemfDZraH7@mail.gmail.com>
References: <AANLkTimTOucIfzSxsYNvmML7MALwj0E3BUASIIKIN1lN@mail.gmail.com>
	<20100603042218.GA21254@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 08:00:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK3Td-0008Qb-TR
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 08:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab0FCGAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 02:00:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47177 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab0FCGAR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 02:00:17 -0400
Received: by gye5 with SMTP id 5so2854750gye.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=MHVIiqXnp0sw8K4wNi0UvjZJ7NxF4G0cqgsZnd8uTTg=;
        b=r4u6xsGIvVQDaWLJ1/QZoB4FVYU40IcDmJ3lSXFnSGx25c73a/wl+ySmuFtpFEwYuI
         wFUPt4fgoaUKlbzQTdyYoHW3HOCy42ZDCLUdLtbNUpUJHeXP+gXkxj1/tjo9kLBLDh8n
         kESlNLpd9SCxYL6IvhytH5M/gnZcBgbNwYJ40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=LuwtHuNZ7eDrlb2XHJ/U35ufYlpy0/pd+oFBtpNvwEq7hcrfl8jE8NyYh+/7MDEByd
         vdwcZjJzgVZ47b654i91CAI5ws0CKqUzSy3ZrpPuQR4MYbt5b8zYaOemU9msdOT0cYBR
         gnEVxJT2OZ3zIgDA/zeOW7W02pThE3/uJhU8Q=
Received: by 10.150.55.33 with SMTP id d33mr9154465yba.58.1275544814351; Wed, 
	02 Jun 2010 23:00:14 -0700 (PDT)
Received: by 10.150.186.2 with HTTP; Wed, 2 Jun 2010 23:00:14 -0700 (PDT)
In-Reply-To: <20100603042218.GA21254@progeny.tock>
X-Google-Sender-Auth: PJ_RpYjdwjPHzPtFKNFq_9Rtbd8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148293>

On 3 June 2010 07:22, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> I noticed this because "git branch -a" and "git branch -av"
>> unexpectedly gave a very different output.
> Hmm --- so the error message must not have been very visible...

I have been working with such set of repositories that most of them
have one or two broken refs. I probably saw it but didn't care because
it was a known issue. If I had called git branch from a script and
piped the output somewhere while relying on exit status, I wouldn't
have noticed anything.

> Will this make =E2=80=98git branch=E2=80=99 exit with status zero? =C2=
=A0Scripts and people
> with fancy prompts benefit from a nonzero exit status.

My change doesn't change the current behaviour. At least git 1.7.0.4
didn't give a nonzero exit status either. It would be good if it did.

I could add that to my patch. I'm, however, unsure of what's the best
way to communicate the error from append_ref() to cmd_branch(). A
static variable in branch.c would of course do.

However, if the git codebase has somewhere a global mechanism for
signalling errors by, for example, raising some flag when error() is
called, using that mechanism would be better, right?

> If I have 37 branches and an error is encountered looking up one of
> them, with this patch the error message will scroll off the screen.
> Is this worth worrying about? =C2=A0It depends on what the usual caus=
es for
> broken branch refs are and whether they require attention or can be
> safely ignored.

Since this only concerns the printing of branches, often for
interactive viewing or bash completion, and does not affect any of the
operations that modify the repository, I think it's sufficient that
the error message is still readable from stderr for those who are
interested.

> One other thought: this patch is line-wrapped, which means it cannot
> be mechanically applied. =C2=A0Documentation/SubmittingPatches has so=
me
> tips on sending a patch unmangled (and please also see the section
> labelled "Sign your work").

Yeah, I have a kosher patch locally. I just copypasted the diff part
here for discussion.


Simo

--=20
() Today is the car of the cdr of your life.
/\ http://arc.pasp.de/
