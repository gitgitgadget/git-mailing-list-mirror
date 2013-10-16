From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Wed, 16 Oct 2013 12:24:13 -0700
Message-ID: <20131016192412.GK9464@google.com>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Oct 16 21:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWWhq-0000pm-42
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 21:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761480Ab3JPTYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 15:24:18 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42035 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761288Ab3JPTYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 15:24:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so1518405pab.25
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DUgGaQUUzJlGbQX0A+kDJrcY6VZ2c5w4nEiRgffM7a8=;
        b=gD+AzQiQ4FLxMlhh2NokqzW7zkEvNPEMZtKTDmHg+YUq0E7cxfVNUNRrkklBgAsHN7
         kIk7zp4Wnc8JE1c+yUR7ZX7EVCV+gLVJODFAtC/4GZNxxYQGBzpa0XeV4Hk3XaVU4VB5
         A9HoPG0Pqcr/DqG8bPTvWtD2SPUmMWCdpI8YEmcR+yUBXwlhmZxc2zwe0TxQK6cygz6v
         oOZrJ4NBpPkSQ5dwg0ltSRMGB01nk5ho81CW2BC7O9Xy+shPUnb3wiRxOmctrpzNuCn9
         z5acNpJb7aIV8MNxuJ/sqJc0SEesCnDmIbsqzFBoQPCuokpmhVcdQ6GX3+aX7UJ9c4JZ
         chww==
X-Received: by 10.68.197.73 with SMTP id is9mr4427028pbc.75.1381951455788;
        Wed, 16 Oct 2013 12:24:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xv2sm92824356pbb.39.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 12:24:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236253>

Hi,

John Keeping wrote:

>                                    Since commit d44e712 (pull: support
> rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
> chosen the most recent reflog entry which is an ancestor of the current
> branch if it can find one.
>
> Change rebase so that it uses the same logic.

Nice idea.

Could pull be made to rely on rebase for this as a follow-up?

[...]
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -437,6 +437,14 @@ then
>  			error_on_missing_default_upstream "rebase" "rebase" \
>  				"against" "git rebase <branch>"
>  		fi
> +		for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
> +		do
> +			if test "$reflog" = "$(git merge-base "$reflog" HEAD)"

"git merge-base --is-ancestor" is faster.

What should happen if HEAD is not a valid commit?  (Tested with:

	$ git checkout --orphan foo
	$ cat >>.git/config <<EOF
	[branch "foo"]
		remote = origin
		merge = refs/heads/master
	EOF
	$ bin-wrappers/git rebase 2>&1 | wc -l
	83

).

diff --git i/git-rebase.sh w/git-rebase.sh
index fd36cf7..d2e2c2e 100755
--- i/git-rebase.sh
+++ w/git-rebase.sh
@@ -439,7 +439,7 @@ then
 		fi
 		for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
 		do
-			if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
+			if git merge-base --is-ancestor "$reflog" HEAD
 			then
 				upstream_name=$reflog
 				break
