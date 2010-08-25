From: Justin Frankel <justin@cockos.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Wed, 25 Aug 2010 11:21:02 -0700
Organization: Cockos Incorporated
Message-ID: <4C755F0E.5080705@cockos.com>
References: <20100823205915.GA4484@ns1.cockos.com> <20100824022820.GE17406@burratino> <5F681E95-9369-490A-84FE-55B99EA8FE63@cockos.com> <20100825044006.GJ11619@burratino> <AANLkTimRyeMbLKLmbKJEqgGPDFo3OCsz=QwVzkSaP5n8@mail.gmail.com> <4C753BFD.5060807@cockos.com> <7vy6bushjx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKbM-0004Ez-AO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab0HYSV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:21:28 -0400
Received: from ns1.cockos.com ([204.11.104.229]:65355 "EHLO ns1.blorp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab0HYSV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:21:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by ns1.blorp.com (Postfix) with ESMTP id 3C4151259C02;
	Wed, 25 Aug 2010 11:21:26 -0700 (PDT)
Received: from ns1.blorp.com ([127.0.0.1])
	by localhost (ns1.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCLmAwRlolVV; Wed, 25 Aug 2010 11:21:03 -0700 (PDT)
Received: from [10.10.10.69] (poo.cockos.com [204.11.104.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ns1.blorp.com (Postfix) with ESMTPSA id D63B61259C01;
	Wed, 25 Aug 2010 11:21:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7vy6bushjx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154456>

Junio C Hamano wrote:
> Justin Frankel <justin@cockos.com> writes:
>
>   
>> The only danger is that ll_merge()'s signature didn't change in such a
>> way to break compilation, i.e:
>>
>> int ll_merge(mmbuffer_t *result_buf,
>>             const char *path,
>>             mmfile_t *ancestor, const char *ancestor_label,
>>             mmfile_t *ours, const char *our_label,
>>             mmfile_t *theirs, const char *their_label,
>>             int flag);
>>
>> becomes:
>>
>> int ll_merge(mmbuffer_t *result_buf,
>>             const char *path,
>>             mmfile_t *ancestor, const char *ancestor_label,
>>             mmfile_t *ours, const char *our_label,
>>             mmfile_t *theirs, const char *their_label,
>>             struct whatever *conf);
>>
>> In this case, passing 0 as the last parameter will compile either way.
>>
>> Sure, we can grep all of the source, but who knows when something else
>> will get merged in...
>>     
>
> That is technically a valid concern but I suspect it does not matter in
> this particular case, where integer 0 used to mean "use the default" and
> the new API uses NULL to mean the same.
>
> If an existing call site used to pass 0 and the patch forgot to update it,
> it will look ugly (we encourage to spell a NULL pointer "NULL", not "0",
> in our codebase) but no harm is done.  If an existing call site asked for
> a non-default behaviour by passing a non-zero integer flag, and the patch
> forgot to update it, the compiler would have caught it.  Merging a side
> branch is the same deal; if it adds a call with a non-zero argument to ask
> for a non-default behaviour, that will be done via an expression over some
> integer variables or constants, and that won't be casted silently to a
> pointer to "struct whatever", no?
>
>   
Agreed, I was responding to Bert's email, in which he stated that he 
hadn't seen NULL-for-default anywhere else in git. Using NULL for 
default behavior is good in that it handles un-updated code and merges 
correctly (passing 0 uses defaults, passing nonzero fails compile).


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
