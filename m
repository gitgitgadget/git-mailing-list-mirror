From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3 v2] Add support for external programs for handling
 native fetches
Date: Tue, 28 Jul 2009 13:38:48 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907281126200.2147@iabervon.org>
References: <alpine.LNX.2.00.0907280155390.2147@iabervon.org> <alpine.DEB.1.00.0907281444140.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mariano Ortega <mgo1977@gmail.com>,
	Reece Dunn <msclrhd@googlemail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVqdh-0006FU-1l
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 19:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbZG1Riu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 13:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbZG1Riu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 13:38:50 -0400
Received: from iabervon.org ([66.92.72.58]:43533 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003AbZG1Rit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 13:38:49 -0400
Received: (qmail 1119 invoked by uid 1000); 28 Jul 2009 17:38:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2009 17:38:48 -0000
In-Reply-To: <alpine.DEB.1.00.0907281444140.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124264>

On Tue, 28 Jul 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 28 Jul 2009, Daniel Barkalow wrote:
> 
> > transport_get() can call transport_shim_init() to have list and
> > fetch-ref operations handled by running a separate program as:
> 
> As I commented already, "shim" is a meaningless word in the context of 
> Git.  At _least_ call it something like "git-remote-<protocol>".  Even 
> "git-fetch-<protocol>" would be better than "shim".

I think git-remote-<protocol> is a good name; I'm not particularly tied to 
"shim", although I think this should be able to support push as well as 
fetch (that is, instead of http-push being a separate program that 
transport.c knows how to run, have that be handled by transport-side code 
that could support pushing with arbitrary protocols, and have the pushing 
code built into the curl handler). I do think that I want to form the 
command names differently depending on whether this is a helper that 
transports git objects to a remote git repository using a protocol that 
the helper is for, or a helper that interacts with a non-git remote 
repository where the helper is particular to the foreign scm.

> > diff --git a/Documentation/git-shim.txt b/Documentation/git-shim.txt
> > new file mode 100644
> > index 0000000..dd80c6d
> > --- /dev/null
> > +++ b/Documentation/git-shim.txt
> > @@ -0,0 +1,37 @@
> > +git-shim(1)
> > +============
> > +
> > +NAME
> > +----
> > +git-shim - Helper programs for interoperation with remote git
> 
> Actually, this is just one helper program, no?  Why can't it be integrated 
> into transport.c?

No, this defines a pattern of helper programs, all of which should behave 
as documented by the same man page, so that the same code can run any of 
them.

> > +COMMANDS
> > +--------
> > +
> > +Commands are given by the caller on the helper's standard input, one per line.
> > +
> > +'list'::
> > +	Lists the refs, one per line, if the format "<value>
> > +	<name>". The value is either a hex sha1 hash or "@<dest>" for
> > +	symrefs. After the complete list, outputs a blank line.
> > +
> > +'fetch' ref::
> > +	Fetches the given ref, writing the necessary objects to the
> > +	database. Outputs a blank line when the fetch is complete.
> > ++
> 
> So you allow only 'list' and 'fetch'.  That is very limiting, and you do 
> not even foresee a method to ask for the helper's capabilities.  We 
> already saw how much pain that caused in the transport protocol, so please 
> do not repeat the mistake here.

I'll put the "capabilities" command back in; I dropped it from this subset 
of the foreign vcs helper protocol because there's not much variation 
possible when the remote repository must be a git repository.

> > diff --git a/transport-shim.c b/transport-shim.c
> > new file mode 100644
> > index 0000000..2518aba
> > --- /dev/null
> > +++ b/transport-shim.c
> > @@ -0,0 +1,142 @@
> > +#include "cache.h"
> > +#include "transport.h"
> > +
> > +#include "run-command.h"
> > +#include "commit.h"
> > +#include "diff.h"
> > +#include "revision.h"
> > +
> > +struct shim_data
> > +{
> > +	const char *name;
> > +	struct child_process *shim;
> > +};
> > +
> > +static struct child_process *get_shim(struct transport *transport)
> > +{
> > +	struct shim_data *data = transport->data;
> > +	if (!data->shim) {
> 
> Why can't the caller check for this?  Would this not make much more sense 
> to begin with?

Depending on the order that the user of transport.c calls commands, the 
helper may or may not already be running (and it may or may not have been 
closed by the previous command, in the future extension of also handling 
importers which produce a fast-import stream). The caller could check for 
the connection already being constructed, but all callers would have to 
add the same check.

> > +static int disconnect_shim(struct transport *transport)
> > +{
> > +	struct shim_data *data = transport->data;
> > +	if (data->shim) {
> > +		write(data->shim->in, "\n", 1);
> > +		close(data->shim->in);
> > +		finish_command(data->shim);
> > +		free(data->shim->argv);
> > +		free(data->shim);
> > +		transport->data = NULL;
> > +	}
> > +	return 0;
> > +}
> 
> Why is this function returning anything?

Good point; we can't really fail to disconnect, and we've already 
determined that things haven't screwed up. It's left over from the pattern 
used by some of the native protocol code, where it may determine that the 
operation didn't work after all when the "I'm done" packet fails to 
produce the "goodbye" response.

> > +static int fetch_refs_via_shim(struct transport *transport,
> > +			       int nr_heads, const struct ref **to_fetch)
> 
> Do you fetch only the refs, or also their objects?  If the latter, the 
> name needs to be adjusted.

This is inherited from the transport.h naming, which made sense years ago 
(when it contrasted fetching objects by name of ref versus fetching 
objects by hash); it is fetching objects as specified by struct refs.

> > +{
> > +	struct child_process *shim;
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
> This would be more readable IMO if it read like this:
> 
> 	for (count = i = 0; i < nr_heads; i++)
> 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
> 			count++;

I think it's more readable to match the flow control of the later loop. 
This is a dry run of the main loop, counting the number of times we 
don't skip the important part. I think your version is a more readable way 
of counting the number of not-up-to-date items, but it's not nearly so 
readable a way of calculating how many times we'll reach the interesting 
part of the loop further down.

> > +	if (count) {
> > +		shim = get_shim(transport);
> 
> It would be much better to say "if (!count) return 0;" here rather than 
> indenting a whole block of code, with no code after that.

True.

> > +		for (i = 0; i < nr_heads; i++) {
> > +			posn = to_fetch[i];
> > +			if (posn->status & REF_STATUS_UPTODATE)
> > +				continue;
> > +			write(shim->in, "fetch ", 6);
> > +			write(shim->in, sha1_to_hex(posn->old_sha1), 40);
> > +			write(shim->in, " ", 1);
> > +			write(shim->in, posn->name, strlen(posn->name));
> > +			write(shim->in, "\n", 1);
> > +		}
> > +		file = fdopen(shim->out, "r");
> > +		while (count) {
> > +			if (strbuf_getline(&buf, file, '\n') == EOF)
> > +				exit(128); /* child died, message supplied already */
> > +
> > +			count--;
> 
> while (count--)

I don't like decrement operators used with values, except for the common 
string idioms. But I like:

	for (; count; count--)
		if ...

> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static struct ref *get_refs_via_shim(struct transport *transport, int for_push)
> > +{
> > +	struct child_process *shim;
> > +	struct ref *ret = NULL;
> > +	struct ref **end = &ret;
> 
> A better name for this is "tail", as is used at least in many parts of the 
> Git source code already.

True.

> > +	struct ref *posn;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	FILE *file;
> > +
> > +	shim = get_shim(transport);
> > +	write(shim->in, "list\n", 5);
> 
> What about the return value of this write()?  It can indicate error or 
> short write.

Yeah, I should use write_in_full(), although we know at this point that 
shim->in is a pipe which has been drained entirely.

> > +
> > +	file = fdopen(shim->out, "r");
> 
> No check for file != NULL?

I don't think this can fail, if setting up the child process didn't fail.

> > +	while (1) {
> > +		char *eov;
> > +		if (strbuf_getline(&buf, file, '\n') == EOF)
> > +			exit(128); /* child died, message supplied already */
> > +
> > +		if (!*buf.buf)
> > +			break;
> > +
> > +		eov = strchr(buf.buf, ' ');
> > +		if (!eov)
> > +			die("Malformed response in ref list: %s", buf.buf);
> > +		*eov = '\0';
> > +		*end = alloc_ref(eov + 1);
> > +		if (eov) {
> 
> Did we not die 4 lines earlier if eov == NULL?

Yeah, I confused myself while paring down the vcs output parsing code. I 
think I actually want to future-proof this code to allow the helper to add 
space-separated flags after the name, and I don't want this test.

> > +			if (buf.buf[0] == '@')
> > +				(*end)->symref = xstrdup(buf.buf + 1);
> > +			else
> > +				get_sha1_hex(buf.buf, (*end)->old_sha1);
> 
> IMHO it is not at all clear what you are doing here.  At least a little 
> hint is in order if the code does not explain itself.

It's parsing the output of the "list" command, as given in the 
documentation. Item starting with a '@' is a symref, otherwise it is a 
sha1.

> > +		}
> > +		end = &((*end)->next);
> > +		strbuf_reset(&buf);
> > +	}
> > +	strbuf_release(&buf);
> > +
> > +	for (posn = ret; posn; posn = posn->next)
> > +		resolve_remote_symref(posn, ret);
> > +
> > +	return ret;
> > +}
> 
> Ciao,
> Dscho
> 
> 
