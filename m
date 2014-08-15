From: David Kastrup <dak@gnu.org>
Subject: Re: Understanding behavior of git blame -M
Date: Fri, 15 Aug 2014 16:42:04 +0200
Message-ID: <874mxderwj.fsf@fencepost.gnu.org>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Sokolov\, Konstantin \(ext\)" <konstantin.sokolov.ext@siemens.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 16:42:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIIiJ-0002ge-2S
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 16:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbaHOOmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 10:42:20 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50202 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHOOmR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2014 10:42:17 -0400
Received: from localhost ([127.0.0.1]:49244 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XIIhr-0001VG-PK; Fri, 15 Aug 2014 10:42:16 -0400
Received: by lola (Postfix, from userid 1000)
	id B8842E17E0; Fri, 15 Aug 2014 16:42:04 +0200 (CEST)
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
	(Konstantin Sokolov's message of "Fri, 15 Aug 2014 13:40:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255292>

"Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com> writes=
:

> Hi Folks,
>
> I'm trying to understand the behavior of git blame -M and find that
> the actual results differ from what I understood from the
> documentation. I've already asked longer time ago on stackoverflow an=
d
> on the user mailing list without any satisfactory results. So here is
> the example:
>
> Initial content of file.txt (2cd9f7f)
>
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
> Move line B to the middle (d4bbd97e):
>
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
>>git blame -s -n -f -w -M20 file.txt
> ^2cd9f7f 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> ^2cd9f7f 3 2) CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> ^2cd9f7f 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> d4bbd97e 4 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> ^2cd9f7f 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> ^2cd9f7f 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> ^2cd9f7f 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
> I wonder, why line B is not recognized as moved. According to the
> documentation, I would expect git blame to report that it originates
> from line 2 in revision 2cd9f7f. Can anybody explain the behavior?

Someone had reasons.  diff_hunks in builtin/blame.c is once called with
0 as third argument, once with 1.  Change the latter call to using 0 as
well and you get your expected result:

dak@lola:/tmp/test$ /usr/local/tmp/git/git blame -s -n -f -w -M20 file.=
txt
^2cab496 file.txt 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
A
^2cab496 file.txt 3 2) CCCCCCCCCCCCCCCCCCCCCCCC222222222222222222222222=
2
^2cab496 file.txt 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD=
D
^2cab496 file.txt 2 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=
B
^2cab496 file.txt 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE=
E
^2cab496 file.txt 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG=
G
^2cab496 file.txt 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
=46

The function diff_hunks is a wrapper for the diff engine.  Putting the
context length explicitly into this wrapper (rather than not passing an
argument and just setting the context length to zero anyway in the
function) clearly indicates that somebody _wanted_ it called with
different values.

There is no documentation or rationale in the file _why_ as far as
I=A0remember.  Maybe it can crash or end up in an infinite loop.  Maybe=
 it
could do so at one point of time but no longer does.

Maybe Git is just a puzzle from genius to genius.  Good luck figuring i=
t
out.

I have not touched this when rewriting git-blame recently, and I am not
interested in touching it.  I stand absolutely nothing to gain from
working on Git.

--=20
David Kastrup
