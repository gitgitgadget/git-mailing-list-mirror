From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3 v2] Add support for external programs for handling
 native fetches
Date: Tue, 28 Jul 2009 15:04:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281444140.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280155390.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mariano Ortega <mgo1977@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVmMV-0008T3-Cy
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbZG1NEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbZG1NEt
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:04:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:42888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751798AbZG1NEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:04:48 -0400
Received: (qmail invoked by alias); 28 Jul 2009 13:04:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 28 Jul 2009 15:04:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vm3pNHDFvE/GxUEBp7dRq0lw7ZZGlwNsgLsA0BE
	wMskHIG0JOVlHz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907280155390.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124245>

Hi,

On Tue, 28 Jul 2009, Daniel Barkalow wrote:

> transport_get() can call transport_shim_init() to have list and
> fetch-ref operations handled by running a separate program as:

As I commented already, "shim" is a meaningless word in the context of 
Git.  At _least_ call it something like "git-remote-<protocol>".  Even 
"git-fetch-<protocol>" would be better than "shim".

> diff --git a/Documentation/git-shim.txt b/Documentation/git-shim.txt
> new file mode 100644
> index 0000000..dd80c6d
> --- /dev/null
> +++ b/Documentation/git-shim.txt
> @@ -0,0 +1,37 @@
> +git-shim(1)
> +============
> +
> +NAME
> +----
> +git-shim - Helper programs for interoperation with remote git

Actually, this is just one helper program, no?  Why can't it be integrated 
into transport.c?

At the very least, the text so far is misleading.

> +COMMANDS
> +--------
> +
> +Commands are given by the caller on the helper's standard input, one per line.
> +
> +'list'::
> +	Lists the refs, one per line, if the format "<value>
> +	<name>". The value is either a hex sha1 hash or "@<dest>" for
> +	symrefs. After the complete list, outputs a blank line.
> +
> +'fetch' ref::
> +	Fetches the given ref, writing the necessary objects to the
> +	database. Outputs a blank line when the fetch is complete.
> ++

So you allow only 'list' and 'fetch'.  That is very limiting, and you do 
not even foresee a method to ask for the helper's capabilities.  We 
already saw how much pain that caused in the transport protocol, so please 
do not repeat the mistake here.

> diff --git a/transport-shim.c b/transport-shim.c
> new file mode 100644
> index 0000000..2518aba
> --- /dev/null
> +++ b/transport-shim.c
> @@ -0,0 +1,142 @@
> +#include "cache.h"
> +#include "transport.h"
> +
> +#include "run-command.h"
> +#include "commit.h"
> +#include "diff.h"
> +#include "revision.h"
> +
> +struct shim_data
> +{
> +	const char *name;
> +	struct child_process *shim;
> +};
> +
> +static struct child_process *get_shim(struct transport *transport)
> +{
> +	struct shim_data *data = transport->data;
> +	if (!data->shim) {

Why can't the caller check for this?  Would this not make much more sense 
to begin with?

> +static int disconnect_shim(struct transport *transport)
> +{
> +	struct shim_data *data = transport->data;
> +	if (data->shim) {
> +		write(data->shim->in, "\n", 1);
> +		close(data->shim->in);
> +		finish_command(data->shim);
> +		free(data->shim->argv);
> +		free(data->shim);
> +		transport->data = NULL;
> +	}
> +	return 0;
> +}

Why is this function returning anything?

> +static int fetch_refs_via_shim(struct transport *transport,
> +			       int nr_heads, const struct ref **to_fetch)

Do you fetch only the refs, or also their objects?  If the latter, the 
name needs to be adjusted.

> +{
> +	struct child_process *shim;
> +	const struct ref *posn;
> +	struct strbuf buf = STRBUF_INIT;
> +	int i, count;
> +	FILE *file;
> +
> +	count = 0;
> +	for (i = 0; i < nr_heads; i++) {
> +		posn = to_fetch[i];
> +		if (posn->status & REF_STATUS_UPTODATE)
> +			continue;
> +		count++;
> +	}

This would be more readable IMO if it read like this:

	for (count = i = 0; i < nr_heads; i++)
		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
			count++;

> +	if (count) {
> +		shim = get_shim(transport);

It would be much better to say "if (!count) return 0;" here rather than 
indenting a whole block of code, with no code after that.

> +		for (i = 0; i < nr_heads; i++) {
> +			posn = to_fetch[i];
> +			if (posn->status & REF_STATUS_UPTODATE)
> +				continue;
> +			write(shim->in, "fetch ", 6);
> +			write(shim->in, sha1_to_hex(posn->old_sha1), 40);
> +			write(shim->in, " ", 1);
> +			write(shim->in, posn->name, strlen(posn->name));
> +			write(shim->in, "\n", 1);
> +		}
> +		file = fdopen(shim->out, "r");
> +		while (count) {
> +			if (strbuf_getline(&buf, file, '\n') == EOF)
> +				exit(128); /* child died, message supplied already */
> +
> +			count--;

while (count--)

> +		}
> +	}
> +	return 0;
> +}
> +
> +static struct ref *get_refs_via_shim(struct transport *transport, int for_push)
> +{
> +	struct child_process *shim;
> +	struct ref *ret = NULL;
> +	struct ref **end = &ret;

A better name for this is "tail", as is used at least in many parts of the 
Git source code already.

> +	struct ref *posn;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *file;
> +
> +	shim = get_shim(transport);
> +	write(shim->in, "list\n", 5);

What about the return value of this write()?  It can indicate error or 
short write.

> +
> +	file = fdopen(shim->out, "r");

No check for file != NULL?

> +	while (1) {
> +		char *eov;
> +		if (strbuf_getline(&buf, file, '\n') == EOF)
> +			exit(128); /* child died, message supplied already */
> +
> +		if (!*buf.buf)
> +			break;
> +
> +		eov = strchr(buf.buf, ' ');
> +		if (!eov)
> +			die("Malformed response in ref list: %s", buf.buf);
> +		*eov = '\0';
> +		*end = alloc_ref(eov + 1);
> +		if (eov) {

Did we not die 4 lines earlier if eov == NULL?

> +			if (buf.buf[0] == '@')
> +				(*end)->symref = xstrdup(buf.buf + 1);
> +			else
> +				get_sha1_hex(buf.buf, (*end)->old_sha1);

IMHO it is not at all clear what you are doing here.  At least a little 
hint is in order if the code does not explain itself.

> +		}
> +		end = &((*end)->next);
> +		strbuf_reset(&buf);
> +	}
> +	strbuf_release(&buf);
> +
> +	for (posn = ret; posn; posn = posn->next)
> +		resolve_remote_symref(posn, ret);
> +
> +	return ret;
> +}

Ciao,
Dscho
