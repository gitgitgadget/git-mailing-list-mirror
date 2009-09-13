From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] transport-helper.c: don't leak fdopen'd stream buffers
Date: Sun, 13 Sep 2009 17:20:36 +0200
Message-ID: <200909131720.36853.j6t@kdbg.org>
References: <87hbv833kd.fsf@meyering.net> <7vtyz760lm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 17:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmqsh-0004Zr-Io
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 17:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbZIMPUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 11:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbZIMPUi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 11:20:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:64172 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbZIMPUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 11:20:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 44224CDF83;
	Sun, 13 Sep 2009 17:20:37 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 33244435B3;
	Sun, 13 Sep 2009 17:20:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtyz760lm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128369>

On Sonntag, 13. September 2009, Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
> > diff --git a/transport-helper.c b/transport-helper.c
> > index f57e84c..0bbd014 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -49,6 +49,7 @@ static struct child_process *get_helper(struct
> > transport *transport) if (!strcmp(buf.buf, "fetch"))
> >  			data->fetch = 1;
> >  	}
> > +	fclose (file);
> >  	return data->helper;
> >  }
> >
> > @@ -88,6 +89,7 @@ static int fetch_with_fetch(struct transport
> > *transport, if (strbuf_getline(&buf, file, '\n') == EOF)
> >  			exit(128); /* child died, message supplied already */
> >  	}
> > +	fclose (file);
> >  	return 0;
> >  }
>
> The callchain of fetch_with_fetch() looks like:
>
>     fetch_with_fetch()
>         helper = get_helper();
>         --> get_helper()
>             - start helper with start_command();
>             - read from helper->out until it sees an empty line;
>             - break out of the loop;
>         <-- return helper
>         - file = xfdopen(helper->out) to get another FILE on the fd
>         - read the rest of the output from helper->out via file
>
> It seems to me that the fclose() in get_helper() will close the underlying
> fd and would break the caller, no?
>
> I think "struct helper_data" should get a new FILE* field and once
> somebody creates a FILE* out of its helper->out, that FILE* can be passed
> around without a new xfdopen().
>
> Or something like that.
>
> Who is responsible for closing the underlying helper->out fd in the
> start_command() API, by the way?

A pipe was requested by setting helper->out = -1 before the call to 
start_command(), and in such a case the caller must close the fd.

-- Hannes
