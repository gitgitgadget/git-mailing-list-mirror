From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Tue, 24 Mar 2009 12:16:45 +0100
Message-ID: <20090324111645.GA6084@pvv.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org> <20090323144650.GA20058@pvv.org> <7v4oxk6wk2.fsf@gitster.siamese.dyndns.org> <7vljqv2t05.fsf@gitster.siamese.dyndns.org> <7vhc1j2si9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 12:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm4eH-0006bl-EP
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 12:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbZCXLQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 07:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757552AbZCXLQy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 07:16:54 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:51119 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548AbZCXLQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 07:16:53 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lm4cf-00014b-6I; Tue, 24 Mar 2009 12:16:45 +0100
Content-Disposition: inline
In-Reply-To: <7vhc1j2si9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114451>

On Tue, Mar 24, 2009 at 02:13:18AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >   $ git push --dry-run sf.net
> >   warning: You did not specify any refspecs to push, and the current remote
> >   warning: has not configured any push refspecs. The default action in this
> >   warning: case is to push all matching refspecs, that is, all branches
> >   warning: that exist both locally and remotely will be updated.  This may
> >   warning: not necessarily be what you want to happen.
> >   warning:
> >   warning: You can specify what action you want to take in this case, and
> >   warning: avoid seeing this message again, by configuring 'push.default' to:
> >   warning:   'nothing'  : Do not push anythig
> >   warning:   'matching' : Push all matching branches (default)
> >   warning:   'tracking' : Push the current branch to whatever it is tracking
> >   warning:   'current'  : Push the current branch
> >   fatal: 'sf.net' does not appear to be a git repository
> >   fatal: The remote end hung up unexpectedly
> >
> > The final, most important error messages are dwarfed out by the warning
> > that talks about setting configuration on the remote that does not even
> > exist.

I actually agree, but that final error is printed in a very ugly
place! It would require some surgery to pause the warning until we
figure out that sf.net is not a valid remote in the current setup.

get_refs_via_connect->connect_setup->git_connect-> .. fork()s .., runs
   "sh -c git-receive-pack 'sf.net'" (which prints the first error)
and get_remote_heads->packet_read_line->safe_read() dumps the final error
and dies.

Is there any reason why remote_get needs to return a valid remote for
a value like "sf.net"?  If it didn't, the error message would be even
better, and not complain about a "remote end".

Just thinking aloud, if what is specified as a remote does not contain
a ":" it cannot really be a URL(?), and we can assume it is a local
directory. If that directory does not exist is not a valid git
repository, it might be safe to fail in remote_get?

- Finn Arne
