From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] register_tempfile(): new function to handle an existing temporary file
Date: Wed, 10 Jun 2015 10:55:43 -0700
Message-ID: <xmqqioavla74.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
	<d0507ec9bdc63b9532bbb348e4505d311ef3c5dc.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:55:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kEB-0000e1-2M
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbbFJRzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:55:47 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38203 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbFJRzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:55:45 -0400
Received: by igblz2 with SMTP id lz2so39247764igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aEFY83S+sZcbaBcTpokHwMkx05yVYgjjLaoVfGW+sy0=;
        b=H0wkwoqjzlezXY9BfoB0AfcuTWDXNSu7Lif5bkhpN0Qk3RCKHljo0epV/FSM0uGfEN
         myztbWongNAEHT+cX2EABVjXhBFLMXQtJs8G5457L9NMQfQb7fNlHO6f8SJSHa7BKpzw
         ZU45Bt8dRvNy4iFTgfLN0AMhisofec3/n4EEqqL8EBv5KdQIy9cGA2aPc3hT7B1/6v97
         7Oudgacs110v2vmUXq8phEROWyN82KuPZoWqv7AOvJSfEV2T++9IdiUualLcdoUDKxBS
         i4kypHCsMPdfcoEXXGNUzLjRXM2Vx9pBpzT2BrZ+uu8kbXyLCnl4RJShl9uQt4oYFAsn
         fZ5Q==
X-Received: by 10.50.41.8 with SMTP id b8mr29173697igl.38.1433958945228;
        Wed, 10 Jun 2015 10:55:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id d4sm3698207igl.1.2015.06.10.10.55.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 10:55:44 -0700 (PDT)
In-Reply-To: <d0507ec9bdc63b9532bbb348e4505d311ef3c5dc.1433751986.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 8 Jun 2015 11:07:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271334>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Allow an existing file to be registered with the tempfile-handling
> infrastructure; in particular, arrange for it to be deleted on program
> exit.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Hmph.  Where does such a tempfile that is not on list come from?

Puzzled, but let's read on---this could for example become an
internal implementation detail for create_tempfile().  Also I cannot
tell which one of register_tempfile() and register_tempfile_object()
I should be calling when updating the implementation of this API
from their names.

> diff --git a/tempfile.c b/tempfile.c
> index 890075f..235fc85 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -82,6 +82,15 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
>  	return tempfile->fd;
>  }
>  
> +void register_tempfile(struct tempfile *tempfile, const char *path)
> +{
> +	register_tempfile_object(tempfile, path);
> +
> +	strbuf_add_absolute_path(&tempfile->filename, path);
> +	tempfile->owner = getpid();
> +	tempfile->active = 1;
> +}
> +
>  int mks_tempfile_sm(struct tempfile *tempfile,
>  		    const char *template, int suffixlen, int mode)
>  {
> diff --git a/tempfile.h b/tempfile.h
> index 6276156..18ff963 100644
> --- a/tempfile.h
> +++ b/tempfile.h
> @@ -145,6 +145,14 @@ struct tempfile {
>   */
>  extern int create_tempfile(struct tempfile *tempfile, const char *path);
>  
> +/*
> + * Register an existing file as a tempfile, meaning that it will be
> + * deleted when the program exits. The tempfile is considered closed,
> + * but it can be worked with like any other closed tempfile (for
> + * example, it can be opened using reopen_tempfile()).
> + */
> +extern void register_tempfile(struct tempfile *tempfile, const char *path);
> +
>  
>  /*
>   * mks_tempfile functions
