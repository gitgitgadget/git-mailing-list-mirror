From: Christian Couder <chriscool@tuxfamily.org>
Subject: Migrate bisect to C (was: [PATCH 1/7] strbuf: add "include_delim" parameter to "strbuf_split")
Date: Sat, 14 Mar 2009 08:46:17 +0100
Message-ID: <200903140846.17599.chriscool@tuxfamily.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org> <200903130702.01039.chriscool@tuxfamily.org> <7vfxhhj4mh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 08:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiOcS-0002ai-JO
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 08:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbZCNHrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 03:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZCNHrS
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 03:47:18 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:56233 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbZCNHrR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 03:47:17 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 75F0A4B0026;
	Sat, 14 Mar 2009 08:47:04 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 7F1FE4B0113;
	Sat, 14 Mar 2009 08:47:02 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vfxhhj4mh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113241>

Le vendredi 13 mars 2009, Junio C Hamano a =E9crit :
>
> I also do not agree that you have to keep list of skip both in shell =
and
> rev-list when you go the route I suggested.  I think a separate bisec=
t.c
> you did is a good first step to make not just the bisect machinery bu=
t
> the whole bisect command into a built-in, and even if we do not do th=
e
> full rewrite in C in one go, moving these "shell script reads from
> refs/bisect only to feed the result to rev-list --bisect" pattern to
> "shell script updates refs/bisect and let rev-list --bisect read from
> there" pattern would be a good initial step.  Oh, and I did not mean =
it
> only for "skip", but also doing this for "good" and "bad" as well.
>
> For example, you read "refs/bisect/skip-*" and keep that in $skip to:
>
>  - feed it to filter_skipped() which you are making built-in with thi=
s
>    series;
>
>  - feed it to check_good_are_ancestors_of_bad that in turn calls
>    check_merge_bases;
>
> and its use is contained in bisect_next() alone.  After this series i=
s
> done, we can move the logic in check_good_are... to bisect.c and you =
do
> not have to read refs/bisect/skip-* in the shell anymore.  IOW, we ca=
n
> migrate away from the "shell reads from refs/bisect/ and feeds that t=
o
> rev-list --bisect" pattern incrementally.

Do you mean that you want this series to migrate both "filter_skipped" =
and
"check_good_are_ancestors_of_bad" to C? Or is it ok=20
if "check_good_are_ancestors_of_bad" migrates later?

If it is ok to migrate "check_good_are_ancestors_of_bad" later, then I =
think=20
something like the 8/7 patch I posted yesterday might be a good way,=20
because I think a "--bisect-read-refs" option that read refs=20
from "refs/bisect/*" would not fit well in "git rev-list".

Because, the "git rev-list" usage is:

git rev-list [OPTION] <commit-id>... [ -- paths... ]

That means that at least one <commit-id> should always be passed to "gi=
t=20
rev-list".

So it would be strange to have to pass a commit on the command line whe=
n=20
using the "--bisect-read-refs" option. And I think it would not be very=
=20
consistent to change the usage like this:

git rev-list [OPTION] [ --bisect-read-refs | <commit-id>... ] [ --=20
paths... ]

Also when we migrate "check_good_are_ancestors_of_bad" to C, we will=20
probably have to move the code that checks out the source code=20
("bisect_checkout" shell function),=20
because "check_good_are_ancestors_of_bad" can call "bisect_checkout".
And I don't think that the checkout behavior would fit well in "git=20
rev-list".

That's why I suggested to add a new "git rev-bisect" plumbing command t=
hat=20
would read refs from "refs/bisect/*" and that could later be fitted wit=
h=20
the "bisect_checkout" and "check_good_are_ancestors_of_bad" behavior.

Best regards,
Christian.
