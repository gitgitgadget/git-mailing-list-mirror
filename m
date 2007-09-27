From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] This exports the update() function from builtin-add.c as
Date: Thu, 27 Sep 2007 02:05:58 -0700
Message-ID: <7v7imcv5op.fsf@gitster.siamese.dyndns.org>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
	<1190868632-29287-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 11:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IapK0-0004p6-0p
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 11:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbXI0JGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbXI0JGD
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 05:06:03 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35836 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbXI0JGA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 05:06:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070927090600.LYMV16791.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 27 Sep 2007 05:06:00 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id tM601X0011gtr5g0000000; Thu, 27 Sep 2007 05:06:00 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59277>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>

Huh?  -EPARSE_TITLE_STRING

[PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
[PATCH 2/4] This exports the update() function from builtin-add.c as
[PATCH 3/4] Implement git commit as a builtin command.
[PATCH 4/4] Move launch_editor() and stripspace() to new file editor.c.

Let's step back a bit.  The whole series organization is very
screwy.  Especially I do not think 4/4 should be at the end.

Reviewing your old series...

 * Enable wt-status output to a given FILE pointer.
 * Enable wt-status to run against non-standard index file.

Let's have the above two from the previous series in 'next'.

Now the following five that have been in 'pu' are from the older
series:

 * Introduce entry point for launching add--interactive.
 * Clean up stripspace a bit, use strbuf even more.
 * Add strbuf_read_file().
 * Export rerere() and launch_editor().
 * Implement git commit as a builtin command.

The changes to stripspace and strbuf_read_file() are unrelated
to making the commit command a builtin.  I have extended the
strbuf topic with these two and merged the result to 'next'.

I think the right organization for the "builtin-commit" series
should be:

 * merge strbuf topic in kh/commit topic, in order to get the
   stripspace updates and strbuf_read_file();

 * add--interactive entry point change (respin the one from the
   old series);

 * rename update() to add_files_to_cache() and export (respin
   this [2/4] with a better commit message);

 * create a separate rerere() function and export (respin part
   of old series, with proper refactoring);

   I am not happy with builtin-foo.c calling into something from
   builtin-bar.c, though.  We probably would want to move
   rerere() and add_files_to_cache() somewhere else.

 * move launch_editor() and stripspace() to create editor.c (new
   [4/4]);

 * add option parser in parse-options.[ch] (new [1/4]);

 * finally, create builtin-commit that uses the groundwork laid
   out above (new [3/4]).

I ended up doing the above up to the rerere() one myself, but
haven't done the rest.

I probably would start more aggressively asking the original
author to clean up and resubmit from now on.  I haven't managed
to scrape enough time for myself to code anything meaningful for
git recently, and instead spent too much time fixing up other
peoples code.
