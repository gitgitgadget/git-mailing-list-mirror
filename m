From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] submodule refactor: use git_path_submodule() in add_submodule_odb()
Date: Mon, 03 Aug 2015 14:29:27 -0700
Message-ID: <xmqqmvy86oy0.fsf@gitster.dls.corp.google.com>
References: <1426713052-19171-1-git-send-email-max@max630.net>
	<1438635836-7857-1-git-send-email-max@max630.net>
	<1438635836-7857-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:29:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNIc-0004lA-5t
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbbHCV33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:29:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35610 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbbHCV33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:29:29 -0400
Received: by pasy3 with SMTP id y3so23146217pas.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oS8F+B06VDs9LLOkr3MeVCYewO9CpVTH9EDFIkFF5dg=;
        b=T3VFsolTTUjfoPcWxRyFFKBRJZRecfY9VNZ0jpUn5WJHCjx4TdJovJT1ztV+FPfgS1
         oXOCjZSyTC6P/J8iOF1slpepo6PJElBSiEMJcJMXI86erywkLKS/7G+kj9ZWSREPWwlU
         6NN2uvXj7mFgL7upxKOe5B80midhiEsRlMOxDGzPUDxoH/VfzQQg9oO4/4AAm849EtKw
         aII5Nxiou6R8UR1L3BuTP5UwG5NCiODrKQqhf1TpI+uKEpVrv14itm//JRvBUEyO35L5
         tcuS70SrlDHcX1MYfqOuRhy+69KzbEu/YU7YxZTOczZtYFIUE0QA9SA9Yq1Tmon4FETO
         Qmaw==
X-Received: by 10.68.254.69 with SMTP id ag5mr295838pbd.130.1438637368646;
        Mon, 03 Aug 2015 14:29:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id k9sm18508113pdp.60.2015.08.03.14.29.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 14:29:27 -0700 (PDT)
In-Reply-To: <1438635836-7857-2-git-send-email-max@max630.net> (Max Kirillov's
	message of "Tue, 4 Aug 2015 00:03:55 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275209>

Max Kirillov <max@max630.net> writes:

Here is a space to describe why this change is a good thing.  Is
this a fix to change the behaviour, and if so how is the behaviour
different with and without the patch?  Or is this just to drop the
block of code from here and replace it with a call to an existing
helper that does exactly the same thing?  I _suspect_ that it is the
latter, but please do not force reviewers to guess.

> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  submodule.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 15e90d1..f6afe0a 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -122,43 +122,35 @@ void stage_updated_gitmodules(void)
>  
>  static int add_submodule_odb(const char *path)
>  {
> -	struct strbuf objects_directory = STRBUF_INIT;
>  	struct alternate_object_database *alt_odb;
> +	const char* objects_directory;

Style; asterisk sticks to the variable, not the type.  I think you
need to fix this in multiple places (not just 1/2 but also in 2/2).

Other than that I think it is a sensible "replace bulk of code with
identical helper that already exists" rewrite.

Thanks.

>  	int ret = 0;
> -	const char *git_dir;
>  
> -	strbuf_addf(&objects_directory, "%s/.git", path);
> -	git_dir = read_gitfile(objects_directory.buf);
> -	if (git_dir) {
> -		strbuf_reset(&objects_directory);
> -		strbuf_addstr(&objects_directory, git_dir);
> -	}
> -	strbuf_addstr(&objects_directory, "/objects/");
> -	if (!is_directory(objects_directory.buf)) {
> +	objects_directory = git_path_submodule(path, "objects/");
> +	if (!is_directory(objects_directory)) {
>  		ret = -1;
>  		goto done;
>  	}
> +
>  	/* avoid adding it twice */
>  	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
> -		if (alt_odb->name - alt_odb->base == objects_directory.len &&
> -				!strncmp(alt_odb->base, objects_directory.buf,
> -					objects_directory.len))
> +		if (alt_odb->name - alt_odb->base == strlen(objects_directory) &&
> +				!strcmp(alt_odb->base, objects_directory))
>  			goto done;
>  
> -	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
> +	alt_odb = xmalloc(strlen(objects_directory) + 42 + sizeof(*alt_odb));
>  	alt_odb->next = alt_odb_list;
> -	strcpy(alt_odb->base, objects_directory.buf);
> -	alt_odb->name = alt_odb->base + objects_directory.len;
> +	strcpy(alt_odb->base, objects_directory);
> +	alt_odb->name = alt_odb->base + strlen(objects_directory);
>  	alt_odb->name[2] = '/';
>  	alt_odb->name[40] = '\0';
>  	alt_odb->name[41] = '\0';
>  	alt_odb_list = alt_odb;
>  
>  	/* add possible alternates from the submodule */
> -	read_info_alternates(objects_directory.buf, 0);
> +	read_info_alternates(objects_directory, 0);
>  	prepare_alt_odb();
>  done:
> -	strbuf_release(&objects_directory);
>  	return ret;
>  }
