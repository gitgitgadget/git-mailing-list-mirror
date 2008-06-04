From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Strbuf documentation: document most functions
Date: Wed, 04 Jun 2008 00:45:06 -0700
Message-ID: <7vzlq1y77h.fsf@gitster.siamese.dyndns.org>
References: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
 <1212542126-21514-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	=?iso-2022-jp?B?UmVuGyRCRlwbKEJjaGFyZmU=?= 
	<rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 09:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3nhf-0001s0-Tr
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 09:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbYFDHpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 03:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYFDHpn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 03:45:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbYFDHpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 03:45:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C5433143;
	Wed,  4 Jun 2008 03:45:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8D58F3142; Wed,  4 Jun 2008 03:45:20 -0400 (EDT)
In-Reply-To: <1212542126-21514-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Wed, 4 Jun 2008 03:15:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 362406E8-320A-11DD-8E3F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83755>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index a52e4f3..15f66b2 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -1,6 +1,236 @@
>  strbuf API
>  ==========
>  
> +An strbuf is NUL terminated for convenience, but no function in the
> +strbuf API actually relies on the string being free of NULs.
>  
> +strbuf's are meant to be used with all the usual C string and memory
> +APIs. Given that the length of the buffer is known, it's often better to
> +use the mem* functions than a str* one (memchr vs. strchr e.g.).
> +Though, one has to be careful about the fact that str* functions often
> +stop on NULs and that strbufs may have embedded NULs.

I think these two paragraphs should be swapped.  The first two lines are
only interesting after you establish what it is and what it is used for
with the second paragraph.

> +However, it is totally safe to touch anything in the buffer pointed by
> +the `buf` member between the index `0` and `len` excluded.

Somehow this "excluded" feels not quite right wording.
Also "touch" is a fuzzy word.  I think.

 - "sb->buf[i] = x" is Ok if and only if "0 <= i < sb->len";
   col. "sb->buf[0] = 'x'" is a no-no if !sb->len.

 - "if (!sb->buf[0])" is Ok even if !sb->len.

> +. The `buf` member is a byte array that has at least `len + 1` bytes
> +  allocated. The extra byte is used to store a `'\0'`, allowing the
> +  `buf` member to be a valid C-string. Every strbuf function ensure this
> +  invariant is preserved.
> ++
> +NOTE: It is OK to "play" with the buffer directly if you work it that
> +      way:

If you are refering to the example you talk next, s/that way/this way/.

> ++
> +----
> +strbuf_grow(sb, SOME_SIZE); <1>
> +strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
> +----
> +<1> Here, the memory array starting at `buf`, and of length

Here you should say `sb->buf` not just `buf`, as you are explaining this
specific example that uses a concrete instance of strbuf `sb`.

> +`strbuf_avail(sb)` is all yours, and you can be sure that
> +`strbuf_avail(sb)` is at least `SOME_SIZE`.
> ++
> +Of course, `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.

It is not clear why this is "Of course" here in this document, because you
haven't talked about what "setlen" is.  It is "Of course" only because
setlen's sole purpose is to truncate and it cannot be used to extend the
buffer (I won't discuss if that is a good API here).

> +Doing so is safe, though if it has to be done in many places, adding the
> +missing API to the strbuf module is the way to go.
> ++
> +WARNING: Do _not_ assume that the area that is yours is of size `alloc
> +- 1` even if it's true in the current implementation. Alloc is somehow a
> +"private" member that should not be messed with.

Talking about "don't" is important, but without guiding the reader with
"instead of that, do this", the document becomes a frustrating read.

> +Data structures
> +---------------
> +
> +* `struct strbuf`
> +
> +This is string buffer structure. The `len` variable can be used to
> +determine the current length of the string, and `buf` provides access
> +to the string itself.

Call both consistently "member".  I.e. The `len` member can be ....

> +Functions
> +---------
> +
> +* Life cycle
> +
> +`strbuf_init`::
> +
> +	Initializes the structure. The second parameter can be zero or a bigger
> +	number to allocate memory, in case you want to prevent further reallocs.

When you start the sentence without a subject, use imperative mood, not
third person singular, for consistency.  I.e. "Initialize the structure".
This comment applies everywhere (you have mixed style).

> +`strbuf_release`::
> +
> +	Releases a string buffer and the memory it used. You should not use the
> +	string buffer after using this function, unless you initialize it again.
> +
> +`strbuf_detach`::
> +
> +	Detaches the string from the string buffer. The function returns a
> +	pointer to the old string and releases a buffer, so that if you want to
> +	use it again, you should initialize it before doing so.

"Detaches the string from the strbuf and returns it; you now own the
storage the string occupies and it is your responsibility from then on to
release it with free(3) when you are done with it."

The strbuf is reinitialized by detach, so there shouldn't be need for
re-initializing it.

> +`strbuf_avail`::
> +
> +	Determines the amount of allocated but not used memory.

s/not used/unused/;

> +`strbuf_grow`::
> +
> +	Ensure that at least this amount of available memory is available. This

"available memory is available"?  "Ensure that at least this amount of
unused memory is available after `len`", perhaps.

> +	is used when you know a typical size for what you will do and want to

s/you will do/you will add/;

> +	avoid repetitive automatic resize of the underlying buffer. This is

s/resize/resizing/;

> +* Adding data to the buffer

You need a blanket comment to say "All of these functions will grow the
buffer as necessary".

> +`strbuf_splice`::
> +
> +	Splice pos..pos+len with given data.

Define "splice".  "Remove the bytes between pos..pos+len and replace it
with the given data".

> +`strbuf_addbuf`::
> +
> +	Add an other buffer to the current one.

Makes the reader wonder what happens to that other buffer after this
operation.  "Copy the contents of the second buffer at the end of the
first buffer", perhaps?
