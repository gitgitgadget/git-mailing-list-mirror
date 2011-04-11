From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 14:37:49 +0530
Message-ID: <20110411090747.GD28959@kytes>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <20110410194739.GC28163@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 11:08:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9D74-00077i-1T
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 11:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab1DKJIm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 05:08:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37725 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab1DKJIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 05:08:41 -0400
Received: by iyb14 with SMTP id 14so5415067iyb.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MvPQgMQUnsk84KPVtO1OpY+/1BB36rnPXNvMu6XSt9Y=;
        b=EBEKT/FXlkghuYKmGtMQX5L4xPiJIMy22U6TYvdLom7bvlVHnHyy2Z+XU6ydZFNtIq
         0sVMbxV0bsbPVnjtl+VcTcpL3h4LKNgf5geqqd1G5RpPrdUfygswNp4+FejsUV3VLot+
         lL+iSxRkue7GTccbY1LMLincXAy4C5mn7u4sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Wzb5USmdVARye/5IqGAptiua1ODMyYkB0/MLWk1kZ88kDqhrA5cYNaPYyopwJjYL9V
         oL0Kuy7UsZexwW/1SvwiQ98pPNQg+Q8kyKGx7kuF6ZMM29ZLa1fYj7nyIK3UOIncMZHN
         y9C/9OJhOjoIAuy53804V0moDRmmYX3AsacZA=
Received: by 10.231.215.140 with SMTP id he12mr3277677ibb.57.1302512920996;
        Mon, 11 Apr 2011 02:08:40 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id hc41sm4093311ibb.47.2011.04.11.02.08.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 02:08:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110410194739.GC28163@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171318>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > 0. Is the general flow alright?
>=20
> Not sure --- I don't have the big picture.  Could you give a quick
> summary of the flow in the cover letter ("patch 1 does such-and-such,
> so patch 2 can do such-and-such, leading to...") to the next revision=
,
> and quick explanations of the purpose (i.e., why we should want each
> change) in the individual change descriptions?

Agreed.  I'll ask again after the next re-roll.

> > 1. Is it okay to use this kind of adaptive error handling (calling
> > 'die' in some places and returning error in other places), or shoul=
d
> > it be more uniform?
>=20
> 'die' gets used in two ways (well, one way really):
>=20
>  - to say "there is no sane way to recover from this failure".  For
>    example, xmalloc dies if even after trying to free up memory,
>    malloc still could not satisfy the request.
>=20
>  - to say "so far we've been too lazy to implement recovery from
>    this failure".  Or "while we *could* recover from this failure, no
>    one has needed it, so let's not --- that code would just bitrot."
>=20
> Therefore a mixture of 'die' and 'return error' seems inevitable.  Th=
e
> dangerous mixtures to avoid are those likely to trip up callers (e.g.=
,
> if all code paths 'return error' except one edge case).

My thoughts precisely.  I was worried about what would happen in
future when Git is completely lib'ified, but I suppose it makes little
sense to think about that now.

> > 2. In 11/11, I've used cmd_revert and cmd_rerere.  This is highly
> > inelegant, mainly because of the command-line argument parsing
> > overhead.  Re-implementing it using more low-level functions doesn'=
t
> > seem to be the way to go either: for example, 'reset --hard' has so=
me
> > additional logic of writing HEAD and ORIG_HEAD, which I don't want =
to
> > duplicate.  Should I work on reworking parts of 'rerere.c' and
> > 'revert.c', or is there some other way?
>=20
> See "git log --grep=3Dlibify" for examples.  Isn't rerere already
> libified?  Ah, you need "rerere clear" --- I think a rerere_clear
> function alongside rerere_forget et al would make sense.

Done in [1].

> More generally, it should be feasible to expose a nice, simple API fo=
r
> any functionality you need (with params struct if necessary, etc).
> That's how many of the current APIs (revision walking, diffcore, ...)
> came about.

I see.  Okay, I'll see if it makes sense to craft an API for rebase.

> > 3. From the format of the TODO and DONE files, one more thing shoul=
d
> > be clear- I'm trying to stick to a slight variation of the 'rebase =
-i'
> > format.  This part will go into the sequencer.  Then I'll use a
> > cherry-pick specific file to keep the command-line options.  Yes, I=
'm
> > trying to work on Daniel's idea [3] from the very start.  Is this a
> > good idea?
>=20
> This is still bouncing in my head.  I think I like it --- is the idea
> that some day you could put commands like
>=20
> 	am topic.mbox
>=20
> in your insn sheet, or do nested rebases with a --force-nested option=
?
> That does sound useful.  How would one request "skip to the next
> operation in the outer rebase" on the command line?  This is starting
> to feel like a debugger.

I'll respond to this later in the thread, since Daniel has already
said something.  I just need help with crafting a nice instruction
sheet now -- please join the discussion at [2].

> > 4. I have a feeling that I've broken translation strings.  Is there=
 a
> > README, plus a bunch of tests I can run to make sure that I've not
> > broken anything?
>=20
> If you put "GETTEXT_POISON =3D YesPlease" in your config.mak, the
> translations will be translated to gibberish when the GIT_GETTEXT_POI=
SON
> envvar is set, so you can use the test suite as a sanity check.
> "make pot" can be used to get the translation template that
> translators will see.
>=20
> As for a readme explaining how to use _, N_, and Q_, yes, I think tha=
t
> would be useful.  I think =C6var's series has something like that (bu=
t
> targetted at translators) later on; it might make sense to prod him o=
r
> me for a simpler explanation can be merged immediately.  Until then,
> there is "git log gettext.h".

Thanks!  Someone should really document this whole translations thing.

-- Ram

[1]: http://article.gmane.org/gmane.comp.version-control.git/171314
[2]: http://thread.gmane.org/gmane.comp.version-control.git/171255/focu=
s=3D171307
