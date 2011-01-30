From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Handle rename of case only, for Windows
Date: Sun, 30 Jan 2011 03:22:24 +0100
Message-ID: <4D44CB60.8000506@lsrfire.ath.cx>
References: <1296344717.25999.1417928123@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 30 03:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjMwd-00029A-EH
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 03:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab1A3CXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 21:23:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:57442 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab1A3CXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 21:23:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PjMwT-00026t-Tp
	for git@vger.kernel.org; Sun, 30 Jan 2011 03:23:05 +0100
Received: from p4ffdb056.dip.t-dialin.net ([79.253.176.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 03:23:05 +0100
Received: from rene.scharfe by p4ffdb056.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 03:23:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4ffdb056.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1296344717.25999.1417928123@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165677>

Am 30.01.2011 00:45, schrieb Tim Abell:
>> Hmm, not so good. st_ino is always 0 on Windows, so this would make
>> false positives, no?
>=20
> I tested this on windows 7 under cygwin (which is what I have
> available) and st_ino reports real numbers for me, I also tested that
> attempting to overwrite another file without --force still fails and
> added a new test case for this scenario. I have now made sure that if
> zero is returned then git won't accidentally overwrite other files as
> I hadn't thought of this before. So this patch shouldn't be
> regressive even if other versions of windows or other filesystems
> don't provide valid inode data.

On MinGW on Vista st_ino is zero, git mv refuses to overwrite and the
added case change test fails as a consequence.

>> I wonder if we can make lstat_case() that would only return 0 if it
>> matches exactly the filename, even on FAT. FindFirstFile/FindNextFil=
e
>> should return true file name, I think. If not, we can make
>> lstat_case() take two paths (src and dst) and move all inode
>> comparison code in there. Much cleaner.
>=20
> I'm afraid this is a bit beyond me at the moment, but I'm fairly
> happy with the solution I have. Thanks for the feedback though.

Hmm, if the patch only works for Cygwin and maybe OS X it's a step
forward, I guess.  A more complete solution would be better, of course.

> diff --git a/builtin/mv.c b/builtin/mv.c
> index cdbb094..c2f726a 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -165,17 +165,27 @@ int cmd_mv(int argc, const char **argv, const c=
har *prefix)
>  		} else if (cache_name_pos(src, length) < 0)
>  			bad =3D "not under version control";
>  		else if (lstat(dst, &st) =3D=3D 0) {
> -			bad =3D "destination exists";
> -			if (force) {
> -				/*
> -				 * only files can overwrite each other:
> -				 * check both source and destination
> -				 */
> -				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
> -					warning("%s; will overwrite!", bad);
> -					bad =3D NULL;
> -				} else
> -					bad =3D "Cannot overwrite";
> +			/* If we are on a case insensitive file system (windows) and we a=
re only
> +			 * changing the case of the file then lstat for the destination w=
ill
> +			 * return !=3D 0 because it sees the source file.
> +			 * To prevent this causing failure, lstat is used to get the inod=
e of the src
> +			 * and see if it's actually the same file as dst. If the inode =3D=
=3D 0 then
> +			 * we can't tell whether it is the same file so we fail regardles=
s. */

Can you make the lines 80 characters long at most?  This subtly helps
avoiding excessive levels of indentation by encouraging to factor out
nice and small functions.

> +			struct stat src_st;
> +			lstat(src, &src_st);

Shouldn't you check the return value of this call?  OK, the source
probably always exists, but still.  Oh, we actually know that because
that's the first lstat() call in this for loop.  You can reuse its
result instead of calling the function again.

> +			if (src_st.st_ino =3D=3D 0 || src_st.st_ino !=3D st.st_ino) {

It may be nice to avoid adding another level of indentation by combinin=
g
this if with the preceding one.

> +				bad =3D "destination exists";
> +				if (force) {
> +					/*
> +					 * only files can overwrite each other:
> +					 * check both source and destination
> +					 */
> +					if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
> +						warning("%s; will overwrite!", bad);
> +						bad =3D NULL;
> +					} else
> +						bad =3D "Cannot overwrite";
> +				}
>  			}
>  		} else if (string_list_has_string(&src_for_dst, dst))
>  			bad =3D "multiple sources for the same target";

Ren=E9
