From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 08:48:43 +0200
Message-ID: <520DCB4B.6090309@web.de>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jharrod LaFon <jlafon@eyesopen.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 08:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VADqB-0005zX-4U
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 08:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196Ab3HPGss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 02:48:48 -0400
Received: from mout.web.de ([212.227.15.3]:57829 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab3HPGsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 02:48:47 -0400
Received: from [192.168.178.41] ([91.3.186.83]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M0yvn-1VxmS10nOx-00v5am for <git@vger.kernel.org>;
 Fri, 16 Aug 2013 08:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:7av0iSkfpNIop7KaouJp8Wrfo3FaAXSyjBEShKBrwvZC5XSRcsw
 eO9PqxGsW6vU9IFiiwD1qI4ygCOuEKBIhOKGbzuuj1zPV7l+fqOIzTpwpd+vLT242B8yHgn
 tqKcAsIFDpqjrX7zd+dzCU9bZGQI64FzOmlKT/KxrSrQx/L+dVeDkyz+5lPbfW1+YzUTWLA
 a1pQhVT7QDYzqixqGXj1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232400>

Am 16.08.2013 03:51, schrieb Jharrod LaFon:
> Git fails due to a segmentation fault if a submodule path is empty.
> Here is an example .gitmodules that will cause a segmentation fault:
> [submodule "foo-module"]
>     path
>     url = http://host/repo.git
> $ git status
> Segmentation fault (core dumped)
> 
> This occurs because in the function parse_submodule_config_option, the
> variable 'value' is assumed not to be null, and when passed as an
> argument to xstrdup a segmentation fault occurs if it is indeed null.
> This is the case when using the .gitmodules example above.

Thanks for digging this up and describing it in a way that makes it
easy to reproduce and understand.

> This patch addresses the issue by returning from the function if
> 'value' is null before the call to xstrdup is made.

Hmm, I'm not sure silently ignoring the misconfiguration is the best
way to go. A submodule config having a path setting without a value
is broken (while a submodule setting without a subsection configures
something else, so the "|| !name" below is fine). So I believe we
should complain to the user when "value" is NULL.

On the other hand this should only happen for the three options we do
parse, as some users (e.g. git-submodule.sh) use other configurations
for which a missing value may be fine. Please see the "lacks value"
errors in read_merge_config() of ll-merge.c for an example of how to
deal with that.

And looking at other users of parse_config_key() I suspect there will
be other configuration options showing the same problem ...

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
> 
