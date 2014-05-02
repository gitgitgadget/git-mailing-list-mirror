From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: #178  parsing of pretty=format:"%an %ad" causes fatal: bad
 revision '%ad'
Date: Fri, 2 May 2014 10:22:56 -0700
Message-ID: <20140502172256.GH9218@google.com>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mysgit@googlegroups.com
To: Dave Bradley <dbradley2@bell.net>
X-From: git-owner@vger.kernel.org Fri May 02 19:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgHAt-0001Yf-T6
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 19:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbaEBRXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 13:23:00 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34210 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbaEBRW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 13:22:59 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so5364988iec.34
        for <git@vger.kernel.org>; Fri, 02 May 2014 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RUObQnCNz9yPBJ04rcm3rKUE2cG6rljeEUIG6ajEvQA=;
        b=reT/8LHWDxEiqDB7QTl5Ucf0fLWhNvwnh5Lz+hcLv+/gBAihErjFt+6WYOIssnZXgC
         FILTQQXE1TVOCHkndaz0TyIdUHuK4rI8Dc3gC/jGGd83L4oG2aeDLsGKDph3O0CLdaoR
         NqJd5jiSSPsABT7Y56wuPob7ybLty84dRu6FEG3iHf1Y6rU/ZL5CfN4gsKJqPWdO/Z4g
         C7qztu//LIlRupTSc1iSdTK1HO0mB5XEh87ogChkv60xEadFGl0WBDj2rhZlhKwzPzU7
         1amGRJVYdDIulnpoVkcnCVYAQOkXoV+V5YJuDLyhgk1Iy1kmsyCN+Ip53QQh1fHCbIOr
         rDjw==
X-Received: by 10.50.79.226 with SMTP id m2mr6112077igx.11.1399051378793;
        Fri, 02 May 2014 10:22:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id p4sm8457438igy.7.2014.05.02.10.22.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 10:22:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247946>

Hi Dave,

Dave Bradley wrote:

> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all --pretty=format:"%an %ad" -- pom.xml
> xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
> xxxx xxxx Mon Nov 23 02:42:24 2009 +0000
>
> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all "--pretty=format:"%an %ad"" -- pom.xml
> fatal: bad revision '%ad'

On Linux, this example gets passed to git as six arguments:

	log
	--all
	--pretty=format:%an
	%ad
	--
	pom.xml

I think the intent was instead to pass five arguments (the third being
'--pretty=format:%an %ad').  That means you shouldn't unquote before
the space, or in other words that the space should be part of a quoted
argument.

On Windows, I believe the argument passing convention is more
complicated.  Programs can inspect the entire command line if they
want to.  But there's still an ambiguity in the command you passed: if
I look at space-separated or double-quoted parts of the command line,
it looks like

	git
	log
	--all
	"--pretty=format:"
	(no space)
	%an
	%ad
	(no space)
	""
	--
	pom.xml

What's the right way to parse this?  How can git tell whether %an %ad
were meant to be separate arguments or not?  In absence of a stronger
convention I suspect the simplest rule is to mimic what a Unix shell
does, where they are separate arguments because the space is not
quoted.

Cc-ing Windows folks in case they have more insight.

Thanks and hope that helps,
Jonathan
