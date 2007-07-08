From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sat, 07 Jul 2007 18:31:15 -0700
Message-ID: <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
References: <20070405071615.2915.6837.reportbug@acer>
	<20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
	<6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
	<20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131354250.4059@racer.site>
	<20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131543140.4059@racer.site>
	<20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0707080148370.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 03:31:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7LcX-0005D1-Tp
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 03:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbXGHBbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 21:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbXGHBbS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 21:31:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63280 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbXGHBbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 21:31:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708013117.ZQOZ1257.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 21:31:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LpXF1X00H1kojtg0000000; Sat, 07 Jul 2007 21:31:16 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51852>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -643,6 +643,20 @@ int threeway_merge(struct cache_entry **stages,
>  	index = stages[0];
>  	head = stages[o->head_idx];
>  
> +	/*
> +	 * Special case: do not care about a dir/file conflict, when
> +	 * the entries have not been touched.
> +	 * IOW if the ancestors are identical to the remote, and the
> +	 * index is the same as head, just take head.
> +	 */

Suppose paths "A" and "A/B" are involved, and you resolved with
this logic to have "A" as a blob (so your HEAD does not have
"A/B").  If the remote adds "A/B", what prevents the resulting
index to have both "A" and "A/B" resolved at stage #0?

A logic to do "if it is unchanged on one and changed in another,
take changed one" already exists in later part of the code; your
patch just circumvents D/F checks built into threeway_merge for
this one case, and only because this one case happens to have
reported.  It doesn't feel right.

IOW, don't make unpack-trees to make policy decisions on final
resolution, unless it is operating under aggressive rule (where
the caller explicitly allows it to make more than the "trivial"
decisions).  The caller (in this case, merge-recursive) should
see A at stage #2 with A/B at stages #1 and #3 and decide what
to do.
