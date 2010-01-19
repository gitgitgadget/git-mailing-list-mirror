From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] Performance optimization for detection of modified
 submodules
Date: Tue, 19 Jan 2010 09:35:30 +0100
Message-ID: <4B556ED2.7020904@web.de>
References: <4B54C3EA.9090200@web.de> <7v1vhmg975.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 09:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX9Yt-00038O-Bg
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 09:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab0ASIfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 03:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841Ab0ASIfj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 03:35:39 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:59780 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab0ASIfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 03:35:38 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5A52D1453A5DF;
	Tue, 19 Jan 2010 09:35:37 +0100 (CET)
Received: from [80.128.74.224] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NX9Yn-00023C-00; Tue, 19 Jan 2010 09:35:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v1vhmg975.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+y9oAnJIuc4cev6YK/hkIMA1uHvJv7UzC644w8
	SySjgW01/jX8Ilf3vaiqO/gIYYH3eIZIA0K7d2KDrLfGhhCHWV
	bORP9Uw9TGHUlouoR2Vg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137443>

Am 19.01.2010 02:44, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> - Changed the type of the new dirty_submodule flags to unsigned.
> 
> Why?  An unsigned used in place of a bool raises an eyebrow as it is more
> common to use "int" (the most natural type on the platform).  Going
> against tradition makes readers waste time wondering if there were some
> other reason why the code couldn't use "int" and had to use "unsigned"
> (e.g. "Hmmpphh, it looked like a mere boolean but the use of 'unsigned'
> suggests there might be something deeper going on.  Is this used as a
> bitfield?  Does this count and cannot go negative?").

I am working on a subsequent patch where dirty_submodule is used as a
bitfield to store more detailed information about the dirtiness. That is
then used by "git diff --submodule" to tell the user if the submodule
contains untracked and/or modified files.

But i can revert that part if you want.


>> +		if (S_ISGITLINK(ce->ce_mode)
>> +		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
>> +		    && is_submodule_modified(ce->name)) {
>> +			changed = 1;
>> +			dirty_submodule = 1;
>> +		}
> 
> If the index records a submodule commit, and the commit checked out in the
> submodule is different from that commit, ce_compare_gitlink() called from
> ce_match_stat() would have already said "changed".  If we want "-dirty",
> we need to call is_submodule_modified(), but otherwise we don't.  Looks
> good.
> 
> Does DIFF_FORMAT_PATCH cover all cases where we may want a reliable value
> in "dirty_submodule" here?  Should use of "--submodule=log" affect this
> decision?

In my testing "git diff --submodule=log" has DIFF_FORMAT_PATCH set too.


>> @@ -204,16 +209,18 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>>  static void diff_index_show_file(struct rev_info *revs,
>>  				 const char *prefix,
>>  				 struct cache_entry *ce,
>> -				 const unsigned char *sha1, unsigned int mode)
>> +				 const unsigned char *sha1, unsigned int mode,
>> +				 unsigned dirty_submodule)
>>  {
>>  	diff_addremove(&revs->diffopt, prefix[0], mode,
>> -		       sha1, ce->name);
>> +		       sha1, ce->name, dirty_submodule);
> 
> Mental note to myself.  prefix[0] is either '-' (removed from the work
> tree) or '+' (added to the work tree).  Added submodule could be
> immediately dirty.

Should i add a comment there?


>> diff --git a/diffcore.h b/diffcore.h
>> index 5b63458..66687c3 100644
>> --- a/diffcore.h
>> +++ b/diffcore.h
>> @@ -42,6 +42,7 @@ struct diff_filespec {
>>  #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
>>  	unsigned should_free : 1; /* data should be free()'ed */
>>  	unsigned should_munmap : 1; /* data should be munmap()'ed */
>> +	unsigned dirty_submodule : 1;  /* For submodules: its work tree is dirty */
> 
> By the way, we might want to consolidate these bitfields into a single 
> 
> 	unsigned should_free:1,
>         	 should_munmap:1,
>                  dirty_submodule:1;
> 
> in a separate clean-up patch, after all the dust settles.

Okay.
