From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying remote 
	branches
Date: Fri, 13 Feb 2009 01:45:33 -0500
Message-ID: <76718490902122245q6f530bb5sc85a65e065966eda@mail.gmail.com>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
	 <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
	 <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 07:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXrpH-00028C-5Y
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbZBMGpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 01:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbZBMGpf
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:45:35 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:40227 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbZBMGpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 01:45:34 -0500
Received: by rv-out-0506.google.com with SMTP id g9so91227rvb.5
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/R/IpqmemmQ+K2U0VkX4xHeK5h6OHH/gFjgGlQuxWng=;
        b=DMaKOjGm06JXnrHKqI/3D5nK4FOdmUqxSnO8TVu1DCQxXux4SUvSippO+pBCUH/B8r
         7IdYweRtQkyOkClvSEsaqT2v1ug9DA4CLjZhodj+ns3puf/9R88vQNPLTcBKhatKPTI8
         nu/ErtpiIhUsfsj5Zgm2AdAfGHaz3VRAwwdzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RIjgtsce8PHVxNaaX5LwV24J8hy4UNL5jnhue3RoscM1w5MANZIEBKGCgcpy+uhOci
         up4UZLKnrInx8TpAMYJKeCZ73ppx0eFPdlAUblppg7n4QKiMwy5mBLlfOberLCn2TceK
         wBImjfy42umgHD/F5DwkkB2hQ0foGCk6J9M/s=
Received: by 10.140.139.3 with SMTP id m3mr987342rvd.77.1234507533750; Thu, 12 
	Feb 2009 22:45:33 -0800 (PST)
In-Reply-To: <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109713>

On Fri, Feb 13, 2009 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> +     if (prefix && !prefixcmp(dst, prefix))
>> +             return xstrdup(skip_prefix(dst, prefix));
>> +     else
>> +             return xstrdup(dst);
>> +}
>
> I wonder modern compilers are clever enough to optimze the above to
> something more like:
>
>        pfxlen = prefix ? strlen(prefix) : 0;
>        if (pfxlen && !strncmp(dst, prefix, pfxlen))
>                return xstrdup(dst + pfxlen);
>        else
>                return xstrdup(dst);
>
> given that skip_prefix is an inline function but prefixcmp is not
> (anymore), perhaps not.
>
>>  static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
>>  {
>>       struct ref_list *ref_list = (struct ref_list*)(cb_data);
>>       struct ref_item *newitem;
>>       struct commit *commit;
>>       int kind;
>> -     int len;
>> +     const char *prefix, *orig_refname = refname;
>>
>>       /* Detect kind */
>>       if (!prefixcmp(refname, "refs/heads/")) {
>>               kind = REF_LOCAL_BRANCH;
>>               refname += 11;
>> +             prefix = "refs/heads/";
>>       } else if (!prefixcmp(refname, "refs/remotes/")) {
>>               kind = REF_REMOTE_BRANCH;
>>               refname += 13;
>> +             prefix = "refs/remotes/";
>>       } else
>>               return 0;
>
> Once you start making each case arm do more things, it might make sense to
> rewrite the above unrolled loop into something like this:
>
>        static struct {
>                int kind;
>                const char *prefix;
>                int pfxlen;
>        } ref_kind[] = {
>                { REF_LOCAL_BRANCH, "refs/heads/", 11 },
>                { REF_REMOTE_BRANCH, "refs/remotes/", 13 },
>        };
>
>        for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
>                prefix = ref_kind[i].prefix;
>                if (strncmp(refname, prefix, ref_kind[i].pfxlen))
>                        continue;
>                kind = ref_kind[i].kind;
>                refname += ref_kind[i].pfxlen;
>                break;
>        }
>        if (ARRAY_SIZE(ref_kind) <= i)
>                return 0;
>
> Then we can later add new elements more easily, e.g.
>
>                { REF_TOPGIT_BASE, "refs/top-base/", 14 },
> ;-)

This strikes me as premature optimization. We're just emitting a few
branch names here. I'm beginning to lose my motivation to keep working
on this patch. I just wanted to improve the UI slightly. :-(

j.
