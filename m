From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Tue, 19 May 2009 06:16:29 +0200
Message-ID: <200905190616.30132.chriscool@tuxfamily.org>
References: <20090517153307.6403.73576.> <20090517153647.6403.44036.chriscool@tuxfamily.org> <7v3ab3exht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 06:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Gni-0001Bl-Qa
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 06:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbZESEST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 00:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbZESESS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 00:18:18 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:50291 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbZESESR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 00:18:17 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id E37954C8049;
	Tue, 19 May 2009 06:18:11 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id EFF104C8079;
	Tue, 19 May 2009 06:18:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3ab3exht.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119486>

Le lundi 18 mai 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Its parents are recursively unparsed too, because they might have
> > been changed. But its tree is not unparsed as it should not have
> > been modifed.
>
> It is a bug in any codepath if it used commit->tree without first
> checking if commit->parsed is true to begin with, so you could NULLif=
y
> commit->tree but that shouldn't make any difference.  I agree leaving=
 the
> tree object as-is would make sense.
>
> I am not convinced that unparsing all the _remaining_ parents recursi=
vely
> like your patch does is enough.  Isn't there a codepath that=20
>
>  - parses a commit A to find list of true parents X, Y, Z;
>
>  - iterates over that list and descend into one of these parents X, d=
oing
>    nasty things such as pruning its parents list after parsing it; an=
d
>
>  - decides to prune that parent X from the parent list, making the pa=
rent
>    list of A into Y and Z?
>
> After such a sequence, calling your unparse_commit(A) will unparse A =
and
> remaining parents of Y and Z, but will still leave X in the dirty sta=
te.

I agree that unparsing all the remaining parents recursively may not be=
=20
enough in some cases, but I don't know much about these cases. Is it on=
ly=20
when revs->prune is set?

I think it should be ok when checking that all good revs are ancestor o=
f the=20
bad rev, but I may be missing something.=20

It should be ok too when using "git replace" and/or grafts as the paren=
t=20
list of a commit should be changed before its parents are changed.

I also found the clear_commit_marks function that could be used when=20
checking ancestors so I will resend a patch series using it and without=
=20
patch 2/3. But I can continue to work on unparsing commits to improve=20
the "git replace" series. I need to find some test cases though, and I=20
cannot think of any interesting one right now.

By the way, when you say that you suspect an attempt to replace an obje=
ct=20
that is directly listed on the command line would not work very well wi=
th=20
the current replace series, is it related to the unparsing commit probl=
em?

Thanks,
Christian.
