From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Sun, 30 Aug 2009 18:25:44 +0200
Message-ID: <87skf9uv3r.fsf@meyering.net>
References: <87k549dyne.fsf@meyering.net>
	<7vvdnt869j.fsf@alter.siamese.dyndns.org>
	<87eiuhdnw9.fsf@meyering.net>
	<7v7i087twu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 18:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhnEz-0000e3-KK
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 18:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbZH3Q0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbZH3Q0o
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 12:26:44 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:39061 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZH3Q0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 12:26:43 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 8DD862CB0D
	for <git@vger.kernel.org>; Sun, 30 Aug 2009 18:26:41 +0200 (CEST)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7787481805A
	for <git@vger.kernel.org>; Sun, 30 Aug 2009 18:25:46 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9244B8180FE
	for <git@vger.kernel.org>; Sun, 30 Aug 2009 18:25:44 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 6ECBB38301; Sun, 30 Aug 2009 18:25:44 +0200 (CEST)
In-Reply-To: <7v7i087twu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 May 2009 13:40:49 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127415>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>> Junio C Hamano wrote:
>>> Jim Meyering <jim@meyering.net> writes:
>>>>
>>>>     # do this in an empty directory
>>>>     $ git init -q; echo>k; git add .; git commit -q -m. .; echo \ >k
>>>>     $ git diff --ignore-space-at-eol --quiet || echo bad
>>>>     bad
>>>
>>> I am slightly torn about this, in that I can picture myself saying that
>>> this is unintuitive on some different days, but not today ;-)
>>
>> Thanks for the quick reply.  Here's why I noticed:
>> ...
>
> It seems that today is already "some different day" ;-) We could do
> something like this patch.
>
> While in the longer term I think it may make the world a better place by
> being more consistent with what users expect, I am not sure at what
> revision boundary we should introduce such a semantic change.
>
> We could always declare this a bug and apply the "fix" at any time.  It's
> all perception ;-).
>
> -- >8 --
> Subject: [PATCH] diff --quiet: special case "ignore whitespace" options
>
> The option "QUIET" primarily meant "find if we have _any_ difference as
> quick as possible and report", which means we often do not even have to
> look at blobs if we know the trees are different by looking at the higher
> level (e.g. "diff-tree A B").  As a side effect, because there is no point
> showing one change that we happened to have found first, it also enables
> NO_OUTPUT and EXIT_WITH_STATUS options, making the end result look quiet.
>
> Traditionally, the --ignore-whitespace* options have merely meant to tell
> the diff output routine that some class of differences are not worth
> showing in the textual diff output, so that the end user has easier time
> to review the remaining (presumably more meaningful) changes.  These
> options never affected the outcome of the command, given as the exit
> status when the --exit-code option was in effect (either directly or
> indirectly).
>
> These two classes of options are incompatible.  When you have only
> whitespace changes, you would expect:
>
> 	git diff -b --quiet
>
> to report that there is _no_ change.  This is unfortunately not the case,
> however, if there are differences to be reported if the command was run
> without --quiet; there _is_ a change, and the command still exits with
> non-zero status.
>
> And that is wrong.
>
> Change the semantics of --ignore-whitespace* options to mean more than
> "omit showing the difference in text".  When these options are used, the
> internal "quick" optimization is turned off, and the status reported with
> the --exit-code option will now match if any the textual diff output is
> actually produced.
>
> Also rename the internal option "QUIET" to "QUICK" to better reflect what
> its true purpose is.

Thanks again.
If there's anything I can to do help (add a test?), let me know.
