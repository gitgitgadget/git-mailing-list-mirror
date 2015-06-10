From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] tempfile: add several functions for creating temporary files
Date: Wed, 10 Jun 2015 10:48:47 -0700
Message-ID: <xmqqmw07laio.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
	<a922fa6cfcc948d541b638d99e2413865ff051e2.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:48:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2k7S-0005Cv-B2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbbFJRsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:48:50 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35722 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965060AbbFJRst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:48:49 -0400
Received: by igbzc4 with SMTP id zc4so41509551igb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3aJGzDOYO2q1i+1qI2+vA8vMeW5eDGNwxiRIEZ9/YJ0=;
        b=Lbk23flgMUvz+E9bDcX1Cflpo4cIGP/hsPDWa0EfeZ+seifx7Xh/aSZmcmlO03Wf53
         WVs6E4LRPb2NpAeLNIfCdWdce+QnvhOjCQiry9CDOgMp+vttNNzMK423VCRfAnczcC+d
         woGleCKWb9iVCOBVHBmg0O/bqeOBz4lIvUi3ntGRih2bdlL495G1V9XaDx3LJI0o79lm
         OnPvW+EdzLg6ewiPw4ehvwSYS2B3emJ48B18JQwamovoIeoKpuc1wErTZ8ZZLs8FPnTN
         8iYW0Dsc/AT7RAxNEp/pKhTSDnOIGOYWWyul2A6TtZqpWyWsMr5jatXI4gxjuD605mks
         EQvw==
X-Received: by 10.43.146.67 with SMTP id jx3mr6115569icc.63.1433958528821;
        Wed, 10 Jun 2015 10:48:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id i4sm3647825igm.2.2015.06.10.10.48.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 10:48:48 -0700 (PDT)
In-Reply-To: <a922fa6cfcc948d541b638d99e2413865ff051e2.1433751986.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 8 Jun 2015 11:07:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271333>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Add several functions for creating temporary files with
> automatically-generated names, analogous to mkstemps(), but also
> arranging for the files to be deleted on program exit.
>
> The functions are named according to a pattern depending how they
> operate. They will be used to replace many places in the code where
> temporary files are created and cleaned up ad-hoc.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  tempfile.c | 55 ++++++++++++++++++++++++++++++++++-
>  tempfile.h | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+), 1 deletion(-)
>
> diff --git a/tempfile.c b/tempfile.c
> index f76bc07..890075f 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -48,7 +48,7 @@ static void register_tempfile_object(struct tempfile *tempfile, const char *path
>  		tempfile->fp = NULL;
>  		tempfile->active = 0;
>  		tempfile->owner = 0;
> -		strbuf_init(&tempfile->filename, strlen(path));
> +		strbuf_init(&tempfile->filename, 0);
>  		tempfile->next = tempfile_list;
>  		tempfile_list = tempfile;
>  		tempfile->on_list = 1;

This probably could have been part of the previous step.  Regardless
of where in the patch series this change is done, I think it makes
sense, as this function does not even know how long the final filename
would be, and strlen(path) is almost always wrong as path is likely to
be relative.

I notice this change makes "path" almost unused in this function,
and the only remaining use is for assert(!tempfile->filename.len).
Perhaps it is not worth passing the "path" parameter?
