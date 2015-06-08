From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v5 02/10] for-each-ref: clean up code
Date: Mon, 08 Jun 2015 20:51:47 +0530
Message-ID: <5575B30B.6000407@gmail.com>
References: <55729B78.1070207@gmail.com>	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>	<1433574581-23980-2-git-send-email-karthik.188@gmail.com> <vpqd2168dwa.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:22:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ysD-0000ow-03
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbbFHPV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:21:56 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34378 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbFHPVw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:21:52 -0400
Received: by pdbki1 with SMTP id ki1so106994767pdb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cbEkFqkOG7SDQyz23+ZC0oH7YwWJNFwXPCwVOE8KDNs=;
        b=zAo5hfF1psyizlh1gqy5VBxC2Xmso4WFmeAcYCXqFb4ErjyXO7bfMOCYXvbeXncXty
         U2Vvl7Y72I2pC8bf8nM6HClJykE209sEP0qzCUCarBeZxqD+ry4NWLg2l9TndQIfOcH3
         YZN6gwXpMAGWNpXgj4C81wQTD/HbrHCadgeXP9Zc9uu/vuh3cyRb+VhjO6DjEZyDfMjM
         EH+nRzZ1xmCIu8LurpGyVRxmKGmcGkKzW0yrPCs9xEjdu9eK7bYiQ6fByWo/6/1dPI53
         Y15T92fC2WqiXj7Xw7ONJBzJ0mHIsaM5MeUsw+9Js3CkwS0IM4VD5i/HTY9oknlTq9Rf
         7IxQ==
X-Received: by 10.70.38.33 with SMTP id d1mr29895826pdk.99.1433776912015;
        Mon, 08 Jun 2015 08:21:52 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ps7sm2934052pbb.18.2015.06.08.08.21.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 08:21:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqd2168dwa.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271050>

On 06/08/2015 08:07 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In 'grab_single_ref()' remove the extra count variable 'cnt' and
>> use the variable 'grab_cnt' of structure 'grab_ref_cbdata' directly
>> instead.
>>
>> Change comment in 'struct ref_sort' to reflect changes in code.
>
> I don't see how the comment change is related to the code change:
>
>>   struct ref_sort {
>>   	struct ref_sort *next;
>> -	int atom; /* index into used_atom array */
>> +	int atom; /* index into 'struct atom_value *' array */
>>   	unsigned reverse : 1;
>>   };
>>
>> @@ -881,7 +881,6 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>>   {
>>   	struct grab_ref_cbdata *cb = cb_data;
>>   	struct refinfo *ref;
>> -	int cnt;
>>
>>   	if (flag & REF_BAD_NAME) {
>>   		  warning("ignoring ref with broken name %s", refname);
>> @@ -898,10 +897,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>>   	 */
>>   	ref = new_refinfo(refname, sha1, flag);
>>
>> -	cnt = cb->grab_cnt;
>> -	REALLOC_ARRAY(cb->grab_array, cnt + 1);
>> -	cb->grab_array[cnt++] = ref;
>> -	cb->grab_cnt = cnt;
>> +	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
>> +	cb->grab_array[cb->grab_cnt++] = ref;
>>   	return 0;
>>   }
>
> Did you squash the comment change into the wrong commit?
>

What I meant was, change the comment to reflect changes in code since 
the comment was made, not relevant to the simplification of code.

I put these two together as they are trivial changes.
Either I could reword the commit message or split the commit.

-- 
Regards,
Karthik
