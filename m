From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Alternates and push
Date: Mon, 8 Sep 2008 03:24:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809080246520.19665@iabervon.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <20080907234118.GA8161@mit.edu> <7v4p4ri5t2.fsf@gitster.siamese.dyndns.org>
 <7viqt7gmtq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@MIT.EDU>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 09:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcb8S-0004yJ-JD
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 09:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYIHHY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbYIHHY6
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 03:24:58 -0400
Received: from iabervon.org ([66.92.72.58]:37729 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbYIHHY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 03:24:58 -0400
Received: (qmail 32374 invoked by uid 1000); 8 Sep 2008 07:24:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Sep 2008 07:24:56 -0000
In-Reply-To: <7viqt7gmtq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95223>

On Sun, 7 Sep 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Theodore Tso <tytso@MIT.EDU> writes:
> >
> >> One way that wouldn't break backwards compatibility would be to use
> >> $D/refs if it exists, but if it isn't, fall back to existing behavior
> >> (which is to say, only use the refs in the repository, not in the
> >> borrowed repository/object store).  Is there a reason why this would
> >> be problematic?
> >
> > This does not answer "is this safe enough change?" question, but the code
> > to implement this should look like this (Area expert Daniel CC'ed).
> 
> Oops, I forgot to Cc Daniel.  Shawn also CC'ed because he will have the
> same issue with the smart CGI based http-push he is building.

The use of transport in general looks good to me; I'm not really an area 
expert for the native protocol.

> > +static int add_refs_from_alternate(struct alternate_object_database *e, void *unused)
> > +{
> > +	char *other = xstrdup(make_absolute_path(e->base));
> > +...
> > +	remote = remote_get(other);
> > +	transport = transport_get(remote, other);
> > +	for (extra = transport_get_remote_refs(transport);
> > +	     extra;
> > +	     extra = extra->next) {
> > +		/*
> > +		 * Make sure this is named uniquely but with invalid name, so
> > +		 * that we can catch the other end trying to do anything funky
> > +		 * with it.
> > +		 */
> > +		strbuf_reset(&buf);
> > +		strbuf_addf(&buf, "refs/borrowed-ref/%s", extra->name);
> > +		add_extra_ref(buf.buf, extra->old_sha1, 0);
> > +	}
> > +	transport_disconnect(transport);
> > +	free(other);
> > +	return 0;
> > +}
> 
> I need to clarify the comment in the above function.
> 
> When you are running "git push", the protocol employed is the send-pack
> protocol, which begins by the receiving end advertising what refs it has
> and where they point at.  The above code is in the receiving end and adds
> extra refs from alternate repositories to this advertisement.
> 
> The advertisement serves two different purposes.  One is the immediate
> issue we are tackling --- to tell the sending end what objects are not
> needed in the pack it sends.  Objects that are reachable from the objects
> in this advertisement do not have to be sent.  When the sending end wants
> to send its 'master', for example, it uses this information to compute the
> set of objects by doing (roughly):
> 
> 	git rev-list --objects master --not $sha1_1 $sha1_2 ...
> 
> where $sha1_N are the objects we advertise here.  The more we assure the
> sender we have, the less it has to send to us.
> 
> But there is another purpose the sender uses this information for.  It is
> used to determine which refs to push (when "git push" is run without any
> explicit refspecs, it does "matching refs" -- it learns the set of refs
> the receiving end has from this advertisement, and updates the refs of the
> same name the sending end also has), and which branches on the receiving
> end should be removed (when "git push --mirror" is run, it will send NULL
> updates to refs the receiving end has but the sender doesn't).
> 
> We do want to show the extra object names to the sender so that it can
> exclude more objects from the transfer, but for the latter purpose, we
> really do not want these phoney refs to be understood as refs we have by
> the sending end.  In the original version of my patch, I actually had
> "refs/borrowed*refs%s/%s" as the format string (notice the asterisk) to
> make it an invalid refname, and (notice the extra %s) to make them unique
> by including the full-pathname to the repository as part of this string,
> so that we can pretend we have different 'master' from two alternate
> repositories.
> 
> The sending end, however, has a safety to silently ignore malformed refs
> it learns from the receiving end over the wire.  So the current sender
> won't work with asterisk in there '*', nor full-pathname, because
> typically it contains "/.git/" in the string, which would make it an
> invalid refname to be ignored.
>
> Also, the sending end remembers the objects we have per refname, so
> sending two records with the same refname pointing at two different
> objects will not work well either (the current code is loose and does not
> check duplicates, but that is not a feature by design but is an accident).
> If the receiving repository borrows from two alternate repositories, both
> of which have 'master' branch, we would be sending two records, each of
> which claims that it is "refs/borrowed-ref/refs/heads/master" but pointing
> at a different commit.
> 
> That is the "unique and invalid" comment above is about (iow, the above
> hunk that does not send "unique and invalid" refs cannot be the final form
> of this enhancement).
> 
> What this means is that we also need to update the sending side in order
> to enable this enhancement.  connect.c::get_remote_heads() is the relevant
> code and we would probably need to add an option to keep all refs (and
> invalid refs) in the returned list.  Both remote.c::match_refs() and
> builtin-send-pack.c::do_send_pack() need to be taught to ignore the
> invalid refs in the list, while builtin-send-pack.c::pack_objects() should
> utilize all the refs (and invalid ones) when excluding the objects the
> receiving end claims to have.  While at it, we probably should declare
> that sending duplicate invalid refs is not an error (and we can use
> something like "*borrowed*" as the phoney refname --- we do not need the
> uniqueness for them, nor we need to tell the other end what ref we are
> borrowing from whom).

I think we should use a really invalid ref name, like "^" or something 
like that, so that it's clearly not an actually available ref, but just a 
way for the remote to mention that it has the object, and the remote 
doesn't have to try to make it unique.

> We can start sending invalid refs (just replace - with * in the patch I
> sent) from the receiving end without waiting for the sender end program to
> get updated.  The sending end will ignore it and nothing (other than the
> extra startup overhead the additional code has) bad should happen.  When
> the sender is updated to keep the invalid refs, it will start to take
> notice and your push will suddenly get smaller.

Agreed.
	-Daniel
*This .sig left intentionally blank*
