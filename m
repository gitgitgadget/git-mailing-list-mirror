From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 11:42:41 +0200
Message-ID: <87d36uomlq.fsf@thomas.inf.ethz.ch>
References: <20120426085156.GB22819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNLDu-0006Ln-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 11:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab2DZJmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 05:42:46 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33220 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab2DZJmp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 05:42:45 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 26 Apr
 2012 11:42:40 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 26 Apr
 2012 11:42:42 +0200
In-Reply-To: <20120426085156.GB22819@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 Apr 2012 04:51:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196362>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 26, 2012 at 02:19:23AM -0400, Jeff King wrote:
>
>> I'd like to eventually stop building the documentation with
>> no-inline-literal. It was an asciidoc7 compatibility thing, but we can
>> probably drop that now. However, I suspect that would require us to
>> simultaneously convert all of the `{tilde}` uses back into `~`.
>
> I took a look at this.  There were about 200 sites that needed to be
> fixed up. It was a pain, but it's now done. The resulting source is much
> nicer, and as a bonus, it revealed (and fixed!) a ton of existing
> formatting bugs.

Great!

> In asciidoc 7, backticks like `foo` produced a typographic
> effect, but did not otherwise affect the syntax. In asciidoc
> 8, backticks introduce an "inline literal" inside which markup
> is not interpreted. To keep compatibility with existing
> documents, asciidoc 8 has a "no-inline-literal" attribute to
> keep the old behavior. We enabled this so that the
> documentation could be built on either version.

The switch was actually at asciidoc 8.4.1, as explained in 71c020c
(Disable asciidoc 8.4.1+ semantics for `{plus}` and friends,
2009-07-25).

>  ifndef ASCIIDOC7
> -ASCIIDOC_EXTRA += -a asciidoc7compatible -a no-inline-literal
> +ASCIIDOC_EXTRA += -a asciidoc7compatible
>  endif

That of course raises the question what asciidoc7compatible means.  I
have no idea, and google hasn't exactly been helpful.  The only thing I
could find was

  http://www.methods.co.nz/asciidoc/chunked/apa.html

It mostly seems to affect quoting rules.  Do we really need it?


As for the actual patch, I only did some "lazy verification" using

  git grep '`[^`]*[\\{]' Documentation/

That (unsurprisingly :-) turned up no mistakes on your part.  However,
some markup mistakes show up in git-fast-import.txt:

diff --git i/Documentation/git-fast-import.txt w/Documentation/git-fast-import.txt
index 2620d28..3e8fbd1 100644
--- i/Documentation/git-fast-import.txt
+++ w/Documentation/git-fast-import.txt
@@ -422,9 +422,9 @@ The `committer` command indicates who made this commit, and when
 they made it.
 
 Here `<name>` is the person's display name (for example
-``Com M Itter'') and `<email>` is the person's email address
-(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
-and greater-than (\x3e) symbols.  These are required to delimit
+`Com M Itter`) and `<email>` is the person's email address
+(`cm@example.com`).  `LT` and `GT` are the literal less-than (`\x3c`)
+and greater-than (`\x3e`) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
 `<name>` and `<email>` are free-form and may contain any sequence
 of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.

On my box (asciidoc 8.4.5) the preimage renders as

  `Com M Itter''

in fixed-width font.  In the process of debugging this, I noticed that
the quoting rules are hilariously screwy.  It seems that within a
paragraph, saying

  ``foo'' means `bar`
   ^^^^^^^^^^^^^

treats the underlined part as a `-quoted chunk of text, and renders it
appropriately using a fixed-width font.  The trailing ` has no effect
unless it is followed by another ` within the same paragraph.  But the `
right at the start of the "quoted" text has no effect either!  Moreover,
this behaviour is the same regardless of the 'asciidoc7compatible'
setting.  I wonder if it has since been fixed, but the above might be a
good idea anyway.  (The quoting around \xAB is just for good measure.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
