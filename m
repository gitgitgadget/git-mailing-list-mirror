From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 05:59:29 +0200
Message-ID: <4FBB0F21.5080608@alum.mit.edu>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <20120521221417.GA22664@sigill.intra.peff.net> <20120521235219.GA5589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 05:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWgG4-0002sW-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 05:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab2EVD7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 23:59:35 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:49078 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753334Ab2EVD7e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 23:59:34 -0400
X-AuditID: 12074411-b7f596d000000932-68-4fbb0f25fc54
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.DB.02354.52F0BBF4; Mon, 21 May 2012 23:59:33 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0A29C.dip.t-dialin.net [79.192.162.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4M3xUvK020791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 23:59:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120521235219.GA5589@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqKvKv9vfYNdvCYuuK91MFg29V5gt
	7r9fx2Txo6WH2YHF43JfL5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdsX/aWsaC
	bXwVU2cdYWxgPMLdxcjJISFgIvHr02o2CFtM4sK99UA2F4eQwGVGibMLNjJBOGeZJDZtOMEC
	UsUroC3xc9ptRhCbRUBV4uWXQ6wgNpuArsSinmagBg4OUYEwidUPNCDKBSVOznwC1ioiICvx
	/fBGsFZmgXZGifN77UBsYQEniRU/prJC7NrOKLHj8U2wizgFrCTmXZoB1WAm0bW1C8qWl9j+
	dg7zBEaBWUh2zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsY
	IQEtuINxxkm5Q4wCHIxKPLyOlbv8hVgTy4orcw8xSnIwKYnyNnPu9hfiS8pPqcxILM6ILyrN
	SS0+xCjBwawkwrupDaicNyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTB
	28wHNFSwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKvxxcBoBUnxAO2NBmnnLS5I
	zAWKQrSeYtTlmPFp0TVGIZa8/LxUKXHefJAiAZCijNI8uBWw9PWKURzoY2HePJAqHmDqg5v0
	CmgJE9CSoBc7QZaUJCKkpBoYrVM+Bs+PTZW43qagLfDpgLXQ5W0Pc3bMEuk+ee6d1vNLBzcL
	Wvg6Tm5SV+3y5eZ8r/nvjpWzYb3hgQurmVadYpl3ovjfY3b+J/wRMca2If2F/BNO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198165>

On 05/22/2012 01:52 AM, Jeff King wrote:
> On Mon, May 21, 2012 at 06:14:17PM -0400, Jeff King wrote:
>
>> The rails and git cases run in ~28s and ~37s, respectively, again mostly
>> going to the actual object transfer. So I think this series removes all
>> of the asymptotically bad behavior from this code path.
>>
>> One thing to note about all of these repos is that they tend to have
>> several refs pointing to a single commit. None of the speedups in this
>> series depends on that fact, but it may be that on a repo with more
>> independent refs, we may uncover other code paths (e.g., I know that my
>> fix for mark_complete in ea5f220 improves the case with duplicate refs,
>> but would not help if you really have 400K refs pointing to unique
>> commits[1]).
>
> Hmm. So I started to do some experimentation with this and noticed
> something odd.
>
> Try doing "git fetch . refs/*:refs/*" in a repository with a large
> number of refs (e.g., 400K). With git v1.7.10, this takes about 9.5s on
> my machine. But using the version of git in "next" takes about 16.5s.
> Bisection points to your 432ad41 (refs: store references hierarchically,
> 2012-04-10). Perf shows sort_ref_dir and msort_with_tmp as hot spots.

I'm looking into this.

For your test, were the 400k references all in one "directory", or were 
they sharded somehow?

A large number of packed references in a single namespace is the 
worst-case scenario for the hierarchical refs change.  Since the refs in 
a namespace are all stored in a single array, there is no benefit from 
the hierarchical storage whereas there is some extra cost from 
traversing the namespace tree for each lookup.  But the performance hit 
shouldn't be this large.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
