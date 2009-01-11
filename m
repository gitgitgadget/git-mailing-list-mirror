From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] word diff: customizable word splits
Date: Sun, 11 Jan 2009 14:20:07 -0800
Message-ID: <7vfxjppjs8.fsf@gitster.siamese.dyndns.org>
References: <cover.1231669012.git.trast@student.ethz.ch>
 <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch> <529cd830908f018f796dbc46d3b055c1f8ba9c1b.1231669012.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8ge-0003c3-I7
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZAKWUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZAKWUS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:20:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbZAKWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:20:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C1741C45E;
	Sun, 11 Jan 2009 17:20:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 170AC1C45C; Sun,
 11 Jan 2009 17:20:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 05E50900-E02E-11DD-A73F-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105237>

Thomas Rast <trast@student.ethz.ch> writes:

> Allows for user-configurable word splits when using --color-words.
> This can make the diff more readable if the regex is configured
> according to the language of the file.
>
> Each non-overlapping match of the regex is a word; everything in
> between is whitespace.

What happens if the input "language" does not have any inter-word spacing
but its words can still be expressed by regexp patterns?

ImagineALanguageThatAllowsYouToWriteSomethingLikeThis.  Does the mechanism
help users who want to do word-diff files written in such a language by
outputting:

	ImagineALanguage<red>That</red><green>Which</green>AllowsYou...

when '[A-Z][a-z]*' is given by the word pattern?

> We disallow matching the empty string (because
> it results in an endless loop) or a newline (breaks color escapes and
> interacts badly with the input coming from the usual line diff).  To
> help the user, we set REG_NEWLINE so that [^...] and . do not match
> newlines.

AndImagineALanguageWhoseWordStruc
tureDoesNotCareAboutLineBreak

Can you help users with such payload?

	Side note.  Yes, I am coming from Japanese background.

        Side note 2.  No, I am not saying your code must support both of
        the above to be acceptable.  I am just gauging the design
        assumptions and limitations.

> Insertion of spaces is somewhat subtle.  We echo a "context" space
> twice (once on each side of the diff) if it follows directly after a
> word.  While this loses a tiny bit of accuracy, it runs together long
> sequences of changed word into one removed and one added block, making
> the diff much more readable.

I guess this part can be later enhanced to be more precise, so that it
keeps the original context space more faithfully (i.e. does not lose two
consecutive spaces in the original occidental script, and does not insert
any extra space to the oriental script), if we were to support the second
example I gave above in the future as a follow-up patch.

> +--color-words[=<regex>]::
> +	Show colored word diff, i.e., color words which have changed.
> +	By default, a new word only starts at whitespace, so that a
> +	'word' is defined as a maximal sequence of non-whitespace
> +	characters.  The optional argument <regex> can be used to
> +	configure this.
> ++
> +The <regex> must be an (extended) regular expression.  When set, every
> +non-overlapping match of the <regex> is considered a word.  (Regular
> +expression semantics ensure that quantifiers grab a maximal sequence
> +of characters.)  Anything between these matches is considered
> +whitespace and ignored for the purposes of finding differences.  You
> +may want to append `|\S` to your regular expression to make sure that
> +it matches all non-whitespace characters.

Whose regexp library do we assume here?  Traditionally we limited
ourselves to POSIX BRE, and I do not think anybody minds using POSIX ERE
here, but we need to be clear.  In either case \S is a pcre outside
POSIX.

The rest I only skimmed but did not spot anything glaringly wrong; thanks.
