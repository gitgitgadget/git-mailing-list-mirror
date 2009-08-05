From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3 v3] Add support for external programs for handling
 native fetches
Date: Wed, 5 Aug 2009 11:34:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051058130.2147@iabervon.org>
References: <alpine.LNX.2.00.0907310109130.2147@iabervon.org> <alpine.DEB.1.00.0908051143000.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYiWM-0007Yz-9N
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbZHEPeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755776AbZHEPet
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:34:49 -0400
Received: from iabervon.org ([66.92.72.58]:36398 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755746AbZHEPet (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:34:49 -0400
Received: (qmail 11677 invoked by uid 1000); 5 Aug 2009 15:34:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 15:34:49 -0000
In-Reply-To: <alpine.DEB.1.00.0908051143000.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124915>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 31 Jul 2009, Daniel Barkalow wrote:
> 
> > dscho: it turned out that disconnect...() is a method defined to return 
> > int.
> 
> Okay, thanks for the clarification.
> 
> > +static int fetch(struct transport *transport,
> > +		 int nr_heads, const struct ref **to_fetch)
> > +{
> > +	struct helper_data *data = transport->data;
> > +	struct child_process *helper;
> > +	const struct ref *posn;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	int i, count;
> > +	FILE *file;
> > +
> > +	count = 0;
> > +	for (i = 0; i < nr_heads; i++) {
> > +		posn = to_fetch[i];
> > +		if (posn->status & REF_STATUS_UPTODATE)
> > +			continue;
> > +		count++;
> > +	}
> 
> I still do not like it, but I guess you refuse to please me here.

I actually ended up rewriting it the way you wanted, because I no longer 
needed the numeric value of count to match the iterations of another loop. 
And your verision is the clearer way of determining if there are any 
not-up-to-date refs.

> > +
> > +	if (!count)
> > +		return 0;
> > +
> > +	helper = get_helper(transport);
> > +
> > +	if (!data->fetch)
> > +		return -1;
> > +
> > +	file = xfdopen(helper->out, "r");
> > +	for (i = 0; i < nr_heads; i++) {
> > +		posn = to_fetch[i];
> > +		if (posn->status & REF_STATUS_UPTODATE)
> > +			continue;
> > +		write_in_full(helper->in, "fetch ", 6);
> > +		write_in_full(helper->in, sha1_to_hex(posn->old_sha1), 40);
> > +		write_in_full(helper->in, " ", 1);
> > +		write_in_full(helper->in, posn->name, strlen(posn->name));
> > +		write_in_full(helper->in, "\n", 1);
> 
> How about
> 
> 		strbuf_addf(&buf, "fetch %s %s\n", 
> 			sha1_to_hex(posn->old_sha1), posn->name);
> 		write_in_full(helper->in, buf.buf, buf.len);
> 
> instead?  It is not only much more readable, but also less error-prone.

Good point. Although I am likely to forget the strbuf_reset(&buf) the 
first time.

> > +static struct ref *get_refs_list(struct transport *transport, int for_push)
> > +{
> > +	struct child_process *helper;
> > +	struct ref *ret = NULL;
> > +	struct ref **tail = &ret;
> > +	struct ref *posn;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	FILE *file;
> > +
> > +	helper = get_helper(transport);
> > +	write_in_full(helper->in, "list\n", 5);
> 
> Speaking of error-prone: we introduced e.g. prefixcmp() for the sole 
> purpose of avoiding errors due to hard-coded constants.  I would strongly 
> suggest to introduce a helper here instead of having all those constants 
> that every reviewer has to check (which is no fun).

I think using strbuf like you suggest above is good for everywhere. Sure, 
it might be overkill for a command with no arguments, but having all of 
the places that write to the helper look the same is good, and it avoids 
the constant. Maybe strbuf could get a function to write a strbuf to an fd 
and reset the strbuf. I'll look into that.

> > +		if (strbuf_getline(&buf, file, '\n') == EOF)
> > +			exit(128); /* child died, message supplied already */
> > +
> > +		if (!*buf.buf)
> > +			break;
> > +
> > +		eov = strchr(buf.buf, ' ');
> > +		if (!eov)
> > +			die("Malformed response in ref list: %s", buf.buf);
> > +                eon = strchr(eov + 1, ' ');
> > +		*eov = '\0';
> > +                if (eon)
> 
> Funny indentation?

Wow, weird. No idea why that happened, although it's a lot less obvious 
before it's got 5 characters in front.

> > +                        *eon = '\0';
> 
> Please register a complaint about your naming ("posn", "eov", "eon"), and 
> also please register a complaint about the rather confusing order of 
> your statements.

I think the order of statements is improved in the latest version. Is 
there a preferred style for things like my "eov" and "eon"? The 
Linus-original code I'm finding just uses "p", which is hardly more 
helpful, and I think that was just written in a hurry. You'd prefer "ref" 
instead of "posn", I assume? I don't think it's meaningfully clearer on 
its own, but I agree that it matches everything better, and that's a 
worthwhile thing.

> > +		*tail = alloc_ref(eov + 1);
> > +		if (buf.buf[0] == '@')
> > +			(*tail)->symref = xstrdup(buf.buf + 1);
> > +		else if (buf.buf[0] != '?')
> > +			get_sha1_hex(buf.buf, (*tail)->old_sha1);
> > +		tail = &((*tail)->next);
> > +		strbuf_reset(&buf);
> 
> For clarity's sake, this should be done _before_ the strbuf is filled, not 
> after it (because then everybody has to think harder why the code is still 
> correct, but the performance is _exactly_ the same).

Actually, it is done before the strbuf is filled, because strbuf_getline() 
is clever and does it for me. In the latest version, the strbuf_reset() 
here is dropped.

> > +	}
> > +	strbuf_release(&buf);
> > +
> > +	for (posn = ret; posn; posn = posn->next)
> > +		resolve_remote_symref(posn, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +int transport_native_helper_init(struct transport *transport)
> > +{
> > +	struct helper_data *data = xmalloc(sizeof(*data));
> > +	char *eom = strchr(transport->url, ':');
> 
> "End of message"?

"End of method"; that's the "method" part of a URL.

> All in all, I like this patch much better, thank you!

Great; I think the version from last night also fixes some but not all of 
your current complaints.

	-Daniel
*This .sig left intentionally blank*
