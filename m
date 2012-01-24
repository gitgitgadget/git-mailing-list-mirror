From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Mon, 23 Jan 2012 22:59:45 -0800
Message-ID: <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 08:00:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpaMW-0006gm-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 08:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab2AXG7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 01:59:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab2AXG7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 01:59:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C4A47A8;
	Tue, 24 Jan 2012 01:59:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aUv85qsdXDPyMbfrmX0xeCLCnXA=; b=wOB5Sh
	p32Ck/eIu+NurFSXCSmtI79ZvCzyQRxpOoyPDgDg8DrJTlv55si1odx/IfrYatu7
	SXPbevgh5s6bx2vS/EAoH0zD8rNbSLrzEq4fSef2cZG55ABqwmzb05W4757tFNdk
	uJFlrrNpxuYVj8vP1ZuQhDhuVVBU2Ftj9g7Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KdYCcLO4QRcZquyuuhWU4oJCzvkppe5I
	/NpepHLjoOTc0vj4Q317Nss7BQu2LO/zdwtUpmESIR5LPkEaTkp+908HQDqltBsL
	2v7EHePKRnbMGRFb8OtOhEEtV/wB7cHw/qmIfZUD4BZiam9ItKip1vTGEnGR3pHe
	alcfUgiqFGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB79447A7;
	Tue, 24 Jan 2012 01:59:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13FE647A4; Tue, 24 Jan 2012
 01:59:46 -0500 (EST)
In-Reply-To: <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 (Conrad Irwin's message of "Mon, 23 Jan 2012 14:59:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 006BE7B6-4659-11E1-92BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189039>

Conrad Irwin <conrad.irwin@gmail.com> writes:

>> in order to avoid uselessly spewing garbage at you while reminding you
>> that the command is not showing the whole truth and you _might_ want to
>> look into the elided file if you wanted to with "grep -a world hello.o".
>> Compared to this, it feels that the result your patch goes too far and
>> hides the truth a bit too much to my taste. Maybe it is just me.
>
> I used to use this approach, hooking into the "diff" attribute directly to mark
> a file as binary, however that was clearly a hack.

After thinking about this a bit more, I have to say I disagree that it is
a hack.

I agree that the issue you are trying to address is real, but I think the
approach taken by the patch is flawed on three counts:

 - You cannot do "grep -a" equivalent once you set your "-grep" attribute;

 - The user has flexibility to set "diff" and "grep" independently, which
   is an unnecessary complication [*1*]; and

 - The user does not get any hint that potential hits are elided, like
   normal "grep" would do.

I also think we can fix the above problems, while simplifying the external
interface visible to the end users.

So let's step back a bit and take a look at the handling of files for
which you do not want to see patch output and/or you do not want to see
grep hits, in a fictional but realisitic use scenario.

I am building a small embedded applicance that links with a binary blob
firmware, xyzzy.so, supplied by an upstream vendor, and this blob is
updated from time to time. In order to keep track of what binary blob went
into which product release, this binary blob is stored in the repository
together with the source files. Because it is useless to view binary
changes in "git log -p" output, I would naturally mark this as "binary".

Now, is it realistic to expect that I might want to see "grep" hits from
this binary blob? I do not think so [*2*].

When I say "xyzzy.so is a binary" in my .gitattributes file, according to
the current documentation, I am saying that "do not run diff, and also do
not run EOL conversion on this file" [*3*], but from the end user's point
of view, it is natural that I am entitled to expect much more than that.
Without having to know how many different kinds of textual operations the
SCM I happen to be using supports, I am telling it that I do not want to
see _any_ textual operations done on it. If a new version of "git grep"
learns to honor the attributes system, I want my "this is binary" to be
considered by the improved "git grep".

If you think about it this way from the very high level description of the
problem, aka, end user's point of view, it is fairly clear that tying the
"binary" attribute to "git grep" to allow us to override the built-in
buffer_is_binary() call you see in grep.c gives the most intuitive result,
without forcing the user to do anything more than they are already doing.

Because "binary" decomposes to "-diff" and "-text", we have two choices.
We _could_ say "-text" should be the one that overrides buffer_is_binary()
autodetection, but using "-diff" instead for that purpose opens the door
for us to give our users even more intuitive and consistent experience.

Suppose that this binary blob firmware came with an API manual formatted
in PDF, xyzzy.pdf, also supplied by the vendor. It is also kept in the
repository, but again, running textual diff between updated versions of
the PDF documentation would not be very useful. I however may have a
textconv filter defined for it to grab the text by running pdf2ascii.

Now if my "git show --textconv xyzzy.pdf" has an output line that says a
string "XYZZY API 2.0" was added to the current version, wouldn't it be
natural for me to expect that "git grep --textconv 'XYZZY API' xyzzy.pdf"
to find it [*4*]?

As an added bonus, if you truly want to omit _any_ hit from "git grep" for
your minified.js files, you can easily do so. Just define a textconv
filter that yields an empty string for them, and "grep --textconv" won't
produce any matches, not even "Binary file ... matches".

So I am inclined to think that reusing the infrastructure we already have
for the `diff` attribute as much as possible would be a better design for
this new feature you are proposing.

The name of the attribute `diff` is somewhat unfortunate, but the end user
interface to the feature at the highest level is already called "binary"
attribute (macro), and our low-level documentation can give precise
meaning of the attribute while alluding to the origin of the name so that
intelligent readers would understand it pretty easily (see attached
patch).

Besides, we already tell the users in "Marking files as binary" section to
mark them with "-diff" in the attributes file if they want their contents
treated as binary.


[Footnotes]

*1* An unused flexibility like this does nothing useful, other than
forcing the user to flip two attributes always as a pair, when one should
suffice.

*2* The essence of my previous message was "why it is insufficient to mark
them binary, i.e. uninteresting for the purpose of all textual operations
not just grep but also for diff." which was unanswered.

*3* This is because "binary" is defined as an attribute macro that expands
to "-diff -text".

*4* This also suggests that the infrastructure we already have for driving
"git diff" is a good match for "git grep".  The "funcname" patterns, which
"git grep -p" already can borrow and use from "diff" infrastructure, is
another indication that using `diff` is a good match for "git grep".


 Documentation/gitattributes.txt |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a85b187..63844c4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -388,9 +388,18 @@ Generating diff text
 `diff`
 ^^^^^^
 
-The attribute `diff` affects how 'git' generates diffs for particular
-files. It can tell git whether to generate a textual patch for the path
-or to treat the path as a binary file.  It can also affect what line is
+The attribute `diff` affects if `git` treats the contents of file as text
+or binary. Historically, `git diff` and its friends were the first to use
+this attribute, hence its name, but the attribute governs textual
+operations in general, including `git grep`.
+
+For `git diff` and its friends, differences in contents marked as text
+produces a textual patch, while differences in non-text are reported only
+as "Binary files differ". For `git grep`, matches in contents marked as
+text are reported by showing lines that contain them, while matches in
+non-text are reported only as "Binary file ... matches".
+
+This attribute can also affect what line is
 shown on the hunk header `@@ -k,l +n,m @@` line, tell git to use an
 external command to generate the diff, or ask git to convert binary
 files to a text format before generating the diff.
