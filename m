From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 00:35:54 -0800
Message-ID: <7vy6w5795h.fsf@gitster.siamese.dyndns.org>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
 <7veixxaale.fsf@gitster.siamese.dyndns.org>
 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
 <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
 <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLSM-0006Rs-T4
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbZBQIgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbZBQIgD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:36:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZBQIgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:36:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F26D9982D;
	Tue, 17 Feb 2009 03:35:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5B8E99982C; Tue,
 17 Feb 2009 03:35:56 -0500 (EST)
In-Reply-To: <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
 (Jay Soffian's message of "Tue, 17 Feb 2009 02:41:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00A95B1E-FCCE-11DD-A371-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110333>

Jay Soffian <jaysoffian@gmail.com> writes:

> So then, why does "git merge FETCH_HEAD" bother to strip out a
> not-for-merge marker that wouldn't be there?

In general, FETCH_HEAD is usable as an extended SHA-1, in that any file
that is in .git/ and begins with [0-9a-f]{40} names that object.  That is
how "git log -p ..FETCH_HEAD" in my example worked.

The reason stripping of not-for-merge is done is to support a usage that
is not so sane as well.

You can do a wildcard fetch that leaves full of not-for-merge entries in
FETCH_HEAD, and then use FETCH_HEAD as an extended SHA-1 to merge the one
that happens to be on the first line.  "git merge" *could* in such a case
produce:

	Merge commit $ugly_40_hexadecimal_name

to say that it merged that commit named by a random extended SHA-1, but it
knows that FETCH_HEAD has better information than that.  The line tells
where you got that commit from.  And that is recorded past not-for-merge
marker (if exists, otherwise it is an empty string) that is enclosed by a
HT on each side.  This is a direct translation from the scripted version
that did:

	sed -e 's/	not-for-merge	/		/' -e 1q

It is being overly nice to produce a sensible merge message, even when you
asked it to do something not very sensible.

Now to something totally useless.

After reading the builtin-merge.c and original git-merge.sh (now in
contrib/examples) script, I think it could have done something entirely
different.

It could have done this instead.

	sed -e '/	not-for-merge	/d'

to learn the commits and their human-readable origins, and it could have
tried to reproduce what "git pull" did when it invoked git-merge using
that information.  Then you could use this workflow:

	$ git pull <possibly with arguments>
        ... oops, conflicted and is very messy.
        ... I tried to resolve, but failed and made the mess even worse.
        ... Let's start over.
        $ git reset --hard
        ... FETCH_HEAD knows which refs are for merging
        $ git merge FETCH_HEAD

That is, no matter what the arguments were for the initial "git pull",
what should be merged is recorded in FETCH_HEAD, and that is how you can
retry the merge without refetching over the network.

But such a change makes FETCH_HEAD different from what it traditionally
meant, and does that only to "git merge", making the result very
inconsistent.  For example, "git log ..FETCH_HEAD" will still use the
object name on the first line, and it won't be a way to convince yourself
that the changes are sensible and it is Ok to run "git merge FETCH_HEAD"
anymore.  So I do not think such a change will be an improvement.
