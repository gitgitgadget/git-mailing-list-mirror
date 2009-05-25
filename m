From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its
 parents
Date: Mon, 25 May 2009 11:46:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905251140320.4288@intel-tinevez-2-302>
References: <20090517153307.6403.73576.> <20090517153647.6403.44036.chriscool@tuxfamily.org> <4A1A621E.10703@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 25 11:46:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Wl7-0006xy-L7
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbZEYJqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbZEYJqI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:46:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:36320 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751335AbZEYJqH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:46:07 -0400
Received: (qmail invoked by alias); 25 May 2009 09:46:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 25 May 2009 11:46:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UHjZnP84Upkas+HAHnaUq1p0POZqR7qd+cvr1WN
	Zsb+SnXmHMGPri
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A1A621E.10703@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119910>

Hi,

On Mon, 25 May 2009, Johannes Sixt wrote:

> Christian Couder schrieb:
> > +static void unparse_commit_list(struct commit_list *list)
> > +{
> > +	for (; list; list = list->next)
> > +		unparse_commit(list->item);
> > +}
> > +
> > +void unparse_commit(struct commit *item)
> > +{
> > +	item->object.flags = 0;
> > +	item->object.used = 0;
> > +	if (item->object.parsed) {
> > +		item->object.parsed = 0;
> > +		if (item->parents) {
> > +			unparse_commit_list(item->parents);
> > +			free_commit_list(item->parents);
> > +			item->parents = NULL;
> > +		}
> > +	}
> > +}
> 
> I see a recursion here. Could this not overflow the stack if there is a
> long ancestry chain?

You mean tail recursion, i.e. something like

void unparse_commit(struct commit *item)
{
	item->object.flags = 0;
	item->object.used = 0;
	while (item->object.parsed) {
		struct commit *first;

		item->object.parsed = 0;
		if (!item->parents)
			break;
		if (item->parents->next)
			unparse_commit_list(item->parents->next);
		first = item->parents->item;
		free_commit_list(item->parents);
		item->parents = NULL;
		item = first;
	}
}

However, I am a bit concerned that this function is dangerous, as it just 
assumes that there is no reference to the commits left, which assumption 
is _very_ easy to break by mistake.

Ciao,
Dscho
