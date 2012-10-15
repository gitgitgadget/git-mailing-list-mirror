From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: push race
Date: Mon, 15 Oct 2012 10:29:08 -0400
Message-ID: <507C1DB4.2010000@xiplink.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com> <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNlnY-0003Wa-N9
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 16:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab2JOOha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 10:37:30 -0400
Received: from smtp152.dfw.emailsrvr.com ([67.192.241.152]:33410 "EHLO
	smtp152.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2JOOh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 10:37:29 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2012 10:37:29 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 156792D0B1D
	for <git@vger.kernel.org>; Mon, 15 Oct 2012 10:29:32 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp130.ord.emailsrvr.com (smtp130.ord.emailsrvr.com [173.203.6.130])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id E93372D09FE
	for <git@vger.kernel.org>; Mon, 15 Oct 2012 10:29:31 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id C1D59380160;
	Mon, 15 Oct 2012 10:28:51 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 68467380168;
	Mon, 15 Oct 2012 10:28:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207750>

On 12-10-15 10:09 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Oct 15, 2012 at 11:14 AM, Angelo Borsotti
> <angelo.borsotti@gmail.com> wrote:
>> Hello,
>=20
> FWIW we have a lot of lemmings pushing to the same ref all the time a=
t
> $work, and while I've seen cases where:
>=20
>  1. Two clients try to push
>  2. They both get the initial lock
>  3. One of them fails to get the secondary lock (I think updating the=
 ref)
>=20
> I've never seen cases where they clobber each other in #3 (and I woul=
d
> have known from "dude, where's my commit that I just pushed" reports)=
=2E
>=20
> So while we could fix git to make sure there's no race condition such
> that two clients never get the #2 lock I haven't seen it cause actual
> data issues because of two clients getting the #3 lock.
>=20
> It might still happen in some cases, I recommend testing it with e.g.
> lots of pushes in parallel with GNU Parallel.

Here's a previous discussion of a race in concurrent updates to the sam=
e ref,
even when the updates are all identical:

http://news.gmane.org/find-root.php?group=3Dgmane.comp.version-control.=
git&article=3D164636

In that thread, Peff outlines the lock procedure for refs:

        1. get the lock
        2. check and remember the sha1
        3. release the lock
        4. do some long-running work (like the actual push)
        5. get the lock
        6. check that the sha1 is the same as the remembered one
        7. update the sha1
        8. release the lock

Angelo, in your case I think one of your concurrent updates would fail =
in
step 6.  As you say, this is after the changes have been uploaded.  How=
ever,
there's none of the file-overwriting that you fear, because the changes=
 are
stored in git's object database under their SHA hashes.  So there'll on=
ly be
an object-level collision if two parties upload the exact same object, =
in
which case it doesn't matter.

		M.
