From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] format-patch: page output with --stdout
Date: Mon, 22 Nov 2010 12:15:01 -0600
Message-ID: <20101122181501.GF2084@burratino>
References: <1290229542-3116-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 19:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKavF-0003ee-Le
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 19:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037Ab0KVSPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 13:15:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46682 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025Ab0KVSPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 13:15:07 -0500
Received: by mail-vw0-f46.google.com with SMTP id 13so3580654vws.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 10:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pQmOAuIXbbKXjUqH/2/G42FCP2WB2EqFYY8XIBfSM/M=;
        b=jT8XxICn3iyRreNjiQ06lnZt3as0g+YKQcQ9zgy1kuO0rV3cGI40aPOWz1IdJSBvi4
         aLkrrC+ekO0a+xGlKU2XNN5ig8wqGXVNoOLKUg99dlX8BVrD+o+PSbd5y+ucDtJ3IXob
         PF0fSg6O6AMBoatkc70ZtXJOqc0RMb4HlRItk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PSDFqSMFsIZvLeuymlivheSuv08jakhqavN1ZP/Uy0+Kp8Qh9NbEVfFcliLvUvrkvr
         Znv7J0qOHjLSrWhxdkPsfOyqYjYjWFSEJohDkk+z1LaBQgfuSpZVYCxL05ODKFOnb4kB
         FYwHhVQlGFRTcVQU9h9MXR61nvcXjoJGkC/60=
Received: by 10.220.188.193 with SMTP id db1mr482806vcb.246.1290449706413;
        Mon, 22 Nov 2010 10:15:06 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j21sm1060444vcr.10.2010.11.22.10.15.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 10:15:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290229542-3116-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161907>

Tay Ray Chuan wrote:

> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1159,6 +1159,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  
>  	if (!use_stdout)
>  		output_directory = set_outdir(prefix, output_directory);
> +	else
> +		setup_pager();

Since it can be disabled with

	[pager]
		format-patch = false

this looks reasonable to me.  Maybe a test to that effect would
help, something like this?

 test_expect_success TTY 'format-patch --stdout paginates' '
	rm -f pager_used &&
	(
		GIT_PAGER="wc >pager_used" &&
		export GIT_PAGER &&
		test_terminal git format-patch --stdout --all
	) &&
	test_path_is_file pager_used
 '

 test_expect_success TTY 'format-patch --stdout pagination can be disabled' '
	rm -f pager_used &&
	(
		GIT_PAGER="wc >pager_used" &&
		export GIT_PAGER &&
		test_terminal git --no-pager format-patch --stdout --all &&
		test_terminal git -c "pager.format-patch=false" format-patch --stdout --all
	) &&
	test_path_is_missing pager_used &&
	test_path_is_missing .git/pager_used
 '
