From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 12:10:11 -0700
Message-ID: <7vabhlb3ho.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8K6k-00062w-Qc
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 21:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYFPTKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 15:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYFPTKU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 15:10:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbYFPTKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 15:10:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D8CF5B8FE;
	Mon, 16 Jun 2008 15:10:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0D30DB8FD; Mon, 16 Jun 2008 15:10:13 -0400 (EDT)
In-Reply-To: <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 16 Jun 2008 11:46:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAF93DD8-3BD7-11DD-91C7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85218>

Junio C Hamano <gitster@pobox.com> writes:

> Ingo Molnar <mingo@elte.hu> writes:
> ...
>>  - Automation: would be nice to have a git-rerere modus operandi where
>>    it would auto-commit things if and only if all conflicting files were 
>>    resolved.
>
> I am not sure how safe this is.  rerere as originally designed does not
> even update the index with merge results so that the application of
> earlier resolution can be manually inspected, and this is exactly because
> I consider a blind textual reapplication of previous resolution always
> iffy, even though I invented the whole mechanism.

By the way, this safety is not a theoretical issue but has been a real
one.  I had two topics that changed the calling convention of the same
function in different ways, and when they were merged to 'pu', the
declaration, definition, and call sites existed on both of these branches
were handled beautifully by rerere.

Recording autoresolution would have been a wrong thing to do.  One of the
branches added a new call site to a file that was not among the ones that
conflicted in the merge between the two branches.  That call site, that
uses the calling convention of one branch, needed to be adjusted to
accomodate the change of calling convention from the other branch (from
textual merge's point of view, this has to be an evil merge).  I had to
make and keep a mental note about that new call site until both topics
graduated to 'master' (similar to your need to remember a particular merge
is resolved to removal right now).

To safely automate reapplication of such a merge, rerere needs to become
much more clever.

The conflicts rerere notices and records are strictly per blob.  A
conflicted merge to a blob is inspected and a "conflict signature", which
becomes the directory name under rr-cache, is computed.  We record the
conflicted blob as a whole as the preimage, and your hand resolution as a
whoe as the postimage.  Next time when you have a conflicted merge to a
blob, and the conflict has the exact same conflict signature, we run
three-way merge between the recorded preimage, postimage and the new
conflicted result.

If we want to handle new call sites added only on a single side, you
should be able to express something like "when a merge has a conflicted
blob with this conflict signature, look in the whole tree, even outside
the set of conflicted paths, and change this text to that".  This is too
much automation and I somehow think the potential for errors (both from
the tool and from the user) is too high.
