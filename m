From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/2] submodule refactor: use strbuf_git_path_submodule() in add_submodule_odb()
Date: Mon, 14 Sep 2015 11:00:56 -0700
Message-ID: <xmqqoah4x4mf.fsf@gitster.mtv.corp.google.com>
References: <1442182662-28834-1-git-send-email-max@max630.net>
	<1442182662-28834-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 20:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbY3t-0003Jm-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 20:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbINSBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 14:01:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35008 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbINSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 14:00:59 -0400
Received: by pacfv12 with SMTP id fv12so153169644pac.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n+2W5yTJXai+drrQ5zovT0wrgQhAUkzDqQQuXwIpNRE=;
        b=Snv+TTAw2rIl6Bd85L3R4DwRkx0m0yZ7jLSv7Q8ASwf3MAgwC4TYk9hSsdArIFnZ4j
         vf5pQV71dUsGI2KB2wV6TYjqBF425KX50C8fkTLGaGE768VwN5hYSBvbNdcAPJ7qWIXz
         wBcrq+APLzeeEeh1tZFkZZgZ0Y5hMf3hCmnI3e9MYzh2aEvvcqdlP183mCsfiW4VnZe2
         yhXIYfbF7iU4KZ8aoDfLqxFVX/fDIfGWuqwL1geKa5+2+EzIx566En7GNVfphgQY5LVI
         bay0CNfq14MjT0gdUCCvv7MlDovj/4Vz3WpUzxP0DUl3ae2fBDjKU4w/wnucHyoT7GV3
         Z4MA==
X-Received: by 10.66.186.39 with SMTP id fh7mr37939478pac.48.1442253658714;
        Mon, 14 Sep 2015 11:00:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id k10sm17394478pbq.78.2015.09.14.11.00.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 11:00:58 -0700 (PDT)
In-Reply-To: <1442182662-28834-2-git-send-email-max@max630.net> (Max
	Kirillov's message of "Mon, 14 Sep 2015 01:17:41 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277855>

Max Kirillov <max@max630.net> writes:

> Functions which directly operate submodule's object database do not
> handle the case when the submodule is linked worktree (which are
> introduced in c7b3a3d2fe). Instead of fixing the path calculation use
> already existing strbuf_git_path_submodule() function without changing
> overall behaviour. Then it will be possible to modify only that function
> whenever we need to change real location of submodule's repository
> content.
>
> Edited-by: Jeff King <peff@peff.net>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  submodule.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

This certainly is a lot nicer ;-)

Thanks.

>
> diff --git a/submodule.c b/submodule.c
> index 245ed4d..16b7c35 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -124,13 +124,7 @@ static int add_submodule_odb(const char *path)
>  	int ret = 0;
>  	const char *git_dir;
>  
> -	strbuf_addf(&objects_directory, "%s/.git", path);
> -	git_dir = read_gitfile(objects_directory.buf);
> -	if (git_dir) {
> -		strbuf_reset(&objects_directory);
> -		strbuf_addstr(&objects_directory, git_dir);
> -	}
> -	strbuf_addstr(&objects_directory, "/objects/");
> +	strbuf_git_path_submodule(&objects_directory, path, "objects/");
>  	if (!is_directory(objects_directory.buf)) {
>  		ret = -1;
>  		goto done;
