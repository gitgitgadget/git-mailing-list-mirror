From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log -g: Complain, but do not fail, when no reflogs
 are there
Date: Tue, 24 Jul 2007 10:14:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241011090.14781@racer.site>
References: <Pine.LNX.4.64.0707240039300.14781@racer.site>
 <7vbqe2jr9m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGTk-00073G-Ib
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390AbXGXJOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbXGXJOt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:14:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:56390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756719AbXGXJOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:14:48 -0400
Received: (qmail invoked by alias); 24 Jul 2007 09:14:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 24 Jul 2007 11:14:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bZ6ZG0i/bD265CnLrJey0tHLlEBqV8jIJXwtL40
	sOlXuRC9UV80uO
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqe2jr9m.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53540>

Hi,

On Mon, 23 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When asking "git log -g --all", clearly you want to see only those refs
> > that do have reflogs, but you do not want it to fail, either.
> >
> > So instead of die()ing, complain about it, but move on to the other refs.
> 
> Hmph, do we even want to error(), I wonder...

Maybe not.  I thought it was some useful information, though.

> Can you tell, at that point, if there were explicit branch names given 
> originally on the command line, or the refs came
> from --all?

No:

                        if (!strcmp(arg, "--all")) {
                                handle_all(revs, flags);
                                continue;
                        }

which calls

static void handle_all(struct rev_info *revs, unsigned flags)
{
        struct all_refs_cb cb;
        cb.all_revs = revs;
        cb.all_flags = flags;
        for_each_ref(handle_one_ref, &cb);
}

which in turn calls

static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 void *cb_data)
{
        struct all_refs_cb *cb = cb_data;
        struct object *object = get_reference(cb->all_revs, path, sha1,
                                              cb->all_flags);
        add_pending_object(cb->all_revs, object, path);
        return 0;
}

If you do not say --all, handle_revision_arg() is called, which calls 
add_pending_object thus:

                        add_pending_object(revs, &a->object, this);
                        add_pending_object(revs, &b->object, next);

or thus

        add_pending_object_with_mode(revs, object, arg, mode);

So no, there is not really a chance to see how the refs were specified at 
the time add_pending_object() is called.

Ciao,
Dscho
