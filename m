From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Thu, 30 Jul 2009 00:54:11 -0700
Message-ID: <7vws5qhaho.fsf@alter.siamese.dyndns.org>
References: <7vtz0uk5z3.fsf@alter.siamese.dyndns.org>
 <C69698D6.61E1C%jbenjore@whitepages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Josh ben Jore <jbenjore@whitepages.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 09:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWQT0-00016q-Vh
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 09:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZG3HyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 03:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbZG3HyP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 03:54:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbZG3HyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 03:54:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 448E819348;
	Thu, 30 Jul 2009 03:54:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9D10819347; Thu,
 30 Jul 2009 03:54:12 -0400 (EDT)
In-Reply-To: <C69698D6.61E1C%jbenjore@whitepages.com> (Josh ben Jore's
 message of "Thu\, 30 Jul 2009 00\:24\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D5316F6-7CDE-11DE-9DE5-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh ben Jore <jbenjore@whitepages.com> writes:

> It is a very accurate shot in the dark. It appears to have fixed it when
> applied to 0a53e9ddeaddad63ad106860237bbf53411d11a7 GIT 1.6.4. I'll be
> trying this against v1.6.0.4 tomorrow.

Thanks.  After re-reading the patch, I am reasonably sure that it is the
right fix.

Earlier we fixed similar issues with bf74106 (merge-recursive: never leave
index unmerged while recursing, 2009-05-09) and 0c44c94 (merge-recursive:
do not die on a conflicting submodule, 2009-04-29).

The former is a fix to 36e3b5e (merge-recursive: mark rename/delete
conflict as unmerged, 2008-12-22) which is probably newer than 1.6.0.4
codebase, and unless you are using submodules, the latter is probalby also
safe to ignore if you are cherry-picking to the ancient 1.6.0.4 codebase.

>> The codepath saw that one branch renamed dev-ubuntu/ stuff to dev/ at that
>> "unmerged" path, while the other branch added something else to the same
>> path, and decided to add that at an alternative path, and the intent of
>> that is so that it can safely resolve the "renamed" side to its final
>> destination.  The added update_file() call is about finishing that
>> conflict resolution the code forgets to do.
>> 
>>  merge-recursive.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index d415c41..868b383 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -955,6 +955,7 @@ static int process_renames(struct merge_options *o,
>>                                 new_path = unique_path(o, ren1_dst, branch2);
>>                                 output(o, 1, "Adding as %s instead",
>> new_path);
>>                                 update_file(o, 0, dst_other.sha1,
>> dst_other.mode, new_path);
>> +                               update_file(o, 0, src_other.sha1,
>> src_other.mode, ren1_dst);
>>                         } else if ((item = string_list_lookup(ren1_dst,
>> renames2Dst))) {
>>                                 ren2 = item->util;
>>                                 clean_merge = 0;
>> 
>
> Thanks very much,
> Josh
