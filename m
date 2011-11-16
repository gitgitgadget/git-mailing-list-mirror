From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Wed, 16 Nov 2011 06:52:37 +0100
Message-ID: <4EC34FA5.2020809@alum.mit.edu>
References: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu> <4EC27328.3070309@alum.mit.edu> <7vk471urfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 06:52:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQYQR-0008Ox-Kc
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 06:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab1KPFwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 00:52:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45195 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab1KPFwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 00:52:41 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEDA0D.dip.t-dialin.net [84.190.218.13])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAG5qbEa002993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Nov 2011 06:52:38 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vk471urfy.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185507>

On 11/15/2011 08:16 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> Did this one fall through the cracks?  I don't see it in your tree.
> 
> Yeah, I was wondering if we can have a concise description in what context
> any "^" must be spelled as {caret} and what other context "^" can be
> spelled literally, and possibly which versions of AsciiDoc toolchain have
> this issue [*1*]. Without a clear guideline, people may unknowingly use
> literal "^" to new paragraphs, or perhaps worse yet, spell {caret} that
> end up being shown literally.
> 
> Since I didn't find a clear pattern other than that "^" can and should be
> literally given in a literal paragraph (i.e. an indented paragraph or
> inside a listing/literal block that shows program examples), I was meaning
> to ask you if you knew the rules better than I did, and I stopped there,
> forgetting to follow through.

I didn't know anything about asciidoc, and just tried to fix it using a
bit of cargo-cult programming.

Now I just did about an hour of research about asciidoc (but I still
don't feel very enlightened).  It seems that asciidoc was interpreting
the caret, paired with one earlier in the paragraph, as markup asking
for the enclosed text to be superscripted [1].  Apparently, single
carets in a paragraph are not treated as markup, which would explain
some apparent inconsistency about when carets need to be quoted.  But it
would seem prudent to escape all carets that don't appear in literal blocks.

Constructs like "{caret}" are "simple attribute references".  In this
particular case, the attribute that it is referencing is not built into
asciidoc but rather defined in the file Documentation/asciidoc.conf.
Empirically it seems that curly braces need to be escaped if they can be
interpreted to be part of an attribute reference, but not otherwise.
For example, curly braces with nothing inside of them like "{}" don't
necessarily need to be quoted, but it doesn't hurt if they are quoted to
"\{\}".

The backslash escape rules are a bit mysterious to me.  Backslash can be
used to escape some special characters.  For example, they can be used
to escape leading special quoting characters to avoid the special
effect, like "\_not italic_" [3].  They can also be used to suppress
attribute references, like "\{caret}" [4].  But it doesn't appear
possible to use a backslash to escape another backslash; for example
"\\{carat}" is rendered as "\{carat}".  In such cases, the backslash can
be spelled "{backslash}" (which is also defined in asciidoc.conf).

How to quote a monstrosity like the regexp in git-show-ref.txt?  We want
it to render as

    ^(?:<anything>\s)?<refname>(?:\^{})?$

, probably in monospaced font and surrounded by double quotes.  asciidoc
supports a bewildering variety of quoting mechanisms [5].  Empirically,

    "`^(?:<anything>\s)?<refname>(?:\^{})?$`"

doesn't work (the backticks don't suppress superscripting).

A pedestrian option is

    "`{caret}(?:<anything>\s)?<refname>(?:{backslash}{caret}\{\})?$`"

or

    "`{caret}(?:<anything>\s)?<refname>(?:{backslash}{caret}{})?$`"

Or the whole blob can be quoted en masse using $$:

    "`$$^(?:<anything>\s)?<refname>(?:\^{})?$$$`"

I don't know whether it treats the last dollar signs as "$$ $" or "$
$$", but either way the result looks OK.

I can't believe I spent my whole morning on this :-(

Michael

[1]
http://www.methods.co.nz/asciidoc/userguide.html#_superscripts_and_subscripts
[2]
http://www.methods.co.nz/asciidoc/userguide.html#_simple_attributes_references
[3] http://www.methods.co.nz/asciidoc/userguide.html#X51
[4] http://www.methods.co.nz/asciidoc/userguide.html#_attribute_references
[5] http://www.methods.co.nz/asciidoc/userguide.html#X77

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
