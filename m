From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Wed, 12 Aug 2009 13:30:25 -0700
Message-ID: <7vocqkydum.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
 <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
 <20090811214849.GA3868@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908120128120.8306@pacific.mpi-cbg.de>
 <20090812074521.GD15152@coredump.intra.peff.net>
 <m363ctpedr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKTI-0008H2-Ba
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbZHLUam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbZHLUam
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:30:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZHLUal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:30:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 436FE270C0;
	Wed, 12 Aug 2009 16:30:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 87A14270BC; Wed, 12 Aug 2009
 16:30:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01706240-877F-11DE-A1D7-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125740>

Jakub Narebski <jnareb@gmail.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>   1. Is there some other syntax that _doesn't_ have this breakage
>>      but that similarly helps the "vast majority of Git users".
>
> Well, proposed possible syntax was:
> 1. <vcs>:<repository location>
> ...
> 2. <vcs>::<repository location>
> ...
> 3. <vcs>+<repository location>
>
>    e.g.
>
>      svn+http://svn.example.com/project
>
>    but
>
>      http+svn://svn.example.com/project
>      svn+path/to/repo

I do not think these are valid examples to demonstrate that 3 is bad.

We do not have (and we will not create) "http+svn://" native transport, so
the former can only mean "Feed 'svn://svn.example.com/project' to the vcs
helper whose name is 'http'".  Similarly I do not see any way to read the
latter other than "Feed 'path/to/repo' to 'svn' vcs helper".

We do have a pair of synonyms "git+ssh://foo" and "ssh+git://bar" that
could make the use of '+' ambiguous.  They could be feeding 'ssh://foo'
and 'git://bar' to 'git' and 'ssh' vcs helpers respectively, but

 (1) they are not even advertised in Documentation/ anywhere as far as I
     can see; and

 (2) these are the only two existing ones that are misdesigned, and we can
     easily special case them to keep backward compatibility.

Double-colon (your 2) is also workable.  It probably is slightly better
than plus because it does not have to grandfather "git+ssh" and "ssh+git"
and that would be beneficial for requiring less complexity in both code
(i.e. special case logic) and more importantly in mental burden to the end
users (i.e. '::' would stand out more than '+' and clearly different from
traditional git URLs in all cases).

As Jeff said (your 1.), a single colon ':' has a rather bad ambiguity
between <vcs> and hostname part in the existing scp-style repository
naming.
