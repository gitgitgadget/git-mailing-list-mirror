From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 14/14] difftool/mergetool: refactor commands to use
	git-mergetool--lib
Date: Sat, 11 Apr 2009 20:41:27 -0700
Message-ID: <20090412034127.GA1398@gmail.com>
References: <1239175040-28974-1-git-send-email-davvid@gmail.com> <20090411120040.GA10381@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Apr 12 05:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsqbL-0004kO-Ez
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 05:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZDLDlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 23:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbZDLDlp
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 23:41:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:30281 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbZDLDlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 23:41:44 -0400
Received: by wa-out-1112.google.com with SMTP id j5so826569wah.21
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 20:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=csApLjlW77EuHUYAskKkQT9CfFrKcHvq7U2azvwchgo=;
        b=J1H34QisirPoUrBAKoEIoUft1pErYoF+geqFSI8+Rkd8eMpnRJTsXHQQmPLeb0GDSZ
         FVuaiB6VYg35Ux6SVi+PsB0UvWN0LAFsnBzekcdfjJYPtIP78OpOsMh8qwA2gj5F5bDF
         SVQ50Ayk7pV0kK5qhKwX55Da2ZSnjl1Ms81+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BWgdDMxUeG1MvDNXlaZOORREdgdu2qq1aKYhCxFWMnzIdcHomob1uX9I4ATBO2uGCB
         Cv434pVgvKxIvhXsXGnr0O8YeeYT3pdzCJXc5mIrSVEjaI+udu4EdrwvK7p7GB/ikNP2
         Aj/3U4NLQfsDzJQ1zcDtrO0eOB6OHaTHqwa1U=
Received: by 10.114.148.2 with SMTP id v2mr2566904wad.169.1239507703477;
        Sat, 11 Apr 2009 20:41:43 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m25sm3608754waf.44.2009.04.11.20.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 20:41:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090411120040.GA10381@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116366>

On  0, Charles Bailey <charles@hashpling.org> wrote:
> On Wed, Apr 08, 2009 at 12:17:20AM -0700, David Aguilar wrote:
> 
> Finally, I've got around to some git work...
> 
> > diff --git a/Documentation/git-mergetool--lib.txt
> --- snip ---
> > +
> > +run_merge_tool::
> > +	launches a merge tool given the tool name and a true/false
> > +	flag to indicate whether a merge base is present.
> > +	'$merge_tool', '$merge_tool_path', and for custom commands,
> > +	'$merge_tool_cmd', must be defined prior to calling
> > +	run_merge_tool.  Additionally, '$MERGED', '$LOCAL', '$REMOTE',
> > +	and '$BASE' must be defined for use by the merge tool.
> 
> Reading this function it doesn't look like the variable $merge_tool is
> actually used, only the first parameter which should be the same
> thing. Also, TOOL_MODE is used and is important so should probably be
> documented here instead.

Done.
My new patch further removes those pesky globals ;)


> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > new file mode 100644
> > index 0000000..c5db24e
> > --- /dev/null
> > +++ b/git-mergetool--lib.sh 
> 
> --- snip ---
> 
> > +get_merge_tool_path () {
> > +	# A merge tool has been set, so verify that it's valid.
> > +	if ! valid_tool "$merge_tool"; then
> > +		echo >&2 "Unknown merge tool $merge_tool"
> > +		exit 1
> > +	fi
> > +	if diff_mode; then
> > +		merge_tool_path=$(git config difftool."$merge_tool".path)
> > +	fi
> > +	if test -z "$merge_tool_path"; then
> > +		merge_tool_path=$(git config mergetool."$merge_tool".path)
> > +	fi
> > +	merge_tool_path="$(translate_merge_tool_path "$merge_tool" "$merge_tool_path")"
> > +	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
> > +		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as '$merge_tool_path'"
> > +		exit 1
> > +	fi
> > +	echo "$merge_tool_path"
> > +}
> 
> I just wanted to double check that we supported finding tools in the
> path with merge.$tool.path unset (it should just work), so I had a

mergetool.$tool.path

> quick play and got some really wierd results. Please tell me if just
> sourcing git-mergetool--lib isn't just going to work.
> 
> From a non-X session:
> 
>     $ git config -l | grep 'merge\.\?tool'; get_merge_tool; get_merge_tool_path
>     mergetool.p4merge.cmd=echo /"$BASE"/ /"$REMOTE"/ /"$LOCAL"/ /"$MERGED"/
>     merge tool candidates: kompare emerge vimdiff
>     vimdiff
>     vim
> 
> From an X session:
> 
>     mergetool.p4merge.cmd=echo /"$BASE"/ /"$REMOTE"/ /"$LOCAL"/ /"$MERGED"/
>     merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff kompare gvimdiff diffuse ecmerge emerge vimdiff
>     kdiff3
>     vim
> 
> I'm not quite sure what's going on here.

mergetool.$tool.path does work (there's a test for that feature,
though we only test difftool.$tool.path currently)

What you probably ran into was that get_merge_tool_path() had
a side-effect of setting $merge_tool_path and thus would just
return that value the 2nd time you ran it.

If you started from a fresh shell (instead of faking X11 by
setting $DISPLAY) then it would behave correctly.

In any case, yes, it needs to be more robust, so I'm
addressing that in:
"mergetool--lib: simplify API usage by removing more global variables"
(patch on its way)



> --- big snip to: @@ merge_file () {
> 
> > +    present=false
> > +    base_present &&
> > +    present=true
> 
> I'm not sure why, but from a style point of view, this seemed a bit
> inconsistent from the rest of mergetool and grated with me a bit.
> 
> I think I'd prefer
> 
> if base_present; then
>     present=false
> else
>     present=true
> fi

Definitely.
This was cleaned up as well.

In my patch get_merge_tool_path and get_merge_tool_cmd now take
$1 as an optional argument since they can easily look up the
$merge_tool themselves in lieu of a passed-in value.

I kept thinking of mergetool--lib from the POV of difftool and
mergetool, but these changes are good since they make it more
useful from a standalone POV.

Let me know what you think.

-- 

	David
