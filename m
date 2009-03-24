From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT BUG?  GIT occasionally redownloads its entire data set
Date: Mon, 23 Mar 2009 19:17:10 -0700
Message-ID: <7vskl34qc9.fsf@gitster.siamese.dyndns.org>
References: <28707.1237855543@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 03:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlwE7-0004rJ-PJ
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 03:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbZCXCRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 22:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZCXCRV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 22:17:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZCXCRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 22:17:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A3408726;
	Mon, 23 Mar 2009 22:17:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 668CF8725; Mon,
 23 Mar 2009 22:17:12 -0400 (EDT)
In-Reply-To: <28707.1237855543@redhat.com> (David Howells's message of "Tue,
 24 Mar 2009 00:45:43 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E598E3D2-1819-11DE-A3BA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114395>

David Howells <dhowells@redhat.com> writes:

> to v2.6.29.  I've attached the command output for reference.

Version of git used, and the .git/config ([remote "origin"] section)?

> warthog>git-pull
> remote: Counting objects: 447, done.
> remote: Compressing objects: 100% (57/57), done.
> remote: Total 266 (delta 216), reused 254 (delta 207)
> Receiving objects: 100% (266/266), 37.94 KiB, done.
> Resolving deltas: 100% (216/216), completed with 105 local objects.
> warning: no common commits
> remote: Counting objects: 1075436, done.
> remote: Compressing objects: 100% (176743/176743), done.
> remote: Total 1075436 (delta 896164), reused 1072243 (delta 893708)
> Receiving objects: 100% (1075436/1075436), 260.71 MiB | 307 KiB/s, done.
> Resolving deltas: 100% (896164/896164), done.
>>From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

This is intereseting because it shows that two separate transfer happened
back to back, which I do not think is what recent git does.

We used to first grab the objects reachable from primary refs (presumably
[remote "origin"] fetch = refs/heads/*:refs/remotes/origin/*) and then
turned around to ask for tags that possibly point at commits we freshly
obtained during the first transfer (i.e. the ones reachable from the tip
of "master").  In such an ancient version I vaguely recall some bugs fixed
before we stopped doing this two-stage transfer altogether, but I do not
recall offhand if a bug that loses track of what it just downloaded (which
is what your description suggests) was among them.

Rings a bell, anybody?
