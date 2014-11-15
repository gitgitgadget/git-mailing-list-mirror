From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Sat, 15 Nov 2014 13:06:04 +0100
Message-ID: <546741AC.9030107@web.de>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu> <1416036379-4994-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:06:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpc7U-00063L-8Y
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 13:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbaKOMGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 07:06:11 -0500
Received: from mout.web.de ([212.227.15.4]:55560 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbaKOMGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 07:06:10 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MWirL-1XUyzV1iSB-00XuRh; Sat, 15 Nov 2014 13:06:06
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1416036379-4994-2-git-send-email-mhagger@alum.mit.edu>
X-Provags-ID: V03:K0:FkWZY/x37WBJwHcJUS16tuz0g3Uw4NWAHCKy2ColthdzEaH8F4W
 sCfENgGAHVgRq3jpTosPNsKq6NZj4gnu1z3/7X9CbbGHrgQComAhfnM+NXNigCJ/YNrmRd4
 C/c9/qXI/6i0u4UL+gu+6N4W4uOACepqIU6PM1xyHvCkx8aDvINwgyiu9K2KlW1+qtYsxqc
 oRrtMdgu90YChxNohbd2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-15 08.26, Michael Haggerty wrote:
The whole thing looks good to me, some minor comments below
> git_config_set() copies the permissions from the old config file to
> the new one. This is a good change in and of itself, but it interacts
> badly with create_default_files()'s sloppiness, causing "git init" to
> leave the executable bit set on $GIT_DIR/config.
> 
> So change create_default_files() to reset the permissions on
s/permissions/executable bit/ ?
> $GIT_DIR/config after its test.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/init-db.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 56f85e2..95ca5e4 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -255,6 +255,7 @@ static int create_default_files(const char *template_path)
>  		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>  				!lstat(path, &st2) &&
>  				st1.st_mode != st2.st_mode);
> +		chmod(path, st1.st_mode);
A "blind" chmod() is good, but I think checking the return code is better.

                filemode &= (!chmod(path, st1.st_mode));

>  	}
>  	git_config_set("core.filemode", filemode ? "true" : "false");
>   
