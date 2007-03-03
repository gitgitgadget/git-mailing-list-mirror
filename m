From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Sat, 03 Mar 2007 05:11:26 -0800
Message-ID: <7vlkiebhfl.fsf@assigned-by-dhcp.cox.net>
References: <200703011206.47213.andyparkins@gmail.com>
	<es9aal$5gf$1@sea.gmane.org>
	<Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 14:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNU1X-0006bn-Pf
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 14:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbXCCNL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Mar 2007 08:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbXCCNL3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 08:11:29 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50401 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030234AbXCCNL2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 08:11:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303131127.MHHT2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 08:11:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WDBT1W00B1kojtg0000000; Sat, 03 Mar 2007 08:11:27 -0500
In-Reply-To: <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 2 Mar 2007 08:58:24 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41294>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 2 Mar 2007, Jakub Narebski wrote:
>
>> Andy Parkins wrote:
>>=20
>> > + - prettyfilter
>> > + =C2=A0 Run by git-cat-file or git-show when content is being pre=
tty-printed
>> > + =C2=A0 for display to the user. =C2=A0If no prettyfilter is set,=
 then it should
>> > + =C2=A0 default to outfilter.
>>=20
>> I'd rather have plumbing operate without filters (if it is possible)=
,
>> so git-cat-file would not run prettyfilter, and git-show would run i=
t.
>
> That really sucks. I do "git show xyz > filname" all the time, and wh=
ile=20
> it's been about diffs and commits, I could imagine doing the same thi=
ng=20
> for things like "git show v2.6.17:Documentation/logo.gif > some.gif" =
too.
>
> Yes, I know could do "git cat-file -p .." instead, but since we added=
 "git=20
> show", and made it do the Right Thing (tm) for blobs, I've come to us=
e it=20
> more (which is as it should be: "cat-file" is low-level plumbing, whi=
le=20
> "git show" is what you'd expect users to use.
>
> So I really think that the issue here is that the *pager* should do t=
he=20
> right thing...

Sorry, but I do not think that would work because of the way we
setup our pager.  The original process turns into the PAGER and
child ships the data to it.

	$ git show -s master maint :t/test4012.png

I do not particularly think the prettyfilter is useful in
practice (it was just a fun toy I did to convince me that I can
use it for things other than input/output munging), but at least
we could make it a bit more usable by this, on top of 'pu':

diff --git a/builtin-log.c b/builtin-log.c
index 86062d3..bc26358 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -116,7 +116,7 @@ static int show_object(const unsigned char *sha1, c=
onst char *path, int nohead)
 	if (size <=3D offset)
 		goto finish;
=20
-	if (path) {
+	if (pager_in_use && path) {
 		const struct pathattr *a =3D pathattr_lookup(path);
 		if (a && a->pretty) {
 			pretty =3D a->pretty;
