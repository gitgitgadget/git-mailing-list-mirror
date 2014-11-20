From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a
 fd
Date: Thu, 20 Nov 2014 13:20:22 -0800
Message-ID: <20141120212022.GJ6527@google.com>
References: <20141120023655.GG6527@google.com>
 <1416508657-9057-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZ9L-0005Cb-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757782AbaKTVUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 16:20:19 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51402 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbaKTVUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:20:18 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so3593442igd.7
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=I/Kva1J8B5gWum+opG1SU1upbb16lt4O5RR3kou4PHI=;
        b=sbi2gig1iYRVrsTY8xyGLzLK02rqInP1KKruGGepeS7t16xyyA6L2uf1eFzEPZAaf0
         2MvUR0v2MN5wADNUXvtHdK4gBn/U+YIPyQw8vQeXH+WD5CqY3WPb9wvDVN5OkXBH3wPe
         aQ9pXogjGO8fJF/gryvj0TJkRtjwFlSkHjdjT54skSTpI7FgXmXunNgfGJZGIk9tNSjk
         TqXeE7rguBWT1CQsP3cmy9bhiQpG7krGW4/Nxb/hqTCkm7mlaq9En6CnQKPzx64O66Mx
         hWjH1FbRr/E3UFjLhC+VgSKdAFScI5yOSeKflWnFy/39MW99k3k1IukX5T1Fzw7kU9eO
         U7wA==
X-Received: by 10.107.40.205 with SMTP id o196mr621061ioo.26.1416518417716;
        Thu, 20 Nov 2014 13:20:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id kb7sm3078953igb.16.2014.11.20.13.20.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 13:20:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416508657-9057-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Move code to create the string for a ref and write it to a file descriptor
> from log_ref_write and add it into a new dedicated function
> log_ref_write_fd.
>
> For now the new function is only used from log_ref_write, but later
> on we will call this function from reflog transactions too. That means
> that we will end up with only a single place, where we write a
> reflog entry to a file instead of the current two places
> (log_ref_write and builtin/reflog.c).

Line-wrapping width is still inconsistent.  I don't think it's worth
resending just for that, but something to look out for in the future.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
[...]
> +++ b/refs.c
[...]
> @@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
[...]
> +	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
> +				  git_committer_info(0), msg);
> +	if (result) {
>  		int save_errno = errno;

I don't understand why the above writes to a temporary variable and
checks it, never to read that temporary again.

I don't think that alone is a reason to block the patch, but it
worries me in that the review comment seems to have been just lost.
