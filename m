From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Sat, 8 Feb 2014 14:36:11 +0700
Message-ID: <CACsJy8CLR4qerWPWs+0TWxnTWidm_VLtYExjKqAOLOSNK0chaA@mail.gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-3-git-send-email-pclouds@gmail.com> <20140206193533.GB14552@sigill.intra.peff.net>
 <20140207234727.GA17520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 08 08:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC2T2-0005qg-EC
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 08:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbaBHHgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 02:36:44 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:47142 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaBHHgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 02:36:43 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so6658924qab.26
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 23:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sc4PmNyT2f3yiKfWcnnRLwgXdUOmJ6B9dueBvsmRDlU=;
        b=FnB8GpvslmHWRyT4NVctX7zK3J2TcEnxJWq/8Spmr2cMPmB6vMUB8yT9COnGMdOhVH
         jsqCJ75g0YddlQ1tBowiRaxkywWc+AKLiwHV1np4G1WdIEI6j1c//pKpu7WzA6n2KGjq
         XXzZXQX5mZmtevRjOnZWR9RFon0O4NKlD2+gJRDHu2FMekR9ub4rjKYamHj60Uz2zRHy
         2ZZrrlq6lDOcBMhD5E4WDxz5GUeThj7QgWz8qNaI2ZCQ3c31+jq8Lt6AZwLRC2IlIDJE
         utT6wUkEpQfh1pkLXJXGDVoAWo8zBL2wob8OCLRizGvDw6sWrw/fo4zPGfeSYhC1TPjk
         pNvQ==
X-Received: by 10.224.19.199 with SMTP id c7mr10092765qab.78.1391845001267;
 Fri, 07 Feb 2014 23:36:41 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 7 Feb 2014 23:36:11 -0800 (PST)
In-Reply-To: <20140207234727.GA17520@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241823>

On Sat, Feb 8, 2014 at 6:47 AM, Jeff King <peff@peff.net> wrote:
> Thinking on this more, I wonder if we should just do something like
> this:
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index bfdff2a..c82b4ee 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -64,7 +64,9 @@ case $(uname) in
>  esac
>
>  LIB_HTTPD_PATH=${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
> -LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'8111'}
> +if test -z "$LIB_HTTPD_PORT"; then
> +       LIB_HTTPD_PORT=${this_test#t}
> +fi
>
>  TEST_PATH="$TEST_DIRECTORY"/lib-httpd
>  HTTPD_ROOT_PATH="$PWD"/httpd
>
> and drop the manual LIB_HTTPD_PORT setting in each of the test scripts.
> That would prevent this type of error in the future, and people can
> still override if they want to.
>
> Any test scripts that are not numbered would need to set it, but we
> should not have any of those (and if we did, the failure mode would be
> OK, as Apache would barf on the bogus port number).

Yes! Next stop, attempt to start httpd at start_httpd regardless of
GIT_TEST_HTTPD. If successful, test_set_prereq HTTPD or something that
the following tests can use. If GIT_TEST_HTTPD is set and start_httpd
fails, error out, not set prereq.
-- 
Duy
