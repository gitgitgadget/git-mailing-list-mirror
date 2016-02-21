From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH] GSoC Micoproject: Hunt down signed int flags
Date: Mon, 22 Feb 2016 00:22:11 +0100
Message-ID: <56CA46A3.9060404@moritzneeb.de>
References: <1456053189-5221-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Saurav Sachidanand <sauravsachidanand@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 00:22:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdKT-0003pM-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbcBUXWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:22:14 -0500
Received: from moritzneeb.de ([78.47.1.106]:55619 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbcBUXWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:22:13 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id 4FA201C01F;
	Mon, 22 Feb 2016 00:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456096932;
	bh=kNRhouDtSJT6pa6FJiiyy+QmUh56cg3ykOcvbU0XK/s=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=oPO2Yngtl/xvNSHxfPkxhlkEjB7iZuaH5heXQHIa1Y9CPukX058ErVZ7sJ5qdtu5d
	 bc2e5RBOkyeb8uT/oCUba78nMgjYEovYSBTmOGHUjHcCYETEoc/ylNzW4uXzZ8r7lF
	 NozrvOeDQ3fF+NkZdgxR2DZ12ST+TNca3OtKVd1g=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1456053189-5221-1-git-send-email-sauravsachidanand@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286841>

Thanks for your patch. Just to let you know, this will be my first
review, but I hope it will be helpful anyway. I will mostly review your
commit text. First some general remarks:

The text you are submitting with you email is directly used as commit
message (the email subject as well, as the first line). You might want
to take care that the description is useful as a "bit of history", I
will give examples of what I mean below. Some guidelines for that can b=
e
found in "Documentation/SubmittingPatches" section (2).

On 02/21/2016 12:13 PM, Saurav Sachidanand wrote:
> This is patch is for a suggested micro project for GSoC 2016; namely,
> that of searching for a field of a struct that is of signed integral
> type and used as a collection of multiple bits, and converting it to
> an unsigned type if the MSB isn=E2=80=99t used in any special way.

Especially, you might not want to include the fact that this is a GSoC
project. You might want to add this kind of information in the
"notes"-section of your email after the three dashes "---", this will b=
e
skipped when the patch is applied.

> Two structs, `pattern` defined in attr.c and `exclude` defined in dir=
=2Eh,
> have a `flags` field of signed int type.=20

I have never seen the Markdown-style quotes ` in git.git commits. To be
in the same style as previous git (which helps e.g. in readability
because it is homogeneous), you can use the "-quote for code. Or even
leave them out if its clear from context.

> The fields of both structs take
> on values from the same set of positive integers {1, 4, 8, 16},
> enumerated through the marco EXC_FLAG_*.

marco -> macro.

I'd say this is a good observation to state.

Maybe it's also helpful to further explain why the two structs are
logically connected, or if that turns out to be false, to split up you
changes into two commits. I am not fully convinced that it should be on=
e
commit.

>`pattern` is used only in attr.c,
> and `exclude` is used only in builtin/check-ignore.c and dir.c, and i=
n
> those files, either, the value of `flags` is checked using the `&` op=
erator
> (e.g.: flags & EXC_FLAG_NODIR), or the value of `flags` is first set =
to 0
> and then set to any one of {1, 4, 8, 16} using the `|=3D` operator
> (e.g.: flags |=3D EXC_FLAG_NODIR). And, so it does not appear that th=
e MSB
> of `flags` is used in any special way.

This is the conclusion that is needed, but you might want state it more
direct, like "the MSB is not used...".

> Therefore, I thought to change the
> type of `flags` in the definitions of both structs to `unsigned int`.
> Furthermore, `flags` is passed by reference (of `pattern` in attr.c a=
nd of
> `exclude` in dir.c) to the function `parse_exclude_pattern` defined i=
n
> dir.c, that accepts an `int *` type for `flags`.
> When make was run, it gave
> a warning for =E2=80=98converting between pointers to integer types o=
f different
> sign=E2=80=99, so I changed the type of that respective argument to `=
unsigned int *`.

I think this explanation can be left out or has to be replaced by
something less compiler-driven, i.e. why does it actually make sense fo=
r
parse_exclude_pattern to have an unsigned int flags as parameter.

> In the end, running make to build didn=E2=80=99t produce any more war=
nings, and
> running make in t/ didn=E2=80=99t produce any breakage that wasn=E2=80=
=99t =E2=80=98#TODO known
> breakage=E2=80=99.

=46or the tests it is, from what I've seen, just assumed that you ran t=
hem
(and the reviewers/the maintainer will confirm this for themselves), so
no need to mention it. But it's good you ran them.

> I also thought it=E2=80=99d be helpful to add the comment /* EXC_FLAG=
_* */ next
> to `flags` of `exclude`, just like it exists for `flags` of `pattern`=
=2E

I would reformulate this as well more direct to something like "when
we're at it, document exclude->flags as EXC_FLAG".

Thanks,
Moritz
