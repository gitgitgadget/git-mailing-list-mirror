From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked branch
Date: Fri, 20 Mar 2009 10:03:43 -0700
Message-ID: <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
References: <200903181448.50706.agruen@suse.de>
 <20090318182603.GM8940@machine.or.cz>
 <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
 <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
 <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lki9w-0000GB-AU
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 18:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395AbZCTRD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 13:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757371AbZCTRD5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:03:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317AbZCTRD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 13:03:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DBFDA192F;
	Fri, 20 Mar 2009 13:03:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45DB5A1929; Fri,
 20 Mar 2009 13:03:44 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri, 20 Mar 2009 17:17:01 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 17597108-1571-11DE-A6EA-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113979>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Often, it is quite interesting to inspect the branch tracked by a given
> branch.  This patch introduces a nice notation to get at the tracked
> branch: '%<branch>' can be used to access that tracked branch.
>
> A special shortcut '%' refers to the branch tracked by the current branch.
>
> Suggested by Pasky.
>
> Even if a branch name can legally start with a '%' sign, we can use the
> special character '%' here, as you can always specify the full ref:
> refs/heads/%my-branch (pointed out by doener on IRC).

That is not a good argument, as %<name> is (just like name@{-n} is) a
substitute way to spell the "name" of a branch, not just a random SHA-1,
and to some commands it makes a difference between <branchname> and
refs/heads/<branchname>.  The latter is not giving the name of the branch,
but merely a commit object name.

An most obvious one is that "git checkout branchname" and "git checkout
refs/heads/branchname" behave differently.  You cannot checkout a branch
called %master after this patch goes in.

Just be honest and say "You may have a branch whose name begins with a '%'
and you cannot refer to it anymore in certain contexts.  Too bad.  Don't
do it next time you create a new branch".  I _can_ buy that argument.

It however asks for a sane escape hatch.  You cannot "fix" such branch
names in most obvious ways (if you could, that would be a bug in this %
feature).

 (1) git branch -m %master percent-master

     We would end up renaming what master tracks to new name.

 (2) git branch percent-master refs/heads/%master; git branch -d %master

     The first part is a good try, but the latter deletes what master
     tracks.

"git update-ref -d refs/heads/%master" needs to replace the second step of
the latter.
