From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Introduce the function strip_path_suffix()
Date: Wed, 18 Feb 2009 20:39:19 +0100
Message-ID: <499C63E7.5040306@kdbg.org>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <7b5ee74d497bbb7144b8683725cd83c8bbd33f9a.1234969572u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZsIE-0000Ro-Pa
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 20:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbZBRTjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 14:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZBRTjq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 14:39:46 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:9232 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbZBRTjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 14:39:46 -0500
Received: from [77.119.118.150] (77.119.118.150.wireless.dyn.drei.com [77.119.118.150])
	by bsmtp.bon.at (Postfix) with ESMTP id C14412C4012;
	Wed, 18 Feb 2009 20:39:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7b5ee74d497bbb7144b8683725cd83c8bbd33f9a.1234969572u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110571>

Johannes Schindelin schrieb:
> The function strip_path_suffix() will try to split the given path into
> prefix/suffix.  The suffix has to be passed to the function, and if the
> path matches, the prefix is set.
> 
> Arbitrary runs of directory separators ("slashes") are assumed identical.
> 
> Example:
> 
> 	strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
> 		"libexec///git-core", &prefix)
> 
> will set prefix to "C:\\msysgit" and return 0.

But you implemented it so that prefix is actually "C:\\msysgit/\\" 
(unless, of course, I'm reading the code wrong).

> +/* sets prefix if the suffix matches */
> +int strip_path_suffix(const char *path, const char *suffix, const char **prefix)

For a general purpose function, the API is very unnatural (and geared 
towards its only user in patch 2/2). I'd expect that the return value is 
the result or NULL on failure.

I would not raise this concern if this were a static function near its 
only call site.

> +{
> +	int path_len = strlen(path), suffix_len = strlen(suffix);
> +
> +	while (suffix_len) {
> +		if (!path_len)
> +			return 1;
> +
> +		if (is_dir_sep(path[path_len - 1])) {
> +			if (!is_dir_sep(suffix[suffix_len - 1]))
> +				return 1;
> +			path_len = chomp_trailing_dir_sep(path, path_len);
> +			suffix_len = chomp_trailing_dir_sep(suffix, suffix_len);
> +		}
> +		else if (path[--path_len] != suffix[--suffix_len])
> +			return 1;
> +	}
> +
> +	if (path_len && !is_dir_sep(path[path_len - 1]))
> +		return 1;

Should strip_path_suffix("foo/bar", "foo/bar", &prefix) succeed and 
prefix be the empty string? This implementation says it should be so. 
That's just a question...

> +	*prefix = xstrndup(path, chomp_trailing_dir_sep(path, path_len));
> +	return 0;
> +}

-- Hannes
