From: Thell Fowler <git@tbfowler.name>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Tue, 8 Sep 2009 15:58:38 -0500 (CDT)
Message-ID: <alpine.WNT.2.00.0909081457190.3732@GWNotebook>
References: <87k549dyne.fsf@meyering.net> <7vvdnt869j.fsf@alter.siamese.dyndns.org> <87eiuhdnw9.fsf@meyering.net> <7v7i087twu.fsf@alter.siamese.dyndns.org> <87skf9uv3r.fsf@meyering.net> <7vljl1dpud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:59:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7mm-0004Mc-Dk
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbZIHU7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZIHU7Q
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:59:16 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:44513 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZIHU7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:59:15 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Ml7mV-0003BE-FP; Tue, 08 Sep 2009 15:59:15 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <7vljl1dpud.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128034>

On Sun, 30 Aug 2009, Junio C Hamano wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>> Junio C Hamano wrote:
>> ...
>>> Subject: [PATCH] diff --quiet: special case "ignore whitespace" options
>>> ...
>>> Change the semantics of --ignore-whitespace* options to mean more than
>>> "omit showing the difference in text".  When these options are used, the
>>> internal "quick" optimization is turned off, and the status reported with
>>> the --exit-code option will now match if any the textual diff output is
>>> actually produced.
>>>
>>> Also rename the internal option "QUIET" to "QUICK" to better reflect what
>>> its true purpose is.
>>
>> Thanks again.
>> If there's anything I can to do help (add a test?), let me know.
>
> The change has been cooking in 'next' and hopefully be in 1.7.0.  I think
> the updated series adds its own test script, too.
>
> Using it in every day scenario, and reporting any breakage you notice
> before 1.7.0 happens, would be greatly appreciated.
>
> Thanks.

Perhaps I'm expected something different than what I _should_ be 
expecting, but shouldn't --quiet always return the same as --exit-code?

# Cut/Paste example
mkdir test_ws_quiet && cd test_ws_quiet && git init
printf "foo bar  \n\n" >f1.txt
git add .
git commit -m 'f text'
printf "foo  bar\n\n" >f1.txt
git commit -a -m 'f with diff white-space in middle & end'
git diff -w --exit-code HEAD^ >/dev/null
echo $?
# returns '0' which it should
git diff -w --quiet HEAD^
echo $?
# returns '0' which it should
git diff -b --exit-code HEAD^ >/dev/null
echo $?
# returns '0' which it should
git diff -b --quiet HEAD^ >/dev/null
echo $?
# returns '0' which it should
git diff --ignore-space-at-eol --exit-code HEAD^ >/dev/null
echo $?
# returns '1' which it should
git diff --ignore-space-at-eol --quiet HEAD^
echo $?
#returns '0' <=== Unexpected.

#
# Next phase
#
printf "foobar\n\n">f1.txt
git commit -a -m 'f without any spaces'
git diff -w --exit-code HEAD^ >/dev/null
echo $?
# returns '0' which it should
git diff -w --quiet HEAD^
echo $?
# returns '0' which it should
git diff -b --exit-code HEAD^ >/dev/null
echo $?
# returns '1' which it should
git diff -b --quiet HEAD^ >/dev/null
echo $?
# returns '0' <=== Unexpected
git diff --ignore-space-at-eol --exit-code HEAD^ >/dev/null
echo $?
# returns '1' which it should
git diff --ignore-space-at-eol --quiet HEAD^
echo $?
#returns '0' <=== Unexpected.

-- 
Thell
