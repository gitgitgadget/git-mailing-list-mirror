From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3 v3] Add support for external programs for handling
 native fetches
Date: Wed, 5 Aug 2009 12:01:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908051143000.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907310109130.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 12:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdIv-0007AX-47
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 12:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934101AbZHEKAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 06:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934100AbZHEKAn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 06:00:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:42982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934092AbZHEKAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 06:00:42 -0400
Received: (qmail invoked by alias); 05 Aug 2009 10:00:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 05 Aug 2009 12:00:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Kv3sAfC9KB0GUvbkTbMknA9IauChavZ6n8RhUp7
	K+2vG7YqbRN6fi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907310109130.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124893>

Hi,

On Fri, 31 Jul 2009, Daniel Barkalow wrote:

> dscho: it turned out that disconnect...() is a method defined to return 
> int.

Okay, thanks for the clarification.

> +static int fetch(struct transport *transport,
> +		 int nr_heads, const struct ref **to_fetch)
> +{
> +	struct helper_data *data = transport->data;
> +	struct child_process *helper;
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

I still do not like it, but I guess you refuse to please me here.

> +
> +	if (!count)
> +		return 0;
> +
> +	helper = get_helper(transport);
> +
> +	if (!data->fetch)
> +		return -1;
> +
> +	file = xfdopen(helper->out, "r");
> +	for (i = 0; i < nr_heads; i++) {
> +		posn = to_fetch[i];
> +		if (posn->status & REF_STATUS_UPTODATE)
> +			continue;
> +		write_in_full(helper->in, "fetch ", 6);
> +		write_in_full(helper->in, sha1_to_hex(posn->old_sha1), 40);
> +		write_in_full(helper->in, " ", 1);
> +		write_in_full(helper->in, posn->name, strlen(posn->name));
> +		write_in_full(helper->in, "\n", 1);

How about

		strbuf_addf(&buf, "fetch %s %s\n", 
			sha1_to_hex(posn->old_sha1), posn->name);
		write_in_full(helper->in, buf.buf, buf.len);

instead?  It is not only much more readable, but also less error-prone.

> +static struct ref *get_refs_list(struct transport *transport, int for_push)
> +{
> +	struct child_process *helper;
> +	struct ref *ret = NULL;
> +	struct ref **tail = &ret;
> +	struct ref *posn;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *file;
> +
> +	helper = get_helper(transport);
> +	write_in_full(helper->in, "list\n", 5);

Speaking of error-prone: we introduced e.g. prefixcmp() for the sole 
purpose of avoiding errors due to hard-coded constants.  I would strongly 
suggest to introduce a helper here instead of having all those constants 
that every reviewer has to check (which is no fun).

> +		if (strbuf_getline(&buf, file, '\n') == EOF)
> +			exit(128); /* child died, message supplied already */
> +
> +		if (!*buf.buf)
> +			break;
> +
> +		eov = strchr(buf.buf, ' ');
> +		if (!eov)
> +			die("Malformed response in ref list: %s", buf.buf);
> +                eon = strchr(eov + 1, ' ');
> +		*eov = '\0';
> +                if (eon)

Funny indentation?

> +                        *eon = '\0';

Please register a complaint about your naming ("posn", "eov", "eon"), and 
also please register a complaint about the rather confusing order of 
your statements.

> +		*tail = alloc_ref(eov + 1);
> +		if (buf.buf[0] == '@')
> +			(*tail)->symref = xstrdup(buf.buf + 1);
> +		else if (buf.buf[0] != '?')
> +			get_sha1_hex(buf.buf, (*tail)->old_sha1);
> +		tail = &((*tail)->next);
> +		strbuf_reset(&buf);

For clarity's sake, this should be done _before_ the strbuf is filled, not 
after it (because then everybody has to think harder why the code is still 
correct, but the performance is _exactly_ the same).

> +	}
> +	strbuf_release(&buf);
> +
> +	for (posn = ret; posn; posn = posn->next)
> +		resolve_remote_symref(posn, ret);
> +
> +	return ret;
> +}
> +
> +int transport_native_helper_init(struct transport *transport)
> +{
> +	struct helper_data *data = xmalloc(sizeof(*data));
> +	char *eom = strchr(transport->url, ':');

"End of message"?

All in all, I like this patch much better, thank you!

Ciao,
Dscho
