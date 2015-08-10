From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 17/17] memoize common git-path "constant" files
Date: Mon, 10 Aug 2015 14:05:14 +0200
Message-ID: <55C8937A.3080206@alum.mit.edu>
References: <20150810092731.GA9027@sigill.intra.peff.net> <20150810093857.GQ30981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 14:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOlph-0000u8-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 14:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbHJMFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 08:05:31 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62493 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbbHJMF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 08:05:27 -0400
X-AuditID: 12074412-f79a76d000007c8b-90-55c8937cedf9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.B6.31883.C7398C55; Mon, 10 Aug 2015 08:05:16 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7AC5EgV026460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 08:05:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150810093857.GQ30981@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1K2ZfCLU4PIWKYuuK91MFj9aepgd
	mDye9e5h9Pi8SS6AKYrbJimxpCw4Mz1P3y6BO+PcvTnMBd3sFd9bfzE2MD5g7WLk4JAQMJHY
	8jSii5ETyBSTuHBvPVsXIxeHkMBlRonNzVtYIJzzTBJvbj5nA6niFdCWaJ53jRGkmUVAVWL3
	4WqQMJuArsSinmYmkLCoQJDE65e5ENWCEidnPmEBsUUEjCRufPgGNkVYwFni6aW5zCC2kECG
	xKUpDSwgrZwC1hKXrxqBhJkF1CX+zLvEDGHLS2x/O4d5AiP/LCRTZyEpm4WkbAEj8ypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkFAU2sG4/qTcIUYBDkYlHt4Zm4+HCrEm
	lhVX5h5ilORgUhLlndFxIlSILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG9kNVCONyWxsiq1KB8m
	Jc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mCN2wSUKNgUWp6akVaZk4JQpqJgxNkOJeU
	SHFqXkpqUWJpSUY8KBbji4HRCJLiAdprCtLOW1yQmAsUhWg9xajLseDH7bVMQix5+XmpUuK8
	WiBFAiBFGaV5cCtgiecVozjQx8K85SBVPMCkBTfpFdASJqAldoFgS0oSEVJSDYwHV05bJLJC
	65+OckDtEcNFRXac7LHWFTo+/K+z9Krf3Z3r+njf+zr7dzsLDF/90Ntw+tj2D9bvJxZwuVel
	tn29J2rKIr+6239/tpjV2vm/8ms83614ZprS+ebVHsH1fXt718jdXPmea+oh5Q+b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275608>

On 08/10/2015 11:38 AM, Jeff King wrote:
> [...]
> This patch introduces a series of functions to "memoize"
> these strings, which are essentially globals for the
> lifetime of the program. We compute the value once, take
> ownership of the buffer, and return the cached value for
> subsequent calls.  cache.h provides a helper macro for
> defining these functions as one-liners, and defines a few
> common ones for global use.
> [...]

I was wondering whether this memoization could interact badly with
update_common_dir(). For example, if any of the memoized functions were
called before git_common_dir is initialized, then the pre-git_common_dir
value would continue to be used even if git_common_dir is changed
afterwards. But I believe it is taboo to call git_path() before
setup_git_env(), so I think this is not a problem.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
