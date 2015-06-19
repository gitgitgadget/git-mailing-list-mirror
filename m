From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 08/19] fsck: Make fsck_commit() warn-friendly
Date: Fri, 19 Jun 2015 13:12:58 -0700
Message-ID: <xmqqmvzv78z9.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<1ce6b2b32cb94d9697056d1181bb1fe396c64a5b.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:13:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62f3-0003lL-5R
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbbFSUNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:13:09 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37771 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338AbbFSUNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:13:00 -0400
Received: by igblr2 with SMTP id lr2so20582423igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qZ2G9zNy8wy3rjAowWwYaXPisOwswluY+UUEmJ9Rl6U=;
        b=phGFmJX1coHD+LbhI5EVTRTfm5J9/PoQivGjZb8D5nUIXGMQ1NRwt6bfpb3j+NX5aK
         VInpi2mzBX9PjYBNxMQZEg1939yGRDlONrVH8Ddcn3/KfqBZ+d099Z7+nycGoN6Kmw8/
         GPEdr1z7PTN3HU40NDFemNd+GGonooJjvzFc6IhZA+/kvTcsL7UeZK124X7djoEFYLkN
         yL0cIby3OkghJNdEyP+1ZLs+J1gIXzMrbgeUaEtUO3sYJtsEnX22hrjHSdogTrDKV6jN
         CrUAjBgqxsPK930B399GU9Mrf01hkT7CzThf6D1Q/Nz5PPnirlv335M/EfGTixlMhiLo
         Zqww==
X-Received: by 10.50.138.74 with SMTP id qo10mr6886484igb.38.1434744780148;
        Fri, 19 Jun 2015 13:13:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id o2sm2363581igr.9.2015.06.19.13.12.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:12:59 -0700 (PDT)
In-Reply-To: <1ce6b2b32cb94d9697056d1181bb1fe396c64a5b.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:33:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272193>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When fsck_commit() identifies a problem with the commit, it should try
> to make it possible to continue checking the commit object, in case the
> user wants to demote the detected errors to mere warnings.

That makes sense.

> Note that some problems are too problematic to simply ignore. For
> example, when the header lines are mixed up, we punt after encountering
> an incorrect line. Therefore, demoting certain warnings to errors can
> hide other problems. Example: demoting the missingauthor error to
> a warning would hide a problematic committer line.

Is this a warning to end-users (which should be better in the doc),
or "because some of them are too problematic to ignore" that forgot
to add the explanation "hence we do not keep going in this code"
(which should be in the log message if that is what is going on)?

I notice that there are many instances of

	if (object does not pass some test)
		return report(...);

that do not do "err = report(); if (err) return;" in this function
after applying this patch.

I think that answers the above question.  The answer is "because
some are too problematic, even after this patch, we give up parsing
the remainder of the commit object once we hit certain errors,
leaving some other errors that appear later in the object
undetected".

I think that is a sensible design decision, but the proposed log
message forgets to say so.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 9faaf53..9fe9f48 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -534,12 +534,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  
>  	if (!skip_prefix(buffer, "tree ", &buffer))
>  		return report(options, &commit->object, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
> -	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
> -		return report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
> +	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n') {
> +		err = report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
> +		if (err)
> +			return err;
> +	}

I do not think this "if (err) return err;" that uses the return
value of report(), makes sense.

As all the errors that use this pattern are isolated ones that does
not break parsing of the remainder (e.g. author ident had an extra >
in it may break "author " but that does not prevent us from checking
"committer ").

Your report() switches its return value based on the user setting;
specifically, it returns 0 if the user tells us to ignore/skip or
warn.  Which means that the user will see all warnings, but we stop
at the first error.

Shouldn't we continue regardless of the end-user setting in order to
show errors on other fields, too?
