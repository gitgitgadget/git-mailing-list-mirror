From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Implement vc-git-annotate-show-diff-revision-at-line
 for emacs vc-git
Date: Fri, 22 Feb 2008 12:51:37 -0800
Message-ID: <7vbq6890km.fsf@gitster.siamese.dyndns.org>
References: <1203706693.7552.56.camel@alexjb-desktop.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSesx-0002rs-WD
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 21:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763549AbYBVUvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762035AbYBVUvy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 15:51:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbYBVUvx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 15:51:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B57A516E;
	Fri, 22 Feb 2008 15:51:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 23A2C516D; Fri, 22 Feb 2008 15:51:45 -0500 (EST)
In-Reply-To: <1203706693.7552.56.camel@alexjb-desktop.transitives.com> (Alex
 Bennee's message of "Fri, 22 Feb 2008 18:58:13 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74758>

Alex Bennee <kernel-hacker@bennee.com> writes:

> +(defun vc-git-annotate-extract-revision-at-line ()
> +  (save-excursion
> +    (move-beginning-of-line 1)
> +    (and (looking-at "[0-9a-f]+")
> +         (buffer-substring (match-beginning 0) (match-end 0)))))

Does this grab the commit object name from the annotation
of a _full_ file?  How is the annotation done?  With "blame"
without frills?

It may be interesting to run:

	git blame -w -n -f -C -- $path

which would give you the code movement (ignoring whitespace
changes) across files, so that you can view where the line
really originated from.

You can also throw in -L line range limiter like this:

	git blame -L$lineno-10,+20 -w -n -f -C -- $path

which would limit the output to lines around the current line,
and that would be slightly less expensive than annotating the
whole file, if you do this on-demand.

E.g.

	$ git blame -L48,+20 -w -n -f -C -- block/blk-exec.c

would give you something like:

    165125e1 block/ll_rw_blk.c         2585 (Jens Axboe       2007-07-2...
    f1970baf drivers/block/ll_rw_blk.c 2255 (James Bottomley  2005-06-2...
    8ffdc655 block/ll_rw_blk.c         2320 (Tejun Heo        2006-01-0...
    f1970baf drivers/block/ll_rw_blk.c 2257 (James Bottomley  2005-06-2...
    f1970baf drivers/block/ll_rw_blk.c 2258 (James Bottomley  2005-06-2...
    f1970baf drivers/block/ll_rw_blk.c 2259 (James Bottomley  2005-06-2...
    f1970baf drivers/block/ll_rw_blk.c 2260 (James Bottomley  2005-06-2...
    4aff5e23 block/ll_rw_blk.c         2530 (Jens Axboe       2006-08-1...
    f1970baf drivers/block/ll_rw_blk.c 2262 (James Bottomley  2005-06-2...
    4c5d0bbd block/ll_rw_blk.c         2480 (Andrew Morton    2006-03-2...
    4c5d0bbd block/ll_rw_blk.c         2481 (Andrew Morton    2006-03-2...
    4c5d0bbd block/ll_rw_blk.c         2482 (Andrew Morton    2006-03-2...
    4c5d0bbd block/ll_rw_blk.c         2483 (Andrew Morton    2006-03-2...
    4c5d0bbd block/ll_rw_blk.c         2484 (Andrew Morton    2006-03-2...
    f1970baf drivers/block/ll_rw_blk.c 2265 (James Bottomley  2005-06-2...
    6e39b69e block/ll_rw_blk.c         2309 (Mike Christie    2005-11-1...
    6e39b69e block/ll_rw_blk.c         2310 (Mike Christie    2005-11-1...
    637b48c8 drivers/block/ll_rw_blk.c 1872 (Jens Axboe       2004-03-1...
    637b48c8 drivers/block/ll_rw_blk.c 1873 (Jens Axboe       2004-03-1...
    637b48c8 drivers/block/ll_rw_blk.c 1874 (Jens Axboe       2004-03-1...
