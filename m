From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/12] repack_without_ref(): split list curation and entry
 writing
Date: Wed, 12 Jun 2013 13:56:24 +0200
Message-ID: <51B861E8.4090200@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu> <1370987312-6761-2-git-send-email-mhagger@alum.mit.edu> <20130612113823.GA20461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 13:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmjfF-0000td-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 13:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab3FLL43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 07:56:29 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57004 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448Ab3FLL42 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 07:56:28 -0400
X-AuditID: 1207440d-b7f006d000000adf-db-51b861ec6b2b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B3.C7.02783.CE168B15; Wed, 12 Jun 2013 07:56:28 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5CBuOMb017715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Jun 2013 07:56:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130612113823.GA20461@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqPsmcUegwc8DzBZdV7qZLBp6rzBb
	zLu7i8niR0sPswOLx6WX39k8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujDMzFjAV
	3OCouLrhKUsD41O2LkZODgkBE4lv7d9YIGwxiQv31gPFuTiEBC4zSlz4fJkVwrnGJHG64R0z
	SBWvgLbE+5Ub2UFsFgFVib+LD4NNYhPQlVjU08wEYosKhEm8XzaVFaJeUOLkzCdgG0QEZCW+
	H97ICGIzC6RLbN0+C6xeWCBC4smSZYwQy1YxSixvOgg2lFPAWmLu7V1AzRxADeoS6+cJQfTK
	S2x/O4d5AqPALCQrZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK
	6SZGSDjz7mD8v07mEKMAB6MSD+8Bs+2BQqyJZcWVuYcYJTmYlER5dyTsCBTiS8pPqcxILM6I
	LyrNSS0+xCjBwawkwpsYD5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBw
	KEnwXgEZKliUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9h4Eaect
	LkjMBYpCtJ5i1OWY8WPyO0Yhlrz8vFQpcV4tkCIBkKKM0jy4FbDk9YpRHOhjYV4hYCoT4gEm
	PrhJr4CWMAEtKcrYDrKkJBEhJdXA6BAatmBp18TgvUt+rA7/s8n04dQnrgozePTPXq/J7lLL
	c74zUWbOvsS3L72W1vN8sxXiX/Scwfmdlt2dp7cv8U6sdrvw11l9E0PFlQNx7Cmz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227601>

On 06/12/2013 01:38 PM, Jeff King wrote:
> On Tue, Jun 11, 2013 at 11:48:21PM +0200, Michael Haggerty wrote:
> 
>> Split repack_without_ref() into multiple passes:
>>
>> * collect the list of refnames that should be deleted from packed_refs
>>
>> * delete those refnames from the cache
>>
>> * write the remainder to the packed-refs file
>>
>> The purpose of this change is to make the "write the remainder" part
>> reusable.
> 
> It took me several reads to figure out what was going on here, because I
> did not see the deleted ref passed to the list of items to delete from
> packed_refs. The part I was missing is something like:
> 
>   The repack_without_ref() function first removes the deleted ref from
>   the internal packed-refs list, then writes the packed-refs list to
>   disk, omitting any broken or stale entries. This patch splits that
>   second step into multiple passes:
> 
>      ...
> 
> Is that accurate?

Yes.  You are right that I should make that clearer.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
