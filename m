X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Teach git-branch howto rename a branch
Date: Tue, 28 Nov 2006 10:55:47 +0100
Message-ID: <8c5c35580611280155v3b21cbe1m4b580ca9838eac15@mail.gmail.com>
References: <1164679287192-git-send-email-hjemli@gmail.com>
	 <7vzmac3qig.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 09:56:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nivKf2Ig6eiBPT4ZX6+RSKFyOL8AEGSO+HTUEyhEtQBEML4GD7tGJfvD39iinRHv3rfDIkvT9BNSRziQGjx+JKKhlL0KFguNwPhpwkXjSxVt3Og2DRJLI53zdfbuxnzTiTB6kJi3umbgwdz91/f13jDrT3i11rZeun0vXqlbKk4=
In-Reply-To: <7vzmac3qig.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32501>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gozgu-0001gE-Sb for gcvg-git@gmane.org; Tue, 28 Nov
 2006 10:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935774AbWK1Jzt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 04:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935782AbWK1Jzt
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 04:55:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:9722 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935774AbWK1Jzt
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 04:55:49 -0500
Received: by nf-out-0910.google.com with SMTP id c2so2368305nfe for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 01:55:47 -0800 (PST)
Received: by 10.82.120.15 with SMTP id s15mr125377buc.1164707747628; Tue, 28
 Nov 2006 01:55:47 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Tue, 28 Nov 2006 01:55:47 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/28/06, Junio C Hamano <junkio@cox.net> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
> >
> > With two branchnames, the second name is renamed to the first.
>
> Thanks.
>
> "--rename newname oldname" feels funny, as already mentioned a
> few times on the list.  rename(2) is "rename(old, new)" and
> mv(1) is "mv old new".

Ok, how about

  git branch [-m|-M] [oldbranch] newbranch

where -m is 'move' and -M is 'force move'?


>
> +       if (!rename_ref(oldref, newref) && !strcmp(oldname, head))
> +               create_symref("HEAD", newref);
> +}
>
> Can create_symref() fail?

Yes... But what can been done if/when it fails? create_symref()
already seems to be pretty verbose about errors, so the only thing I
can think of is to return the errorcode to the caller (which I should
have done in the first place, git-branch ought to have a usable
exitcode)

>
> +int rename_ref(const char *oldref, const char *newref)
> +{
> +       unsigned char sha1[20], orig_sha1[20];
> +       int flag = 0, logmoved = 0;
> +       struct ref_lock *lock;
> +       char msg[PATH_MAX*2 + 100];
> +       struct stat stat;
> +       int log = !lstat(git_path("logs/%s", oldref), &stat);
>
> This is not wrong per-se, but it made me stop and wonder if we
> want to error out when we find out "logs/oldref" is a symlink; I
> do not think we care about it that much, but in that case we may
> want to say stat() here instead...  Just a minor detail.

Well, it's a good point. If it's a symlink that's a pretty strong
indication that someone has been messing with the log for some reason,
so to error out is probably the right thing to do.


>
> +       lock = lock_ref_sha1_basic("tmp-renamed-ref", NULL, NULL);
> +       if (!lock)
> +               return error("unable to lock tmp-renamed-ref");
> +       lock->force_write = 1;
> +       if (write_ref_sha1(lock, orig_sha1, msg))
> +               return error("unable to save current sha1 in tmp-renamed-ref");
> +       if (log && rename(git_path("logs/%s", oldref), git_path("tmp-renamed-log")))
> +               return error("unable to move logfile logs/%s to tmp-renamed-log: %s",
> +                       oldref, strerror(errno));
>
> I am confused with this code.  tmp-renamed-ref is not even a
> ref, you lock $GIT_DIR/tmp-renamed-ref and call write-ref_sha1()
> with an uninitialized msg[] buffer to write into a logfile. What
> is the name of that logfile?  $GIT_DIR/log/tmp-renamed-ref???

My goal was to save the ref in a tmp-file before deleting the old ref,
not to log the event. I think of it as a way to get out of trouble if
rename_ref should fail badly.

Btw: I't _might_ be interesting to have $GIT_DIR/logs/tmp-renamed-ref
(or something similar) as a branch-independent log of branch renames


Anyway, I'l fix up the mentioned issues in a new patch

--
