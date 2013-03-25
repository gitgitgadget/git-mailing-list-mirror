From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/9] streaming_write_entry: propagate streaming errors
Date: Mon, 25 Mar 2013 14:39:34 -0700
Message-ID: <20130325213934.GE1414@google.com>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202216.GF16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:40:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKF7f-0006MS-GW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149Ab3CYVjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:39:39 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47944 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758642Ab3CYVjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:39:39 -0400
Received: by mail-pb0-f49.google.com with SMTP id um15so626794pbc.8
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UDaLGWT9TtgzRGoQqvu1Zow2qSCWJax3JThvv25wHew=;
        b=s1cN6CsMlRmkmTcMsoZNmQx9oymTbWloc8fRreCmeenWlbShUzXTrrj5ce4RQe+p9e
         i1e4Wn6etCv+Q7YKzC6FAM70TN2IfbBbrTGVXdOBo9KZX6k9fc4VcqHnui1Eakc14M+Z
         +7SfarTfWw2hfi3mpu79HDfCGdVrQG1DXaK/FOq3dWNU0H+d6xlmjPhOaSJo3DdFA14b
         Qgp/hi1iMnZu9r850LqoTJYAPLIb9D6848zWjRW16Wy+Olnc6VcZCcWozewuM1EEuGfn
         oB8KshrizQGsUURqmDIW2Yswv3olgIB5qpHA6IGlXyvangsvD8Je8maUv7L3UlH8CFQQ
         26Ew==
X-Received: by 10.68.39.129 with SMTP id p1mr20111094pbk.19.1364247578747;
        Mon, 25 Mar 2013 14:39:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id pb3sm14755516pbc.7.2013.03.25.14.39.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 14:39:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130325202216.GF16019@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219097>

Jeff King wrote:

> When we are streaming an index blob to disk, we store the
> error from stream_blob_to_fd in the "result" variable, and
> then immediately overwrite that with the return value of
> "close".

Good catch.

[...]
> --- a/entry.c
> +++ b/entry.c
> @@ -126,8 +126,10 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
>  	fd = open_output_fd(path, ce, to_tempfile);
>  	if (0 <= fd) {
>  		result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
> -		*fstat_done = fstat_output(fd, state, statbuf);
> -		result = close(fd);
> +		if (!result) {
> +			*fstat_done = fstat_output(fd, state, statbuf);
> +			result = close(fd);
> +		}

Should this do something like


	{
		int fd, result = 0;

		fd = open_output_fd(path, ce, to_tempfile);
		if (fd < 0)
			return -1;

		result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
		if (result)
			goto close_fd;

		*fstat_done = fstat_output(fd, state, statbuf);
	close_fd:
		result |= close(fd);
	unlink_path:
		if (result)
			unlink(path);
		return result;
	}

to avoid leaking the file descriptor?

> @@ -31,4 +40,20 @@ test_expect_success 'streaming a corrupt blob fails' '
>  	)
>  '
>  
> +test_expect_success 'read-tree -u detects bit-errors in blobs' '
> +	(
> +		cd bit-error &&
> +		rm content.t &&
> +		test_must_fail git read-tree --reset -u FETCH_HEAD
> +	)

Makes sense.  Might make sense to use "rm -f" instead of "rm" to avoid
failures if content.t is removed already.

> +'
> +
> +test_expect_success 'read-tree -u detects missing objects' '
> +	(
> +		cd missing &&
> +		rm content.t &&

Especially here.

Thanks,
Jonathan
