From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --no-rename to git-apply
Date: Wed, 26 Sep 2007 22:12:06 -0700
Message-ID: <7vbqbozo7t.fsf@gitster.siamese.dyndns.org>
References: <11908420041596-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 07:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ialfg-00059S-11
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXI0FMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 01:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXI0FMN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:12:13 -0400
Received: from rune.pobox.com ([208.210.124.79]:54493 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbXI0FMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:12:12 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id CD0B113C2CD;
	Thu, 27 Sep 2007 01:12:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 40D2C13B8D8;
	Thu, 27 Sep 2007 01:12:30 -0400 (EDT)
In-Reply-To: <11908420041596-git-send-email-robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Wed, 26 Sep 2007 23:26:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59262>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> With this option git-apply can apply a patch with a rename
> onto the original file(s).

This is troubling from both design and implementation point of
view.

 * Why would this be useful?  What's the point of producing the
   renaming patch if you know you would want to apply while
   ignoring the rename?

 * The change looks too special purpose to me.  If you are
   giving the ability to deposit the result to somewhere other
   than where the patch intendes to, why limit it only to the
   preimage name?  Aren't there cases where A is renamed to B
   sometime in the history, and you have a patch that talks
   about the content change A->A but the tree you have has the
   contents already in B, and you would want to apply that
   patch?  It feels that this and your "ignore rename" could be
   handled much more cleanly and flexibly by preprocessing the
   patchfile.

 * By disabling the parsing of rename header lines, you are
   disabling the sanity checking of the input done in
   gitdiff_verify_name() called from gitdiff_oldname() and
   gitdiff_newname().  I think it is wrong for --no-rename
   option to affect the parsing of the input.  If we were to do
   this, perhaps write_out_results() or one of its callee would
   be a better place to do so.
