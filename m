From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 1/3] t3030-merge-recursive: Test known breakage with
 empty work tree
Date: Fri, 24 Jan 2014 08:51:12 -0800
Message-ID: <20140124165112.GK18964@google.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com>
 <cover.1390574980.git.brad.king@kitware.com>
 <bee33fbfe83408a69085d58db302b3e72edf16a4.1390574981.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 17:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6jyW-0000PR-AD
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 17:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbaAXQvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 11:51:20 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:36332 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaAXQvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 11:51:19 -0500
Received: by mail-bk0-f44.google.com with SMTP id mz12so1291381bkb.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nzDCCOB2T/NeueqKUZg/f0D9UiV0iJjNKvW/UXmnXfs=;
        b=mJY30ZWc+j0SjLWATusaRk2zPISpx3BDAGPZqw/ue02IAPc6dg895p+cN2kdBw9Imw
         tURuVXbrdEVlhDmR7b44fP+xvYW4eoYDCq6Az7n+NqprA5Vba8PI1Y9S4WzkCHR/h+Bj
         6Z6R0fRYhHypTzK2MdtpKTOCLcB+3udrBuZX5FhtOvdlLTewU2nBcPm2puLOd/rlFki/
         JuwHYbnmRAE5W01u8tVUgEj5uLMJbSc6FMsKlyhW24FdK/dbm94MlCnRsSTxWFrkgj/m
         njgPQx05/+bQs2ZjQFg7JX6WWyyh8Vv5tZTPu7NJb858chXhsscQCregZlo46+aupoim
         i5jQ==
X-Received: by 10.204.60.203 with SMTP id q11mr334201bkh.156.1390582278410;
        Fri, 24 Jan 2014 08:51:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kk3sm3228414bkb.12.2014.01.24.08.51.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 08:51:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bee33fbfe83408a69085d58db302b3e72edf16a4.1390574981.git.brad.king@kitware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241014>

Hi,

Brad King wrote:

> Add test cases that use 'merge-recursive' plumbing with a temporary
> index and empty work tree.  Populate the index using 'read-tree' and
> 'update-index --ignore-missing --refresh' to prepare for merge without
> actually checking all files out to disk.  Verify that each merge
> produces its expected tree while displaying no error diagnostics.

Following my usual review practice of lazy reading for the sake of
readers in the future who might be in a hurry, it's not clear what
problem these tests are solving or trying to detect.  Could you start
with a quick summary of the symptoms and when it came up?

The commit message doesn't need to paraphrase the actual code, since
anyone curious about the details can always look at the code.  It's
more important to explain the motivation and intended effect so people
can understand what went wrong if something ends up being broken by a
later patch.

> This approach can be used to compute tree merges while checking out only
> conflicting files to disk (which is useful for server-side scripts).
> Prior to commit 5b448b85 (merge-recursive: When we detect we can skip an
> update, actually skip it, 2011-08-11) this worked cleanly in all cases.

Do you mean something like the following?

	Sometimes when working with a large repository it can be useful to
	try out a merge and only check out conflicting files to disk (for
	example as a speed optimization on a server).  Until v1.7.7-rc1~28^2~20
	(merge-recursive: When we detect we can skip an update, actually
	skip it, 2011-08-11), it was possible to do so with the following
	idiom:

		... summary of commands here ...

	Nowadays, that still works and the exit status is the same,
	but merge-recursive produces a diagnostic if "our" side renamed
	a file:

		error: addinfo_cache failed for path 'dst'

	Add a test to document this regression.

[...]
> +++ b/t/t3030-merge-recursive.sh
[...]
> @@ -517,6 +518,52 @@ test_expect_success 'reset and bind merge' '
>  
>  '
>  
> +test_expect_failure 'merge-recursive w/ empty work tree - ours has rename' '
> +	(
> +	 GIT_WORK_TREE="$PWD/ours-has-rename-work" &&

Elsewhere in the test, commands in a subshell are indented by another
tab, so these new tests should probably follow suit.  As a side
effect, that makes the indentation easier to see.

Hope that helps,
Jonathan
