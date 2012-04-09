From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory
 diffs
Date: Mon, 09 Apr 2012 11:02:24 -0700
Message-ID: <7v1unwyea7.fsf@alter.siamese.dyndns.org>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
 <CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHIvL-0000y6-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab2DISCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:02:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702Ab2DISCc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:02:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B40E26C16;
	Mon,  9 Apr 2012 14:02:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1GHQnpbWJ61lDq1u+kcsvv32+eA=; b=wLwNfm
	+Q8FCbViDygX9gqbSRgeqMxK3mPSzWYF+A1W/Ag+qojxpVsp3fmRO4xVd9AUgf+P
	G87SwyRjEYd3yS2YhgULMIRbfKeRYAQqkPBi55DYrg/JDBxla4+2OyJLSreMsWha
	GkfcwJCzvZneBcpxuD/rKPCj/hgB7I6KNtD2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FiY1G/GKbtWBJggUljm/P8T2TCMKMJZ2
	WvqvzgcdtsDHXGRDu99kDUrXkjPHTe4DJQTdzFgchMCGEpQI11jFVsc5H02hS/+j
	rJIWceQhZuPzNO5VTuqNbThIOHqf2r7SoZeg9DPbz+Wr92VhUvbK3fkpfulXfffl
	UpLNVTiiLuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB1996C15;
	Mon,  9 Apr 2012 14:02:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33D636C14; Mon,  9 Apr 2012
 14:02:26 -0400 (EDT)
In-Reply-To: <CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com> (David
 Aguilar's message of "Mon, 9 Apr 2012 05:14:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A1F4F7A-826E-11E1-8B89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195019>

David Aguilar <davvid@gmail.com> writes:

> On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.com> wrote:
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index d4fe998..5bb01e1 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -1,21 +1,29 @@
>>  #!/usr/bin/env perl
> ...
> I also think we should change the shebang line to #!/usr/bin/perl.

Good point; it would not make a difference in the end result, but
consistency is good.

>> -# ActiveState Perl for Win32 does not implement POSIX semantics of
>> -# exec* system call. It just spawns the given executable and finishes
>> -# the starting program, exiting with code 0.
>> -# system will at least catch the errors returned by git diff,
>> -# allowing the caller of git difftool better handling of failures.
>> -my $rc = system(@command);
>> -exit($rc | ($rc >> 8));
>> +       $ENV{GIT_PAGER} = '';
>> +       $ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
>> +       my $rc = system(('git', 'diff', @ARGV));
>> +       exit($rc | ($rc >> 8));
>> +}
>
> 
> We went back and forth a few times on this section,
> eventually landing back on using system().
>
> Should we retain this comment to help future readers from
> having to re-learn it the hard way again?

Well, I kept typing "good point" but ended up agreeing with everything you
said in your message, and removed all "Me too"s ;-).

Thanks for a thorough review.
