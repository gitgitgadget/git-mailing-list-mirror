From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
 plumbing
Date: Mon, 08 Dec 2008 00:27:25 -0800
Message-ID: <7v63lv842a.fsf@gitster.siamese.dyndns.org>
References: <20081208025700.GB22072@coredump.intra.peff.net>
 <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org>
 <20081208045924.GA22780@coredump.intra.peff.net>
 <7vskoz88g8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 09:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9bVF-00034f-LQ
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 09:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbYLHI1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 03:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbYLHI1h
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 03:27:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYLHI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 03:27:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F46285F8A;
	Mon,  8 Dec 2008 03:27:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2598785F89; Mon,
  8 Dec 2008 03:27:27 -0500 (EST)
In-Reply-To: <7vskoz88g8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Dec 2008 22:52:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E3D6FDA-C502-11DD-891F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102535>

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I've applied the series for an entirely different reason.
> The patch is the most natural way to allow users of Porcelain to disable
> textconv with the --no-textconv option, just like --no-ext-diff can be
> used to disable the external diff.

I imagine that web developers may want to use a textconv filter that
replaces ">" with "\n>" on the HTML files their designer-colleagues throw
in the source tree to make "git log -p" of the whole project easier to
follow.  When the developers would want to suggest improvements to what
their designer-colleagues did, however, by running "git diff --stat -p" in
their dirty work tree to produce a patch (like I just did just now,
visible from the mnemonic prefixes below), they would want to disable
textconv temporarily to get an appliable patch with --no-textconv option.

Once we have --no-textconv, somebody would inevitably ask about its
positive counterpart, --textconv option.  Even though it might not make
sense from patch applicability viewpoint, the option would allow the end
user to explicitly ask for "git format-patch --textconv" and get a patch
that can only be reviewed by humans but cannot be applied.  Hence the
attached update to the draft release notes to version 1.6.1 [Update #1].

You raised an intriguing possibility to use textconv in blame.  It would
also be useful if we allowed "git show --textconv $blob" to pass the blob
via textconv filter and any other transformation controlled by the
attributes mechanism..  When "git show" sees the above command line, it
only knows the blob object name and not the path, so we may need to allow
a new option to tell the command to pretend as if the content came from a
path, perhaps with a syntax like:

	$ git show --attribute-path=a/b/c $blob
	$ git show --attribute-path=a/b/c --textconv $blob

Note that I envision that the above two commands would produce different
results.  The former would behave as if $blob were recorded at path a/b/c
and what would be checked out (i.e. usual crlf, ident, and smudge that are
in effect for the path are applied) to the standard output.  The latter
would apply the textconv filter that would apply to what is recorded at
the given path and show that.

[Update #1]

 Documentation/RelNotes-1.6.1.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git c/Documentation/RelNotes-1.6.1.txt w/Documentation/RelNotes-1.6.1.txt
index 0405309..09bbcad 100644
--- c/Documentation/RelNotes-1.6.1.txt
+++ w/Documentation/RelNotes-1.6.1.txt
@@ -133,7 +133,8 @@ on.
   contents can be munged into human readable form and the difference
   between the results of the conversion can be viewed (obviously this
   cannot produce a patch that can be applied, so this is disabled in
-  format-patch among other things).
+  format-patch and plumbing, but if you really wanted to, you can enable
+  it by giving them --textconv command line option explicitly).
 
 * "--cached" option to "git diff has an easier to remember synonym "--staged",
   to ask "what is the difference between the given commit and the
