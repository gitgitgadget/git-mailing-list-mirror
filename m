From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Mon, 12 Nov 2007 21:43:40 -0800
Message-ID: <7v1wauzomr.fsf@gitster.siamese.dyndns.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IroZE-0003Z7-O1
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 06:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXKMFny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 00:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbXKMFny
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 00:43:54 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44030 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbXKMFnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 00:43:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AB8E72F2;
	Tue, 13 Nov 2007 00:44:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 140CB9329F;
	Tue, 13 Nov 2007 00:44:08 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 12 Nov 2007 20:58:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64755>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Anyway, this is a real fix, but gitk remains a bit useless as is.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  revision.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 931f978..8872a91 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1352,6 +1352,8 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
>  		if (!revs->limited)
>  			if (add_parents_to_list(revs, p, &revs->commits) < 0)
>  				return rewrite_one_error;
> +		if (!p->object.parsed)
> +			return rewrite_one_ok;
>  		if (p->parents && p->parents->next)
>  			return rewrite_one_ok;
>  		if (p->object.flags & (TREECHANGE | UNINTERESTING))

This is too subtle, or I am missing something.

I have to wonder what would happen if a much higher level caller
caused the objects to get parsed before coming into the revision
walking machinery, e.g. after the command line processing for
A...B walked the ancestry chain until their common ancestors are
found.  So these commits between A and B are parsed, but the
revision limiting machinery hasn't done its operation to set
TREECHANGE and/or UNINTERESTING in add_parents_to_list() on
these commits yet.

I think the fix will not trigger for such parents, but the
processing just goes on.
