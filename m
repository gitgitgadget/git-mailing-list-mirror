From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Sun, 22 Jul 2012 14:08:12 -0700
Message-ID: <7vr4s3pkqr.fsf@alter.siamese.dyndns.org>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
 <7vwr23zb65.fsf@alter.siamese.dyndns.org>
 <20120717082452.GC1849@tgummerer.surfnet.iacbox>
 <500C1AA9.4000306@dewire.com> <7vfw8jsk5o.fsf@alter.siamese.dyndns.org>
 <87629fvaxz.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3O6-0008QY-Oq
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 23:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab2GVVIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 17:08:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab2GVVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 17:08:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 237828B62;
	Sun, 22 Jul 2012 17:08:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AD9G467l+hl89nFWyzJIhX4srnY=; b=xJb0/E
	hFjWGegSnXZUVBwp5cYgua/c1QcfyBnFQMSk7s0AaB3yP1QKhRDBeaqFSqoqlcvV
	L88XEJY66AGBmI7xF5S+5+v7sPQydKlZnkVvNGA/9V1PfGKGOxMEPicb1gicC50l
	QTlQLL3T/TPpXPXNfujUObKNd5J1JRT4LDMXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bd1f0l1rOtLKMRUpCe2x2dJZ+I/WacbH
	zjkdqxQpFIqEU1nJVRAp1l5aRKjq+8PH8CHrnkR+iPYJJOsUwr6bxiAD/Zs5fpCJ
	ha8nO+crMSU++go3gMZEDR7AQpjUd/9rcyLP6YNDwfHkFIrVvHwRN+PRtrsUS0ro
	TflybMW9KKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115868B60;
	Sun, 22 Jul 2012 17:08:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 012D18B5D; Sun, 22 Jul 2012
 17:08:16 -0400 (EDT)
In-Reply-To: <87629fvaxz.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Sun, 22 Jul 2012 21:43:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B840F0E-D441-11E1-BEE5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201866>

Thomas Rast <trast@student.ethz.ch> writes:

> Hum, I'm a bit lost now.
>
> What is the status quo?  I take it JGit does not have any of ctime, dev,
> ino etc., and either leaves the existing value or puts a 0....
> an argument in favor of splitting stat_crc into its fields again?

A difference is that JGit already has such code, and we would be
adding a burden to do so yet again.  It also may not just be JGit,
but anything that wants to be "compatible" with systems whose
filesystem interface does not give enough data by omitting fields
the current index pays attention to.

It isn't really a discussion about splitting again, but more about
not squishing them into a new field in the first place---IIUC, even
outside Windows, ctime is already problematic on some systems where
background processes muck with extended attributes Git does not pay
attention to. If the patch makes us lose the ability to selectively
ignore changes to certain fields (e.g. changes to dev and ino are
noticed but ctime are ignored) by squishing them into one new field,
wouldn't removing them without adding such a useless field a simpler
way to go?
