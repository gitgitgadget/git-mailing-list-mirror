From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Thu, 18 Jun 2015 10:13:37 -0700
Message-ID: <xmqq616ley7y.fsf@gitster.dls.corp.google.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5dNo-0000a7-O1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 19:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbbFRRNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 13:13:41 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35595 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbbFRRNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 13:13:39 -0400
Received: by igbzc4 with SMTP id zc4so61477igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wBh0Up81/sMCDWrjCkphIpuCUtoTq+qqPzxzopxoOX0=;
        b=g0Wy5e1Yh53VQRANKwHFQ8/WSg+jhubH5TbxzPOYdB3XI0jlmFWj84ZbKjJGkWQyQc
         KakBSm84LeMIMh+eM0/zO2vvgicVlU9lZQNf3NAa5OOoP4nt5+PR9QOS7U6L/KXvUtWY
         bu9E0E1zrxpLN4mNJWn6JRCi03fQKE+nlvLv/8L4Inja3OoVSnvPfW5WjJYrt6p9ODQg
         DztzClCIPblFl4jUn5qMz8ow8QeeidHwO7TvLkW0go4aPrrIDPqTHDMXxgyPhVtRG+4H
         M1mMLNTYpHrtraDY8qS2nSMJT26QjW4IqjsCXHUX4Y1IPNgRRAJxBxgBsRK/G51i32gO
         v6yQ==
X-Received: by 10.50.43.131 with SMTP id w3mr14873529igl.8.1434647619044;
        Thu, 18 Jun 2015 10:13:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id b15sm14657318igm.12.2015.06.18.10.13.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 10:13:38 -0700 (PDT)
In-Reply-To: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Thu, 18 Jun 2015 17:18:00 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272028>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fd2036c..8f6f7ed 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1247,6 +1247,10 @@ format.coverLetter::
>  	format-patch is invoked, but in addition can be set to "auto", to
>  	generate a cover-letter only when there's more than one patch.
>  
> +format.outputDirectory::
> +	Set a custom directory to store the resulting files instead of the
> +	current working directory.
> +

After you set this configuration variable, how would you override it
and get the default behaviour back from the command line for one
time invocation?  "-o ./"?  That needs to be documented somewhere.

Documentation/format-patch.txt must have description on -o; that
paragraph needs to mention this new configuration variable, and it
would be a good place to document the "-o ./" workaround.

> -static const char *set_outdir(const char *prefix, const char *output_directory)
> +static const char *set_outdir(const char *prefix, const char *output_directory,
> +			      const char *config_output_directory)

This change looks ugly and unnecessary.  All the machinery after and
including the point set_outdir() is called, including reopen_stdout(),
work on output_directory variable and only that variable.

Wouldn't it work equally well to have

	if (!output_directory)
        	output_directory = config_output_directory;

before a call to set_outdir() is made but after the configuration is
read (namely, soon after parse_options() returns), without making
any change to this function?
