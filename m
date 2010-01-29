From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 17:34:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazQB-0006zd-Ck
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab0A2Wea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755780Ab0A2Wea
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:34:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37052 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab0A2We3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:34:29 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX100B795DG13B0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 17:34:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7viqakh8ty.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138390>

On Fri, 29 Jan 2010, Junio C Hamano wrote:

> We used to just say "topic is not a rev nor path" and failed when the user
> said "git checkout topic".  And the magic kicks in when there is only one
> "remotes/*/topic".
> 
> Because this cannot be any request other than to check out a local branch
> "topic", and because there is no place more sensible than the "topic"
> taken from the "origin" (as that is the sole place that has "topic"), it
> dwims as a shorthand for "checkout -b topic origin/topic" and tells you
> that it did so.

OK.  That is probably sensible.

I don't think any improvement on the detached head message should 
presume on this though.

And it might be a good idea to say explicitly that what happened is the 
creation of a detached HEAD, like in:

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..c0a44d7 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -523,7 +523,10 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path)
-				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+				fprintf(stderr, "Note: '%s' isn't a local branch head: creating a detached HEAD\n"
+						"If you want to create a new branch from this checkout, you may do so\n"
+						"(now or later) by using -b with the checkout command again. Example:\n"
+						"  git checkout -b <new_branch_name>\n", new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}

(string split onto multiple lines for easier source reading)

I think this is important to 1) mention the notion of a branch _head_, 
and 2) mention "detached HEAD" explicitly for people to be directed to 
appropriate documentation.  So with this change you know exactly what 
happened and why.


Nicolas
