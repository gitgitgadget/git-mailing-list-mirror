From: Junio C Hamano <gitster@pobox.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 16:43:03 -0800
Message-ID: <7vocx1evvs.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
 <loom.20090216T101457-231@post.gmane.org>
 <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com>
 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com> <7vprhidpnc.fsf@gitster.siamese.dyndns.org>
 <20090216224330.GA23764@sigill.intra.peff.net>
 <7vhc2uezl7.fsf@gitster.siamese.dyndns.org>
 <20090217002352.GA23507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZE4o-0005Ca-I7
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbZBQAnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZBQAnM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:43:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZBQAnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:43:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ADD132B488;
	Mon, 16 Feb 2009 19:43:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 730992B486; Mon,
 16 Feb 2009 19:43:05 -0500 (EST)
In-Reply-To: <20090217002352.GA23507@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 16 Feb 2009 19:23:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F38100FA-FC8B-11DD-A3AF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110272>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 16, 2009 at 03:23:00PM -0800, Junio C Hamano wrote:
>
>> >   1. How can we improve this situation?
>> 
>> The situation you described is all about "don't allow a push that is NOT
>> CONTROLLED BY YOU and that can interfere with what you are doing into a
>> live repository", and you are right, we have operations that deliberately
>> detach the HEAD and expect nobody mucks with the branch.
>
> I don't agree that it has to be a push not controlled by you. I have
> many times left a rebase-in-progress sitting in a repository, either
> accidentally because I meant to "--abort" it after a conflict but
> forgot, or because I got interrupted during an interactive edit and
> needed to come back to it.

That sounds similar to saying "I left my editor open without saving my
changes, and accidentally opened another instance of an editor from a
different terminal and edited the same file, the result is a mess".  The
editors protect users from such a situation by locking the file they are
editing.

Perhaps operations that detaches HEAD (rebase and perhaps sequencer) can
all agree to use a single marker file that says "Do not mess with these
refs via push or fetch" and make receive-pack and fetch honor that?  Then
the issue you raised in your earlier message about receive-pack having to
know random states random set of tools leave will be alleviated.  We need
to make sure that the marker is cleaned up correctly when the command is
done with the lock, of course.

If we were to go that route, I think the same receive.denyCurrentBranch
configuration variable can and should be used to control this, even though
its name originally comes from the most visible operation that can cause
the confusion (i.e. "pushing into the current branch").  It is about
protecting the person who is currently using the work tree, or who will
use the work tree next.

> I am really just proposing that the "ref was not what we expected"
> message to better indicate what is going on, and how the user might get
> out of it. Do you not agree with that?

The recovery recipe you described looked good.
