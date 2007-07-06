From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Fri, 06 Jul 2007 10:06:51 +0200
Message-ID: <863b02j6qs.fsf@lola.quinscape.zz>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site> <20070705135824.GB5493@sigill.intra.peff.net> <Pine.LNX.4.64.0707051636240.9789@racer.site> <468DE9F3.B4489CDE@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 10:07:52 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ir1-0007vR-6o
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763147AbXGFIHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763166AbXGFIHK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:07:10 -0400
Received: from main.gmane.org ([80.91.229.2]:36455 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763272AbXGFIHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:07:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I6iqF-0006q2-RB
	for git@vger.kernel.org; Fri, 06 Jul 2007 10:07:03 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 10:07:03 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 10:07:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:xurPQAvnwSFDn8mrBSncm95sEVw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51729>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Johannes Schindelin wrote:
>> -       sed -e '1,/^$/d' <../commit | \
>> -               eval "$filter_msg" | \
>> -               sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
>> -                       $parentstr > ../map/$commit
>> +       (sed -e '1,/^$/d' <../commit |
>> +               (eval "$filter_msg" ||
>> +                die "msg filter failed: $filter_msg" 2>&3) |
>> +               (sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
>> +                       $parentstr > ../map/$commit ||
>> +                die "commit filter failed: $filter_commit" 2>&3)) 3>&1 |
>> +        grep . && die
>
> You introduce a handful of new forks and an exec. Isn't an intermediate
> file much cheaper?

The number of forks can be reduced by using { ...; } instead of (
... ) here (though it is possible the shell optimizes them away).
grep . should likely redirect its output with >&2 so that it ends up
on stderr.  I'd probably prefer grep ^ or grep '' since that matches
empty lines as well.  When done that way, I don't see a "handful of
new forks".

Instead of "grep ." one could also do something like

if read line then
  while echo "$line" && read line; do :; done
  die
fi

which is fork-less.

-- 
David Kastrup
