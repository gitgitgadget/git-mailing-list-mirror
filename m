From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH, RFC] diff: add option to show context between close chunks
Date: Mon, 20 Oct 2008 20:06:25 +0200
Message-ID: <48FCC8A1.5090109@lsrfire.ath.cx>
References: <48FB757B.9030105@lsrfire.ath.cx> <48FC9685.8030704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:42:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrzAU-0007eL-S5
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 20:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbYJTSGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2008 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbYJTSGi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 14:06:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:50527 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbYJTSGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 14:06:34 -0400
Received: from [10.0.1.101] (p57B7C6D1.dip.t-dialin.net [87.183.198.209])
	by india601.server4you.de (Postfix) with ESMTPSA id 2EC142F8057;
	Mon, 20 Oct 2008 20:06:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48FC9685.8030704@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98733>

Johannes Sixt schrieb:
> Why can't you just use -U6 instead instead of --inter-chunk-context=3D=
3? If
> this is intended for human consumption anyway, then you can just as w=
ell
> increase the overall number of context lines: You get extra context l=
ines
> in the places where hunks are not fused, but this cannot be a disadva=
ntage
> for the targeted audience.

The extra lines _are_ a disadvantage for me, since each chunk gets them
while only close ones need them -- that's wasted space.  The intent is
to save time by not having to apply and rediff a patch on a mailing lis=
t
in order to see the hidden text; part of the savings would be lost if
the reader had to skip over extra lines.

Besides, this option is probably most useful if set by default on
machines not controlled by me.  E.g. I wouldn't want to change an optio=
n
on a gitweb page, I'd want to get fused chunks by default.  I wouldn't
want to write "best viewed with -U6" in a patch description, I'd want i=
t
to just work (e.g. for gitk users).

I have to admit my main motivation was that one line gap, where a chunk
header hid an interesting line of context.  Showing it didn't change th=
e
length of the patch, so I found this to be a sad wastage.

Optimizing patches for readability makes sense since they are such an
important part of our communication here.  I think --i-c-c=3D1 results =
in
an obvious win without much of a downside.  I was surprised to find tha=
t
almost 4% of the chunks in git 1.6.0 would be eliminated by that option=
:

   $ git log -p v1.6.0 | grep -c '^@@ '
   60544
   $ git log -p v1.6.0 --inter-chunk-context=3D1 | grep -c '^@@ '
   58471

But perhaps a higher value would be even better?

   $ git log v1.6.0 | wc -l
   225441
   $ git log -p v1.6.0 | wc -l
   1736188
   $ git log -p --inter-chunk-context=3D10 v1.6.0 | wc -l
   1779048
   $ git log -p -U8 v1.6.0 | wc -l
   2214448

Well, I don't know if those patches are easier to read (haven't looked
at them), but I imagine that some related changes are presented with th=
e
full context between them (e.g. changes to loop header and footer,
function signature and body).  The numbers only show that it's
affordable (3% more lines with -i-c-c=3D10, 30% more lines with the
comparable -U8).

(Why 10?  With the default of -U3, a chunk is 6 lines of context plus a=
t
least one line of actual change.  Two chunks are at least 14 lines long=
,
thus only 10 more fit into 24 lines, i.e. a terminal window..)

Ren=E9
