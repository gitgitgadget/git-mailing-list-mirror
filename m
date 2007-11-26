From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Mon, 26 Nov 2007 12:39:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711261236280.27959@racer.site>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vbq9hiz6a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 13:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdGD-0003rn-N3
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 13:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbXKZMkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 07:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbXKZMkF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 07:40:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:38438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752804AbXKZMkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 07:40:03 -0500
Received: (qmail invoked by alias); 26 Nov 2007 12:39:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 26 Nov 2007 13:39:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198NhtuSrJ8hk5IgfsitnmTiDinayEjhi9BoaItZD
	OdwGu5mcnEHQ20
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq9hiz6a.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66067>

Hi,

On Sun, 25 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> > new file mode 100644
> > index 0000000..073ff7f
> > --- /dev/null
> > +++ b/Documentation/git-fast-export.txt
> > ...
> > +DESCRIPTION
> > +-----------
> > +This program dumps the given revisions in a form suitable to be piped
> > +into gitlink:git-fast-import[1].
> > +
> > +You can use it as a human readable bundle replacement (see
> > +gitlink:git-bundle[1]), or as a kind of an interactive
> > +gitlink:git-filter-branch[1].
> > +
> > +
> > +OPTIONS
> > +-------
> > +--progress=<n>::
> > +	Insert 'progress' statements every <n> objects, to be shown by
> > +	gitlink:git-fast-import[1] during import.
> > +
> > +--signed-tags=(ignore|warn|strip|abort)::
> > +	Specify how to handle signed tags.  Since any transformation
> > +	after the export can change the tag names (which can also happen
> > +	when excluding revisions) the signatures will not match.
> > ++
> > +When asking to 'abort' (which is the default), this program will die
> > +when encountering a signed tag.  With 'strip', the tags will be made
> > +unsigned, with 'ignore', they will be silently ignored (i.e. not exported)
> > +and with 'warn', they will be exported, but you will see a warning.
> 
> I am not sure if abort should be the default.

I tried to be conservative.

> If a straight dump-restore is made without rewriting, the result will be 
> identical to the original, right?

Yep.

> The reason I mention a straight dump-restore is because ...
> 
> > +$ git fast-export master~5..master |
> > +	sed "s|refs/heads/master|refs/heads/other|" |
> > +	git fast-import
> 
> ... I find this a quite unrealistic example to assume that the data
> stream does not have some string and convert blindly without parsing.

That's what the warning after the example is about.  For quick and dirty 
operations, it is quite adequate.

Besides, I have the feeling that some people are more comfortable dumping 
the whole repository into a file, editing it, and fast-importing it.  That 
is what I referred to when I said "think of it as kind of an interactive 
filter-branch".

> On the other hand, we _could_ also have a separate filter that works on 
> input stream for fast-import, but that filter should know what the 
> fast-import input stream looks like (a simple sed does not cut it).

I agree that for most serious operations sed is not good enough.

> So unless the future direction is to deprecate filter-branch and replace 
> it with such a fast-import based filter in between fast-export and 
> fast-import, I think the use of fast-export is to make verbatim copy 
> without munging the contents, which leads me to think --signed-tag 
> option should default to "export it as-is".
> 
> ... which seem to be missing from the available values to the option.

You mean something like "--signed-tag=warn 2> /dev/null"?  How about a 
"--signed-tag=quiet" mode?

> > diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> > new file mode 100755
> > index 0000000..48d0c54
> > --- /dev/null
> > +++ b/builtin-fast-export.c
> > ...
> > +/*
> > + * TODO:
> > + * - tags (--signed-tags=(ignore|warn|strip|abort)
> > + */
> 
> This comment is stale?

Correct.

Ciao,
Dscho
