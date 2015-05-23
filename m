From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Sat, 23 May 2015 16:42:38 +0200
Message-ID: <vpq8ucffj8h.fsf@anie.imag.fr>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com>
	<vpqbnhd157k.fsf@anie.imag.fr> <555F252C.2060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 16:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwAdT-0002u4-OC
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 16:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982AbbEWOmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 10:42:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54855 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757865AbbEWOmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 10:42:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4NEgaQ9007561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 May 2015 16:42:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4NEgcmB011866;
	Sat, 23 May 2015 16:42:38 +0200
In-Reply-To: <555F252C.2060601@gmail.com> (karthik nayak's message of "Fri, 22
	May 2015 18:16:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 23 May 2015 16:42:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4NEgaQ9007561
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432996957.90181@CbCBCC9/KRP7KvLDPtgLrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269804>

karthik nayak <karthik.188@gmail.com> writes:

>> At some point, I'd expect something like
>>
>>    filtered_list_of_refs = filer(full_list_of_refs, description_of_filter);
>>
>> That would remove some refs from full_list_of_refs according to
>> description_of_filter.
>>
>> (totally invented code, only to show the idea)
>>
>> If there's a piece of code looking like this, then you need a data
>> structure to store list of refs (full_list_of_refs and
>> filtered_list_of_refs) and another to describe what you're doing with it
>> (description_of_filter).
>>
>> The name ref_filter implies to me that it contains the description of
>> the filter, but looking at the code it doesn't seem to be the case.
>>
>
> But it does just that, doesn't it?
>
> struct ref_filter {
> 	int count, alloc;
> 	struct ref_filter_item **items;
> 	const char **name_patterns;
> };
>
> If you see it does contain 'name_patterns' according to which it will
> filter the given refs,

But it also contains struct ref_filter_item **items, which as I
understand it contains a list of refs (with name, sha1 & such).

That's the part I do not find natural: the same structure contains both
the list of refs and the way it should be filtered.

Re-reading the patch, I seem to understand that you're putting both on
the same struct because of the API of for_each_ref() which takes one
'data' pointer to be casted, so you want both the input (filter
description) and the output (list of refs after filtering) to be
contained in the same struct.

But I think this could be clearer in the code (and/or comment + commit
message). Perhaps stg like:

struct ref_filter_data /* Probably not the best name */ {
        struct ref_list list;
        struct ref_filter filter;
};

struct ref_list {
 	int count, alloc;
 	struct ref_filter_item **items;
 	const char **name_patterns;
};

struct ref_filter {
	const char **name_patterns;
	/* There will be more here later */
};

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
