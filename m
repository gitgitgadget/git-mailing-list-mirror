From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 04/24] read-cache: clear version in discard_index()
Date: Wed, 21 Aug 2013 05:06:31 +0200
Message-ID: <87ob8r4ua0.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-5-git-send-email-t.gummerer@gmail.com> <xmqqmwoc5f6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 05:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VByl6-0000NL-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 05:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab3HUDGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 23:06:53 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55902 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3HUDGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 23:06:52 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so255515pad.32
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 20:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=VvKA0WFoaMBl9QWMX0uaCqaxg9A8oM5iX8KpiKLQjvg=;
        b=Ili1tugFgiMBifqMMLmB7ji9Wf+k9u1lQySgk7KaJQzZ5tdCqVJuK324emk6YgTm4b
         ekm0txeNTPjEv6IRhmzVyaePFeUkad3cRZi0ySqaTsp9eoau4tJCtbPbu6RMouOPIUdo
         l90f2xRRk/qNgkKmaBcdkSfbRMAtx7qk0ICF/sHiEnoK1zNG7NDp8IttjZBAoYqD68km
         Bn5QYPKChpT8jry723Ig4sZwj7Sdz4DfNsovAUmTNSFSMEnLBsRpBeWzjxxOjWBJ3WGM
         +qU+Oj8ZhJ76GKTiL+W8MmiNzm2XdlcdNRIiK1JjMVAUmr2F0eIloXD2W6gTKCscmXx+
         RVUg==
X-Received: by 10.68.115.15 with SMTP id jk15mr5435573pbb.36.1377054412114;
        Tue, 20 Aug 2013 20:06:52 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:7e6d:62ff:fe8c:90ce])
        by mx.google.com with ESMTPSA id py4sm5240527pbb.33.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 20:06:51 -0700 (PDT)
In-Reply-To: <xmqqmwoc5f6t.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232682>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> All fields except index_state->version are reset in discard_index.
>> Reset the version too.
>
> What is the practical consequence of not clearing this field?  I
> somehow have a feeling that this was done deliberately, so that we
> can stick to the version of the index file format better, once the
> user said "update-index --index-version $N" to set it up.  I suspect
> that the patch would affect a codepath that does read_cache(), calls
> discard_index(), populates the index and then does write_cache().
> We stick to the version the user specified earlier in our current
> code, while the patched code will revert to whatever default built
> into your Git binary, no?

Yeah you're right, I missed that use-case.  I'll drop this patch from
the re-roll.  Sorry for the noise.

>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  read-cache.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index de0bbcd..1e22f6f 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1558,6 +1558,7 @@ int discard_index(struct index_state *istate)
>>  	for (i = 0; i < istate->cache_nr; i++)
>>  		free(istate->cache[i]);
>>  	resolve_undo_clear_index(istate);
>> +	istate->version = 0;
>>  	istate->cache_nr = 0;
>>  	istate->cache_changed = 0;
>>  	istate->timestamp.sec = 0;
