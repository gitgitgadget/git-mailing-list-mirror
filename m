From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/16] diff: use tempfile module
Date: Tue, 11 Aug 2015 13:03:18 -0700
Message-ID: <xmqqbnedr3sp.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<404c8bc508639a5723420691d9daa122f10d7cd4.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPFle-0006wf-95
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbbHKUDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:03:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36435 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbbHKUDV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:03:21 -0400
Received: by pdco4 with SMTP id o4so87146705pdc.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DCgMe8fbvACOwY1VK06uEJsmF8Mn28KBTYPFiS5Nlz4=;
        b=x3uY4yd25/NVZI76QpcETeDAcVcwAtfziB9r/EfWeOtQQM1K9pBMilAJZLlG4aRp7Z
         8sUxFgQxwNGgKizSMwYgwE14Q5RtEk91hynKiNJFD1XYFPWxtceiMf0dbg4iKejjachO
         iap2MNgajmpU4VHDb6tovfnOQWgu8srIqc139IEec9HB12RML/gFEBU1J6AJTf/VORiq
         BDDWWm1t9RHok1Wzg9uPi/SyuqpKbJ/sF7d5jismtepYsSeh2/Smegzgsk2wxVLNSUHX
         fSwzGn0wCjHd73FrGZJ8o+iuIzEqo2tqin7ONkvlCz750rLQrIQfEU2wJVrMetA31n0n
         vXSQ==
X-Received: by 10.70.135.133 with SMTP id ps5mr32170219pdb.48.1439323400191;
        Tue, 11 Aug 2015 13:03:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id f10sm2931139pdk.20.2015.08.11.13.03.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 13:03:19 -0700 (PDT)
In-Reply-To: <404c8bc508639a5723420691d9daa122f10d7cd4.1439198011.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 10 Aug 2015 11:47:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275716>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  diff.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)

Nice code reduction.

> diff --git a/diff.c b/diff.c
> index 7500c55..dc95247 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2,6 +2,7 @@
>   * Copyright (C) 2005 Junio C Hamano
>   */
>  #include "cache.h"
> +#include "tempfile.h"
>  #include "quote.h"
>  #include "diff.h"
>  #include "diffcore.h"
> @@ -312,7 +313,7 @@ static struct diff_tempfile {
>  	const char *name; /* filename external diff should read from */
>  	char hex[41];
>  	char mode[10];
> -	char tmp_path[PATH_MAX];
> +	struct tempfile tempfile;
>  } diff_temp[2];
>  
>  typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
> @@ -564,25 +565,16 @@ static struct diff_tempfile *claim_diff_tempfile(void) {
>  	die("BUG: diff is failing to clean up its tempfiles");
>  }
>  
> -static int remove_tempfile_installed;
> -
>  static void remove_tempfile(void)
>  {
>  	int i;
>  	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
> -		if (diff_temp[i].name == diff_temp[i].tmp_path)
> -			unlink_or_warn(diff_temp[i].name);
> +		if (is_tempfile_active(&diff_temp[i].tempfile))
> +			delete_tempfile(&diff_temp[i].tempfile);

I suspect that this indicates that there is something iffy in the
conversion.  The original invariant, that is consistently used
between claim_diff_tempfile() and remove_tempfile(), is that .name
field points at .tmp_path for a slot in diff_temp[] that holds a
temporary that is in use.  Otherwise, .name is NULL and it can be
claimed for your own use.

Here the updated code uses a different and new invariant: .tempfile
satisfies is_tempfile_active() for a slot in use.  But the check in
claim_diff_tempfile() still relies on the original invariant.

The updated code may happen to always have an active tempfile in
tempfile and always set NULL when it clears .name, but that would
mean (1) future changes may easily violate one of invariants (we
used to have only one, now we have two that have to be sync) by
mistake, and (2) we are keeping track of two closely linked things
as two invariants.

As the value that used to be in the .name field can now be obtained
by calling get_tempfile_path() on the .tempfile field, perhaps we
should drop .name (and its associated invariant) at the same time?
