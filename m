From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git bisect issue
Date: Sat, 4 Apr 2009 21:48:31 +0200
Message-ID: <200904042148.32723.chriscool@tuxfamily.org>
References: <Pine.LNX.4.64.0904041307360.10230@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: malc@pulsesoft.com
X-From: git-owner@vger.kernel.org Sat Apr 04 21:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqBzw-00045f-J3
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 21:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbZDDTtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2009 15:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbZDDTtm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 15:49:42 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41882 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296AbZDDTtm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Apr 2009 15:49:42 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5DF5A940099;
	Sat,  4 Apr 2009 21:49:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 769FF94004B;
	Sat,  4 Apr 2009 21:49:31 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.LNX.4.64.0904041307360.10230@linmac.oyster.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115593>

Hi,

Le samedi 4 avril 2009, malc@pulsesoft.com a =E9crit :
> Hello,
>
> I was trying to run git bisect today and stumbled upon this:
>
> $ git bisect start
> error: pathspec 'bisect' did not match any file(s) known to git.
>
> .git had some (stale?) BISECT_XXX files in it, and removing them
> helped. One of those (BISECT_START) consisted of a single line:
> "bisect". If i remember correctly i used to have a bisect branch
> in this particular repo.

When you start bisecting, the current branch is saved in .git/BISECT_ST=
ART=20
so if you started a bisection in a branch named "bisect", then "bisect"=
 was=20
saved in ".git/BISECT_START". Then you probably didn't use "git bisect=20
reset" to stop bisecting, so the .git/BISECT_START file was not removed=
=2E

You probably deleted the "bisect" branch and later when you started a n=
ew=20
bisection, "git bisect" found the .git/BISECT_START file, so it thought=
=20
that you were currently bisecting.

It then tryed to abort the previous bisection by going back to branch s=
aved=20
in the .git/BISECT_START file, and that failed with the error message y=
ou=20
saw.

The error message could perhaps be improved with this patch:

diff --git a/git-bisect.sh b/git-bisect.sh
index e313bde..093736c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,7 +77,7 @@ bisect_start() {
        then
                # Reset to the rev from where we started.
                start_head=3D$(cat "$GIT_DIR/BISECT_START")
-               git checkout "$start_head" || exit
+               git checkout "$start_head" -- || exit
        else
                # Get rev from where we start.
                case "$head" in

it will give the following error message instead of the one you saw:

fatal: invalid reference: bisect

Regards,
Christian.
