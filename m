From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 2/2] Teach "guilt graph" the "-x exclude-pattern" option.
Date: Fri, 23 Jan 2015 09:49:13 -0500
Message-ID: <20150123144913.GI101465@meili.jeffnet.31bits.net>
References: <1422022867-7908-1-git-send-email-cederp@opera.com>
 <1422022867-7908-3-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:49:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfY0-0003pV-Jd
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbbAWOtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:49:17 -0500
Received: from josefsipek.net ([71.174.113.7]:1676 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbbAWOtP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:49:15 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 6FCFA55654;
	Fri, 23 Jan 2015 09:49:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422022867-7908-3-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262939>

On Fri, Jan 23, 2015 at 03:21:07PM +0100, Per Cederqvist wrote:
> Some projects keep a ChangeLog which every commit modifies.  This
> makes the graph a very uninteresting single line of commits.  It is
> sometimes useful to see how the graph would look if we ignore the
> ChangeLog file.
> 
> The new -x option is useful in situations like this.  It can be
> repeated several times to ignore many files.  Each argument is saved
> to a temporary file and "grep -v -f $TEMPORARY" is used to filter out
> the file names you want to ignore.

Cool idea.

> Also added a minimal test case and documentation.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  Documentation/guilt-graph.txt |  5 +++++
>  guilt-graph                   | 24 ++++++++++++++++++------
>  regression/t-033.out          | 12 ++++++++++++
>  regression/t-033.sh           |  3 +++
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/guilt-graph.txt b/Documentation/guilt-graph.txt
> index f43206e..eeed321 100644
> --- a/Documentation/guilt-graph.txt
> +++ b/Documentation/guilt-graph.txt
> @@ -16,6 +16,11 @@ patches.
>  
>  OPTIONS
>  -------
> +-x <pattern>::
> +	Ignore files that matches the given grep pattern. Can be
> +	repeated to ignore several files. This can be useful to ignore
> +	for instance ChangeLog files that every commit modifies.
> +
>  <patchname>::
>  	Instead of starting with the topmost applied patch, start with
>  	<patchname>.
> diff --git a/guilt-graph b/guilt-graph
> index d90c2f1..4d5fe46 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -3,7 +3,7 @@
>  # Copyright (c) Josef "Jeff" Sipek, 2007-2013
>  #
>  
> -USAGE="[<patchname>]"
> +USAGE="[-x exclude-pattern]... [<patchname>]"
>  if [ -z "$GUILT_VERSION" ]; then
>  	echo "Invoking `basename "$0"` directly is no longer supported." >&2
>  	exit 1
> @@ -11,6 +11,22 @@ fi
>  
>  _main() {
>  
> +cache="$GUILT_DIR/$branch/.graphcache.$$"
> +xclude="$GUILT_DIR/$branch/.graphexclude.$$"
> +trap "rm -rf \"$cache\" \"$xclude\"" 0
> +mkdir "$cache"
> +>"$xclude"
> +
> +while [ $# -gt 0 ]; do
> +    if [ "$1" = "-x" ] && [ $# -ge 2 ]; then
> +	echo "$2" >> "$xclude"
> +	shift
> +	shift
> +    else
> +	break
> +    fi

Spaces used for indentation.  Otherwise looks good.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

> +done
> +
>  if [ $# -gt 1 ]; then
>  	usage
>  fi
> @@ -39,10 +55,6 @@ getfiles()
>  	git diff-tree -r "$1^" "$1" | cut -f2
>  }
>  
> -cache="$GUILT_DIR/$branch/.graphcache.$$"
> -mkdir "$cache"
> -trap "rm -rf \"$cache\"" 0
> -
>  disp "digraph G {"
>  
>  current="$top"
> @@ -66,7 +78,7 @@ while [ "$current" != "$base" ]; do
>  	rm -f "$cache/dep"
>  	touch "$cache/dep"
>  
> -	getfiles $current | while read f; do
> +	getfiles $current | grep -v -f "$xclude" | while read f; do
>  		# hash the filename
>  		fh=`echo "$f" | sha1 | cut -d' ' -f1`
>  		if [ -e "$cache/$fh" ]; then
> diff --git a/regression/t-033.out b/regression/t-033.out
> index c120d4f..1ed371f 100644
> --- a/regression/t-033.out
> +++ b/regression/t-033.out
> @@ -88,3 +88,15 @@ digraph G {
>  	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
>  	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
>  }
> +%% The same graph, but excluding deps introduced by file.txt.
> +% guilt graph -x file.txt
> +digraph G {
> +# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
> +	"bc7df666a646739eaf559af23cab72f2bfd01f0e" [label="a-\"better&quicker'-patch.patch"]
> +# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
> +	"891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
> +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
> +	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
> +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> +	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
> +}
> diff --git a/regression/t-033.sh b/regression/t-033.sh
> index 9fe1827..ae22914 100755
> --- a/regression/t-033.sh
> +++ b/regression/t-033.sh
> @@ -59,3 +59,6 @@ cmd git add file.txt
>  cmd guilt refresh
>  fixup_time_info "a-\"better&quicker'-patch.patch"
>  cmd guilt graph
> +
> +echo "%% The same graph, but excluding deps introduced by file.txt."
> +cmd guilt graph -x file.txt
> -- 
> 2.1.0
> 

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
