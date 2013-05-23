From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/17] get_revision_internal(): make check less mysterious
Date: Thu, 23 May 2013 08:39:01 +0200
Message-ID: <519DB985.5040103@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-11-git-send-email-mhagger@alum.mit.edu> <7vsj1gnsgn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 08:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfPBA-0004ZC-6d
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 08:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab3EWGjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 02:39:07 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:60539 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386Ab3EWGjG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 02:39:06 -0400
X-AuditID: 1207440f-b7f0e6d000000957-fe-519db9897e22
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 11.91.02391.989BD915; Thu, 23 May 2013 02:39:05 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4N6d2d5005883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 May 2013 02:39:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vsj1gnsgn.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqNu5c26gweZeFouuK91MFg29V5gt
	5t3dxWTxo6WH2YHF49LL72wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xoU9x9gK
	mvkrLsw6ytLA+IG7i5GTQ0LARGLx5UlMELaYxIV769m6GLk4hAQuM0qcar3ACOFcY5KY17iF
	EaSKV0BbYvOaH2AdLAKqEqtuPGcGsdkEdCUW9TSDxUUFwiTeL5vKClEvKHFy5hMWEFtEQE1i
	YtshMJtZIE5iZ+cqsHphAT+JP6+WQG1ewShxeOZOsASngJnEq663zBANOhLv+h5A2fIS29/O
	YZ7AKDALyY5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMk
	pPl3MHatlznEKMDBqMTDe+DGnEAh1sSy4srcQ4ySHExKorw+W+cGCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLh3dwDlONNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfCq
	7wBqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFa3wxMF5BUjxAe/VB2nmLCxJz
	gaIQracYdTlm/Jj8jlGIJS8/L1VKnNcVpEgApCijNA9uBSyBvWIUB/pYmNcSpIoHmPzgJr0C
	WsIEtGTpqTkgS0oSEVJSDYx+FlNYt7fsNzi6q1ar0GTH7aiah9JLr78PKnxmk/fJ+6rmhhqP
	D++PrD7osnLBlrufpFyZ2Q90nC12dn6cwj4no6xnXdn+9ScsFgRLZUQ5mDuz5zQs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225218>

On 05/21/2013 07:38 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The condition under which gc_boundary() is called was previously
>>
>>     if (alloc <= nr)
>>
>> .  But by construction, nr can never exceed alloc, so the check looks
>> unnecessarily mysterious.  In fact, the purpose of the check is to try
>> to avoid a realloc() call by shrinking the array if possible if it is
>> at its allocation limit when a new element is about to be added.  So
>> change the check to
>>
>>     if (nr == alloc)
>>
>> and add a comment to explain what's going on.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> Please check that I have properly described the purpose of this check.
>>
>> The way the code is written, it looks like a bad pattern of growth and
>> shrinkage of the array (namely, just under the resize limit) could
>> cause gc_boundary() to be called over and over again with (most of)
>> the same data.  I hope that the author had some reason to believe that
>> such a pattern is unlikely.
> 
> That is about comparing with "alloc", not having high and low
> watermarks, right?
> 
> I do not see "alloc <= nr" is mysterious at all; it is merely being
> defensive.

If nr would ever exceed alloc, then the code would be broken and would
probably have already performed an illegal memory access.  Pretending to
support nr > alloc here is not defensive but misleading, because by that
time the ship is going down anyway.

On a more practical level, when I saw this code I thought to myself
"that's strange, I'd better look into it because it suggests that I
don't understand the meaning of nr and alloc".  I think that the
suggested change will help prevent the next reader from repeating the
same pointless investigation.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
