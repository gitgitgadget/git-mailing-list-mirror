From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] clone: respect configured fetch respecs during
 initial fetch
Date: Thu, 31 Mar 2016 22:50:55 +0200
Message-ID: <20160331225055.Horde.1X4mNM4L4J85rAeMFQzAEH_@webmail.informatik.kit.edu>
References: <20160307153304.GA23010@sigill.intra.peff.net>
 <1459349623-16443-1-git-send-email-szeder@ira.uka.de>
 <xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
 <xmqq1t6qo4rd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:51:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljYz-0001Pv-Do
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbcCaUv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:51:28 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48259 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932260AbcCaUvI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 16:51:08 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aljYU-0000JT-10; Thu, 31 Mar 2016 22:51:02 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aljYN-0008PY-Ra; Thu, 31 Mar 2016 22:50:55 +0200
Received: from x4db0ec79.dyn.telefonica.de (x4db0ec79.dyn.telefonica.de
 [77.176.236.121]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 31 Mar 2016 22:50:55 +0200
In-Reply-To: <xmqq1t6qo4rd.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1459457462.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290466>


Quoting Junio C Hamano <gitster@pobox.com>:

> IOW, special casing -c remote.origin.fetch=spec
> is a bad idea.

I completely agree :)
But it's the other way around.

'remote.origin.fetch=spec' during clone is special _now_, because the
initial fetch ignores it, no matter where it is set.

My patch makes it non-special, so that the initial fetch respects it,
the same way it already respects 'fetch.fsckObjects' and
'fsck.unpackLimit', or the way the initial checkout respects e.g.
'core.eol'.

> So how about teaching "git clone" a new _option_ that is about what
> branches are followed?
>
> 	git clone $there --branches="master next pu"
>
> would give
>
> 	[remote "origin"]
>         	fetch = +refs/heads/master:refs/remotes/origin/master
>         	fetch = +refs/heads/next:refs/remotes/origin/next
>         	fetch = +refs/heads/pu:refs/remotes/origin/pu

Without my patch the initial fetch would ignore these refspecs, too.

> instead of the usual
>
> 	[remote "origin"]
> 		fetch = +refs/heads/*:refs/remotes/origin/*

Typing only branch names is much shorter and simpler than typing the
name of a config var and full refspecs, so this would be a nice
simplification of the UI for the case when the user is only
interested in certain branches.  But it wouldn't help if the user
wants to include 'refs/interesting/*' in the initial fetch.


> And that can be made to work orthognonal to --single-branch by a
> small additional rule: if the branch given by -b <name> (or their
> HEAD) is not part of --branches, then we add it to the set of
> branches to be followed (i.e. if you give only --single-branch,
> without --branches, the set of branches to be followed will become
> that single branch).
>
> Hmm?
