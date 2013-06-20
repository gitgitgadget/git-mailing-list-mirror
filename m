From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the
 packed-refs file
Date: Thu, 20 Jun 2013 20:03:43 +0200
Message-ID: <51C343FF.6030002@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu> <1371628293-28824-5-git-send-email-mhagger@alum.mit.edu> <7vfvwdzz6k.fsf@alter.siamese.dyndns.org> <51C2B41F.2050708@alum.mit.edu> <20130620115508.GB773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 20:03:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpjD7-0003mA-5o
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 20:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758019Ab3FTSDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 14:03:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43515 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757977Ab3FTSDr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 14:03:47 -0400
X-AuditID: 12074413-b7f136d000006de1-9f-51c344024478
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A3.36.28129.20443C15; Thu, 20 Jun 2013 14:03:46 -0400 (EDT)
Received: from [192.168.69.140] (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5KI3hP2026093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 14:03:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130620115508.GB773@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqMvkcjjQYOc/dYuuK91MFg29V5gt
	5t3dxWTxo6WH2WL3tAVsDqwel15+Z/N41ruH0ePiJWWPxxNPsHp83iQXwBrFbZOUWFIWnJme
	p2+XwJ0xbX83Y8EfjopNy2+yNjBOYu9i5OSQEDCRuPR5ERuELSZx4d56IJuLQ0jgMqPElE+X
	mCGcs0wS3988BqviFdCW6Jv+hBnEZhFQlfh27zwLiM0moCuxqKeZCcQWFQiTeL9sKitEvaDE
	yZlPwGpEBGQlvh/eyAgylFlgEqPE7G23wQYJC8RINPy9wQSx7QujxJEVS8Hu4xSwlJg+cTaQ
	zQHUoS6xfp4QSJhZQF5i+9s5zBMYBWYh2TELoWoWkqoFjMyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3TN9XIzS/RSU0o3MUKCXHgH466TcocYBTgYlXh4A5QOBwqxJpYVV+YeYpTkYFIS5WVx
	BgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4ZVWAMrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeW
	pGanphakFsFkZTg4lCR4uUGGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiNb4Y
	GK0gKR6gvXedQPYWFyTmAkUhWk8x6nIc+LHlPaMQS15+XqqUOO8TkCIBkKKM0jy4FbCU9opR
	HOhjYd7/IFU8wHQIN+kV0BImoCV7Vh8CWVKSiJCSamA0a1GtvrxQOYhLqP8Jg9u+ZX/u7n4v
	V3ipfZf+W1eG9r/TRJ/tnZ2mbCkjN/s0272D158E1alrHd1lpLtXpsg54kzNn1Nf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228518>

On 06/20/2013 01:55 PM, Jeff King wrote:
> On Thu, Jun 20, 2013 at 09:49:51AM +0200, Michael Haggerty wrote:
> 
>> [I just noticed that lock_ref_sha1_basic() leaks a struct lock_file
>> every time that it is called.]
> 
> I noticed that recently, too. I have a patch series about 90% complete
> that abstracts the tempfile handling (the ultimate goal of which is to
> optionally clean up tmp_* files in the objects/ directory). It refactors
> the lockfile cleanup, and it would not be too hard to have a committed
> or rolled-back lockfile actually remove itself from the "to clean at
> exit" list.
> 
> Which would make it perfectly safe to have a lockfile as an automatic
> variable as long as you commit or rollback before leaving the function.

Cool, then I won't work on that.  You might also have to make the
lockfile list into a doubly-linked-list to avoid having to do a linear
scan to find the entry to delete, unless the total number of entries is
known to remain small.

Please CC me on the patch series when it is done.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
