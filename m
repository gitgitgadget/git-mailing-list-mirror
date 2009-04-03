From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Fri, 3 Apr 2009 05:58:29 +0200
Message-ID: <200904030558.30872.chriscool@tuxfamily.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <200904020557.25058.chriscool@tuxfamily.org> <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 06:01:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpaad-0001e0-3C
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 06:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZDCD7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 23:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZDCD7j
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 23:59:39 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:56745 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbZDCD7i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 23:59:38 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 261C3E08002;
	Fri,  3 Apr 2009 05:59:28 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DC685E0804F;
	Fri,  3 Apr 2009 05:59:25 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115515>

Le jeudi 2 avril 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Ok, so I suggest the following simple guiding principles:
> >
> > - git-compat-util.h or cache.h or builtin.h should always be the fi=
rst
> > #include in C files,
> >
> > - header files should include other incude files if and only if the
> > other includes are needed to compile them,
>
> This is unclear.
>
> Long before I started touching git, I used to be religious about maki=
ng
> header files self contained.  For a header file frotz.h in the projec=
t, I
> used to insist that
>
> 	$ cat >1.c <<\EOF
> 	#include "frotz.h"
>         EOF
>         $ cc -Wall -c 1.c
>
> did not fail.
>
> Are you talking about that by "to compile them"?

Well, I wanted to say that for a header file frotz.h in the project:

	$ cat >1.c <<\EOF
	#include "cache.h"
	#include "frotz.h"
	EOF
	$ cc -Wall -c 1.c
=09
should not fail.

(Ok, in practice, let's say that something like:

$ cc -Wall -DSHA1_HEADER=3D'<openssl/sha.h>' -c 1.c

should not fail.)

> I stopped doing that long time ago, partly because the rule was
> cumbersome to enforce, but primarily because it was not helping much =
in
> the larger picture.
>
> Such a rule, together with strict rules such as the order of includin=
g
> other header files in the header files themselves, may make life easi=
er
> for programmers who touch .c files but never .h files, because they c=
an
> include only the necessary .h files and in any order.  But in practic=
e,
> people need to touch both .h and .c files and when they need to inclu=
de
> new system header files, they need to follow the inclusion order rule
> somewhere anyway---at that point, it does not matter much if the rule
> applies to only .h files or both .h and .c files.
>
> So for example, you cannot compile
>
> 	$ cat >1.c <<\EOF
>         #include "revision.h"
>         EOF
>         $ cc -Wll -c 1.c
>
> in git.git project, but I do not think it is a problem.

I think it may become a problem if a header needs more headers to be=20
included before it, and those latter headers again need more headers an=
d so=20
on.

The advantage of having and using "cache.h" is that things are quite si=
mple.=20
You include cache.h and then a few more headers for special features yo=
u=20
need, and, here you go, you can code up something quite interesting wit=
hout=20
worrying too much about includes. (Though the compilation time is perha=
ps a=20
little longer than it could be.)

If we loose this simplicity because we don't take care or for some=20
theoretical reason, then I think we have lost everything that really=20
matters.

A simple patch like this:

---------8<------------
$ gdiff
diff --git a/revision.h b/revision.h
index 5adfc91..495d7eb 100644
--- a/revision.h
+++ b/revision.h
@@ -3,6 +3,8 @@

 #include "parse-options.h"
 #include "grep.h"
+#include "diff.h"
+#include "commit.h"

 #define SEEN           (1u<<0)
 #define UNINTERESTING   (1u<<1)
---------8<------------

makes the following just work(tm):

	$ cat >1.c <<\EOF
	#include "cache.h"
	#include "revision.h"
	EOF
	$ cc -Wall -DSHA1_HEADER=3D'<openssl/sha.h>' -c 1.c
	$

(By the way it's this kind of patches that I hoped would get posted fir=
st.)

> > - a header file should be included in a C file only if it is needed=
 to
> > compile the C file (it is not ok to include it only because it incl=
udes
> > many other headers that are needed)

I should have said "a header file other than git-compat-util.h or cache=
=2Eh=20
should be included ..."

> If that is the rule, perhaps the problem lies not in a .c program tha=
t
> includes such a .h header, but in the .h itself that includes many ot=
her
> header files.

It depends if the .h that includes many other header files does that fo=
r a=20
good reason or not.

> > - other than the above rules, it is ok to reduce the number of incl=
udes
> > as much as possible
> >
> > What do you think?
>
> What you did not write and I forgot to mention, which is a logical
> conclusion of the first rule, is that C files should not directly inc=
lude
> common system header files such as unistd, sys/stat, etc.

Yeah, I forgot to restate that.

> There are exceptions to any rule.  For example, inclusion of syslog.h=
 in
> daemon.c is OK because most of the rest of the system does not even u=
se
> syslog.  If we later find a platform whose syslog.h has some funny
> inter-header dependencies, however, we will need to include it in the
> git-compat-util.h and resolve the dependencies there, like we do for
> other system header files.

Ok, I will state that too.

If you agree I will post a patch to "Documentation/CodingGuidelines" wi=
th=20
the above clarifications. (I can also post an improved version of my pa=
tch=20
to "revision.h".)

Thanks,
Christian.

> > Or perhaps Junio would prefer that you work on a C file by C file
> > basis? Like for example:
> >
> > "delete useless includes in 'builtin-diff-files.c'"
> > "delete useless includes in 'builtin-diff-index.c'"
>
> If the series does not involve .h file clean-up, then a series that
> consists of one patch per .c file would be easier to handle, I think.
