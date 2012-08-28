From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere vs rebase --skip
Date: Tue, 28 Aug 2012 15:55:26 -0700
Message-ID: <7vzk5ey6ch.fsf@alter.siamese.dyndns.org>
References: <20120828215202.GB7702@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 00:55:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6UhB-0002hY-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 00:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab2H1Wzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 18:55:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476Ab2H1Wz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 18:55:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA0498E1F;
	Tue, 28 Aug 2012 18:55:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iV4JyUpNTOHMKBLcUx/sZua7+Bo=; b=D553ay
	j1ArWXYjM9o3Fmz8tbRVRH4GRSoXekMPOs5hwnuQbN6/Xx04GWpmxIqycHGLh4SO
	JsWbKtyDE6Irxx9Pl/emctHWZA+q4WM2xwYc5dIe+iCfdySXKbD9u+SePcD1CjjX
	TLUtKfXSpa4fxbbjRzMdr3yIzOnvnPFGCpT5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZjJNyBKZTMewHuLBFW4DxCO6+UgEp1Mb
	DIv0HjaTcfRS4CvGld+Y/zQdc0SBvmef0nx0C+GFLTSINlyhmxP3cKWV8Of4NCyE
	Wde1zqSSnMZeZsBHmv0KJIPOt4Loh27ptU7PzjP8G+lIVu1atwaT7X+8R5asO9+b
	Y2G1tbAepEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97FB38E1E;
	Tue, 28 Aug 2012 18:55:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01D898E1D; Tue, 28 Aug 2012
 18:55:27 -0400 (EDT)
In-Reply-To: <20120828215202.GB7702@glandium.org> (Mike Hommey's message of
 "Tue, 28 Aug 2012 23:52:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75EA0E54-F163-11E1-BD3E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204458>

Mike Hommey <mh@glandium.org> writes:

> When rebasing the topic branches, I can hit conflict resolution that I
> already had to do for other topic branches on another upstream import
> branch. Here, git rerere is very helpful. But sometimes, the conflict
> resolution is just to skip the patch, because it was incorporated
> upstream in a way that git doesn't detect, or it was obsoleted, or
> whatever. In such cases, git rerere is not being helpful because it
> doesn't store any information about that, and I have to check again if
> that's an actual conflict to solve or a patch to skip again.
>
> It would be helpful if there was a rebase --skip mode that would tell
> rerere to record that the resolution *is* --skip.

That is like saying "my hammer is very helpful when I want to hit
nails, but sometimes I wish it helped me with screws".

The only thing "rerere" does is to remember the shape of the
conflicted state and desired resolution _per_ _file_.  It does not
tell "rebase" what to do next (you do, via "git add -u" followed by
"git rebase --continue").

Presumably, you _could_ run "git checkout HEAD $path" followed by
"git rerere" to record that a particular shape of the conflicted
state should resolve to what you already have in the HEAD commit, so
that the same conflict that happens in future rebases automatically
resolve to a no-op for these conflicted paths, and telling "rebase"
to continue via the same "add -u && rebase --continue" might notice
that there is no change, and its "skip empty" logic might kick in.

But I wouldn't blindly recommend it.  If a change you are replaying
has two paths, one that somehow cleanly merges, and the other that
conflicts because you do have an equivalent change (and more) in the
updated HEAD, letting "rebase" continue that way would record only
the changes to the first path while ignoring the other one, which
may or may not be what you want.
