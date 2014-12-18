From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Thu, 18 Dec 2014 11:18:32 -0800
Message-ID: <xmqqegrw7omv.fsf@gitster.dls.corp.google.com>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com>
	<885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenneth Lorber <keni@his.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:18:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1gau-0005L1-H0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 20:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbaLRTSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 14:18:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751155AbaLRTSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 14:18:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98ED5265E6;
	Thu, 18 Dec 2014 14:18:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hl0PMmQpHnudiC/5M/CorAPTrNs=; b=cw8qCP
	NyicfGR/1qq3VSCd8/ZGgOTwlMhj5NvhRxoFHXY/Fvz2hsRNclNzvyYXulYBf5rf
	82scIJGyJle70BEKKxFBwIMB3vBsSt0FNzAl/qd+y6gw+EKB+5CIDwTLBBOCm/g+
	x1onv0ck1fBDeUsygMqCJsMHMY9708+cadDo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWsx1JCzGJut8Q683Mdk0d3uTv0DBD0E
	GMc1A5fnhW6udPnDBQccKCDkUnxQk2xMByxryf0O1fJt7FWhEM8Bhngwhw8qeF+y
	1Pwl5x72LHQ8hLBKGgUOn89q5+dyQFtaIsOesnFwmDgPITr0RHXyK30GtEizcbRe
	rLCrAJ4Nl34=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F62A265E5;
	Thu, 18 Dec 2014 14:18:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12342265E4;
	Thu, 18 Dec 2014 14:18:36 -0500 (EST)
In-Reply-To: <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com> (Kenneth Lorber's
	message of "Wed, 17 Dec 2014 21:15:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA04B8F0-86EA-11E4-BCFA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261534>

Kenneth Lorber <keni@his.com> writes:

>> Bug: exit codes from (at least) internal commands are handled incorrectly.
>> E.g. git-merge-file, docs say:
>>        The exit value of this program is negative on error, and the number of
>>        conflicts otherwise. If the merge was clean, the exit value is 0.
>> But only 8 bits get carried through exit, so 256 conflicts gives
>> exit(0), which means the merge was clean.

Wouldn't any cmd_foo() that returns negative to main() be buggy?

Your change sweeps such problems under the rug, which is not a
healthy thing to do.

Expecting that the exit code can signal small positive integers and
other generic kinds of failures is a losing proposition.  I think it
is a better fix to update cmd_merge_file() to return 1 (when ret is
positive), 0 (when ret is zero) or 128 (when ret is negative), or
something simple like that, and update the documentation to match
that, without touching git.c::main().

Among the in-tree users, I notice git-cvsserver.perl is already
using the command incorrectly.  It does this:

            my $return = system("git", "merge-file", $file_local, $file_old, $file_new);
            $return >>= 8;

            cleanupTmpDir();

            if ( $return == 0 )
            {
                $log->info("Merged successfully");
                ...
            }
            elsif ( $return == 1 )
            {
                $log->info("Merged with conflicts");
                ...
            }
            else
            {
                $log->warn("Merge failed");
                next;
            }

which assumes $return == 1 is special "half-good", which is not
consistent with the documented interface.  It will incorrectly
say "Merge failed" when there are two or more conflicts.

And with such a "1 or 0 or -1" change, you will fix that caller as
well ;-)
