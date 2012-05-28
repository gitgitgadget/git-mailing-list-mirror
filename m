From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Mon, 28 May 2012 10:26:33 +0200
Message-ID: <20120528082633.GA6449@tgummerer>
References: <20120523122135.GA58204@tgummerer.unibz.it>
 <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer>
 <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
 <20120527090407.GD86874@tgummerer>
 <7vbolaotwj.fsf@alter.siamese.dyndns.org>
 <CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 10:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYvHv-00067T-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 10:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab2E1I0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 04:26:39 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48103 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab2E1I0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 04:26:38 -0400
Received: by weyu7 with SMTP id u7so1786585wey.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fP+PbTE/CnHBIWtxU8ky2nkzEoecByRzwfaygN9+L58=;
        b=X2dLiO2NAY52KjQmi++QBgYwOXNxkmJ3yq0k9UqdHA9Lyu9dcoJP0zrr9sxoP/ctRY
         8IZ65OpQwBiDaP70HMmpOA9X5V6FI3WccUHsWDJ6ljJOJZ28Aiv/xoO8ua7HK2U30OQq
         bVgtdRH3oWq9DYcnR0e08KItUzee3X2q9UzuZA70qvat/2kAiayfpLSx6ULDheq9ZTwn
         vnxmUs6Fxvtvtla5ZIKp4RUPWrhQ3kHSq+jEY3wNRpxQZCZ8e+taT8h5ppDmkW2mDXCf
         yQMngakfKCi/uVsWJD1l7T66cmzcpi+AhERQjkZXjthzv89aU3NHJbpcUgjYOmZU6SI5
         15uA==
Received: by 10.216.228.232 with SMTP id f82mr4012938weq.211.1338193596904;
        Mon, 28 May 2012 01:26:36 -0700 (PDT)
Received: from localhost (host172-20-dynamic.4-87-r.retail.telecomitalia.it. [87.4.20.172])
        by mx.google.com with ESMTPS id gv4sm31154930wib.8.2012.05.28.01.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 01:26:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198634>



On 05/27, Nguyen Thai Ngoc Duy wrote:
> On Sun, May 27, 2012 at 4:27 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> >>> No, read_index_from would go through the normal tree->list conver=
sion.
> >>> What I'd like to see is what it looks like when a command accesse=
s
> >>> index v5 directly in tree form, taking all advantages that tree-f=
orm
> >>> provides, and how we should deal with old index versions while st=
ill
> >>> supporting index v5 (without losing tree advantages)
> >>
> >> Ah ok, thanks for the clarification, I understand what you meant n=
ow.
> >> I think however, that it's not very beneficial to do this conversi=
on
> >> now. git ls-files needs the whole index file anyway, so it's proba=
bly
> >> not a very good test.
> >
> > Think about "git ls-files t/" and "git ls-files -u".
>=20
> Or harder things like "ls-files -- 't/*.sh'"
>=20
> > The former obviously does *not* have to look at the whole thing, ev=
en
> > though the current code assumes the in-core data structure that has=
 the
> > whole thing in a flat array. =C2=A0IIRC, you had unmerged entries t=
ucked at the
> > end outside the main index data, so the latter is also an interesti=
ng
> > demonstration of how wonderful the new data format could be.
>=20
> and "ls-files -uc" can show how you combine unmerged entries back.
> There's also entry existence check deep in "ls-files -o" that you can
> show how good bsearch on trees is, though that might be going too far
> for an experiment because the call chain is really deep, way outside
> ls-files.c:
>=20
> show_files (builtin/ls-files.c)
>  fill_directory (dir.c)
>   read_directory
>    read_directory_recursive
>     treat_path
>      treat_one_path
>       treat_directory
>        directory_exists_in_index
>         cache_pos_name (read-cache.c)
>=20
> I just want to make sure that by exercising the new format with some
> real problems, we are certain we don't overlook anything in designing
> the format (or else could be fixed before finalizing it).

Ok, that makes sense. I just thought of git ls-files alone, for which
it wouldn't make a lot of sense. I'll try implementing this as next
step.
