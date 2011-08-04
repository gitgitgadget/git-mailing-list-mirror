From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 09/19] Allow querying all attributes on a file
Date: Thu, 04 Aug 2011 05:16:29 +0200
Message-ID: <4E3A0F0D.7050403@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu> <1311828418-2676-10-git-send-email-mhagger@alum.mit.edu> <7vwrevg73x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 05:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QooQK-00035G-PQ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab1HDDQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 23:16:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39413 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1HDDQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:16:34 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEB339.dip.t-dialin.net [84.190.179.57])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p743GTDk026288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Aug 2011 05:16:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vwrevg73x.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178660>

On 08/02/2011 05:34 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Add a function, git_allattrs(), that reports on all attributes that
>> are set on a path.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  Documentation/technical/api-gitattributes.txt |   45 +++++++++++++++++-------
>>  attr.c                                        |   43 +++++++++++++++++++++++
>>  attr.h                                        |    9 +++++
>>  3 files changed, 84 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
>> index ab3a84d..640240e 100644
>> --- a/Documentation/technical/api-gitattributes.txt
>> +++ b/Documentation/technical/api-gitattributes.txt
>> @@ -22,19 +22,6 @@ Data Structure
>> ...
>>  (JC)
> 
> The last line, I think, can now be dropped. This was a marker saying "we
> lack documentation for this API; bug this person for necessary information
> and write one".

OK; I will drop the line in the re-roll.

>> diff --git a/attr.c b/attr.c
>> index bfa1f43..9c2fca8 100644
>> --- a/attr.c
>> +++ b/attr.c
>> @@ -737,6 +737,49 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
>>  	return 0;
>>  }
>>  
>> +int git_allattrs(const char *path, int *num, struct git_attr_check **check)
>> +{
>> +	struct attr_stack *stk;
>> +	const char *cp;
>> +	int dirlen, pathlen, i, rem, count, j;
>> +
>> +	bootstrap_attr_stack();
>> +	for (i = 0; i < attr_nr; i++)
>> +		check_all_attr[i].value = ATTR__UNKNOWN;
>> +
>> +	pathlen = strlen(path);
>> +	cp = strrchr(path, '/');
>> +	if (!cp)
>> +		dirlen = 0;
>> +	else
>> +		dirlen = cp - path;
>> +	prepare_attr_stack(path, dirlen);
>> +	rem = attr_nr;
>> +	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
>> +		rem = fill(path, pathlen, stk, rem);
> 
> Shouldn't the above part at least should be refactored instead of copied
> and pasted from git_checkattr()?

Quite right.  Will be fixed in re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
