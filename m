From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3 v2] Add support for external programs for handling
 native fetches
Date: Thu, 30 Jul 2009 00:02:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907292351040.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280155390.2147@iabervon.org> <alpine.DEB.1.00.0907281444140.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0907281126200.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mariano Ortega <mgo1977@gmail.com>,
	Reece Dunn <msclrhd@googlemail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHEA-0003VU-6W
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbZG2WCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZG2WCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:02:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:54816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751581AbZG2WCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:02:14 -0400
Received: (qmail invoked by alias); 29 Jul 2009 22:02:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 30 Jul 2009 00:02:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+htMoLyPOhuPn4q9gFHVpDU1M/616sRzSIzpA1rf
	oK2+iRHjbfcU6T
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907281126200.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124394>

Hi,

On Tue, 28 Jul 2009, Daniel Barkalow wrote:

> On Tue, 28 Jul 2009, Johannes Schindelin wrote:
> 
> > On Tue, 28 Jul 2009, Daniel Barkalow wrote:
> > 
> > > transport_get() can call transport_shim_init() to have list and
> > > fetch-ref operations handled by running a separate program as:
> > 
> > As I commented already, "shim" is a meaningless word in the context of 
> > Git.  At _least_ call it something like "git-remote-<protocol>".  Even 
> > "git-fetch-<protocol>" would be better than "shim".
> 
> I think git-remote-<protocol> is a good name;

Good.

> I think this should be able to support push as well as fetch

So you agree that it should be extensible.  Also good.

> I do think that I want to form the command names differently depending 
> on whether this is a helper that transports git objects to a remote git 
> repository using a protocol that the helper is for, or a helper that 
> interacts with a non-git remote repository where the helper is 
> particular to the foreign scm.

I think that is a rather bad decision: you should not _need_ to care on 
the transport.c side.  If the helper handles fetching and/or pushing: 
fine.  How it accomplishes that: don't care.

> > > diff --git a/Documentation/git-shim.txt b/Documentation/git-shim.txt
> > > new file mode 100644
> > > index 0000000..dd80c6d
> > > --- /dev/null
> > > +++ b/Documentation/git-shim.txt
> > > @@ -0,0 +1,37 @@
> > > +git-shim(1)
> > > +============
> > > +
> > > +NAME
> > > +----
> > > +git-shim - Helper programs for interoperation with remote git
> > 
> > Actually, this is just one helper program, no?  Why can't it be integrated 
> > into transport.c?
> 
> No, this defines a pattern of helper programs, all of which should 
> behave as documented by the same man page, so that the same code can run 
> any of them.

See?  That description _is_ misleading.

> > > +COMMANDS
> > > +--------
> > > +
> > > +Commands are given by the caller on the helper's standard input, one per line.
> > > +
> > > +'list'::
> > > +	Lists the refs, one per line, if the format "<value>
> > > +	<name>". The value is either a hex sha1 hash or "@<dest>" for
> > > +	symrefs. After the complete list, outputs a blank line.
> > > +
> > > +'fetch' ref::
> > > +	Fetches the given ref, writing the necessary objects to the
> > > +	database. Outputs a blank line when the fetch is complete.
> > > ++
> > 
> > So you allow only 'list' and 'fetch'.  That is very limiting, and you do 
> > not even foresee a method to ask for the helper's capabilities.  We 
> > already saw how much pain that caused in the transport protocol, so please 
> > do not repeat the mistake here.
> 
> I'll put the "capabilities" command back in; I dropped it from this 
> subset of the foreign vcs helper protocol because there's not much 
> variation possible when the remote repository must be a git repository.

Just because you do not foresee it now does not mean that it won't happen.

As I hinted at: it is rather likely that you do not foresee what kind of 
capability negotiation we'll want in the future.

Let's learn from history.

