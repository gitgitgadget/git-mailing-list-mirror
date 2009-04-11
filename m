From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v6 14/14] difftool/mergetool: refactor commands to use
	git-mergetool--lib
Date: Sat, 11 Apr 2009 13:00:40 +0100
Message-ID: <20090411120040.GA10381@hashpling.org>
References: <1239175040-28974-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 14:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsbuf-0008VB-AO
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 14:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbZDKMAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbZDKMAr
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 08:00:47 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:52883 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753230AbZDKMAq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 08:00:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAJcj4EnUnw6T/2dsb2JhbADJY4I+gT4G
Received: from ptb-relay03.plus.net ([212.159.14.147])
  by relay.pcl-ipout02.plus.net with ESMTP; 11 Apr 2009 13:00:41 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1Lsbt2-0005Mi-Uv; Sat, 11 Apr 2009 13:00:41 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n3BC0eur011197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 13:00:40 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n3BC0ehY011196;
	Sat, 11 Apr 2009 13:00:40 +0100
Content-Disposition: inline
In-Reply-To: <1239175040-28974-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 3a89e5681aae0c59c467178c9d77adbe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116294>

On Wed, Apr 08, 2009 at 12:17:20AM -0700, David Aguilar wrote:

Finally, I've got around to some git work...

> diff --git a/Documentation/git-mergetool--lib.txt
> b/Documentation/git-mergetool--lib.txt
> new file mode 100644
> index 0000000..3d57031
> --- /dev/null
> +++ b/Documentation/git-mergetool--lib.txt

--- snip ---

> +
> +run_merge_tool::
> +	launches a merge tool given the tool name and a true/false
> +	flag to indicate whether a merge base is present.
> +	'$merge_tool', '$merge_tool_path', and for custom commands,
> +	'$merge_tool_cmd', must be defined prior to calling
> +	run_merge_tool.  Additionally, '$MERGED', '$LOCAL', '$REMOTE',
> +	and '$BASE' must be defined for use by the merge tool.

Reading this function it doesn't look like the variable $merge_tool is
actually used, only the first parameter which should be the same
thing. Also, TOOL_MODE is used and is important so should probably be
documented here instead.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> new file mode 100644
> index 0000000..c5db24e
> --- /dev/null
> +++ b/git-mergetool--lib.sh 

--- snip ---

> +get_merge_tool_path () {
> +	# A merge tool has been set, so verify that it's valid.
> +	if ! valid_tool "$merge_tool"; then
> +		echo >&2 "Unknown merge tool $merge_tool"
> +		exit 1
> +	fi
> +	if diff_mode; then
> +		merge_tool_path=$(git config difftool."$merge_tool".path)
> +	fi
> +	if test -z "$merge_tool_path"; then
> +		merge_tool_path=$(git config mergetool."$merge_tool".path)
> +	fi
> +	merge_tool_path="$(translate_merge_tool_path "$merge_tool" "$merge_tool_path")"
> +	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
> +		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as '$merge_tool_path'"
> +		exit 1
> +	fi
> +	echo "$merge_tool_path"
> +}

I just wanted to double check that we supported finding tools in the
path with merge.$tool.path unset (it should just work), so I had a
quick play and got some really wierd results. Please tell me if just
sourcing git-mergetool--lib isn't just going to work.

>From a non-X session:

    $ git config -l | grep 'merge\.\?tool'; get_merge_tool; get_merge_tool_path
    mergetool.p4merge.cmd=echo /"$BASE"/ /"$REMOTE"/ /"$LOCAL"/ /"$MERGED"/
    merge tool candidates: kompare emerge vimdiff
    vimdiff
    vim

>From an X session:

    mergetool.p4merge.cmd=echo /"$BASE"/ /"$REMOTE"/ /"$LOCAL"/ /"$MERGED"/
    merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff kompare gvimdiff diffuse ecmerge emerge vimdiff
    kdiff3
    vim

I'm not quite sure what's going on here.


> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index cceebb7..efa31a2 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh

--- big snip to: @@ merge_file () {

> +    present=false
> +    base_present &&
> +    present=true

I'm not sure why, but from a style point of view, this seemed a bit
inconsistent from the rest of mergetool and grated with me a bit.

I think I'd prefer

if base_present; then
    present=false
else
    present=true
fi

or even:

present=$(base_present && echo true || echo false)

Really, really minor stlye point, though.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
