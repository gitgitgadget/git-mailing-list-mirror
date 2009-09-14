From: Owen Taylor <otaylor@redhat.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Mon, 14 Sep 2009 19:18:14 -0400
Message-ID: <1252970294.11581.71.camel@localhost.localdomain>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
	 <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
	 <1252895719.11581.53.camel@localhost.localdomain>
	 <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 01:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnKof-0003g6-T8
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 01:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933556AbZINXSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 19:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757478AbZINXSQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 19:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33942 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbZINXSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 19:18:15 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8ENIGQm027141;
	Mon, 14 Sep 2009 19:18:16 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8ENIFiO027110;
	Mon, 14 Sep 2009 19:18:15 -0400
In-Reply-To: <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128501>

On Mon, 2009-09-14 at 18:21 -0400, Daniel Barkalow wrote:
> On Sun, 13 Sep 2009, Owen Taylor wrote:

[...]
> I think the classification logic should move to match_refs(), assuming you 
> mean the ref->nonfastforward and ref->deletion stuff. It would probably 
> also be worth having a bit for "already up to date". (Note that 
> cmd_send_pack() calls match_refs(), so there wouldn't have to be 
> duplication between the legacy cmd_send_pack() code path and the 
> transport_push() codepath if the code moved into match_refs()).
[...]
> >  - You add another vfunc to the transport - '->get_capabilities' or
> >    something - that encapsulates server_supports("delete-refs").
> 
> I think it would be better to have a vfunc that takes refs with the 
> classification bits set and sets the statuses based on the idea that we're 
> not going to lose any races and the remote won't reject our change for 
> some reason we don't know about. There's a potentially large and varied 
> set of restrictions on what the other side is willing to accept, and I 
> think it would be better to put that on the other side of the vfunc, 
> rather than having the main transport code know that "delete-refs" means 
> that you can delete refs, "nonfastforward" means you can force a 
> non-fast-forward, something means you can create files named "CVS", etc.

match_refs seems like a reasonable place to put this logic, but I'm not
sure I completely follow what you are proposing in terms of
transport-specific customization.

match_refs() is called from a couple of places where there is no
'transport' (cmd_send_pack() and http-push.c) so it can't itself call
into the transport code.

Are you thinking of a virtual function that would be a "second pass"
after the main logic done is done by match_refs; so ->check_refs()
virtual function?

How would the 'bit for "already up to date"' differ from
REF_STATUS_UPTODATE. ?

> I think a pre-push hook would be popular; I know I'd like to have a hook 
> that makes sure that I signed off anything I'm pushing (when the server 
> might check that *somebody* did, but wouldn't know that this push is 
> supposed to be me), and I'd like a hook that checks that I've referenced 
> an issue in an issue tracker for each commit that I'm pushing (but only 
> when I go to push it).

If I can figure out the rest of it, I'll look at adding a hook on top as
a sweetener :-)

- Owen
