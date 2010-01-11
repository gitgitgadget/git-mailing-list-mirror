From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Mon, 11 Jan 2010 20:22:31 +0100
Message-ID: <201001112022.31257.j6t@kdbg.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com> <7vpr5krxoo.fsf@alter.siamese.dyndns.org> <7v4omte72j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUPrQ-0004LU-BW
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 20:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab0AKTX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930Ab0AKTX1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 14:23:27 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:63486 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753912Ab0AKTX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 14:23:27 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6D2B810028;
	Mon, 11 Jan 2010 20:23:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8276A19F5C6;
	Mon, 11 Jan 2010 20:22:31 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v4omte72j.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136655>

On Montag, 11. Januar 2010, Junio C Hamano wrote:
> I ended up doing this myself.  As we are dropping the postimage and adding
> a new MERGE_RR entry, I also think that it is safer to update the preimage
> with the conflict we got for this round, so I added that as well.

Thank you, it appears to work as expected. It is actually very important to 
update the preimage as well, otherwise, the new postimage can contain 
unrelated additional changes.

> However, I think there is a room for improvement in preimage handling.
>
> Currently, the rerere database is indexed with the conflict hash and for
> each conflict hash you can record a single preimage-postimage pair to
> replay.  But you can have conflicts with the same conflict hash, but with
> slightly different contexts outside the conflicted region, and the right
> resolution can be different depending on the outside context.

I did encounter a case where the same resolution would apply to all conflicts 
that have the same conflict hash, so it's not quite what you talk about. But 
not all conflicts were automatically resolved. I haven't yet analyzed what 
happened - it could just be that the xdl_merge call fails due to the 
differences in the text immediately outside the conflict markers.

> In the traditional implementation, I punted this issue by noticing
> conflicts in the three-way merge between pre, post and this images.  If
> preimage is too different from the conflicted contents we got during this
> merge, then the previous resolution should not apply.
>
> But I think the right solution would be to have more than one preimage and
> postimage pairs (preimage.0 vs postimage.0,... etc.) and try to use each
> of them in handle_path() until it finds one that can be used to cleanly
> merge with the conflict we got in thisimage during this round.

The situation happens rarely, so I don't know if we should care. OTOH, *when* 
the situation arises, and a recorded resolution is applied incorrectly, it 
may be quite annoying. Dunno.

-- Hannes
