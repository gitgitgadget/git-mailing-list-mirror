From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [RFC/GSoC] Proposal Draft: Unifying git branch -l, git tag -l,
 and git for-each-ref
Date: Sun, 29 Mar 2015 00:14:58 +0530
Message-ID: <5516F6AA.50103@gmail.com>
References: <55101080.90805@gmail.com> <20150326163748.GF6564@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 28 19:47:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybvlc-0004qO-4C
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 19:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbbC1SrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2015 14:47:24 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35097 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbC1SrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 14:47:23 -0400
Received: by pddn5 with SMTP id n5so14106445pdd.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0jXYHEze0Z0LIXXNieKiCXnp2FHztY+A7seEep55C2w=;
        b=JoBFJQrx5O2pwgnyvdCtd31yK5chaPS0B748RuBYXJG/NBfV6C1YZfUqScFE9miwjt
         9o4bac4hJEqJQ9h2R+DWNOuFqbUJqiY/EbaNw2sZ+AHm34YG6xpoCl4dX8LxuL38UZ7J
         pMOXuIZ5U1VChvyPCHISuzvirJwtCs6apqn7vYF5SiY999Q5BOkdrMOvPngp37HC8/Gg
         FbLhv0JnlOREzT8otpza9uYTmfgrEtyoEwhotudYzKJfClA1YMmxy7PeMDPtTZHF0KWR
         r9qs3AeaXtwsUpM6xSSePPKwiwRbtjEr8RAXm+XhpBS0bNOScOHpNj2U19oPWcHap1QV
         5OXw==
X-Received: by 10.70.131.227 with SMTP id op3mr46048814pdb.12.1427568443220;
        Sat, 28 Mar 2015 11:47:23 -0700 (PDT)
Received: from [192.168.43.24] ([106.76.202.79])
        by mx.google.com with ESMTPSA id jd5sm5722461pbd.35.2015.03.28.11.46.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2015 11:47:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150326163748.GF6564@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266421>


On 03/26/2015 10:07 PM, Jeff King wrote:
> On Mon, Mar 23, 2015 at 06:39:20PM +0530, karthik nayak wrote:
>
> > All three commands select a subset of the repository=E2=80=99s refs=
 and print the
> > result. There has been an attempt to unify these commands by Jeff K=
ing[3]. I
> > plan on continuing his work[4] and using his approach to tackle thi=
s
> > project.
>
> I would be cautious about the work in my for-each-ref-contains-wip
> branch. At one point it was reasonably solid, but it's now a year and=
 a
> half old, and I've been rebasing it without paying _too_ much attenti=
on
> to correctness. I think some subtle bugs have been introduced as it h=
as
> been carried forward.
>
> Also, the very first patch (factoring out the contains traversal) is
> probably better served by this series:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/252472
>
> I don't remember all of the issues offhand that need to be addressed =
in
> it, but there were plenty of review comments.
Thanks for the link, will go through that.
>
> > For extended selection behaviour such as =E2=80=98--contains=E2=80=99=
 or =E2=80=98--merged=E2=80=99 we could
> > implement these within
> > the library by providing functions which closely mimic the current =
methods
> > used individually by =E2=80=98branch -l=E2=80=99 and =E2=80=98tag -=
l=E2=80=99. For eg to implement
> > =E2=80=98--merged=E2=80=99 we implement a =E2=80=98compute_merge()=E2=
=80=99 function, which with the help of
> > the revision API=E2=80=99s will be able to perform the same functio=
n as =E2=80=98branch -l
> > --merged=E2=80=99.
>
> One trick with making a library-like interface is that some of the
> selection routines can work on a "streaming" list of refs (i.e., as w=
e
> see each ref we can say "yes" or "no") and some must wait until the e=
nd
> (e.g., --merged does a single big merge traversal). It's probably not
> the end of the world to just always collect all the refs, then filter
> them, then sort them, then print them. It may delay the start of outp=
ut
> in some minor cases, but I doubt that's a big deal (and anyway, the
> packed-refs code will load them all into an array anyway, so collecti=
ng
> them in a second array is probably not a big deal).
I think I noted this down while going through your implementation also.
You even mentioned this on the mailing list if I'm not wrong.
Will have to work out a design around this and think about it more.
>
> > For formatting functionality provided by =E2=80=98for-each-ref=E2=80=
=99 we replicate the
> > =E2=80=98show_ref=E2=80=99 function in =E2=80=98for-each-ref.c=E2=80=
=99 where the format is given to the
> > function and the function uses the format to obtain atom values and=
 prints
> > the corresponding atom values to the screen. This feature would all=
ow us to
> > provide format functionality which could act as a base for the =E2=80=
=98-v=E2=80=99 option
> > also.
>
> Yeah, I'd really like to see "--format" for "git branch", and have "-=
v"
> just feed that a hard-coded format string (or even a configurable one=
).
>
> > Although Jeff has built a really good base to build upon, I shall u=
se
> > his work as more of a reference and work on unification of the thre=
e
> > commands from scratch.
>
> Good. :)
>
> -Peff
>
Thanks for the Review/Tips.

Regards
-Karthik
