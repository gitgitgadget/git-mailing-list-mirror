From: Jonathon Mah <me@jonathonmah.com>
Subject: Re: [PATCH] mergetool: Teach about submodules
Date: Wed, 13 Apr 2011 03:00:15 -0700
Message-ID: <C411FA8C-8E26-4DB8-BC2A-B95CDBB2CF38@jonathonmah.com>
References: <1302321570-85987-1-git-send-email-me@JonathonMah.com> <7v62qkwomk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1213)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 12:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9wsU-0000x1-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 12:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab1DMKAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 06:00:30 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:39673 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756900Ab1DMKAY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 06:00:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApIjALJwpU1i6vJRPGdsb2JhbAAMiQidAAEBAQE3w2+FbgSFXg
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO [192.168.120.10]) ([98.234.242.81])
  by ipmail06.adl6.internode.on.net with ESMTP; 13 Apr 2011 19:30:19 +0930
In-Reply-To: <7v62qkwomk.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171440>

Hi Junio,

On 2011-04-11, at 12:53, Junio C Hamano wrote:

>> +resolve_submodule_merge () {
>> +    while true; do
>> +	printf "Use (l)ocal or (r)emote, or (a)bort? "
>> +	read ans
>> +	case "$ans" in
>> +	    [lL]*)
>> +		local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
>> +		if is_submodule "$local_mode"; then
>> +		    stage_submodule "$MERGED" $(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
> 
> If the version we had checked out and merging into has a submodule at the
> path, use that.  This part of the logic seem sensible.
> 
> Don't you already have local_mode from the caller here?  For that matter,
> don't you also have access to local_sha1 the caller already has computed?

Thanks for the feedback. I'm not particularly experienced with shell scripts, so I don't usually think of the lack of variable scope.

>> +		else
>> +		    git checkout-index -f --stage=2 -- "$MERGED"
>> +		    git add -- "$MERGED"
> 
> If what we had is not a submodule, then do a checkout-index.  Here you
> assume that we _must_ have a stage #2 entry, but is that always the case?

Indeed, it may not have. A v2 patch is following that handles the submodule path without a stage 2 (either because the submodule was deleted, or turned into a regular directory).

>> +stage_submodule () {
>> +    path="$1"
>> +    submodule_sha1="$2"
>> +
>> +    submodule_basename=$(basename "$path")
>> +    tree_with_module=$(echo "160000 commit $submodule_sha1	\"$submodule_basename\"" | git mktree --missing 2>/dev/null)
>> +    if test -z "$tree_with_module" ; then
>> +	echo "$path: unable to stage commit $sha1"
>> +	return 1
>> +    fi
>> +    git checkout $tree_with_module -- "$path"
> 
> Are you looking for "git update-index --cacheinfo 160000 $sha1 $name"

Yes, this is the command I was intending. I needed it a while back when I was converting a monolithic repo into a super/submodule configuration, but couldn't find a better way than the kludge above. I had hoped someone would show me the clean way to do it!



Jonathon Mah
me@JonathonMah.com
