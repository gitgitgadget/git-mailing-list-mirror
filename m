From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 09:50:50 +0200
Message-ID: <87zjsif50l.fsf@linux-k42r.v.cablecom.net>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jharrod LaFon <jlafon@eyesopen.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 09:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAEoG-00010d-32
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 09:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab3HPHuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 03:50:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33490 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab3HPHux (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 03:50:53 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 16 Aug
 2013 09:50:47 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 16 Aug 2013 09:50:50 +0200
In-Reply-To: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com> (Jharrod
	LaFon's message of "Thu, 15 Aug 2013 18:51:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232401>

Jharrod LaFon <jlafon@eyesopen.com> writes:

> Git fails due to a segmentation fault if a submodule path is empty.
> Here is an example .gitmodules that will cause a segmentation fault:
> [submodule "foo-module"]
>     path
>     url = http://host/repo.git
> $ git status
> Segmentation fault (core dumped)

Can you turn this into a test to guard against the bug reappearing?

> This occurs because in the function parse_submodule_config_option, the
> variable 'value' is assumed not to be null, and when passed as an
> argument to xstrdup a segmentation fault occurs if it is indeed null.
> This is the case when using the .gitmodules example above.
>
> This patch addresses the issue by returning from the function if
> 'value' is null before the call to xstrdup is made.
>
> Signed-off-by: Jharrod LaFon <jlafon <at> eyesopen.com>
> ---
>  submodule.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 1821a5b..880f21b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -130,7 +130,7 @@ int parse_submodule_config_option(const char *var, const char *value)
>  	const char *name, *key;
>  	int namelen;
>  
> -	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
> +	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name || !value)
>  		return 0;
>  
>  	if (!strcmp(key, "path")) {

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
