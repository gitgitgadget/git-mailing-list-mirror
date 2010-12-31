From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 1/3] filter-branch: optionally dump all mappings at the end
Date: Fri, 31 Dec 2010 18:09:24 +0100
Message-ID: <201012311809.24205.j6t@kdbg.org>
References: <cover.1293809100.git.trast@student.ethz.ch> <57609f1df897f19becc77d5c43c3c3608725160b.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: jeffrey.freeman@syncleus.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 31 18:10:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYiUf-0005mD-EB
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 18:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab0LaRJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 12:09:27 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:12698 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753216Ab0LaRJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 12:09:26 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 84B10CDF85;
	Fri, 31 Dec 2010 18:09:24 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 466B319F69E;
	Fri, 31 Dec 2010 18:09:24 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <57609f1df897f19becc77d5c43c3c3608725160b.1293809100.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164390>

On Freitag, 31. Dezember 2010, Thomas Rast wrote:
> In some cases, like the sub/super-project filtering attempted in this
> series, it may be necessary to carry over the mappings from one or
> more filter-branch run to another.
>
> As the first part to this, make a --dump-map option that dumps a flat
> text file with lines of the form
>
>   $sha1 $(map $sha1)

Despite the alternative implementation that I suggest below, the commit 
message (and also the documentation to be written) should state the output 
format in this way.

> @@ -194,6 +195,16 @@ do
>  	--original)
>  		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
>  		;;
> +	--dump-map)
> +		case "$OPTARG" in
> +		/*)

Please use

	if is_absolute_path "$OPTARG"
	then
	...

> +# At this point the mappings are stable so we can dump them if
> +# requested
> +
> +if test -n "$dump_map"; then
> +	( cd "$workdir"/../map/; ls ) |
> +	while read sha1; do
> +		echo $sha1 $(map $sha1)

There must be a more efficient way than to spawn an additional process for 
each mapped SHA1. Since this excercises only one branch in the map() function 
anyway, how about this:

	( cd "$workdir"/../map/ && ls -1 ) |
	while read sha1; do
		read mapped << $sha1 &&
		echo $sha1 $mapped
	done > "$dump_map"

Though, there is some mechanism that maps one SHA1s to more than one, and my 
approach might not cover that case.

> +	done > "$dump_map"

-- Hannes
