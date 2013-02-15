From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Sat, 16 Feb 2013 01:30:58 +0700
Message-ID: <CACsJy8A6oBjbaX=3iQcSxcwed28KLTk_tN+iuWDLsC512Z2V1Q@mail.gmail.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com> <7vd2w1wmdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6Q4g-0002HZ-Te
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 19:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab3BOSba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 13:31:30 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:45393 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab3BOSb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 13:31:29 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so3865503obc.27
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0jxLflX6sxjSK17OaVzOshuEo2+WThOTcnB3hKooPPc=;
        b=iepqykV30mTcwV6Cw8BKuqDNQ7ctICo2tk1DykcYhl9F95Atpk/ok0BveufQMxiDFd
         VCuJPv/TzZ/9Rm9QJ0QjM4D8dnSaQMI8fcrcfjZ3hK6lAQz1UcGdaQS3y2iP4fC5NoMi
         OXbVtJLcJT1hak4z1hiCFMlEBAP8uTHv2/mdTKLq5yT1R9oftmxIaS6BHxVZ+Yo6qFE/
         s6CYVMDIE3tlUcci+lHgjIMJMqjMlE5g1Y8Xc1XlGzhSNtqtkMUb3lz9ULv/Izipxqtq
         IRkty8MwTRIeYdsddRPa4DOgehaml5m2th549ta/f0DJ4zd7kDLf+wFrOenm9GdL4Ovv
         GMyQ==
X-Received: by 10.60.5.231 with SMTP id v7mr2454417oev.62.1360953088975; Fri,
 15 Feb 2013 10:31:28 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Fri, 15 Feb 2013 10:30:58 -0800 (PST)
In-Reply-To: <7vd2w1wmdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216350>

On Fri, Feb 15, 2013 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In the current code, we always check if a path is excluded, and when
> dealing with DT_REG/DT_LNK, we call treat_file():
>
>  * When such a path is excluded, treat_file() returns true when we
>    are not showing ignored directories. This causes treat_one_path()
>    to return path_ignored, so for excluded DT_REG/DT_LNK paths when
>    no DIR_*_IGNORED is in effect, this change is a correct
>    optimization.
>
>  * When such a path is not excluded, on the ther hand, and when we
>    are not showing ignored directories, treat_file() just returns
>    the value of exclude_file, which is initialized to false and is
>    not changed in the function.  This causes treat_one_path() to
>    return path_handled.  However, the new code returns path_ignored
>    in this case.
>
> What guarantees that this change is regression free?

If you consider read_directory_recursive alone, there is a regression.
The return value of r_d_r depends on path_handled/path_ignored. With
this patch, the return value will be different. The return value is
only used by treat_directory() in two cases:

 - when DIR_SHOW_IGNORED is set, which disables the optimization so no
regression

 - when DIR_HIDE_EMPTY_DIRECTORIES is _not_ set (and neither is
DIR_SHOW_IGNORED), the optimization is still on and different r_d_r's
return value would lead to different behavior. However I don't think
it can happen.

treat_directory checks if the given directory can be found in index.
In that case the neither r_d_r calls in treat_directory is reachable.
If the given directory cannot be found in the index, the second r_d_r
is reachable. But then the cache_name_exists() in the patch should
always be false (parent not in index, children cannot), so the
optimization is off and r_d_r returns correctly.

It's a bit tricky. I'm not sure if I miss anything else.

> I do not seem
> to be able to find anything that checks if the path is already known
> to the index in the original code for the case you special cased
> (i.e. DIR_*_IGNORED is not set and dtype is not DT_DIR).  Do all the
> callers that reach this function in their callgraph, when they get
> path_ignored for a path in the index, behave as if the difference
> between path_ignored and path_handled does not matter?
-- 
Duy
