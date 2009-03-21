From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sat, 21 Mar 2009 12:28:21 -0700
Message-ID: <7vskl6ekve.fsf@gitster.siamese.dyndns.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
 <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 20:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll6tU-0004aV-NR
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 20:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbZCUT2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 15:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758353AbZCUT2a
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 15:28:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbZCUT23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 15:28:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 39D5F8CF0;
	Sat, 21 Mar 2009 15:28:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5D5C38CEA; Sat,
 21 Mar 2009 15:28:23 -0400 (EDT)
In-Reply-To: <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com> (Wincent
 Colaiuta's message of "Sat, 21 Mar 2009 17:20:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 73191E5C-164E-11DE-95EC-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114052>

Wincent Colaiuta <win@wincent.com> writes:

>> Given that git-difftool shares basically all the same options as
>> "git diff", I think a good long-term plan would be looking at adding
>> the "--tool" option to "git diff" itself so that users wouldn't have
>> to learn a new subcommand, just a new option.
>
> What do people think?

I am not "people" but since I was "To:"ed not "Cc:"ed...

I did not comment on it because personally I was not very interested in
it; admittedly, I do not use difftool myself, but:

 (1) "git diff --tool" is more to type than "git difftool"; and

 (2) it requires adding more code to "git diff" for a dubious benefit from
     end user's point of view.

"git diff" itself is already just a thin command dispatcher that calls
underlying vastly different modes operations, and it is designed that way
in order to make it easy to add a new totally different mode of operation.

We originally had four underlying modes of operation (index-with-worktree,
tree-with-tree, tree-with-worktree, and tree-with-index), and Dscho
managed to add random-file-with-random-file without disturbing existing
codepaths too much.

Even though it is a "thin" dispatcher, command line parsing is largely
done by "git diff" itself, and its results are fed to the underlying modes
of operations, for two reasons:

 (1) These "modes of operations" share large set of options (e.g. "-U20"
     works the same way no matter which mode you invoke); and

 (2) the dispatcher needs to inspect command line option and arguments to
     decide which mode to invoke anyway.

When an end user says "I want to compare two things with these settings
(e.g. use color, with 5 lines of context, only inside Documentation/howto
directory, detect renames with lower-than-usual threashold, ...)", the
mental model is same whether the two things being compared happens to be
index-vs-worktree or tree-vs-index from the end user's point of view.  It
makes a lot of sense for "git diff --options" to invoke both modes of
operations with a similar-looking command line.

Even though the --no-index mode of operation internally does not fit very
well compared to the original four modes from the implementation point of
view, it still naturally fits the end user's mental model and that is why
it is given as an option to "git diff".

Does "git difftool" fit well in the end user's mental model in a similar
way to "git diff"?  I somehow suspect it doesn't.  What does it mean to
give "-U8 --color --stat --summary -p --ignore-space-at-eol" options when
you invoke it, for example?
