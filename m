From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 19:14:19 +0200
Message-ID: <6E1CBEF5-C2EA-447A-9FED-1423A17C2D19@wincent.com>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <4710F47D.2070306@gmx.ch>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Sat Oct 13 19:15:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgkZp-0006qw-Tp
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 19:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXJMROw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2007 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbXJMROv
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 13:14:51 -0400
Received: from wincent.com ([72.3.236.74]:46710 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbXJMROv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 13:14:51 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9DHEmoO017262;
	Sat, 13 Oct 2007 12:14:49 -0500
In-Reply-To: <4710F47D.2070306@gmx.ch>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El 13/10/2007, a las 18:38, Jean-Luc Herren escribi=F3:

> Here are my two cents.
>
> Wincent Colaiuta wrote:
>> +sub print_ansi_color($$;$) {
>> +    my $color =3D shift;
>> +    my $string =3D shift;
>> +    my $trailer =3D shift;
>
> None of the other subs in this file have a prototype, so for
> consistency I'd suggest to not add it on this function either.
> However maybe a patch that adds it to all subs would be welcome.
> (I wouldn't see the necessity though.)

Yes, I saw that the other functions didn't use prototypes and I agree =20
that consistency would be a good thing. I liked the idea of it in =20
this case because it makes explicit the fact that the function takes =20
two params plus a third, optional one. So definitely not necessary, =20
but a preference of mine. In any case, a change to all the other =20
functions is a question for a separate patch.

> And the common way of getting the arguments is reading @_ (see all
> other subs in the file).  So maybe instead write:
>
> [...]
> sub print_ansi_color {
> 	my ($color, $string, $trailer) =3D @_;
> [...]

Yes, I actually did write it that way first but then my doubts about =20
Perl made me write it the longer way; but if they are equivalent then =20
I prefer the shorter way.

>> +    if ($use_color) {
>> +        printf '%s%s%s', Term::ANSIColor::color($color), $string,
>> +            Term::ANSIColor::color('clear');
>> +    } else {
>
> Why use printf when you could directly use print here?  It's only
> used for concatenating.

True. I had may brain in the C-world.

>> +    if ($trailer) {
>> +        print $trailer;
>> +    }
>
> This will fail to print $trailer when $trailer happens to be a
> string that evaluates to false in bool context, like '0'.  Write
> this as:
>
> 	if (defined $trailer) {
> 	    print $trailer;
> 	}

Again, I actually wrote it that way the first time, and then changed =20
it, this time because I thought they were the same. Like I said, not =20
a perl hacker.

> IMHO, parsing the output of 'git diff-files --color' is a very bad
> idea and it makes all regexes uglier and more difficult to read.
> You're much better off recolorizing it yourself, which makes it a
> more localized change.

You're probably right, although it is also duplicating the work =20
that's already done elsewhere. In general I favor making the simplest =20
change that would work, and tweaking a few of the regexes did look =20
simpler than re-implementing the colorization logic.

But the approach you suggest might be more robust, perhaps, seeing as =20
there's not much to the diff output. As far as I can tell there are =20
really only five or six different things to look for, and they'd be =20
fairly easy to catch:

- lines beginning with "@@ " (hunk headers)

- lines beginning with "+" (insertions)

- lines beginning with "-" (deletions)

- lines beginning with " " (context lines, no color)

- lines beginning with "\" (things like "\ No newline at end of =20
file", again, no color)

- everything else; ie. the diff header stuff (eg "diff --git a/foo b/=20
foo")

The only special cases seem to be the "+++" and "---" lines in the =20
header, which look like insertions and deletions when they're not.

Trickier would be the highlighting of dubious whitespace, and that's =20
when it starts to sound like re-inventing the wheel and duplicating =20
the logic for the detection that's defined elsewhere (possibly in =20
diff-lib.c? haven't found the exact spot yet).

> Especially, I don't think that you have
> any guarantee that escape sequences won't ever contain the
> characters '+', '-' or ' ' (space)

Yes, that was one of the things I didn't like about the sloppy =20
regexes. I couldn't really make them any stricter though because I =20
wasn't confident about the range of possible characters that might be =20
included in the escape sequences.

> Finally -- and this might be just my eyes -- blue is a very nice
> color, but it looks a bit too dark on black background.  Maybe
> choose a default color that looks reasonable on black *and* white
> background.

Yeah, well I didn't choose the colours and I didn't really want to =20
get into it. Before being considered for inclusion a patch like this =20
would need to tap in to the existing config settings for color.diff =20
and color.diff.<slot> anyway...

Wincent
