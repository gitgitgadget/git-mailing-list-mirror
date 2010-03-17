From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Add support for GIT_ONE_FILESYSTEM
Date: Wed, 17 Mar 2010 07:45:50 +0700
Message-ID: <fcaeb9bf1003161745j17d13a8dv248d169276777c8a@mail.gmail.com>
References: <1268777101-22122-1-git-send-email-lars@pixar.com>
	 <1268777101-22122-3-git-send-email-lars@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 01:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrhWW-0004ds-8j
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 01:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824Ab0CQAyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 20:54:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:55635 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab0CQAyC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 20:54:02 -0400
Received: by qw-out-2122.google.com with SMTP id 8so109256qwh.37
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Gfu11z4NfXk0zaLVgvRmjFWrRi8WXeB41S+GXCbHHx0=;
        b=RlvHm32sYWzZ8ZSbEiMpvzXrVyN7XS6AmPrmS5MV1c4x/Y+YHHaLautKJaZl1/ofus
         E98aUv3lyY5rAv0D8dxgLHmYfZW7+g/Af/e8kiOMjHNcsQYu+BIbufEE0jcs6vyVCms0
         C7hI+RYm9rLaDKdG/s9xtQMcj6FQ/l3Y5H8So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aEkvDY1U350yXbcOr08zx+KLouVhglSqxnHu7h4TuY1VHVQIUgEKEsQuLzQ0ZLkkrn
         mOI3AvTBOnKB+9bWSBT0+7s1/OupqsyOenYk8VJPX+3GfMIjI4d4u2sZrW5OSrYxykll
         WnAdrkOqubjg2SNL3Ru8ufJ4rHTUnrlgdq+JQ=
Received: by 10.229.250.2 with SMTP id mm2mr98100qcb.165.1268786750494; Tue, 
	16 Mar 2010 17:45:50 -0700 (PDT)
In-Reply-To: <1268777101-22122-3-git-send-email-lars@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142361>

On 3/17/10, Lars R. Damerow <lars@pixar.com> wrote:
>  @@ -422,6 +429,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                         }
>                         die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
>                 }
>  +               if (one_filesystem) {
>  +                       if (stat("..", &buf))
>  +                               die_errno("failed to stat '%s/..'", getcwd(err_cwd, sizeof(err_cwd)-1));
>  +                       if (buf.st_dev != current_device)
>  +                               die("Not a git repository (or any parent up to %s/..)\n"
>  +                                       "Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.",
>  +                                       getcwd(err_cwd, sizeof(err_cwd)-1));
>  +               }
>                 if (chdir(".."))
>                         die_errno("Cannot change to '%s/..'", cwd);
>         }

It should not die() if nongit_ok != NULL (gentle mode). Maybe
something like this on top:

diff --git a/setup.c b/setup.c
index 500c03e..625fb35 100644
--- a/setup.c
+++ b/setup.c
@@ -499,10 +499,17 @@ static const char
*setup_git_directory_gently_1(int *nongit_ok)
 		if (one_filesystem) {
 			if (stat("..", &buf))
 				die_errno("failed to stat '%s/..'", getcwd(err_cwd, sizeof(err_cwd)-1));
-			if (buf.st_dev != current_device)
+			if (buf.st_dev != current_device) {
+				if (nongit_ok) {
+					if (chdir(cwd))
+						die_errno("Cannot come back to cwd");
+					*nongit_ok = 1;
+					return NULL;
+				}
 				die("Not a git repository (or any parent up to %s/..)\n"
 					"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.",
 					getcwd(err_cwd, sizeof(err_cwd)-1));
+			}
 		}
 		if (chdir(".."))
 			die_errno("Cannot change to '%s/..'", cwd);

Another thing. Is err_cwd needed? I think "cwd" can be used, like
die_errno("Cannot change to %s/..", cwd) above. Hmm.. that die_errno
needs "cwd[offset] = '\0';" first. Maybe you can fix it too ;-)
-- 
Duy
