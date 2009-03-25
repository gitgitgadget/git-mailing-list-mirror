From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Document details of transport function APIs
Date: Wed, 25 Mar 2009 12:19:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251142470.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303250.19665@iabervon.org> <7v63hy9k0l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVrR-00078D-Tk
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558AbZCYQUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757582AbZCYQUA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:20:00 -0400
Received: from iabervon.org ([66.92.72.58]:41927 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756181AbZCYQT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:19:58 -0400
Received: (qmail 23944 invoked by uid 1000); 25 Mar 2009 16:19:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 16:19:56 -0000
In-Reply-To: <7v63hy9k0l.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114615>

On Tue, 24 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > In particular, explain which of the fields of struct ref is used for
> > what purpose in the input to and output from each function.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  transport.h |   38 ++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 38 insertions(+), 0 deletions(-)
> >
> > diff --git a/transport.h b/transport.h
> > index 489e96a..2e1650a 100644
> > --- a/transport.h
> > +++ b/transport.h
> > @@ -18,11 +18,49 @@ struct transport {
> >  	int (*set_option)(struct transport *connection, const char *name,
> >  			  const char *value);
> >  
> > +	/**
> > +	 * Returns a list of the remote side's refs. In order to allow
> > +	 * the transport to try to share connections, for_push is a
> > +	 * hint as to whether the ultimate operation is a push or a fetch.
> > +	 *
> 
> It is unclear what this "hint" is intended to be used for, what the
> transport is and isn't allowed to use it for, and what existing transports
> typically use it for.

I don't think there's anything the transport isn't allowed to use the hint 
for (of course, it shouldn't go and do things that haven't been requested 
at all yet, but that's true with or without a hint). It's intended to be 
used for things like the git native protocol, where the client side has to 
declare up front whether it wants to talk to receive-pack or upload-pack, 
and it would have to disconnect and reconnect to get the other one.

It's probably also legitimate for the http transport to guess that, if 
"for_push" is true, that it's worth trying to list directories with 
webdav, although perhaps it should try both in any case.

> > +	/**
> > +	 * Push the objects and refs. Send the necessary objects, and
> > +	 * then tell the remote side to update each ref in the list
> > +	 * from old_sha1 to new_sha1.
> > +	 *
> > +	 * Where possible, set the status for each ref appropriately.
> > +	 *
> > +	 * If, in the process, the transport determines that the
> > +	 * remote side actually responded to the push by updating the
> > +	 * ref to a different value, the transport should modify the
> > +	 * new_sha1 in the ref. (Note that this is a matter of the
> > +	 * remote accepting but rewriting the change, not rejecting it
> > +	 * and reporting that a different update had already taken
> > +	 * place)
> > +	 **/
> 
> It this even a sane thing to allow?  How would it interact with the
> "pretend we immediately turned around and fetched them into the remote
> tracking branches" local updates we usually do?

We already allow a git server to rewrite refs with a hook when it gets 
them, and we record the pre-rewriting value. This allows the transport to 
propagate the post-rewriting value back (if it can get it), and we'd 
update the tracking branches with what the server actually did instead of 
what we asked it to (i.e., we do what we would do if we really did turn 
around and fetch them immediately).

Of course, I primarily want this for the case where it's a foreign system 
and we don't get to control everything in the foreign history, even when 
it is accepted (e.g., it applies its own timestamp and attributes it to a 
different username), and we want to avoid simply losing the information as 
to what became of the commit.

> >  	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
> >  	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
> >  
> > +	/** get_refs_list(), fetch(), and push_refs() can keep
> > +	 * resources (such as a connection) reserved for futher
> > +	 * use. disconnect() releases these resources.
> > +	 **/
> >  	int (*disconnect)(struct transport *connection);
> >  	char *pack_lockfile;
> >  	signed verbose : 2;
> 
> It is just a style thing, but all of our multi-line comments are
> 
>    /*
>     * of
>     * this
>     * form
>     */
> 
> and these new comments are formatted slightly differently with double
> asterisks on only the first and the last lines.  In addition, th last
> comment block uses a yet another different style, which is a bit of
> eyesore.

Ah, yes, I'll correct that.

	-Daniel
*This .sig left intentionally blank*
