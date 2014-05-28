From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 31/41] refs.c: make prune_ref use a transaction to
 delete the ref
Date: Wed, 28 May 2014 14:56:15 -0700
Message-ID: <CAL=YDWnBu_vWM67TcnRAPJPij9NV_473C1GNEkjBv1gWAm4RNg@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-32-git-send-email-sahlberg@google.com>
	<20140528215118.GA12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wplpd-0005Kp-2t
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaE1V4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:56:17 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:58262 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbaE1V4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:56:16 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so13122116vcb.15
        for <git@vger.kernel.org>; Wed, 28 May 2014 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bDesLVVvDrCbCVuQ8B/SqkK3snWIBDcQPcJP0uba2bk=;
        b=EsGBkCuiZrdfFnuj5oZMl6V4Hyq+3RzAKZXIdsAS2hM7aL8aLEiTUoqgBL6G/Kkc3j
         BkxilyYvWaIuhZsFhEmdJflBhixhoJntyFvFQtKYyczjl3v4tS1RD87j0IwZf4+wuLFD
         84NoLOSt2EVLm1mWN7W8Oxqzd0/yRnQ5lOBgGo8h5jQrmzZYaFMHVqs+q8pScawIXv8t
         SrNn0ud5JORbrEWYeOy86uVPhENFjfu8gtR3rf5pBbujhwCbYDIFqZ89ij6asAW1rB/y
         JN3hZQZ/8uVa8auop2axon3Pg/Obq9Qg6EQwvwW4lXZdu8/o5weabjubga65c8Abgfa0
         EDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bDesLVVvDrCbCVuQ8B/SqkK3snWIBDcQPcJP0uba2bk=;
        b=JVXRCy7whY8sNeUAALcD+vUlGp/CGxEUwXR9HlySD9rW8+DZd10AbmRJLQsfZJLfN/
         0B/3k6OD/kHeFZwkyynFNDcETDNxNsPVY1XlWcJxAw30V3gAIvhgHWYoE1b1yqGdpRxp
         I5KWf/2wbDaEyd4dSi1XmHbCLBH6UjDh2nvjd3zlwrO+F9c3IgS74+oMMXAlSp7cv6UB
         4sAsnynU5Q3Q6y/e/sloEJ7I6bTE/F/zZ2H22ktcfVGAjm9FNtSt8DKFfshksTd88FCq
         r4w1CYDPj+L7F85L7+YUOaH+Yql43ZFVKvYjT8gx+lXa6/TzeEomoszoBAI6q0A95YLW
         b4dQ==
X-Gm-Message-State: ALoCoQm9CZlOb0xBu0Od3O/PQcczBS2vg+Qk3MGeiE21AjogW0tEY7zplp395fSepPVGzI01LO5C
X-Received: by 10.58.112.8 with SMTP id im8mr2595878veb.35.1401314175756; Wed,
 28 May 2014 14:56:15 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 14:56:15 -0700 (PDT)
In-Reply-To: <20140528215118.GA12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250335>

On Wed, May 28, 2014 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change prune_ref to delete the ref using a ref transaction. To do this we also
>> need to add a new flag REF_ISPRUNING that will tell the transaction that we
>> do not want to delete this ref from the packed refs.
>
> s/from the packed refs/from packed-refs, nor delete the ref's reflog/
>
> [...]
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -235,6 +235,11 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>>   * The following functions add a reference check or update to a
>>   * ref_transaction.  In all of them, refname is the name of the
>>   * reference to be affected.  The functions make internal copies of
>>   * refname, so the caller retains ownership of the parameter.  flags
>>   * can be REF_NODEREF; it is passed to update_ref_lock().
>>   */
>>
>>  /*
>> + * ref_transaction_update ref_transaction_create and ref_transaction_delete
>> + * all take a flag argument. Currently the only public flag is REF_NODEREF.
>> + * Flag values >= 0x100 are reserved for internal use.
>> + */
>> +/*
>>   * Add a reference update to transaction.  new_sha1 is the value that
>
> The comment right before here already tries to explain the flag argument,
> though it isn't in an obvious place so it's easy to miss.  Maybe the flag
> argument should be explained in the overview documentation for the
> ref_transaction API near the top of the file (but I haven't thought that
> through, so leaving it alone).
>
> How about this as a way to make the reserved flag values easier to
> find when adding new flags?
>
> diff --git i/refs.h w/refs.h
> index 25ac4a9..dee7c8f 100644
> --- i/refs.h
> +++ w/refs.h
> @@ -171,8 +171,17 @@ extern int ref_exists(const char *);
>   */
>  extern int peel_ref(const char *refname, unsigned char *sha1);
>
> -/** Locks any ref (for 'HEAD' type refs). */
> +/*
> + * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
> + * ref_transaction_create(), etc.
> + * REF_NODEREF: act on the ref directly, instead of dereferencing
> + *              symbolic references.
> + *
> + * Flags >= 0x100 are reserved for internal use.
> + */
>  #define REF_NODEREF    0x01
> +
> +/** Locks any ref (for 'HEAD' type refs). */
>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>                                                 const unsigned char *old_sha1,
>                                                 int flags, int *type_p);
> @@ -265,11 +274,6 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   */
>
>  /*
> - * ref_transaction_update ref_transaction_create and ref_transaction_delete
> - * all take a flag argument. Currently the only public flag is REF_NODEREF.
> - * Flag values >= 0x100 are reserved for internal use.
> - */
> -/*
>   * Add a reference update to transaction.  new_sha1 is the value that
>   * the reference should have after the update, or zeros if it should
>   * be deleted.  If have_old is true, then old_sha1 holds the value

Thanks. Changed.
