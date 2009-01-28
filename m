From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 17:06:06 -0800
Message-ID: <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
 <20090127233939.GD1321@spearce.org>
 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: PJ Hyett <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyu7-0005gL-HK
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZA1BGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZA1BGR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:06:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZA1BGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:06:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82D049445D;
	Tue, 27 Jan 2009 20:06:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E06E99445B; Tue,
 27 Jan 2009 20:06:08 -0500 (EST)
In-Reply-To: <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 (PJ Hyett's message of "Tue, 27 Jan 2009 16:34:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC114F4C-ECD7-11DD-A419-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107440>

PJ Hyett <pjhyett@gmail.com> writes:

>> As we do not know what version github used to run (or for that matter what
>> custom code it adds to 1.6.1), I guessed that the previous one was 1.6.0.6
>> and did some comparison.  The client side pack_object() learned to take
>> alternates on the server side into account to avoid pushing objects that
>> the target repository has through its alternates, so it is not totally
>> unexpected the client side changes its behaviour depending on what the
>> server does.
>
> The only custom code we've written was a patch to git-daemon to map
> pjhyett/github.git to a sharded location (eg.
> /repositories/1/1e/df/a0/pjhyett/github.git) instead of the default.
>
> The new alternates code in 1.6.1 sounds like that could be the issue.

It could be.

With the old server, when project A has a forked project A1, and A1
borrows (via alternates) objects from A, pushing into A1 did not look at
refs in A's repository (this all happens on the server end).

With the new server, the server side also advertises the tips of A's
branches as commits that are fully connected, when the client side tries
to push into A1.  Older clients ignored this advertisement, so when they
pushed into A1, because their push did not depend on what's in repository
A on the server end, did not get affected if repository A (not A1) is
corrupted.  A new client talking to the server would be affected because
it believes what the server says.

Older client ignores this advertisement, so if you are seeing trouble
reports from people who use older clients, then you can dismiss this
conjecture as unrelated.  But if you see the issue only from people with
new clients, this could be just exposing a repository corruption of A (not
A1) on the server end that people did not know about before.
