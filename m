From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add--interactive: ignore mode change in 'p'atch
 command
Date: Thu, 27 Mar 2008 09:24:10 -0700
Message-ID: <7v7ifob0et.fsf@gitster.siamese.dyndns.org>
References: <cover.1206602393.git.peff@peff.net>
 <20080327073043.GB22444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeuuY-0006Ed-AA
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 17:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbYC0QYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 12:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbYC0QYY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 12:24:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395AbYC0QYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 12:24:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DE07F51A1;
	Thu, 27 Mar 2008 12:24:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4949C51A0; Thu, 27 Mar 2008 12:24:13 -0400 (EDT)
In-Reply-To: <20080327073043.GB22444@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 27 Mar 2008 03:30:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78352>

Jeff King <peff@peff.net> writes:

> When a path is examined in the patch subcommand, any mode
> changes in the file are given to use in the diff header by
> git-diff. If no hunks are staged, then we throw out that
> header. But if _any_ hunks are staged, we use the header,
> and the mode is changed.
>
> Since the 'p'atch command should just be dealing with hunks
> that are shown to the user, it makes sense to just ignore
> mode changes entirely. We do squirrel away the mode, though,
> since a future patch will allow users to select the mode
> update.

I agree that treating each logical block of the metainformation as if it
is a hunk on its own makes sense.  Possibly, it would be useful to make
the interactive patch session look like this:

    diff --git a/gostak b/doshes
    old mode 100644
    new mode 100755
    Stage the mode change [y/n/a/d/j/J/?]?
    similarity index 90%
    rename from gostak
    rename to doshes
    Stage the name change [y/n/a/d/j/J/?]?
    @@ -1,5 +1,5 @@
     The
    -gostak
    +Gostak
     distims
     doshes
    Stage this hunk [y/n/a/d/j/J/?]?

Handlilng the rename needs a bit more thought and enhancements not just in
your parse_diff_header() code but the way we extract the diff text (we
would need to first find renames by whole-tree diff and then feed two
(src,dst) paths in parse_diff() to obtain the text), but it should be
doable.

By the way, why was it done as a new sub called from parse_diff() and not
as a part of parse_diff() itself?