> > > diff --git a/transport-shim.c b/transport-shim.c
> > > new file mode 100644
> > > index 0000000..2518aba
> > > --- /dev/null
> > > +++ b/transport-shim.c
> > > @@ -0,0 +1,142 @@
> > > +#include "cache.h"
> > > +#include "transport.h"
> > > +
> > > +#include "run-command.h"
> > > +#include "commit.h"
> > > +#include "diff.h"
> > > +#include "revision.h"
> > > +
> > > +struct shim_data
> > > +{
> > > +	const char *name;
> > > +	struct child_process *shim;
> > > +};
> > > +
> > > +static struct child_process *get_shim(struct transport *transport)
> > > +{
> > > +	struct shim_data *data = transport->data;
> > > +	if (!data->shim) {
> > 
> > Why can't the caller check for this?  Would this not make much more sense 
> > to begin with?
> 
> Depending on the order that the user of transport.c calls commands, the 
> helper may or may not already be running (and it may or may not have been 
> closed by the previous command, in the future extension of also handling 
> importers which produce a fast-import stream). The caller could check for 
> the connection already being constructed, but all callers would have to 
> add the same check.

Fair enough.  That large deeply indented part that makes up the most part 
of the function is very ugly, though.

> > > +static int fetch_refs_via_shim(struct transport *transport,
> > > +			       int nr_heads, const struct ref **to_fetch)
> > 
> > Do you fetch only the refs, or also their objects?  If the latter, the 
> > name needs to be adjusted.
> 
> This is inherited from the transport.h naming, which made sense years ago 
> (when it contrasted fetching objects by name of ref versus fetching 
> objects by hash); it is fetching objects as specified by struct refs.

It is actually not inherited from the naming, as the member you assign 
this function to does not contain the string "refs".

> > > +{
> > > +	struct child_process *shim;
> > > +	const struct ref *posn;
> > > +	struct strbuf buf = STRBUF_INIT;
> > > +	int i, count;
> > > +	FILE *file;
> > > +
> > > +	count = 0;
> > > +	for (i = 0; i < nr_heads; i++) {
> > > +		posn = to_fetch[i];
> > > +		if (posn->status & REF_STATUS_UPTODATE)
> > > +			continue;
> > > +		count++;
> > > +	}
> > 
> > This would be more readable IMO if it read like this:
> > 
> > 	for (count = i = 0; i < nr_heads; i++)
> > 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
> > 			count++;
> 
> I think it's more readable to match the flow control of the later loop. 

Yeah, right.  It was so readable that I bothered to comment.
 
> > > +		for (i = 0; i < nr_heads; i++) {
> > > +			posn = to_fetch[i];
> > > +			if (posn->status & REF_STATUS_UPTODATE)
> > > +				continue;
> > > +			write(shim->in, "fetch ", 6);
> > > +			write(shim->in, sha1_to_hex(posn->old_sha1), 40);
> > > +			write(shim->in, " ", 1);
> > > +			write(shim->in, posn->name, strlen(posn->name));
> > > +			write(shim->in, "\n", 1);
> > > +		}
> > > +		file = fdopen(shim->out, "r");
> > > +		while (count) {
> > > +			if (strbuf_getline(&buf, file, '\n') == EOF)
> > > +				exit(128); /* child died, message supplied already */
> > > +
> > > +			count--;
> > 
> > while (count--)
> 
> I don't like decrement operators used with values, except for the common 
> string idioms. But I like:
> 
> 	for (; count; count--)
> 		if ...

Which is even more ugly than your current version.  Just my personal 
taste, of course.  Oh, and maybe also a little disagreement with the rest 
of Git's source.

> > > +	struct ref *posn;
> > > +	struct strbuf buf = STRBUF_INIT;
> > > +	FILE *file;
> > > +
> > > +	shim = get_shim(transport);
> > > +	write(shim->in, "list\n", 5);
> > 
> > What about the return value of this write()?  It can indicate error or 
> > short write.
> 
> Yeah, I should use write_in_full(), although we know at this point that 
> shim->in is a pipe which has been drained entirely.

I am not at all sure that you can guarantee that at this point.

> > > +	file = fdopen(shim->out, "r");
> > 
> > No check for file != NULL?
> 
> I don't think this can fail, if setting up the child process didn't fail.

Until somebody reports a segmentation fault because her operating system 
ran out of file descriptors.

In any case, I would rather be safe than sorry.  It is not a good habit to 
get into, calling functions that can return NULL and not checking them 
(even if you try to be super-clever).

> > > +	while (1) {
> > > +		char *eov;
> > > +		if (strbuf_getline(&buf, file, '\n') == EOF)
> > > +			exit(128); /* child died, message supplied already */
> > > +
> > > +		if (!*buf.buf)
> > > +			break;
> > > +
> > > +		eov = strchr(buf.buf, ' ');
> > > +		if (!eov)
> > > +			die("Malformed response in ref list: %s", buf.buf);
> > > +		*eov = '\0';
> > > +		*end = alloc_ref(eov + 1);
> > > +		if (eov) {
> > 
> > Did we not die 4 lines earlier if eov == NULL?
> 
> Yeah, I confused myself while paring down the vcs output parsing code. I 
> think I actually want to future-proof this code to allow the helper to 
> add space-separated flags after the name, and I don't want this test.

Yeah, why not making it hard on the reviewer for the slight possibility 
that some change will go in in the future, in the exact form you envisaged 
it now?

> > > +			if (buf.buf[0] == '@')
> > > +				(*end)->symref = xstrdup(buf.buf + 1);
> > > +			else
> > > +				get_sha1_hex(buf.buf, (*end)->old_sha1);
> > 
> > IMHO it is not at all clear what you are doing here.  At least a little 
> > hint is in order if the code does not explain itself.
> 
> It's parsing the output of the "list" command, as given in the 
> documentation. Item starting with a '@' is a symref, otherwise it is a 
> sha1.

That's nice.

It would be even nicer if there was a comment in the patch so that future 
puzzled readers do not know that they have to search the mailing list to 
understand this code.

Ciao,
Dscho
