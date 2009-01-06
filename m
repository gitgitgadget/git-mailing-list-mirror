From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC 1/4] Optimised, faster,
 more effective symlink/directory detection
Date: Tue, 06 Jan 2009 10:56:50 +0100
Organization: private
Message-ID: <86bpuklpul.fsf@broadpark.no>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
 <1231161001-32599-2-git-send-email-barvik@broadpark.no>
 <7vprj0j181.fsf@gitster.siamese.dyndns.org>
 <7v3afwizi7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 10:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK8hR-0000xz-Ly
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbZAFJ4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 04:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZAFJ4y
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 04:56:54 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:44424 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbZAFJ4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 04:56:53 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD1004Q2NMR1LA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 10:56:51 +0100 (CET)
Received: from localhost ([80.202.166.60]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD1006LBNMQM850@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 10:56:51 +0100 (CET)
In-reply-to: <7v3afwizi7.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104674>

Junio C Hamano <gitster@pobox.com> writes:
 <snipp>
> If everything is working correctly, I do not think you will ever have a
> situation where you check "A/B" here and get ENOTDIR back.  lstat("A/B")
> would yield ENOTDIR if "A" is not a directory, but:
>
>  (1) If you did test "A" in the earlier round in the loop, you would have
>      already found it is not a directory and would have exited the loop
>      with LSTAT_ERR.  You cannot test "A/B" in such a case;

  No, if the test lstat("A") already returned -1 it would then have set
  errno to ENOTDIR in this case, I think.  So in this case the cache
  would have only stored "A".

>  (2) If you did not test "A" in the loop, that has to be because you had a
>      cached information for it, and the caching logic would have returned
>      early if "A" was a non-directory without entering the loop; in other
>      words, you would test "A/B" here without testing "A" in the loop only
>      when the cache says "A" was a directory.  You cannot get ENOTDIR in
>      such a case.
>
> In any case, my main puzzlement still stands.  I think ENOTDIR case should
> behave differently from ENOENT case.
>
> And I think it is an indication of a grave error, either this code is
> racing with an external process that is actively mucking with the work
> tree to make your cached information unusable, or somebody forgot to call
> clear_lstat_cache().
>
> Hmm?

  I think that you do not see that the when the lstat() function returns
  errno =

    ENOENT   A component of the path path does not exist, or the path is
             an empty string.
    ENOTDIR  A component of the path is not a directory.

  the cache logic will/must assume that the component we got an error on
  will/must always be the _last_ component in the path.

> I take 1/4 of the above back.

  Will this means that I do not have to update the patch to version 2?

  Note, one thing what I personally do not like with this patch so far,
  is that it makes a new file, and then it kinda hides the comments from
  Linus which talks aboth extending the logic.  It would maybe be better
  to have reused the same file (symlinks.c), but then the function name
  ('lstat_cache()') and the filename would not match.

  -- kjetil
