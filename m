From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 10/11] vcs-svn,svn-fe: add --incremental option
Date: Mon, 25 Jul 2011 23:35:26 +0200
Message-ID: <20110725213526.GB8708@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-11-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:35:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlSoM-0004KP-7v
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab1GYVfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:35:34 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:41575 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab1GYVfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 17:35:32 -0400
Received: by eye22 with SMTP id 22so3936569eye.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TljXNS/qy1zDjdA4gYrCYqlHck/KrYAteKc59iqFW3g=;
        b=i18W9dXuibzchZplzypjIeAkd4Dt44kcK4qsxqPtXhIpAkgO4rSKb2rKaVHWugU/Az
         D5kpaBHFvum8iYgZIs7X1BwdNHIrDo7AuHN1/miz04StGqM9eeQ6EWuth12vW+f1rhsK
         v6phaI+MjMQQkc9pJS7zvLRKNB9VijElIVE8c=
Received: by 10.213.106.20 with SMTP id v20mr1751960ebo.121.1311629731504;
        Mon, 25 Jul 2011 14:35:31 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id 16sm695983eei.13.2011.07.25.14.35.28
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 14:35:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-11-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177820>

Dmitry Ivankov wrote:

> This option is to make svn-fe write commits on top of the existing ref
> instead of overwriting it. More precise, the first commit's parent is
> set to be :(first_revision_in_current_dump - 1) mark.
>
> Prerequisite is to (re)use import marks (from previous imports). It is
> safe to use this option on a svn dump that starts with r0/r1. The svn
> dump itself should be incremental too.

In other words, this allows running svn-fe to resume a partial import or
to resume an import after the remote repository has added more history.
Hoorah!

[...]
> +	try_dump_ext "--incremental" "" "--export-marks=./marks" emptyprop.dump &&
> +	test_line_count = 2 ./marks &&
> +
> +	try_dump_ext "--incremental" "" "--import-marks=./marks --export-marks=./marks" moreempty.dump &&
> +	test_line_count = 3 ./marks &&

It should be possible to avoid this extra argument by making "reinit_git"
remove the marks file and using something like

	git fast-import --import-marks-if-exists=marks --export-marks=marks

> --- a/test-svn-fe.c
> +++ b/test-svn-fe.c
> @@ -22,6 +22,9 @@ static struct option test_svnfe_options[] = {
>  	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
>  	OPT_STRING(0, "ref", &args.ref, "dst_ref",
>  		"write to dst_ref instead of refs/heads/master"),
> +	OPT_BIT(0, "incremental", &args.incremental,
> +		"resume export, requires marks and incremental dump",
> +		1),

Why OPT_BIT?

Hope that helps,
Jonathan
