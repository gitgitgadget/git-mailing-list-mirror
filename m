From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on HP NonStop
Date: Mon, 20 Aug 2012 19:06:01 -0700
Message-ID: <7vy5l9f186.fsf@alter.siamese.dyndns.org>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de>
 <7vr4r98rfd.fsf@alter.siamese.dyndns.org>
 <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de>
 <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr>
 <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de>
 <503217F2.5070105@viscovery.net> <7vfw7hle6l.fsf@alter.siamese.dyndns.org>
 <001901cd7f15$98c6ab50$ca5401f0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Johannes Sixt'" <j.sixt@viscovery.net>,
	"'Jan Engelhardt'" <jengelh@inai.de>, <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Aug 21 04:06:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3drD-00042P-Rg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 04:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab2HUCGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 22:06:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017Ab2HUCGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 22:06:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 975A077A5;
	Mon, 20 Aug 2012 22:06:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9PTKhoLJ5m5da2P1j5fnBl5KFc=; b=bGcGH2
	uEbcIT0HecP27mnE3aui/xPh+dEuaT/W4csfM+7jlxpFCTtIsk7FaMAGBJfb9YVK
	Q/zmxleGSBXL9uhL+A7lEN+ZgFmQZQJwVw/MKOzVeIBYLpWazpMptfv5/aK4Qr6k
	ae4wS3p631IRhIz+HeeK5s0/UmKAKOsfbk5XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hrLVt2cFkPUczZS+5zUsk0U9Z40gj8E7
	WSq/SF2hqpP13MABq9m9m3MECQXEH0M5NcuAV0vhmSGRBd3z+/8iBW5vJIFJtHcX
	8rymJGh64kmhaYRKp49xBeG6unchykE5Ch3m/S6CeNaAr+00Hczz+gMFwJ5s3eFB
	0DL47CThCko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8392577A4;
	Mon, 20 Aug 2012 22:06:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9032E77A3; Mon, 20 Aug 2012
 22:06:03 -0400 (EDT)
In-Reply-To: <001901cd7f15$98c6ab50$ca5401f0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Mon, 20 Aug 2012 22:51:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2BFBFCE-EB34-11E1-BE34-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203917>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> OK, so let's have a look at code, current git,
> builtin/cat-file.c, line 196:
>         void *contents = contents;
>
> This variable is set later in an if branch (if (print_contents == BATCH),
> but not in the else branch. It is later used always under the same condition
> as the one under which it is set.
> Apparently is is malloc_d storage (there a "free(content);"), so there's no
> harm al all in initializing it with NULL, even if it only appeases a stupid
> compiler.

It actually is harmful.  See below.

> The next one, builtin/fast-export.c, line 486:
>                 struct commit *commit = commit;
> it is set in a switch statement, but not in every case, as far as I can see.
> Hmm, maybe it is, and I just get lost in the code
> And it is used directly after the switch, hopefully set to something
> reasonable.
> Why take the risk and not set it to NULL?

Ditto.

> Next one, builtin/rev-list.c, line 390:
>                 int reaches = reaches, all = all;
>
>                 revs.commits = find_bisection(revs.commits, &reaches, &all,
>                                               bisect_find_all);
>
> Seem pretty pointless to initialize them, provided find_bisection doesn't
> read them. Does it?

That is why they are not initializations but marks to the compiler
to signal "you may be stupid enough to think they are used before
initialized or assigned, but that is not the case".  Initializing
them would be pointless.

> Next one, fast-import.c, line 2268:
>         struct object_entry *oe = oe;
>
> os gets set in en if and an else branch, but not in then intermediate else
> if branch!

Look again.  If the recent code is too complex for you to
understand, go back to 10e8d68 (Correct compiler warnings in
fast-import., 2007-02-06) and read the function.

The control flow of the early part of that function dictates that
either oe is assigned *or* inline_data is set to 1.  When inline_data
is false, oe is always set.

The compiler was too stupid to read that, and that is why the
(confusing) idiom to mark it for the stupid compiler was used.

There are a few reasons why I do not think this self-assignment
idiom or initializing the variable to an innocuous-looking random
value is a particularly good thing to do when you see compiler
warnings.

If the compiler suspects the variable might be unused, you should
always look at it and follow the flow yourself.  Once you know it is
a false alarm, you can use the idiom to squelch the warning, and it
at the same serves as a note to others that you verified the flow
and made sure it is a false warning.

When the next person wants to touch the code, if the person knows
the use of the idiom, it only serves as a warning to be extra
careful not to introduce a new codepath that reads the variable
without setting, as the compiler no longer helps him.  If the person
who touches the code is as clueless as the compiler and cannot
follow the codepath to see the variable is never used uninitialized,
the result will be a lot worse.

That is the reason why I do not think the idiom to squelch the
compiler is such a good thing.  Careless people touch the code, so
"oe = oe" initialization carefully placed in the original version
does not necessarily stay as a useful documentation.

But if you use "oe = NULL" as a way to squelch the warning in the
first place, it is no better than "oe = oe".  In a sense, it is even
worse, as it just looks like any other initialization and gives a
false impression that the remainder of the code is written in such a
way that it tolerates oe being NULL in any codepath, or there is
some assignment before that before the code reaches places where oe
cannot be NULL.  That is different from what "oe = oe" initializaion
documents---in the codepath protected by "if (inline_data)", it
isn't just "oe can safely be NULL there"; instead it is "oe can
safely be *any* value there, because we don't use it".  Of course,
if you explicitly initialized oe to NULL, even if you introduce a
codepath where oe cannot be NULL later, you won't get a warning from
the compiler, so it is no better than "oe = oe".

And that is the reason why I do not think initialization to an
innocuous-looking random value (e.g. NULL) is a good answer, either.

When both are not good, replacing "oe = oe" with "oe = NULL" didn't
make much sense, especially when the former _could_ be used better
by more careful people.  And that is the resistance J6t remembers.

But when recent compilers started to warn "oe = oe" that itself is
undefined, the equation changed.  The idiom ceased to be a way to
squelch the incorrect compiler warning (which was the primary point
of its use---the documentation value is secondary, as what we
document is "we are squelching a false alarm", but we no longer are
squelching anything).

See 4a5de8d (vcs-svn: avoid self-assignment in dummy initialization
of pre_off, 2012-06-01), and 58ebd98 (vcs-svn/svndiff.c: squelch
false "unused" warning from gcc, 2012-01-27) that it updated, for an
example of how we are migrating away from "oe = oe" idiom.

In any case, I already said initializing to 0 is OK in my previous
message, I think, so if you are seeing warning from the compiler on
uninitialized variables in your new code, you know you should

 (1) first follow the codepath to make sure it is a false alarm (if
     it isn't, fix the code);

 (2) then see if you can simplify your code so that it is crystal
     clear even to the stupid compiler that you are not using an
     uninitialized variable; and

 (3) if you can't, then initialize it to some known bad value,
     avoiding the "oe = oe" idiom.

Is there anything more to discuss on this topic?
