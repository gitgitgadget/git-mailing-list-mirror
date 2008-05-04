From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Sun, 04 May 2008 13:16:47 -0700
Message-ID: <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
 <alpine.DEB.1.00.0805041040560.30431@racer>
 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 22:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jskef-00085G-Ne
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 22:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbYEDURF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 16:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbYEDURE
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 16:17:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbYEDURD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 16:17:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 560394518;
	Sun,  4 May 2008 16:17:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C8D344513; Sun,  4 May 2008 16:16:52 -0400 (EDT)
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D761B6A-1A17-11DD-88FA-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81197>

Let's step back a bit and try to clarify the problem with a bit of
illustration.

The motivation behind "word diff" is because line oriented diff is
sometimes unwieldy.

    -Hello world.
    +Hi, world.

A na=C3=AFve strategy to solve this would be to convert the input into =
one
character a line while changing the representation of characters into
their codepoints, take the diff between them, and synthesize the result
back, like this:

    preimage        postimage       char-diff
    48 H            48 H             48 H
    65 e                            -65 e
    6c l                            -6c l
    6c l                            -6c l
    6f o                            -6f o
                    69 i            +69 i
                    2c ,            +2c ,
    20 ' '          20 ' '           20 ' '=20
    77 w            77 w             77 w  =20
    6f o            6f o             6f o  =20
    72 r            72 r             72 r  =20
    6c l            6c l             6c l  =20
    64 d            64 d             64 d  =20
    2e .            2e .             2e .  =20
    0a '\n'         0a '\n'          0a '\n'

That would produce "H/ello/i,/ world.\n" which is very suboptimal for
human consumption because it chomps a word "Hello" and "Hi" in the midd=
le.
We instead can do this word by word (note that I am doing this as a
thought experiment, to illustrate what the problem is and what should
conceptually happen, not suggesting this particular implementation):

    preimage        postimage       word-diff
    48656c6c6f                      -48656c6c6f Hello
                    4869            +4869       Hi
                    2c              +2c         ,
    20              20               20         ' '
    776f726c64      776f726c64       776f726c64 world     =20
    2e              2e               2e         .
    0a              0a               0a         '\n'

Which would give you "/Hello/Hi,/ world.\n".

Another my favorite example:

    -if (i > 1)
    +while (i >=3D 0)
       =20
    preimage       postimage        word-diff
    6966                            -6966       if
                   7768696c65       +7768696c65 while
    20             20                20         ' '
    28             28                28         ( =20
    69             69                69         i =20
    20             20                20         ' '
    3e                              -3e         >
                   3e3d             +3e3d       >=3D
    20             20                20         ' '
    31                              -31         1 =20
                   30               +30         0 =20
    29             29                29         )

which should yield "/if/while/ (i />/>=3D/ /1/0/)".

So the overall algorithm I think should be is:

 - make the input into stream of tokens, where a token is either a run =
of
   word characters only, non-word punct characters only, or whitespaces
   only;

 - compute the diff over the stream of tokens;

 - emit common tokens in white, deleted in red and added in green.

Notice that you do not have to special case LF in any way if you go thi=
s
route.

You could do this with only two classes, and use a different tokenizati=
on
rule: a token is either a run of word characters only, or each byte of =
non
word character becomes individual token.  This however would yield a
suboptimal result:

    -if (i > 1)
    +while (i >=3D 0)
       =20
    preimage       postimage        word-diff
    6966                            -6966       if
                   7768696c65       +7768696c65 while
    20             20                20         ' '
    28             28                28         ( =20
    69             69                69         i =20
    20             20                20         ' '
    3e             3e                3e         >
                   3d               +3d         =3D
    20             20                20         ' '
    31                              -31         1 =20
                   30               +30         0 =20
    29             29                29         )

This would give "/if/while/ (i >//=3D/ /1/0/)".  A logical unit ">=3D" =
is
chomped into two tokens, which is suboptimal for the same reason why th=
e
output "H/ello/i,/" from the original char-diff based one was suboptima=
l.
