From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] archive: ignore blob objects when checking reachability
Date: Thu, 06 Jun 2013 09:57:32 +0200
Message-ID: <51B040EC.6080707@alum.mit.edu>
References: <20130605223551.GF8664@sigill.intra.peff.net> <20130605224038.GD15607@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ian Harvey <iharvey@good.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 09:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkV4n-0007os-T9
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 09:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab3FFH5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 03:57:39 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57900 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986Ab3FFH5h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 03:57:37 -0400
X-AuditID: 12074412-b7f216d0000008d4-ef-51b040ef475b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.51.02260.FE040B15; Thu,  6 Jun 2013 03:57:35 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r567vX4H015414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Jun 2013 03:57:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130605224038.GD15607@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqPveYUOgwdsGeYuuK91MFjs+72e1
	+NHSw+zA7PH57T42j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOeLuvh7GgU6Ri9c6N7A2M
	n/m6GDk5JARMJLrOzmaEsMUkLtxbz9bFyMUhJHCZUWLGgtVMIAkhgatMEsf+hYLYvALaErsn
	7GUGsVkEVCXa/3eD2WwCuhKLeprB6kUFwiTeL5vKClEvKHFy5hMWEFtEQFbi++GNYMuYBcwk
	zi6BWCwsECCx8echqF0ZEs/XbWAHsTkFrCU2NO4B6uUAqleXWD9PCKJVXmL72znMExgFZiHZ
	MAuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQgJXaAfj+pNy
	hxgFOBiVeHglAtYHCrEmlhVX5h5ilORgUhLlPWu/IVCILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CG+sCFCONyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mCVw0YoUKCRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCiNLwbGKUiKB2ivE0g7b3FBYi5QFKL1FKMx
	x+bzk98xcsz4ASSFWPLy81KlxHkFQUoFQEozSvPgFsFS1itGcaC/hXmlQKp4gOkObt4roFVM
	QKu+PF0HsqokESEl1cDIFnalY7/z79ddJmxif31iVvmbXWWK9Tq9xeI7wzPlU9Iej9sWr/u2
	5PvqSz8W/fw5w2+2XIKy9aeJ5/+6HTJfWeY+v9RvloP++8rqa6nGEr2Lns2zsAmb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226486>

On 06/06/2013 12:40 AM, Jeff King wrote:
> We cannot create an archive from a blob object, so we would
> not expect anyone to provide one to us. And if they do, we
> will fail anyway just after the reachability check.  We can
> therefore optimize our reachability check to ignore blobs
> completely, and not even create a "struct blob" for them.
> 
> Depending on the repository size and the exact place we find
> the reachable object in the traversal, this can save 20-25%,
> a we can avoid many lookups in the object hash.
> 
> The downside of this is that a blob provided to a remote
> archive process will fail with "no such object" rather than
> "object is not a tree" (we could organize the code to retain
> the old message, but since we no longer know whether the
> blob is reachable or not, we would potentially be leaking
> information about the existence of unreachable objects).

Could we change the error message to "no such tree object" to be
non-committal about the reason for the failure?


For a moment I thought that one could get correct error messages while
retaining the speed gain in the usual case by doing a quick object
lookup, and then

    check type of object
    if object is missing:
        die(there is no such object)
    else if object is a blob:
        do reachability test including blobs
        if object is not reachable:
            die(there is no such object)
        else
            die(object is not a tree)
    else
        do reachability test excluding blobs
        etc

However, even this would leak information about the existence of
nonreachable objects to a client measuring time time for the response
because the death due to non-reachability would take longer than death
due to missing object.  So, if one would insist on correct error
messages and no information leakage, one could just skip the first
"object is missing" optimization (it should be pretty rare anyway!) like so:

    check type of object
    if object is missing or object is a blob:
        /* Force the same delay in either case: */
        do reachability test including blobs
        if object is missing or object is not reachable:
            die(there is no such object)
        else
            die(object is not a tree)
    else
        do reachability test excluding blobs
        etc

I'm not suggesting that the extra effort is worth it; I just wanted to
mention the possibility.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
