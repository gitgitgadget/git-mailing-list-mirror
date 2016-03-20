From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 04/33] files-backend: break out ref reading
Date: Sun, 20 Mar 2016 06:03:09 +0100
Message-ID: <56EE2F0D.5030709@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 20 06:17:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahVjy-0007Tb-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 06:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbcCTFKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 01:10:35 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49676 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809AbcCTFKd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 01:10:33 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Mar 2016 01:10:33 EDT
X-AuditID: 12074411-fd3ff700000071cf-50-56ee2f112717
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C4.56.29135.11F2EE65; Sun, 20 Mar 2016 01:03:13 -0400 (EDT)
Received: from [192.168.69.130] (p508EA724.dip0.t-ipconnect.de [80.142.167.36])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2K53AI9005284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 20 Mar 2016 01:03:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1456793586-22082-5-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqCuk/y7M4HYTh8X8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zA6vHzll32T2e9e5h9Lh4SdljwfP77B6fN8kFsEZx2yQllpQFZ6bn
	6dslcGesWHKCteAme0Xj/RtMDYwtbF2MnBwSAiYS7+5vZ+9i5OIQEtjKKDHlx2so5zyTxI+n
	N1hBqoQFnCRm/53IDmKLCGRLzPl0jhWiqJ1RonPNP2aQBLOAmkT7pilgDWwCuhKLepqZQGxe
	AW2Jv78PMHYxcnCwCKhK3L+sDxIWFQiReP/1OStEiaDEyZlPWEBsTgFPiSdrPrJDjNST2HH9
	FyuELS+x/e0c5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZ
	JXqpKaWbGCHBLLiDccZJuUOMAhyMSjy8CR/fhgmxJpYVV+YeYpTkYFIS5X3HABTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwivL8S5MiDclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwfteF6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhST8cXAqARJ8QDt
	5dQD2VtckJgLFIVoPcVozLHgx+21TBxH9t9byyTEkpeflyolztsGskkApDSjNA9uESyNvWIU
	B/pbmFceZCAPMAXCzXsFtIoJaNWxuFcgq0oSEVJSDYyVn5JDpq9QW3FCLWDfZ7Zi/TlJSf5X
	/8xT/mzjHZIr/p+fcWeY1BP9ZVIiezdc3N8S8cjE8U+DeFnezbrdnxfIR0+S2uRS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289334>

On 03/01/2016 01:52 AM, David Turner wrote:
> Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
> is responsible for reading ref data from the ref storage.
> 
> Later, we will make read_raw_ref a pluggable backend function, and make
> resolve_ref_unsafe common.
> 
> Testing done: Hacked in code to run both old and new version of
> resolve_ref_1 and compare all outputs, failing dramatically if outputs
> differed.  Ran test suite.

I like that you are splitting up resolve_ref_1(), which was too
complicated and convoluted before.

This is a textually large change and I'm still auditing it, but
meanwhile I have a question...

> [...]
> -		if (--depth < 0) {
> -			errno = ELOOP;
> -			return NULL;
> -		}

The old version set errno to ELOOP if there were too many layers of
symrefs. The new version doesn't seem to set errno at all in that case.
I think that is a regression, though I might be misunderstanding something.

Michael
