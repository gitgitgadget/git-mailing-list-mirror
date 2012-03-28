From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 15:42:21 -0500
Message-ID: <20120328204221.GE8982@burratino>
References: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>,
	Frans Klaver <fransklaver@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:42:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzhS-0008Eu-JL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab2C1Uma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:42:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34263 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758014Ab2C1Um3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:42:29 -0400
Received: by iagz16 with SMTP id z16so1962452iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kQVgadlh6+L5NjtmStSqVTSmJsKuvKtn1HeeUknokzE=;
        b=X3a525RBwMmN/LiHCvsKScO9k7ZZEX3186x1fJF76TOqG0KBy1lDD82XuKfkVieqFL
         vQXMCmeeXdmn1Xd3H07mNI9252GdlShZUDjrGKz+A+2hTCbEKXJdoFcdsE+DydzVlceC
         XWyj0ZTHR3ekuHIsHOm7iAbuq3wqj3Gl5izlRSMMKklq0U0C/FunM1TfE6YvtDv1kqi5
         RHDBz9hyY57YndIUibV66l1LBQ3pfSQ2c53KdRTFHJn2nygxjarfPsGHtMAee8PZDlgG
         jnqOqS7gQET3FYO3QHUvitaT5aXhG1V0ZUp7q4fV6o2tZBjqK19obktAWwXfQPHdfmNT
         jR2A==
Received: by 10.50.194.133 with SMTP id hw5mr373551igc.57.1332967347818;
        Wed, 28 Mar 2012 13:42:27 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bh8sm3982923igc.9.2012.03.28.13.42.27
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 13:42:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120328201851.GA29315@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194190>

(cc-ing Frans who had a related itch if I remember correctly[1])
Hi again,

Jeff King wrote:

> --- a/run-command.c
> +++ b/run-command.c
> @@ -76,6 +76,39 @@ static inline void dup_devnull(int to)
>  }
>  #endif
>  
> +static int file_in_path_is_nonexecutable(const char *file)
> +{
> +	const char *p = getenv("PATH");
> +
> +	if (!p)
> +		return 0;
> +
> +	while (1) {
> +		const char *end = strchrnul(p, ':');
> +		const char *path;
> +		struct stat st;
> +
> +		path = mkpath("%.*s/%s", (int)(end - p), p, file);
> +		if (!stat(path, &st) && access(path, X_OK) < 0)
> +			return 1;
> +
> +		if (!*end)
> +			break;
> +
> +		p = end + 1;
> +	}
> +
> +	return 0;
> +}

Nice.

Nitpicks:

 - (end - p) is not guaranteed to fit inside an int.  What should happen
   when my PATH is very long?

 - the existence check would be simpler spelled as access(path, F_OK).

 - the above checks if there is _any_ nonexecutable instance of "file"
   in the directories listed in $PATH, but isn't what we want to check
   whether _all_ of them are nonexecutable?

> +
> +int sane_execvp(const char *file, char * const argv[])
> +{
> +	int ret = execvp(file, argv);
> +	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
> +		errno = ENOENT;
> +	return ret;
> +}

Makes sense.  No objections from me.

	if (!execvp(file, argv))
		return 0;
	/*
	 * When a command can't be found because one of the directories
	 * listed in $PATH is unsearchable, execvp reports EACCES, but
	 * careful usability testing (read: analysis of occasional bug
	 * reports) reveals that "No such file or directory" is more
	 * intuitive.
	 */
	if (errno == EACCES && cannot_find_in_PATH(file))
		errno = ENOENT;
	return -1;

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/189077/focus=189913
