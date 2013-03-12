From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Updating not actual branch
Date: Tue, 12 Mar 2013 19:19:36 +0400
Message-ID: <20130312191936.d25cbca4934a8c92b7ec0542@domain007.com>
References: <006501ce1f24$94636a30$bd2a3e90$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jan =?UTF-8?B?UGXFoXRh?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Tue Mar 12 16:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFQzp-0006xa-FM
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 16:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3CLPTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 11:19:43 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60853 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab3CLPTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 11:19:42 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r2CFJasd023188;
	Tue, 12 Mar 2013 19:19:38 +0400
In-Reply-To: <006501ce1f24$94636a30$bd2a3e90$@certicon.cz>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217965>

On Tue, 12 Mar 2013 14:22:00 +0100
Jan Pe=C5=A1ta <jan.pesta@certicon.cz> wrote:

> I have a question if there is a posibility tu update a branch which
> is not actual working copy.
>=20
> I have following situation:
>=20
> A - B - C - I - J                       master
>                \ - D - E - F               feature 1
>                                  \ G - H     feature 2 (working copy)
>=20
> I would like tu update whole tree with latest changes in master
>=20
> A - B - C - I - J                                              master
>                            \ - D* - E* - F*                  feature =
1
>                                                    \ G* - H*
> feature 2 (working copy)
>=20
>=20
> Is there some way how to do it without swithing to each branch and
> update them manually?

It's partially possible to do: you are able to forcibly fetch a remote
object into any local branch provided it's not checked out.  Hence, in
your case you'll be able to update any branch excapt for "feature 2".

To do this, you could use the explicit refspec when fetching, like this=
:

$ git fetch origin +src1:dst1 '+blooper 1:feature 1'

(Consult the `git fetch` manual for more info on using refspecs.)

One possible downside is that I'm not sure this approach would play
nicely with remote branches, if you have any.  I mean, direct fetching
into local branches will unlikely to update their matching "upstream"
remote branches.

So supposedly a better way to go would be to write a script which would
go like this:
1) Do a simple one-argument `git fetch <remotename>` to fetch from
   the specified remote and update its remote branches.
2) Run `git for-each-ref`, and for each local branch found first check
   whether it's currently checked out (that is, HEAD points at it)
   and ignore the branch if it is; otherwise do `git update-ref`
   updating the branch pointer from its upstream branch -- referring to
   that using the <ref>@{upstream} syntax.
   (Consult the gitrevisions manual for more info on this syntax.)
