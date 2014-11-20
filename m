From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 19 Nov 2014 18:36:55 -0800
Message-ID: <20141120023655.GG6527@google.com>
References: <xmqqvbma4pu3.fsf@gitster.dls.corp.google.com>
 <1416449134-12281-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, sahlberg@google.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 03:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrHc9-0005jt-5K
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 03:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663AbaKTCgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 21:36:53 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41517 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138AbaKTCgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 21:36:52 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so1934241iec.15
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9RQncTUmFr04g7bEulaNtQxTb6BHByMT2dOO+LfPUpg=;
        b=EJfqnshpyCv1e3NWcUFNsU3k2kdypVe/+mO+qwQtukTbjHWeBPClSuAAEowU/PQbMY
         8At+tNbL+K6beQeLi0in84LOXK93WL7ddPiK+Y/sndORTDlR6tS5lrV+CYZO+MH4F7w4
         ELPvYwZSum5oOWFJiazfzpX1Yq3OMCa+Aqx47WRIlEyuC6dz14j8GmKfbYTX8STLBkyu
         jmGsnR0W/90NZHE1/Mj2BLtKooDa/e70dxCuYPCfhXcX0GLcaIkKWRfb9z2Q9gpV/Y/k
         ghYz93sMMdjnJv52sBGcqJ0Z4FBVVKmTytB2bFJPOM6W9GrzwfslTdy7u9EIdUBio11/
         K1hA==
X-Received: by 10.50.26.99 with SMTP id k3mr13583088igg.47.1416451011822;
        Wed, 19 Nov 2014 18:36:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id m125sm590516iom.6.2014.11.19.18.36.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 18:36:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416449134-12281-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> [Subject: [PATCH] refs.c: add a function to append a reflog entry to a fd]

Does this supersede the other patch with the same subject?

Please keep adding v<num> in the subject --- when it's there, it makes
reading much easier.

>

Missing 'From:' line naming the original patch author.

> Break out the code to create the string and writing it to the file
> descriptor from log_ref_write and add it into a dedicated function
> log_ref_write_fd.

(grammar) I'm having trouble parsing the above.

Is the idea something like "Split out a function that [explanation
of when a caller would use this function goes here]?"

>                   For now this is only used from log_ref_write,
> but later on we will call this function from reflog transactions too,

Useful to know.  I'd end the sentence here, since it seems to run
on with a different thought.

> which means that we will end up with only a single place,
> where we write a reflog entry to a file instead of the current two
> places (log_ref_write and builtin/reflog.c).

Ah, so builtin/reflog.c is doing something similar and will later
be changed to use this code, too?

Overall it sounds like a very good change.

[...]
> Here comes a resend without changing code, but just making it a new function,
> so we come forwards with the patch.

\o/

> Let's discuss the change and decide if I shouldsend a follow up patch to change
> it into snprintf.

Both sprintf and snprintf are error-prone functions.  It would be
lovely in a followup to use strbuf_addf or xstrfmt in this code path.
strbufs are how git deals with bookkeeping for string sizes --- they
are very pleasant.

[...]
> +++ b/refs.c
[...]
> @@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
[...]
> +	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
> +				  git_committer_info(0), msg);
> +	if (result) {
>  		int save_errno = errno;
>  		close(logfd);
>  		error("Unable to append to %s", log_file);

Since 'result' isn't used here, this could be simplified to

	if (log_ref_write_fd(...)) {
		...
	}

Thanks and hope that helps,
Jonathan
