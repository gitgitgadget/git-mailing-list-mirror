From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: git-diff silently fails when run outside of a repository
 (v1.5.4.2)
Date: Tue, 29 Apr 2008 16:37:58 -0700
Message-ID: <7vskx444h5.fsf@gitster.siamese.dyndns.org>
References: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com>
 <7vabjc5l3r.fsf@gitster.siamese.dyndns.org>
 <3c6c07c20804291603q4fbe957eq3e3da39d4a2e29c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:39:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqzPe-0003T8-Hz
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbYD2XiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbYD2XiL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:38:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbYD2XiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:38:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A49B93F14;
	Tue, 29 Apr 2008 19:38:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C43063F10; Tue, 29 Apr 2008 19:38:03 -0400 (EDT)
In-Reply-To: <3c6c07c20804291603q4fbe957eq3e3da39d4a2e29c0@mail.gmail.com>
 (Mike Coleman's message of "Tue, 29 Apr 2008 18:03:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52AD1498-1645-11DD-B736-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80771>

"Mike Coleman" <tutufan@gmail.com> writes:

> On Tue, Apr 29, 2008 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Mike Coleman" <tutufan@gmail.com> writes:
>>
>>  > At least in version 1.5.4.2, git-diff silently fails when not run
>>  > inside a repository.  It should give an error diagnostic, especially
>>  > since "no output" would otherwise be a meaningful response.
>>
>>  Unfortunately this does not have enough information to go by, as unlike
>>  many other programs, "git diff" contains a hack to be usable as a better
>>  (for certain definition of "better" I may not necessarily agree with) GNU
>>  diff replacement when run outside a repository.
>>
>>  i.e.
>>
>>         mkdir -p /var/tmp/junk
>>         cd /var/tmp/junk
>>         rm -fr .git ;# make sure it is not a repository
>>         echo >a hello
>>         echo >b world
>>         git diff --color a b
>>
>>  is supposed to work.

> Oh, I didn't realize that.  It doesn't seem to be mentioned on the man
> page, though I can't necessarily claim that I would have seen it if it
> had.
>
> Even so, this seems like a bug.  If I do this:
>
>     $ cd /
>     $ git-diff
>
> there is no error message and no error status.  A diagnostic would be
> very helpful.

Ah, that indeed is not very helpful.

Unfortunately, every time I look at this hack, I seem to find an unrelated
bug in it.  Here is today's.

	$ for i in 1 2 3; do >/var/tmp/$i; done
        $ cd /
        $ git diff /var/tmp/1
        Segmentation Fault

When nongit is true, we know the user has to be asking --no-index diff, so
perhaps we can fix it by doing something like this?

diff --git a/diff-lib.c b/diff-lib.c
index 069e450..cfd629d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -264,6 +264,9 @@ int setup_diff_no_index(struct rev_info *revs,
 			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
 			break;
 		}
+	if (nongit && argc != i + 2)
+		die("git diff [--no-index] takes two paths");
+
 	if (argc != i + 2 || (!is_outside_repo(argv[i + 1], nongit, prefix) &&
 				!is_outside_repo(argv[i], nongit, prefix)))
 		return -1;
