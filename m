From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 04:12:43 -0700
Message-ID: <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	<7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 13:12:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpjLI-0003fR-DD
	for gcvg-git@gmane.org; Sun, 20 May 2007 13:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbXETLMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 07:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbXETLMp
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 07:12:45 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50262 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbXETLMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 07:12:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520111243.YROD12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 07:12:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1PCj1X0041kojtg0000000; Sun, 20 May 2007 07:12:44 -0400
In-Reply-To: <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	(Marco Costalba's message of "Sun, 20 May 2007 12:34:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47824>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>
>> > Signed-off-by: Marco Costalba <mcostalba@gmail.com>
>> > ---
>> >
>> > This one seems to pass all the tests.
>>
>> I think this happens to work because you are not feeding -u0
>> patch; if you have more than one context, then a hunk that ends
>> with + line is guaranteed to apply only at the end,  With a
>> diff prepared with -u0, that is not true anymore, is it?
>
> I don't know much about this -u0 thing, could you please point me to
> an example so I can try to fix also this case?

I was starting to suspect that I misunderstood what you were
trying to do.  I thought you were trying to avoid a patch that
adds (one or more) blank line(s) at the end of the file, but is
it that you do not want to have a hunk that adds more than one
blank line anywhere?  However, the comment "Only fragments that
add lines at the bottom ends with '+' lines" suggests otherwise.

But.

If you start with this file:

$ git init
$ cat >AAA <<\EOF
a
b
c
d
EOF
$ git add AAA

and modify it by adding three blank lines between b and c, like
this:

$ cat >AAA <<\EOF
a
b



c
d
EOF

If you say "give me zero lines of context" (again, I think use
of -u0 is insane, but we got complaints in the past that we did
not get this right), you would get this:

$ git diff --unified=0 >P.diff
$ cat P.diff
diff --git a/AAA b/AAA
index d68dd40..8410b89 100644
--- a/AAA
+++ b/AAA
@@ -2,0 +3,3 @@ b
+
+
+

Because we had the same mistake in our earlier code as you made
in this patch, which assumed that a hunk that ends with '+' only
apply at the end (and we still assume that by default), if you
apply this with patch git-apply without --unidiff-zero option,
you get an error.  If you use the option this patch can be
applied correctly.

$ git checkout -- AAA ;# to go back to the original a/b/c/d
$ git apply --unidiff-zero P.diff

Now, with --unidiff-zero option, I think your patch will mistake
that this hunk adds _trailing_ blank lines, because it does not
see anything that comes after the '+'.

        I think it should notice that it adds three trailing
        blank lines and should reduce "new" to zero lines, but
        somehow it does not seem to do so.  You start with
        newsize == 3 and do not allow (newsize-empty) to go
        below 2, so you would get only 1 in empty, not 3, and
        end up reducing this hunk by only one line.

        Which may or may not be a bug, but that is besides the
        point.

The point is that this hunk does not apply to the end of the
file, and I do not think you should even be attempting to reduce
"new" at all.

But the code to determine where in the dest buffer the hunk
applies to exists way after the point you patched (inside of the
for(;;) loop, where we have memmove and memcpy).  The memmove is
to move away the later part of the file to make room if "new" is
larger than "old" (if the hunk deletes more than it adds, the
memmove would move the remainder up, otherwise down), and I
think that should be the place you would first decide if you are
applying at the end, and reduce "new" only if that is the case.

Am I misreading your patch?
