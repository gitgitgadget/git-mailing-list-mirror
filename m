From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] Optimised, faster, more effective
 symlink/directory detection
Date: Tue, 06 Jan 2009 00:56:32 -0800
Message-ID: <7v3afwizi7.fsf@gitster.siamese.dyndns.org>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
 <1231161001-32599-2-git-send-email-barvik@broadpark.no>
 <7vprj0j181.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:58:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7lE-0001RM-1O
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbZAFI4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbZAFI4k
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:56:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZAFI4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:56:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AECF58E122;
	Tue,  6 Jan 2009 03:56:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 656E78E121; Tue,
  6 Jan 2009 03:56:34 -0500 (EST)
In-Reply-To: <7vprj0j181.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 06 Jan 2009 00:19:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDE0E976-DBCF-11DD-981D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104666>

Junio C Hamano <gitster@pobox.com> writes:

> Let me see if I understand the logic behind this caching....
> ...
>> +		last_slash = match_len;
>> +		cache_path[last_slash] = '\0';
>> +
>> +		if (lstat(cache_path, &st)) {
>> +			ret_flags = LSTAT_LSTATERR;
>> +			if (errno == ENOENT || errno == ENOTDIR)
>> +				ret_flags |= LSTAT_NOTDIR;
>
> If you tested "A/B" here and got ENOENT back, you know "A/B" does not
> exist; you cache this knowledge as "A/B is not a directory" (I also think
> you could use it as a cached knowledge that "A exists and is a directory".
> I am not sure if you are taking advantage of that).
>
> What I do not understand about this code is the ENOTDIR case.  If you
> tested "A/B" and got ENOTDIR back, what you know is that "A" is not a
> directory (if the path tested this round were deeper like "X/Y/A/B", you
> know "X/Y/A" is not a directory, and you know "X" and "X/Y" are true
> directories; otherwise the loop would have exited before this round when
> you tested "X" or "X/Y" in the earlier rounds).
>
> So as far as I can think of, ENOENT case and ENOTDIR case would give you
> different information (ENOENT would say "A is a dir, A/B is not"; ENOTDIR
> would say "A is not a dir").  I am confused how you can cache the same
> path and same flag between these two cases here.

I take 1/4 of the above back.

If everything is working correctly, I do not think you will ever have a
situation where you check "A/B" here and get ENOTDIR back.  lstat("A/B")
would yield ENOTDIR if "A" is not a directory, but:

 (1) If you did test "A" in the earlier round in the loop, you would have
     already found it is not a directory and would have exited the loop
     with LSTAT_ERR.  You cannot test "A/B" in such a case;

 (2) If you did not test "A" in the loop, that has to be because you had a
     cached information for it, and the caching logic would have returned
     early if "A" was a non-directory without entering the loop; in other
     words, you would test "A/B" here without testing "A" in the loop only
     when the cache says "A" was a directory.  You cannot get ENOTDIR in
     such a case.

In any case, my main puzzlement still stands.  I think ENOTDIR case should
behave differently from ENOENT case.

And I think it is an indication of a grave error, either this code is
racing with an external process that is actively mucking with the work
tree to make your cached information unusable, or somebody forgot to call
clear_lstat_cache().

Hmm?
