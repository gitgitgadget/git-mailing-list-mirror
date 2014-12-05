From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Fri, 5 Dec 2014 09:47:37 -0800
Message-ID: <20141205174737.GB29570@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
 <CAN05THTTba-1n12hBszJAU-O+wsbSFd5Lt+kMk7_MU_0C=wZGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: ronnie sahlberg <ronniesahlberg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 18:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwwym-0005VY-JE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 18:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaLERrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 12:47:40 -0500
Received: from mail-yk0-f201.google.com ([209.85.160.201]:40938 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaLERrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 12:47:39 -0500
Received: by mail-yk0-f201.google.com with SMTP id 142so54808ykq.4
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZvtzbJGOZdHAD1Hx6S5xz9yVc0uTpn0Kx9l5iX8nglg=;
        b=VW5OR+QMMPDmxnxsdr2j0r4w53UFOIOZnSUrDvNwKKRGdAKj+bv+PAjFv84blBzUGG
         KWHwTAzZ+Cs3KRlQRBckSNEqqSGCwOcRgK88C0t541Fkdn6aBr9A8AFBzvQsiUitIcHT
         j9SIBt7THlgzULIQQRrdFIZZeFuG4fgJsjgNRmiOkf930nFgOq9IP3RNYby/lgNok9vK
         W6f+JmV6nljViHjEVmvNWCpbjo8Ol9KTQ9iHytE06QXtAoMWOqVkLOJELbfDYbyLgXEt
         epRZYtXCGR6rjN2kjK49L2IgT2JDGvseB8UhRUNwsh8aEhWnKVnX+6x447t+s2SMaOTp
         lR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZvtzbJGOZdHAD1Hx6S5xz9yVc0uTpn0Kx9l5iX8nglg=;
        b=PYw4Q6a7n0+4xIG7Oo1BM5TnKCpiCzJn97Pb8v8Uv/yPJs9qOyl64DKndXqUNIzRxL
         Qr7TqUC64ry8Vy7ZKit9fOfOZZ5vwtgJ0i2v7aZz6kyctECCE4PjNOU9nPi3ahccTNUf
         UTFkz7dwHjIvsMAvDKdG3F6+bzUxG4icRH2tGhUXBxFiOH5uNEGGQwRJy88WZRCRyVcu
         azMibv+BByifGvGxDuFKXbZZLqOEjnPnj5GTqyNspZscWFYJlSmfcqTAvFBvK3IbH0Q8
         pzEnak3/H6WP1R3QbIjOSRa+jnaX/Xmf5vxssXfJrf9tAXLOuebesy+N8EStPpjeG203
         ZVoA==
X-Gm-Message-State: ALoCoQmeGq4XBTkkGiz0SyC+2S60f3kKuVByEc3cOmkIEfi8kQ/hGEhpJubKs/DOX6oFk+ED+Y/0
X-Received: by 10.236.203.98 with SMTP id e62mr15675131yho.56.1417801658986;
        Fri, 05 Dec 2014 09:47:38 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si1296664yhe.3.2014.12.05.09.47.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2014 09:47:38 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id FUdvDgRq.1; Fri, 05 Dec 2014 09:47:38 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id F2A5B140B70; Fri,  5 Dec 2014 09:47:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN05THTTba-1n12hBszJAU-O+wsbSFd5Lt+kMk7_MU_0C=wZGQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260877>

On Thu, Dec 04, 2014 at 06:51:36PM -0800, ronnie sahlberg wrote:
> On Thu, Dec 4, 2014 at 3:08 PM, Michael Haggerty <mhagger@alum.mit.edu>
> wrote:
> 
> > We don't actually need the locking functionality, because we already
> > hold the lock on the reference itself,
> 
> 
> No. You do need the lock.
> The ref is locked only during transaction_commit()
> 

Michael is saying, that you never want to modify the reflog, if you're not holding
the lock on the corresponding ref. Or in other words, you may modify the reflog, if
the corresponding ref is held. This used to be this way back then. 

> If you don't want to lock the reflog file and instead rely on the lock on
> the ref itself you will need to
> rework your patches so that the lock on the ref is taken already during,
> for example, transaction_update_ref() instead.
> 
> But without doing those changes and moving the ref locking from _commit()
> to _update_ref() you will risk reflog corruption/surprises
> if two operations collide and both rewrite the reflog without any lock held.
> 
> 
> 
> 
> 
> > which is how the reflog file is
> > locked. But the lock_file code still does some of the bookkeeping for
> > us and is more careful than the old code here was.
> >
> > For example:
> >
> > * Correctly handle the case that the reflog lock file already exists
> >   for some reason or cannot be opened.
> >
> > * Correctly clean up the lockfile if the program dies.
> >
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> >  builtin/reflog.c | 37 ++++++++++++++++++++++---------------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/builtin/reflog.c b/builtin/reflog.c
> > index a282e60..d344d45 100644
> > --- a/builtin/reflog.c
> > +++ b/builtin/reflog.c
> > @@ -349,12 +349,14 @@ static int push_tip_to_list(const char *refname,
> > const unsigned char *sha1, int
> >         return 0;
> >  }
> >
> > +static struct lock_file reflog_lock;
> > +
> >  static int expire_reflog(const char *refname, const unsigned char *sha1,
> > void *cb_data)
> >  {
> >         struct cmd_reflog_expire_cb *cmd = cb_data;
> >         struct expire_reflog_cb cb;
> >         struct ref_lock *lock;
> > -       char *log_file, *newlog_path = NULL;
> > +       char *log_file;
> >         struct commit *tip_commit;
> >         struct commit_list *tips;
> >         int status = 0;
> > @@ -372,10 +374,14 @@ static int expire_reflog(const char *refname, const
> > unsigned char *sha1, void *c
> >                 unlock_ref(lock);
> >                 return 0;
> >         }
> > +
> >         log_file = git_pathdup("logs/%s", refname);
> >         if (!cmd->dry_run) {
> > -               newlog_path = git_pathdup("logs/%s.lock", refname);
> > -               cb.newlog = fopen(newlog_path, "w");
> > +               if (hold_lock_file_for_update(&reflog_lock, log_file, 0) <
> > 0)
> > +                       goto failure;
> > +               cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> > +               if (!cb.newlog)
> > +                       goto failure;
> >         }
> >
> >         cb.cmd = cmd;
> > @@ -423,10 +429,9 @@ static int expire_reflog(const char *refname, const
> > unsigned char *sha1, void *c
> >         }
> >
> >         if (cb.newlog) {
> > -               if (fclose(cb.newlog)) {
> > -                       status |= error("%s: %s", strerror(errno),
> > -                                       newlog_path);
> > -                       unlink(newlog_path);
> > +               if (close_lock_file(&reflog_lock)) {
> > +                       status |= error("Couldn't write %s: %s", log_file,
> > +                                       strerror(errno));
> >                 } else if (cmd->updateref &&
> >                         (write_in_full(lock->lock_fd,
> >                                 sha1_to_hex(cb.last_kept_sha1), 40) != 40
> > ||
> > @@ -434,21 +439,23 @@ static int expire_reflog(const char *refname, const
> > unsigned char *sha1, void *c
> >                          close_ref(lock) < 0)) {
> >                         status |= error("Couldn't write %s",
> >                                         lock->lk->filename.buf);
> > -                       unlink(newlog_path);
> > -               } else if (rename(newlog_path, log_file)) {
> > -                       status |= error("cannot rename %s to %s",
> > -                                       newlog_path, log_file);
> > -                       unlink(newlog_path);
> > +                       rollback_lock_file(&reflog_lock);
> > +               } else if (commit_lock_file(&reflog_lock)) {
> > +                       status |= error("cannot rename %s.lock to %s",
> > +                                       log_file, log_file);
> >                 } else if (cmd->updateref && commit_ref(lock)) {
> >                         status |= error("Couldn't set %s", lock->ref_name);
> > -               } else {
> > -                       adjust_shared_perm(log_file);
> >                 }
> >         }
> > -       free(newlog_path);
> >         free(log_file);
> >         unlock_ref(lock);
> >         return status;
> > +
> > + failure:
> > +       rollback_lock_file(&reflog_lock);
> > +       free(log_file);
> > +       unlock_ref(lock);
> > +       return -1;
> >  }
> >
> >  static int collect_reflog(const char *ref, const unsigned char *sha1, int
> > unused, void *cb_data)
> > --
> > 2.1.3
> >
> >
