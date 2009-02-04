From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Wed, 04 Feb 2009 20:53:46 +0100
Organization: private
Message-ID: <86tz7ayo51.fsf_-_@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
 <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
 <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:55:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUnqa-0001VK-Rw
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbZBDTxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbZBDTxt
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:53:49 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:32907 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758186AbZBDTxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:53:48 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEK008FI4LN1540@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 20:53:47 +0100 (CET)
Received: from localhost ([80.203.29.216]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEK004YD4LMRT40@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 20:53:47 +0100 (CET)
In-reply-to: <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108418>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
<snip>
>> I've a bad gut feeling about this: It may not work as expected on Windows
>> because there is this statement in the documentation:
>>
>>   "The only guarantee about a file timestamp is that the file time is
>>    correctly reflected when the handle that makes the change is closed."
>>
>> (http://msdn.microsoft.com/en-us/library/ms724290(VS.85).aspx)

  Ok, I admit I was not aware of this Windows fact.

>> We are operating on a temporary file. It could happen that the fstat()
>> returns the time when the file was created, as opposed to when the
>> write_in_full() was completed successfully. The fstat()ed time ends up in
>> the index, but it can be different from what later lstat() calls report
>> (and the file would be regarded as modified).
>>
>> I have the suspicion that the gain from this patch is minimal. Would you
>> mind playing it safe and drop this patch?
>
> Hmm, write_entry() is actually called once per one path we write out, and
> the fstat() is added to the common case (no --tempfile, no --prefix=<dir>
> checkout), 

  Yes, I had to make sure that the path string and ce->name was the
  exact same string, so therefore I had to add the test "&& !to_tempfile
  && !state->base_dir_len" to the if-test.

> which would mean that if there were any performance gain from
> this change, it was obtained by trading correctness away.  Sad.

  Sorry about this.  Yes, I agree that we should drop this patch.

  And, yes, since each lstat() call cost approximately 44 microseconds
  compared to 12-16 for each lstat() on my Linux box, there was a little
  performance gain from this patch.

  Junio, is it OK to ask that you drop this patch if/when you update the
  pu branch, such that I do not have to resend the patch series almost
  unchanged to the mailinglist (except for one missing patch)?

  Ok, maybe wait one day, just in case there will be more comments.

  And, thanks for the review!

  -- kjetil
