From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v2 2/3] make USE_NSEC work as expected
Date: Fri, 20 Feb 2009 11:07:16 +0100
Organization: private
Message-ID: <86mychifqj.fsf@broadpark.no>
References: <cover.1235071656.git.barvik@broadpark.no>
 <24cefa55a62e2c898f9bd75ff7a6fe8e70836cf0.1235071656.git.barvik@broadpark.no>
 <7vab8hfqug.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaSJM-00015o-Ds
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 11:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbZBTKHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754365AbZBTKHU
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 05:07:20 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:38042 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbZBTKHT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 05:07:19 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFD001SO045D670@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 11:07:17 +0100 (CET)
Received: from localhost ([84.48.79.78]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFD00L66044CY70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 11:07:17 +0100 (CET)
In-reply-to: <7vab8hfqug.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110831>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> diff --git a/read-cache.c b/read-cache.c
>> index 940ec76..ca4bec2 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -67,8 +67,15 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>>   */
>>  void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>>  {
>> -	ce->ce_ctime = st->st_ctime;
>> -	ce->ce_mtime = st->st_mtime;
>> +	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
>> +	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
>> +#ifdef USE_NSEC
>> +	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
>> +	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
>> +#else
>> +	ce->ce_ctime.nsec = 0;
>> +	ce->ce_mtime.nsec = 0;
>> +#endif
>
> How does this affect a use case where the same index file used with two 
> instances of git (one compiled with and another without USE_NSEC)?

  OK, I admit that I was thinking safe here, so the one using the git
  compiled with USE_NSEC will see a slow down.

  If we for the use case can assume that both is using an git program
  compiled from the same source, and the index file is placed on a
  filesystem which supports nanoseconds timestamp, I guess that the use
  case for the one using USE_NSEC could be better.

  I will make a new patch to this one (since it is already placed in
  next), and then you can see if you like the updated one.


>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index e547282..44714cc 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -380,8 +380,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>  
>>  	memset(&o->result, 0, sizeof(o->result));
>>  	o->result.initialized = 1;
>> -	if (o->src_index)
>> -		o->result.timestamp = o->src_index->timestamp;
>> +	if (o->src_index) {
>> +		o->result.timestamp.sec = o->src_index->timestamp.sec;
>> +#ifdef USE_NSEC
>> +		o->result.timestamp.nsec = o->src_index->timestamp.nsec;
>> +#endif
>> +	}
>
> Do we need this hunk?

  Since timestamp is now a 'struct cache_time' member, I converted the
  usage of this if-test to be in line with the USE_NSEC usage.

  -- kjetil
