From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 13/42] commit.c: use ref transactions for updates
Date: Thu, 15 May 2014 09:53:32 -0700
Message-ID: <CAL=YDWkve_vXpmuL7qdsmyhEys+PdfHT3RN1g0oriBQxvVC7wg@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-14-git-send-email-sahlberg@google.com>
	<20140515011134.GJ9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:53:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyuY-0007Ep-4G
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbaEOQxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:53:34 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:48980 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbaEOQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:53:33 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so1691487veb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BzHR0N/zXigLyzTVGqQ7Kaltw1ZGk4ANwGbB+gERBhE=;
        b=IEnPkYKX9rkXkF7JbqHEJ0BlRvjsGBIdim4ZjZy3C73bAJ8DG5ZSdgd33zUlgxtzOo
         o189SuVOgmqRDs+HgtgGXdWMxKXL8czkERmU6wbo9MblyZuy8pEBN4KYU8bLUgwxTmR0
         Jl9Iv5DEYe+3qpKHpWbSC6u0+hCvF3SS5Bs53xTrrWXkWlFEKpmkoI3MdJPgxj2AeS7G
         a6gM7Bp6WVgFWGmQnlYUPe5Wfe9DQiAyhVOP8CHvRZ3h1SjokRPUuDjgu3wzpkkHEuph
         z9q5jeM1XUYFeO17UU7fToyRFqTuzwBrWqv/fGh/Le6ylS95zQWBr50EfiIuZON1AUfI
         Rpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BzHR0N/zXigLyzTVGqQ7Kaltw1ZGk4ANwGbB+gERBhE=;
        b=PzZNnfx388KRIzODRdH2/p4aULCWJ2K50eOX4mQyaVc6YLnAdo3eshC9N5EvRTZV/b
         ZRJNX9HMbYSyRmgQ0UOFW4sYUKtNYRdBotyRz54C7Y9umcpILJH0t0z19wcf8GyZ3aFi
         PfQgaUog01HERHjpu2DlfRdpdJBSw1K+2crcEwGMyAqdNfpV1DeLfEH9JX15EavAmlMc
         ftI2/RQV9XcAIjyAQspNLVKka0sPALHPf2GWHiVP3gU2EqVCbDiJrm/4+yVAHw5OgV0J
         407QtTcLleLEH5nLS5kUUb8OZWHokPng28FNUWT1fBvLOdKJNBJx6Z+qJAVG6b2YhgMV
         8UTA==
X-Gm-Message-State: ALoCoQkMzPiD7PLf6By/bk+givX7UB8oSaN/xqIuPNObQrTtanqOLM1k0UnnF1acqaIguJwsvpF9
X-Received: by 10.221.20.199 with SMTP id qp7mr9477888vcb.24.1400172812511;
 Thu, 15 May 2014 09:53:32 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 09:53:32 -0700 (PDT)
In-Reply-To: <20140515011134.GJ9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249116>

On Wed, May 14, 2014 at 6:11 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
> [...]
>> +++ b/builtin/commit.c
>> @@ -1541,11 +1541,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> [...]
>> @@ -1667,16 +1668,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>       strbuf_release(&author_ident);
>>       free_commit_extra_headers(extra);
>>
>> -     ref_lock = lock_any_ref_for_update("HEAD",
>> -                                        !current_head
>> -                                        ? NULL
>> -                                        : current_head->object.sha1,
>> -                                        0, NULL);
>> -     if (!ref_lock) {
>> -             rollback_index_files();
>> -             die(_("cannot lock HEAD ref"));
>> -     }
>> -
>>       nl = strchr(sb.buf, '\n');
>>       if (nl)
>>               strbuf_setlen(&sb, nl + 1 - sb.buf);
>>       else
>>               strbuf_addch(&sb, '\n');
>>       strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>>       strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>>
>> -     if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, "HEAD", sha1,
>> +                                current_head ?
>> +                                current_head->object.sha1 : NULL,
>> +                                0, !!current_head) ||
>> +         ref_transaction_commit(transaction, sb.buf, &err)) {
>>               rollback_index_files();
>> -             die(_("cannot update HEAD ref"));
>> +             die(_("HEAD: cannot update ref: %s"), err.buf);
>
> Same question about !transaction (it also applies to later patches but I
> won't mention it any more).
>
> The error message changed from
>
>         fatal: cannot lock HEAD ref
>
> to
>
>         fatal: HEAD: cannot update ref: Cannot lock the ref 'HEAD'.
>
> Does the message from ref_transaction_commit always say what ref
> was being updated when it failed?  If so, it's tempting to just use
> the message as-is:
>
>         fatal: Cannot lock the ref 'HEAD'
>
> If the caller should add to the message, it could say something about
> the context --- e.g.,
>
>         fatal: cannot update HEAD with new commit: cannot lock the ref 'HEAD'
>
> Looking at that,
>
>         die("%s", err.buf)
>
> seems simplest since even if "git commit" was being called in a loop,
> it's already clear that git was trying to lock HEAD to advance it.

Changed it to
>         die("%s", err.buf)

as you suggested.



Many thanks for the reviews so far!

regards
ronnie sahlberg
