From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 6/7] refs: add update_refs for multiple simultaneous
 updates
Date: Thu, 29 Aug 2013 14:20:28 -0400
Message-ID: <521F90EC.6040208@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com> <xmqqhae85rbl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6rG-00069D-4R
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab3H2SWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:22:09 -0400
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:38097 "HELO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756094Ab3H2SWI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:22:08 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]) (using TLSv1) by na3sys009aob133.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+RT+NYBDJj5qo77VBxEoXeK7RTI7pn@postini.com; Thu, 29 Aug 2013 11:22:08 PDT
Received: by mail-oa0-f54.google.com with SMTP id n10so854901oag.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=z1QuE204iFVsxH7GgsPOO9lFmfsPMNCltnKDgTdGbdA=;
        b=HBy3NaNYIE2RIVGPzF4QFysfhvj2AOKXekoTr0OG4tl2joU6wW+8i0siygz2m/1x92
         HB7l/GoZ3ofDGkVGULtmmxLwMthk3qxZyBJzmJIcjQ0DARAleJx4XdgcgPrp/ay9FA4D
         mstMrdmdMcATxC4PD38Qqxr1eiXC2v2oSxh0zLFEl0pVyOczpZM0qX/gKJHh4auRDL4P
         lnaRO0/l5bo89z00i+/iePOS9jv/yzgX2wQZqqnFIrPOLFuZFpDNMuqKqqI0HubFTpOp
         GMWzqcknBSpahrOrXUbMV0SC7GD9IIX9ilqBHcPIQFlKqYHE/tuF9u63vF4IEHaQJYqv
         b1gQ==
X-Received: by 10.182.246.39 with SMTP id xt7mr3596522obc.16.1377800527153;
        Thu, 29 Aug 2013 11:22:07 -0700 (PDT)
X-Gm-Message-State: ALoCoQlFguiYDzrzgknoNTWoDiuWuOWUW9WZZexMG9SkiqpvD5YD158aZqJMW3jlt5TevqZlLdSu6mllnbVLo971sM5mPDIPSN3cOya21U3GqT3oz2Sb+ph9lULKI9jFs798FMo1BWixf3CsGIpizeqIT6OlqxI5TQ==
X-Received: by 10.182.246.39 with SMTP id xt7mr3596516obc.16.1377800527063;
        Thu, 29 Aug 2013 11:22:07 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id qi5sm32695122obb.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:22:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqhae85rbl.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233319>

On 08/29/2013 01:39 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> +	for (i=0; i < n; ++i) {
> 
> Style:
> 
> 	for (i = 0; i < n; i++) {

Fixed.

> Is it asking for AB-BA deadlock?  If so, is the caller responsible
> for avoiding it?

Since we don't actually block waiting for locks we won't really
deadlock.  However, if two competing callers keep repeating they
might never finish.  In order to avoid this one must sort the refs
so that locks are always acquired in a consistent order.

For Git's internal API I think we can document this in a comment so
that update_refs does not have to sort.  Then we can add a new
ref_update_sort function to sort an array of struct ref_update.
The user-facing "update-ref --stdin" can then use ref_update_sort.

The sort logic may subsume duplicate ref update detection too.
After sorting a simple linear-time scan can detect duplicates.

>> +	unsigned char new_sha1[20];
>> +	unsigned char *old_sha1;
> 
> This asymmetry is rather curious and will later become problematic
> when we have more users of this API.  Maybe your callers happen have
> static storage to keep old_sha1[] outside this structure but do not
> have it for new_sha1[] for some unknown reason, which may not apply
> to later callers we may want to add.

I wasn't happy with the asymmetry either but forgot to raise it in
the cover letter.  We need a way to represent "old value not given"
as different from "old value is_null_sha1".

One approach is to use a bit in the "flags" member that already
stores REF_NODEREF.  However, that will be inconsistent with the
other ref update APIs that check whether old_sha1 is NULL.  We could
still do it and document the bit to mean "ignore old_sha1 member of
struct ref_update".

Another approach is to add a dedicated member to struct ref_update.

Comments?
-Brad
