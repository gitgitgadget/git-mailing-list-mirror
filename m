From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Mon, 23 Feb 2009 23:06:42 -0800
Message-ID: <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrOq-00058w-GF
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbZBXHGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 02:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbZBXHGu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:06:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbZBXHGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 02:06:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BAC52BCF9;
	Tue, 24 Feb 2009 02:06:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5CD182BCF4; Tue,
 24 Feb 2009 02:06:44 -0500 (EST)
In-Reply-To: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 (Brent Goodrick's message of "Mon, 23 Feb 2009 22:47:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3476B58-0241-11DE-80EA-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111228>

Brent Goodrick <bgoodr@gmail.com> writes:

> Say I have these files and directories [2]:
>
>   /home/smart_tator/misc_files/.gitignore
>   /home/smart_tator/misc_files/foo/
>   /home/smart_tator/misc_files/bar/
>   /home/smart_tator/misc_files/bar/baz/foo/
>   /home/smart_tator/misc_files/bar/baz/real/
>
> then I do:
>
>   cd /home/smart_tator/misc_files/; git init
>
> and say I have this line in that .gitignore file:
>
>   foo/
>
> And then I naively execute:
>
>   git add bar/
>
> then the bar/baz/real/ is added, but these are dutifully ignored:
>
>   /home/smart_tator/misc_files/foo/
>   /home/smart_tator/misc_files/bar/baz/foo/

I think you are looking for "/foo/".  From Documentation/gitignore.txt:

 - If the pattern ends with a slash, it is removed for the
   purpose of the following description, but it would only find
   a match with a directory.  In other words, `foo/` will match a
   directory `foo` and paths underneath it, but will not match a
   regular file or a symbolic link `foo` (this is consistent
   with the way how pathspec works in general in git).

With this rule, (1) the trailing slash in your "foo/" tells git to match
only with directories, but (2) it behaves as if you said "foo" for all the
other rules.

With "/foo/", you tell git to match only with a directory, and it is as if
you said "/foo".

 - If the pattern does not contain a slash '/', git treats it as
   a shell glob pattern and checks for a match against the
   pathname without leading directories.

Your "foo/" now behaves the same way as "foo" behaves.  You are telling
git to match directory foo anywhere in the tree.  "/foo/" (now behaving
the same way as "/foo") does not satisfy this criteria so we would skip
this rule.

 - Otherwise, git treats the pattern as a shell glob suitable
   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
   wildcards in the pattern will not match a / in the pathname.
   For example, "Documentation/\*.html" matches
   "Documentation/git.html" but not
   "Documentation/ppc/ppc.html".  A leading slash matches the
   beginning of the pathname; for example, "/*.c" matches
   "cat-file.c" but not "mozilla-sha1/sha1.c".

Your "foo/" does not survive to this rule, but "/foo/" does.  It now
behaves as "/foo" and its leading slash makes it match the beginning.
