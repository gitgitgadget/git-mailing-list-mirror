From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] pseudorefs: create and use pseudoref update and
 delete functions
Date: Wed, 29 Jul 2015 02:38:26 -0400
Message-ID: <CAPig+cSe9jL465CefToBwSLMz9-HfJA6u+Vcc0rszJ=Co-gsBg@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 08:38:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKL0Z-0003Az-QT
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 08:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbbG2Gi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 02:38:27 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34786 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbbG2Gi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 02:38:27 -0400
Received: by ykax123 with SMTP id x123so412963yka.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PWKljdyB0Ad8AitJXmtPGwjZ/RQ1fpdatyHOP5uLLSQ=;
        b=UvFVTdiR/9a4r4Fmdz8tXcENuHaJOj+06UhDsFF4e07o584hDbtlzFNtEEMuOtwR+f
         fVtQm/oX/IKj5cIctGqmX+5yhdEhhgpbY1kI4lnAOI/+Z01fk+xWfYvhY2dAPk3wxI/X
         DgZf+ExyuCln2XxJJVcFgaW4NAR6U+YzJ0LQI/W5h85undbqUBQs9g/mFe73h7zSrPJ8
         vRL7Kj4IMnTGmhv/orkR/ze2tyfPg1l5tVO/rCjhfOpaurPbHqxeH9MgmgQA4o3nnIXX
         zQDHLwmK9GTM1Kt/j7aX6M3twD9heufV2DdyhjmD2oXJT0Uy8m7dyTckzhzevAs6h/9C
         yiFg==
X-Received: by 10.170.97.9 with SMTP id o9mr42030657yka.84.1438151906670; Tue,
 28 Jul 2015 23:38:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 23:38:26 -0700 (PDT)
In-Reply-To: <1438107144-24293-5-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: 66FIM2LxB0oPhLsK2fPc21BKyok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274884>

On Tue, Jul 28, 2015 at 2:12 PM, David Turner <dturner@twopensource.com> wrote:
> Pseudorefs should not be updated through the ref transaction
> API, because alternate ref backends still need to store pseudorefs
> in GIT_DIR (instead of wherever they store refs).  Instead,
> change update_ref and delete_ref to call pseudoref-specific
> functions.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/refs.c b/refs.c
> index 553ae8b..2bd6aa6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2877,12 +2877,87 @@ enum ref_type ref_type(const char *refname)
> +static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
> +{
> +       static struct lock_file lock;
> +       const char *filename;
> +
> +       filename = git_path("%s", pseudoref);
> +
> +       if (old_sha1 && !is_null_sha1(old_sha1)) {
> +               int fd;
> +               unsigned char actual_old_sha1[20];
> +
> +               fd = hold_lock_file_for_update(&lock, filename,
> +                                              LOCK_DIE_ON_ERROR);
> +               if (fd < 0)
> +                       die_errno(_("Could not open '%s' for writing"), filename);
> +               read_ref(pseudoref, actual_old_sha1);
> +               if (hashcmp(actual_old_sha1, old_sha1)) {
> +                       warning("Unexpected sha1 when deleting %s", pseudoref);
> +                       return -1;

Does this need to release the lock file before returning?

> +               }
> +
> +               unlink(filename);
> +               rollback_lock_file(&lock);
> +       } else {
> +               unlink(filename);
> +       }
> +
> +       return 0;
> +}
