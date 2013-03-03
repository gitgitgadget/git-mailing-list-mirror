From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 3 Mar 2013 23:24:14 +0000
Message-ID: <20130303232413.GN7738@serenity.lan>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch>
 <20130303102946.GH7738@serenity.lan>
 <7vk3pob38d.fsf@alter.siamese.dyndns.org>
 <20130303214206.GL7738@serenity.lan>
 <7vppzg9k0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIHC-0005Zx-53
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab3CCXY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:24:29 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:37607 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab3CCXY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:24:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 76FEDCDA570;
	Sun,  3 Mar 2013 23:24:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6Z6Mlp2Uuo5; Sun,  3 Mar 2013 23:24:24 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0C611CDA55E;
	Sun,  3 Mar 2013 23:24:16 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vppzg9k0n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217366>

On Sun, Mar 03, 2013 at 02:49:12PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Sun, Mar 03, 2013 at 01:08:50PM -0800, Junio C Hamano wrote:
> >> >> > Additionally, it seems that Johan added graph_set_column_colors
> >> >> > specifically so that CGit should use it - there's no value to having
> >> >> > that as a method just for its use in graph.c and he was the author of
> >> >> > CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).
> >> >> 
> >> >> Perhaps you could add a comment in the source to prevent this from
> >> >> happening again?
> >> > ...
> >> > I would hope that having this message in the history should be enough to
> >> > prevent this changing in the future....
> >> 
> >> Given how it happened in the first place, I do not think anything
> >> short of in-code comment would have helped.  There wouldn't be any
> >> hint to look into the history without one.
> >
> > So you'd accept a patch doing that?
> 
> The answer obviously depends on the specifics of "that" ;-) I was
> merely agreeing with what Thomas said.  A straight-revert would be
> insufficient to prevent this from recurring again.
> 
> > Something like this perhaps:
> >
> >     NOTE: Although these functions aren't used in Git outside graph.c,
> >     they are used by CGit.
> 
> It would be a good place to start, although I prefer to see it
> completed with s/used by CGit/& in order to do such and such/ by
> somebody working on CGit.

CGit uses graph_set_column_colors() to set the column colors to:

    "<span class='column1'>",
    ...
    "<span class='column6'>",
    "</span>"

(the last value is RESET), thus avoiding the need to filter the output
to convert ANSI colours to HTML.

Similarly, it accesses graph_next_line() directly so that it can output
the necessary HTML around each line.

> Also it probably is worth adding contact information for folks who
> work on CGit (http://hjemli.net/git/cgit/ might be sufficient),

The current CGit homepage is http://git.zx2c4.com/cgit/

>                                                                 as
> changing these functions (e.g. changing the function signature) will
> affect them; making them "static" is not the only way to hurt them.

But since CGit uses a specific version of Git (as a submodule), in
general it doesn't need to worry about keeping consistency across
different versions.  CGit has been using Git 1.7.6 for quite a while -
I posted a series of patches to take it to 1.7.12 yesterday [1] but hit
this issue when I got to 1.8.x.

I think CGit expects to have to respond to changes in Git, so I don't
think it's worth restricting changes in Git for that reason - it's just
a case of exposing useful functionality somehow.

[1] http://hjemli.net/pipermail/cgit/2013-March/000933.html
