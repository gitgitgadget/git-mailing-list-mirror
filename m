From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] builtin/am: read mailinfo from file
Date: Thu, 7 Apr 2016 20:15:51 +0300
Message-ID: <20160407201323-mutt-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
 <1460042563-32741-4-git-send-email-mst@redhat.com>
 <xmqqinzt1h4a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:16:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDXF-0004tk-BP
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbcDGRP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbcDGRP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:15:56 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F4977F080;
	Thu,  7 Apr 2016 17:15:55 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37HFqxc003816;
	Thu, 7 Apr 2016 13:15:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqinzt1h4a.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290929>

On Thu, Apr 07, 2016 at 10:08:37AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Slightly slower, but will allow easy additional processing on it.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> I haven't read 4/4 yet, but can guess from what this patch does that
> the next step would let others futz with the contents of the message
> that is on disk (i.e. what mailinfo() wrote out, which is identical
> to what we have in mi.log_message at this point of the codeflow)
> before you do the new strbuf_read_file().
> 
> It probably is better to do this as part of 4/4; it is easier to
> understand why this is a good and necessary thing to do.  An obvious
> improvement is to omit this extra "read back from the filesystem"
> when we won't be making any interpret-trailer calls (i.e. no -t
> option from the command line), but if we stop at this step 3/4, then
> we'd end up wasting cycles without having any benefit.

Hmm - splitting it out was easy for development since I could verify all
tests pass.  But if you do want the optimization, then sure, I'll have
to squash it in.

> >  builtin/am.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/am.c b/builtin/am.c
> > index d003939..4180b04 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -1246,6 +1246,7 @@ static int parse_mail(struct am_state *state, const char *mail)
> >  	FILE *fp;
> >  	struct strbuf sb = STRBUF_INIT;
> >  	struct strbuf msg = STRBUF_INIT;
> > +	struct strbuf log_msg = STRBUF_INIT;
> >  	struct strbuf author_name = STRBUF_INIT;
> >  	struct strbuf author_date = STRBUF_INIT;
> >  	struct strbuf author_email = STRBUF_INIT;
> > @@ -1330,7 +1331,12 @@ static int parse_mail(struct am_state *state, const char *mail)
> >  	}
> >  
> >  	strbuf_addstr(&msg, "\n\n");
> > -	strbuf_addbuf(&msg, &mi.log_message);
> > +
> > +	if (strbuf_read_file(&log_msg,  am_path(state, "msg"), 0) < 0) {
> > +		die_errno(_("could not read '%s'"), am_path(state, "msg"));
> > +	}
> 
> I do not think these {} serve any purpose; drop them?
> 
> > +
> > +	strbuf_addbuf(&msg, &log_msg);
> >  	strbuf_stripspace(&msg, 0);
> >  
> >  	if (state->signoff)
> > @@ -1349,6 +1355,7 @@ static int parse_mail(struct am_state *state, const char *mail)
> >  	state->msg = strbuf_detach(&msg, &state->msg_len);
> >  
> >  finish:
> > +	strbuf_release(&log_msg);
> >  	strbuf_release(&msg);
> >  	strbuf_release(&author_date);
> >  	strbuf_release(&author_email);
