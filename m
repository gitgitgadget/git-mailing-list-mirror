From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 13:20:05 -0700
Message-ID: <7vhcetck5m.fsf@gitster.siamese.dyndns.org>
References: <47EAABB6.30803@thorn.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jec7Z-0007fq-Ho
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759085AbYCZUUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758895AbYCZUUV
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:20:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128AbYCZUUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 16:20:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 681BD5C4A;
	Wed, 26 Mar 2008 16:20:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 83E605C49; Wed, 26 Mar 2008 16:20:12 -0400 (EDT)
In-Reply-To: <47EAABB6.30803@thorn.ws> (Tommy Thorn's message of "Wed, 26 Mar
 2008 13:01:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78305>

Tommy Thorn <tommy-git@thorn.ws> writes:

> According to the man page, I should be able to change .gitignore to
> "foo/" to stop it from looking recursively, but that doesn't work, as
> now git clean -n -f -d wants to remove mydir/foo but not mydir/foo/objs
>
> My desperate attempts "./foo" and "^foo" also didn't work. Please note
> that this is a vastly simplified version of the real problem, so I
> can't just use "!mousetrap/foo".
>
> It seems "foo/" _should_ work even though foo isn't a directory.

Are you talking about d6b8fc3 (gitignore(5): Allow "foo/" in ignore list
to match directory "foo", 2008-01-31), specifically this part of the
manual?

    diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
    index 08373f5..e847b3b 100644
    --- a/Documentation/gitignore.txt
    +++ b/Documentation/gitignore.txt
    @@ -57,6 +57,13 @@ Patterns have the following format:
        included again.  If a negated pattern matches, this will
        override lower precedence patterns sources.

    + - If the pattern ends with a slash, it is removed for the
    +   purpose of the following description, but it would only find
    +   a match with a directory.  In other words, `foo/` will match a
    +   directory `foo` and paths underneath it, but will not match a
    +   regular file or a symbolic link `foo` (this is consistent
    +   with the way how pathspec works in general in git).
    +
      - If the pattern does not contain a slash '/', git treats it as
        a shell glob pattern and checks for a match against the
        pathname without leading directories.

Incidentally I notice that the above patch did not include new tests to
see if "git clean" honors the corrected pattern matching rule.  If your
"real problem" is too complex to describe, perhaps an additional test that
exercises "git clean" with test_expect_failure would help motivated
parties to triage and fix the problem.

"git clean" has always been an ugly and unreliable stepchild, and I would
not be surprised at all if it is ridden with corner case bugs, especially
around the area to skip untracked directories; but in this case you are
not dealing with a directory but a symlink, and it should not get confused
by the fact that the symlink happens to point at a directory.
