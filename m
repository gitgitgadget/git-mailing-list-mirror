From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 29/30] create_dir_entry(): allow the flag value to be
 passed as an argument
Date: Thu, 26 Apr 2012 23:12:22 +0200
Message-ID: <4F99BA36.5070803@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu> <1335307536-26914-30-git-send-email-mhagger@alum.mit.edu> <xmqqfwbrd5ny.fsf@junio.mtv.corp.google.com> <xmqq62cnd4pv.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVzc-0006fR-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 23:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab2DZVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 17:12:38 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43839 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142Ab2DZVMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 17:12:36 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3QLCMLO017101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Apr 2012 23:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <xmqq62cnd4pv.fsf@junio.mtv.corp.google.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196416>

On 04/25/2012 08:52 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> mhagger@alum.mit.edu writes:
>>
>>> diff --git a/refs.c b/refs.c
>>> index 4eca965..869c9a7 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -231,18 +231,18 @@ static void clear_ref_dir(struct ref_dir *dir)
>>>   }
>>>
>>>   /*
>>> + * Create a struct ref_entry object for the specified dirname and flag.
>>>    * dirname is the name of the directory with a trailing slash (e.g.,
>>>    * "refs/heads/") or "" for the top-level directory.
>>>    */
>>>   static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
>>> -					  const char *dirname)
>>> +					  const char *dirname, int flag)
>>>   {
>>>   	struct ref_entry *direntry;
>>>   	int len = strlen(dirname);
>>>   	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
>>>   	memcpy(direntry->name, dirname, len + 1);
>>> -	direntry->flag = REF_DIR;
>>> +	direntry->flag = flag;
>>>   	direntry->u.subdir.ref_cache = ref_cache;
>>
>> As the returned structure will always represent a subdirectory and not a
>> leaf node, i.e. you use u.subdir, I do not think it makes any sense to
>> make it responsibility for the caller of this function to include
>> REF_DIR in the value of the flag.
>
> Forseeing a response "But but but REF_DIR will become OR of two
> variants", my complaint is still valid ;-) and it is the bit assignment
> you did in the final patch that is wrong.  If you make REF_DIR (or not)
> to differenticate between ref_dir vs ref_value, and use another bit
> REF_INCOMPLETE to remember that you still need to find out the actual
> value of it, the the above can still be

In an earlier design, there were three types of REF_DIR: packed, 
loose(read), and loose(unread), which could all be packed (along with 
dir/non-dir) into two bits.  The current bit assignment was left over 
from that design, plus a latent expectation that it would sometime be 
necessary to distinguish between packed and loose(read) references.

But so far I haven't found a reason to distinguish between packed and 
loose(read), so your suggested bit assignment is simpler.  I will 
include it in the next version of the patch series.

> The suggested bit assignment would also allow you to create ref_value
> leaf nodes, whose presence you know about (by iterating over readdir()
> results) but not their values yet (because you haven't opened and read
> them), by marking them with REF_INCOMPLETE to be extra lazy in the
> future, if necessary.  I do not know if that much laziness buys us a
> lot, though ;-).

This would be pretty easy to implement.  Maybe I'll try it someday.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
