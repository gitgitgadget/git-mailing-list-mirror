From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Fri, 27 Jan 2012 06:07:33 +0100
Message-ID: <4F223115.3050004@alum.mit.edu>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126073752.GA30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqe2N-0003vz-H2
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2A0FHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:07:43 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45814 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2A0FHm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:07:42 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEB790.dip.t-dialin.net [84.190.183.144])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0R57XD6023010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Jan 2012 06:07:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <20120126073752.GA30474@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189189>

On 01/26/2012 08:37 AM, Jeff King wrote:
> [...]
> This patch introduces an include directive for config files.
> It looks like:
> 
>   [include]
>     path = /path/to/file

I like it.

> diff --git a/cache.h b/cache.h
> index 10afd71..21bbb0a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1138,6 +1138,12 @@ extern const char *get_commit_output_encoding(void);
>  
>  extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
>  
> +struct git_config_include_data {
> +	config_fn_t fn;
> +	void *data;
> +};
> +int git_config_include(const char *name, const char *value, void *vdata);
> +
>  extern const char *config_exclusive_filename;
>  
>  #define MAX_GITNAME (1000)

How about a short comment or two?

> diff --git a/config.c b/config.c
> index 40f9c6d..a6966c1 100644
> --- a/config.c
> +++ b/config.c
> [...]
> +int git_config_include(const char *name, const char *value, void *vdata)
> +{
> +	const struct git_config_include_data *data = vdata;
> +	const char *type;
> +	int ret;
> +
> +	/*
> +	 * Pass along all values, including "include" directives; this makes it
> +	 * possible to query information on the includes themselves.
> +	 */
> +	ret = data->fn(name, value, data->data);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (prefixcmp(name, "include."))
> +		return ret;
> +	type = strrchr(name, '.') + 1;
> +
> +	if (!strcmp(type, "path"))
> +		ret = handle_path_include(value, vdata);
> +
> +	return ret;
> +}
> +

Doesn't this code accept all keys of the form "include\.(.*\.)?path"
(e.g., "include.foo.path")?  If that is your intention, then the
documentation should be fixed.  If not, then a single strcmp(name,
"include.path") would seem sufficient.

>  int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  {
>  	int ret = 0, found = 0;
>  	const char *home = NULL;
> +	struct git_config_include_data inc;
> +
> +	inc.fn = fn;
> +	inc.data = data;
> +	fn = git_config_include;
> +	data = &inc;
>  
>  	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
>  	if (config_exclusive_filename)

The comment just after your addition should be adjusted, since now "the
given config file and any files that it includes" are read.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
