From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Fri, 14 Nov 2008 13:25:12 +0000
Message-ID: <491D7C38.7070906@hashpling.org>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org> <20081114064756.GB11907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0yhf-0000jn-0J
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbYKNNZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 08:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYKNNZ1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:25:27 -0500
Received: from pih-relay06.plus.net ([212.159.14.19]:57332 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbYKNNZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 08:25:23 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1L0yfi-0002Li-8i; Fri, 14 Nov 2008 13:25:14 +0000
Received: from [192.168.76.29] (heisenberg2.hashpling.org [192.168.76.29])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mAEDPCcH010269;
	Fri, 14 Nov 2008 13:25:12 GMT
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081114064756.GB11907@coredump.intra.peff.net>
X-Plusnet-Relay: 19baea9a192090ffdb0b552bfb05b92c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100973>

Jeff King wrote:

>>  Documentation/config.txt        |    4 +++
>>  Documentation/git-mergetool.txt |   12 +++++++++-
>>  git-mergetool.sh                |   46
++++++++++++++++++++++++++++++--------
>>  3 files changed, 51 insertions(+), 11 deletions(-)
>
> This patch in particular changes some of the innards of mergetool, and
> while the changes look good to me via reading, I would feel even more
> comfortable if there were some tests (it looks like your previous t7610
> gives at least a basic sanity check, but it might be nice to test to
> make sure we detect merge failures, too).

I had a little difficulty thinking of some decently robust tests. git
mergetool is, by its nature, more interactive than many git commands.

With --no-prompt it should be easier to make some tests that don't just
hang when it goes wrong. I'll have a further think on this.

>> [...]
>> -	exit 1
>> +	cleanup_temp_files
>> +	return 1
>
> One of these is not like the others. Is there a reason to add a
> cleanup_temp_files here (and if so, should it be noted in the commit
> message, and/or be in a separate commit?).

Ah yes, it's definitely worthy of at least a comment. This is something
that I changed right at the end of testing and I should really have made
it into a separate commit.

Previously, if you aborted a merge, you were left with the
base/local/remote temporaries for the merge that you aborted.

To be honest, I found this a little irritating. The base, local and
remote temporaries are inputs so are accessible from slots 1,2 and 3 of
the index, and any intermediate output will be in the target file. You
can git clean, but if you have other temporaries you need to keep, you
end up having to manually clean them up in any case.

With --keep-going, the problem is compounded. If you make several passes
through a list of complex merges you end up with fistfuls of these
temporary trios in your working tree. It goes from slightly annoying to
very irritating.

Charles.
