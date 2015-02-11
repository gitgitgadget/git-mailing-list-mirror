From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Tue, 10 Feb 2015 16:49:22 -0800
Message-ID: <CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:49:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLLUk-0003Sb-1u
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 01:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbbBKAt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 19:49:26 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:37659 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbbBKAtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 19:49:23 -0500
Received: by iebtr6 with SMTP id tr6so553639ieb.4
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 16:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k6K6q4G7kxgEHmgoQTac9hsel8mhmls2zGegOxqVnvw=;
        b=jkOkKzwztSLjtkYPQ37CO3lRXAXyajidUspFhWjMIimzxwyLGdgECCl2PBkmnvY71C
         K4a2TSsPl+3pA9ZZ5LJGNRKJFEHtQjX641ZYpU0StknZO6+TuYzLqg0mgsKlxurpKjkA
         VeMyib8yWhFoP+4gr07gRUWY0TEgrT20Debz9BpmJ/g/c9tdqt3x9uSlMWWipop373Cc
         bHFmDt9RRDjtkVtm2u6qlBMT2k7a0VesgG7P6Esgee4zvrVhc5sPHIuhoaeyOVaTOUm+
         aktKkkO+CdHzbgiSBa/TKlILsnBDeSC/upGUHt7fbeHJZiha9CklPlaKq8oCvbyoRmvW
         85Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=k6K6q4G7kxgEHmgoQTac9hsel8mhmls2zGegOxqVnvw=;
        b=WD85BPJ5Xyh7U27ApPuI1YxvpYp4sOOGrGT2BpiHgAZxuVeqGwipT8eSMIsgohbR/r
         COQ2muYc9KqxRKD7yj2YSXqX9DrvKI78jf/YUzfC9XerB5wjJj+MP6I89S3H/LPTxS8w
         ELBTekEA6RNcv+j1gJvDstMmo8ocaCASvZKKTRkAmurYjLkAdzHZqnOHKyBYaa58PRjf
         JZHV1RSpGcTs5G14OT4Qs/m3lUzerJLxWkvAzIhC5hf21m/qdoSsM85zD/Np771TMB5Z
         eOPxKvnIviVIuv9UUOpy9Djv4ZjWSWp3dchRWyixTHx/+BDH+h/UhfF3WKbVN0fcdiHw
         2H7w==
X-Gm-Message-State: ALoCoQmQt/K2tDg9x5j07iZqMy2A6lXS8OEQ9qzUyMETyAvHb4vEv+5O6AW6CyZcXCVJsOcVRdH5
X-Received: by 10.42.230.67 with SMTP id jl3mr432326icb.15.1423615762594; Tue,
 10 Feb 2015 16:49:22 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 16:49:22 -0800 (PST)
In-Reply-To: <1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263667>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> When processing the reflog of a symbolic ref, hold the lock on the
> symbolic reference itself, not on the reference that it points to.

I am not sure if that makes sense.
So when expiring HEAD, you want to have a .git/HEAD.lock file
instead of a .git/refs/heads/master.lock file?

What would happen if there is a concurrent modification
to the master branch?

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 1b2a497..3fcf342 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4037,7 +4037,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>          * reference itself, plus we might need to update the
>          * reference if --updateref was specified:
>          */
> -       lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, &type);
> +       lock = lock_ref_sha1_basic(refname, sha1, NULL, REF_NODEREF, &type);
>         if (!lock)
>                 return error("cannot lock ref '%s'", refname);
>         if (!reflog_exists(refname)) {
> --
> 2.1.4
>
