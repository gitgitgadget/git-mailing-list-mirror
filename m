From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Fri, 3 May 2013 19:56:47 +0200
Message-ID: <87y5bw3q1s.fsf@hexa.v.cablecom.net>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 19:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYKE2-0007wX-Fn
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 19:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023Ab3ECR4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 13:56:50 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:51190 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933827Ab3ECR4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 13:56:49 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 May
 2013 19:56:38 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 May
 2013 19:56:47 +0200
In-Reply-To: <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 2 May 2013 23:31:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223316>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no point in storing blob, they would increase the time of
> loading the marks, and the vast majority of them will never be used
> again.
>
> This also makes fast-export and fast-import marks compatible.
[...]
> -			if (m->data.marked[k])
> +			if (m->data.marked[k]) {
> +				struct object_entry *e;
> +				e = m->data.marked[k];
> +				if (e->type != OBJ_COMMIT)
> +					continue;
>  				fprintf(f, ":%" PRIuMAX " %s\n", base + k,
> -					sha1_to_hex(m->data.marked[k]->idx.sha1));
> +					sha1_to_hex(e->idx.sha1));
> +			}

IIUC, you are unconditionally storing only marks to commit objects.

Are you allowed to do that at this point?  I notice that
git-fast-export(1) says

   --export-marks=<file>
       Dumps the internal marks table to <file> when complete. Marks are
       written one per line as :markid SHA-1. Only marks for revisions
       are dumped[...]

But git-fast-import(1) says nothing of the sort; I would even claim that

   --export-marks=<file>
       Dumps the internal marks table to <file> when complete.

means that the *full* marks table is dumped.

How do we know that this doesn't break any users of fast-import?  Your
comment isn't very reassuring:

> the vast majority of them will never be used again

So what's with the minority?

In any case, if this does go in, please update the documentation to
match, probably by copying the sentence from git-fast-export(1).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
