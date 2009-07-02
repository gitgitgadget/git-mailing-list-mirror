From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace  differences
Date: Thu, 02 Jul 2009 16:55:55 -0700
Message-ID: <7vhbxuzlkk.fsf@alter.siamese.dyndns.org>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com>
	<cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com>
	<7vhbxu6f87.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 01:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMW8Q-0000bf-3B
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 01:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbZGBXzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbZGBXzx
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 19:55:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43838 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZGBXzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 19:55:53 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702235555.BFZM18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 2 Jul 2009 19:55:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id BBvv1c00L4aMwMQ04BvvxF; Thu, 02 Jul 2009 19:55:55 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=SK8bdSSw-t4A:10 a=s9DunzN3-kS4Bjelyl0A:9
 a=v_V-SbdGULBg6NfK5ogA:7 a=KM1pRBaHkBxdIlGTvUhlBeCYxWEA:4 a=Xd8QDxADr6IA:10
 a=6J_nGldjey_7iN8l:21 a=aRyNp2xh8EJ_w2xl:21
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 2 Jul 2009 22\:33\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122676>

By the way, I think we need to make sure your understanding of how the
current code works matches mine before you go any further.

Are the words "preimage", "postimage" and "target" used consistently
between us?  By these words, I mean:

  preimage = the lines prefixed with '-' and ' ' in the patch

  postimage = the lines prefixed with ' ' and '+' in the patch

  target = lines in the file being patched that corresponds to the preimage

The point of patch application is to find a block of lines in the target
that matches preimage, and replace that block with postimage.  When the
patch applies cleanly (which is the case we should optimize for), the
preimage match the target byte-for-byte.  The hunk starting at line 1690
does a memcmp of the whole thing, without ws fuzz, for this reason.  You
do not want to touch that part with your patch (and that is why I am
writing this message to make sure you understand what you are doing).

After that, as a fallback, we compare line-by-line, while fixing the
whitespace breakage in the preimage (what the patch author based on) and
the target (what we currently have).  The reason for the loop is because
we are interested in two cases:

 (1) The patch was made against an old code without recent whitespace fix
     we already have.

 (2) The patch was made against a code with whitespace fix we do not have
     yet.

In either case, preimage and target won't match byte-for-byte, but by
applying the whitespace breakage on each of the preimage line and the
corresponding target line, they will match in either of the above cases.
While doing this "convert-and-match", we prepare a version of preimage
with whitespace breakage fixed to give to update_pre_post_images() at the
end of the function in fixed_buf.

The contents of fixed_buf is used to update the preimage and the postimage
by calling update_pre_post_images().  This is to avoid reverting the
whitespace fix we already had in the target when we are in situation (1).
The postimage is what replaces the block of lines in the image that
matched the preimage, so this step is essential.

This is another point I am worried about your patch.  Suppose you have this
target:

    a a a
    b b b
    c c
    d
    e e

And we have a broken patch that needs --ignore-whitespace to apply:

    diff --git a/file b/file
    index xxxxxx..yyyyyy 100644
    @@ -1,4, +1,5 @@
     a  a  a
     b b  b
    +q
     c  c
       d

Your preimage is "a  a  a\nb b  b\nc  c\n  d\n",
target is        "a a a\nb b b\nc c\nd\ne e\n",
and postimage is "a  a  a\nb b  b\nq\nc  c\n  d\n".

Wouldn't you want to have this as the result of patch application?

    a a a
    b b b
    q
    c c
    d
    e e

With whitespace squashed, the preimage would match the target (perhaps
after fixing line_matches()), but wsfix_copy() called while we fix each
preimage line won't have changed anything in the fixed_buf that is to
become the new preimage, and update_pre_post_images() while copying the
fixed preimage to the postimage won't have corrected "a a a" back to "a a
a" that was in the target as the result.

So I suspect that you would instead end up with:

    a  a  a
    b b  b
    c  c
      d
    e e

I think the intent of --ignore-whitespace is "don't worry about ws
differences in the context when locating where to make the change", and it
is not "I do not care about getting whitespace mangled anywhere in the
file the patch touches."  correct_ws_error is special in that we can
afford to take the fixed pre/postimage, "because we are fixing the ws
breakage anyway", but arguably it _might_ be nicer to limit the change to
the lines marked with '-' and '+' in the patch even in that case.
