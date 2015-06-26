From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/7] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Fri, 26 Jun 2015 14:42:29 -0700
Message-ID: <xmqqy4j6rvsq.fsf@gitster.dls.corp.google.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
	<1435278548-3790-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:42:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8bOR-0004UV-8A
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbFZVmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:42:35 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34892 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbFZVmd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:42:33 -0400
Received: by iebrt9 with SMTP id rt9so83958186ieb.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AsOf3uYoz9vGRbTYHN+uZ0i3jcR/pLrJ8Yq8F4aHiAY=;
        b=b7uPDjmMdfj9wdI/0z8fSdIOHkuxOKV2BvST6c50LzxwKP7bvZHR+C99vbpPMGgoP0
         xORo7my4LVtlEe+vo2m5PPt0hF31jXfikThB1cSps2O2vQgI1AuzyGX6FugnQ0TEeezT
         VCbTtLSQNWY5+vQ5+7EBfVNChqbWDZqPG0hS4LTlyHETm/lQW5/Dpfo2oATftFrRUsFV
         hosuy1hr9gfMCaLObYgX3UBhtRDtytweUPHkxOs/DnVWvaR9C6CAzMkudTEtMMhLhVtk
         sJ+nFNJEI7xgh23qcQEHnUujGzPUgtCfK5nSHsZ/uGudydbLGMX9+hGB3YldAYaWR+lu
         uYSA==
X-Received: by 10.107.136.214 with SMTP id s83mr5253012ioi.65.1435354953135;
        Fri, 26 Jun 2015 14:42:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id vk8sm98550igb.4.2015.06.26.14.42.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 14:42:31 -0700 (PDT)
In-Reply-To: <1435278548-3790-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 20:29:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272831>

David Turner <dturner@twopensource.com> writes:

> Instead of directly writing to and reading from files in
> $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> and REVERT_HEAD.
> ...
> diff --git a/sequencer.c b/sequencer.c
> index f8421a8..de904aa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -160,19 +160,20 @@ static void free_message(struct commit *commit, struct commit_message *msg)
>  
>  static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)

I guess this is no longer "pseudoref"?

> @@ -878,8 +879,8 @@ static int rollback_single_pick(void)
>  {
>  	unsigned char head_sha1[20];
>  
> -	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
> -	    !file_exists(git_path("REVERT_HEAD")))
> +	if (read_ref("CHERRY_PICK_HEAD", head_sha1) &&
> +	    read_ref("REVERT_HEAD", head_sha1))
>  		return error(_("no cherry-pick or revert in progress"));
>  	if (read_ref_full("HEAD", 0, head_sha1, NULL))
>  		return error(_("cannot resolve HEAD"));

I would have expected that you would use ref_exists() here; you are
not reading "HEAD" yet writing it into head_sha1[], and not using
the value of the ref.

Other than that, looked very sensible.  Thanks.
