From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 16:36:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031632290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060703171751.2ed33220.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 16:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxPX8-0000CD-LO
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 16:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWGCOgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWGCOgF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 10:36:05 -0400
Received: from mail.gmx.de ([213.165.64.21]:31167 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932067AbWGCOgE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 10:36:04 -0400
Received: (qmail invoked by alias); 03 Jul 2006 14:36:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 03 Jul 2006 16:36:02 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060703171751.2ed33220.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23180>

Hi,

On Mon, 3 Jul 2006, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > +struct list {
> > +	char **list;
> > +	void **payload;
> > +	unsigned nr, alloc;
> > +};
> 
> How about something like this instead to reduce mallocs to half and
> simplify the code?
> 
> struct item {
> 	char *value;
> 	void *payload;
> };
> 
> struct list {
> 	struct item *items;
> 	unsigned int nr, alloc;
> };
> 
> (But I realize this isn't performance critical)

I had in mind that I want to use path-list instead (which is cooking in 
the merge-recursive efforts ATM). And there, I would add a flag 
needs_payload. Opinions?

> > +static void append_to_list(struct list *list, char *value)
> 
> Add void *payload parameter too, would simplify the code.

Okay.

> > +static void free_list(struct list *list)
> > +{
> > +	int i;
> > +
> > +	if (list->alloc == 0)
> > +		return;
> 
> Unnecessary if nr is 0 too.

No. If nr == 0, alloc need not be 0, and if it is not, list and payload 
are still allocated.

> > +	for (i = 0; i < list->nr; i++) {
> > +		free(list->list[i]);
> > +		if (list->payload[i])
> > +			free(list->payload[i]);
> 
> free(NULL) is safe.

Is it? I vaguely remember that I had problems with this on some obscure 
platform.

> > +	if (!strncmp(line, "branch ", 7)) {
> > +		origin = strdup(line + 7);
> > +		append_to_list(&(src_data->branch), origin);
> 
> Parenthesis isn't needed.

Okay. Wanted to be on the safe side.

> > +	head->object.flags |= UNINTERESTING;
> > +        prepare_revision_walk(rev);
> 
> Spaces..

True. Will fix.

> > +	if (merge_summary) {
> > +		struct commit *head;
> > +		struct rev_info rev;
> > +
> > +		head = lookup_commit(head_sha1);
> > +parse_object(head->object.sha1);
> > +head = head->parents->item;
> 
> Indentation.

No. Bug. This was a leftover from my tests (with this, the summary is not 
done versus HEAD, but HEAD^).

Will fix and resubmit.

Ciao,
Dscho
