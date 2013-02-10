From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent parents
Date: Sun, 10 Feb 2013 21:02:29 +0000
Message-ID: <20130210210229.GB2270@serenity.lan>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
 <7vliawt19c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4e3E-0002rW-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab3BJVCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2013 16:02:39 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46940 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab3BJVCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:02:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9BD1C6064D0;
	Sun, 10 Feb 2013 21:02:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThXjPwZ7+CWF; Sun, 10 Feb 2013 21:02:38 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 3CE6D6064A6;
	Sun, 10 Feb 2013 21:02:31 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vliawt19c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215933>

On Sun, Feb 10, 2013 at 11:30:39AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>=20
> > Can you squash this into the first commit before you do?
> >
> > Matthieu is correct that the graph_is_commit_finished() check isn't
> > needed in the loop now that we've pulled it out to be checked first=
 -
> > the value returned can't change during the loop.  I've left the ear=
ly
> > return out.
> >
> >  graph.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/graph.c b/graph.c
> > index 2a3fc5c..56f970f 100644
> > --- a/graph.c
> > +++ b/graph.c
> > @@ -1237,7 +1237,7 @@ void graph_show_commit(struct git_graph *grap=
h)
> >  		shown_commit_line =3D 1;
> >  	}
> > =20
> > -	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
> > +	while (!shown_commit_line) {
> >  		shown_commit_line =3D graph_next_line(graph, &msgbuf);
> >  		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
> >  		if (!shown_commit_line)
>=20
> Is it correct to say that this essentially re-does 656197ad3805
> (graph.c: infinite loop in git whatchanged --graph -m, 2009-07-25)
> in a slightly different way, in that Micha=C5=82's original fix also
> protected against the case where graph->state is flipped to
> GRAPH_PADDING by graph_next_line() that returns false, but with your
> fixup, the code knows it never happens (i.e. when graph_next_line()
> returns false, graph->state is always in the GRAPH_PADDING state),
> and the only thing we need to be careful about is when graph->state
> is already in the PADDING state upon entry to this function?

Yes, although I wonder if we can end up in POST_MERGE or COLLAPSING
state here as well.  The check in the loop guards against that because
those will eventually end up as PADDING.

As far as I can see, this is okay because we have called
graph_show_remainder() at the end of outputting a commit, even when we
end up outputting the same (merge) commit more than once.  But someone
more familiar with the graph code might want to comment here.


John
