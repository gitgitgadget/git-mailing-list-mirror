From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 12:27:24 -0800
Message-ID: <7v7i67zsgj.fsf@gitster.siamese.dyndns.org>
References: <20081209224622.28106.89325.stgit@localhost.localdomain>
 <20081210124901.6117@nanako3.lavabit.com>
 <200812101439.18526.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVg3-0006K2-CX
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbYLJU1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbYLJU1f
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:27:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbYLJU1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:27:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A7ED785EC7;
	Wed, 10 Dec 2008 15:27:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8540285EC4; Wed,
 10 Dec 2008 15:27:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F9D683D0-C6F8-11DD-8866-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102717>

Jakub Narebski <jnareb@gmail.com> writes:

> On Wed, 10 Dec 2008, Nanako Shiraishi wrote:
>> Quoting Jakub Narebski <jnareb@gmail.com>:
>> 
>> > Unfortunately the implementation in 244a70e used one call for
>> > git-rev-parse to find parent revision per line in file, instead of
>> > using long lived "git cat-file --batch-check" (which might not existed
>> > then), or changing validate_refname to validate_revision and made it
>> > accept <rev>^, <rev>^^, <rev>^^^ etc. syntax.
>> 
>> Could you substantiate why this is "Unfortunate"?
>
> Because it calls git-rev-parse once for _each line_, even if for lines
> in the group of neighbour lines blamed by same commit $parent_commit
> is the same, and even if you need to calculate $parent_commit only once
> per unique individual commit present in blame output.

It probably was obvious that this was meant as a patch for better
performance without changing the functionality.  I tend to think the
presentation wasn't so great, though.

    Luben Tuikov changed 'lineno' link from leading to commit which lead
    to current version of given block of lines, to leading to parent of
    this commit in 244a70e (Blame "linenr" link jumps to previous state at
    "orig_lineno").  This supposedly made data mining possible (or just
    better).

Other than "supposedly" which I do not think should be there, I think this
is a great opening paragraph to establish the context.

    Unfortunately the implementation in 244a70e used one call for
    git-rev-parse to find parent revision per line in file, instead of
    using long lived "git cat-file --batch-check" (which might not existed
    then), or changing validate_refname to validate_revision and made it
    accept <rev>^, <rev>^^, <rev>^^^ etc. syntax.

But I do not think this is such a great second paragraph that states what
problem it tries to solve.  I'd say something like this instead:

        The current implementation calls rev-parse once per line to find
        parent revision of blamed commit, even when the same commit
        appears more than once, which is inefficient.

And then the outline of the solution:

    This patch attempts to migitate issue a bit by caching $parent_commit
    info in %metainfo, which makes gitweb to call git-rev-parse only once
    per unique commit in blame output.

which is very good, except that I do not think you need to say "a bit".
And have your benchmark (two tables and footnotes) after this outline of
the solution.

I think the first part of "Unfortunately" paragraph can be dropped
(because that is already in the first half of problem description) and the
rest can come as the last paragraph as "Possible future enhancements".

> Appendix A:
> ~~~~~~~~~~~
> #!/bin/bash
>
> export GATEWAY_INTERFACE="CGI/1.1"
> export HTTP_ACCEPT="*/*"
> export REQUEST_METHOD="GET"
> export QUERY_STRING=""$1""
> export PATH_INFO=""$2""
>
> export GITWEB_CONFIG="/home/jnareb/git/gitweb/gitweb_config.perl"
>
> perl -- /home/jnareb/git/gitweb/gitweb.perl
>
> # end of gitweb-run.sh

I'd suggest making a separate patch to add "gitweb-run.sh" in contrib/ so
that other people can use it when checking their changes to gitweb.  The
script might need some more polishing, though.  For example, it is not
very obvious if you have *_config.perl only to customize for your
environment (e.g. where the test repositories are) or you need to have
some overrides in there when you are running gitweb as a standalone script.

To recap, I think the commit log for this patch would have been much
easier to read if it were presented in this order:

	a paragraph to establish the context;

	a paragraph to state what problem it tries to solve;

        a paragraph (or more) to explain the solution; and finally

	a paragraph to discuss possible future enhancements.
