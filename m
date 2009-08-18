From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Tue, 18 Aug 2009 12:25:09 -0700
Message-ID: <7vk510diwa.fsf@alter.siamese.dyndns.org>
References: <4A89E185.2010307@fastmail.fm>
 <7vzl9ykovh.fsf@alter.siamese.dyndns.org> <4A89EC07.2010402@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karthik R <karthikr@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdUJM-0008EJ-S5
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 21:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZHRTZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 15:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZHRTZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 15:25:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZHRTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 15:25:26 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88A0EF974;
	Tue, 18 Aug 2009 15:25:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB1F8F971; Tue, 18 Aug
 2009 15:25:20 -0400 (EDT)
In-Reply-To: <4A89EC07.2010402@fastmail.fm> (Karthik R.'s message of "Mon\,
 17 Aug 2009 18\:47\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1FA8F46-8C2C-11DE-A4BD-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126440>

Karthik R <karthikr@fastmail.fm> writes:

>> Two questions.
>>
>>  - What if a user has SVN_SSH exported _and_ wants to use a different one
>>    from the one s/he uses for git?  Naturally such a user would set both
>>    environment variables and differently, but this seems to override the
>>    value in SVN_SSH;
>>   

> Do you mean user wants to use a different one with "git svn
> ... svn+ssh://" (than the one with "git clone ssh://") ?

Yes.

> In this case
> - defining SVN_SSH, but not GIT_SSH will still work (with this patch,
> GIT_SSH overrides)

Which means if you need to use GIT_SSH to specify one and SVN_SSH to
specify another, you have trouble.  IOW, you cannot use anything but
whatever the default is for native git access over ssh:// protocol.

> - but SVN_SSH needs to have \\s.
>
> So unless the user already knew of this quirk, we'll only see
> unescaped \s - so it *does* make sense to escape the \s (if the user
> knew, then too many escaped \s still work).
>
>>  - Can a user have SVN_SSH exported, on MSWin32 or msys, and use svn
>>    outside git?  If so, what does the value of SVN_SSH look like?  Does it
>>    typically have necessary doubling of backslashes already?
>>   
> With subversion for Windows, these \\s are not needed (but doesn't
> cause any break). The doubling is something to do with the bash (in
> msys) I think.
>

Ok, so does that mean the logic should look more like the one you quoted
below without saying yes/no/anything?  The points are:

 (1) do not muck with SVN_SSH if already given by the user.

 (2) when and only when we reuse value from GIT_SSH for SVN_SSH, double
     the backslashes.

>> What I am getting at is, if the patch should look something like this
>> instead:
>>
>> 	if (! exists $ENV{SVN_SSH}) {
>> 		if (exists $ENV{GIT_SSH}) {
>> 			$ENV{SVN_SSH} = $ENV{GIT_SSH};
>> 			if ($^O eq 'MSWin32' || $^O eq 'msys') {
>>                                $ENV{SVN_SSH} =~ s/\\/\\\\/g;
>> 			}
>> 		}
>> 	}
>>
>>   
