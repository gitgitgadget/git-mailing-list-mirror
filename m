From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more careful about updating refs
Date: Tue, 15 Jan 2008 17:11:32 -0800
Message-ID: <7vzlv6bmm3.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwpD-0005Y8-LH
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYAPBLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYAPBLp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:11:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYAPBLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:11:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 32CB165FD;
	Tue, 15 Jan 2008 20:11:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDD465FB;
	Tue, 15 Jan 2008 20:11:39 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 15:50:17 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70590>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This makes write_ref_sha1() more careful: it actually checks the SHA1 of 
> the ref it is updating, and refuses to update a ref with an object that it 
> cannot find.
>
> Perhaps more importantly, it also refuses to update a branch head with a 
> non-commit object. I don't quite know *how* the stable series maintainers 
> were able to corrupt their repository to have a HEAD that pointed to a tag 
> rather than a commit object, but they did. Which results in a totally 
> broken repository that cannot be cloned or committed on.

Two questions and a comment:

 - Do we want to impose the same restriction on refs/remotes/?
   I think that is a logical thing to do.

 - What should the receive-pack and git-fetch do if they trigger
   the check in this codepath while updating the refs under the
   affected hierarchies?  Fail the push and fetch?

 - I think !strcmp(refname, "HEAD") is not quite a right check
   to do here.  In order to catch the detached head case, it
   must be checked, but at the same time if the head is not
   detached, it should look at where the symref points at
   (i.e. a symref HEAD that points outside refs/heads is an
   error, and we need to catch that).

> +static int is_branch(const char *refname)
> +{
> +	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
> +}
