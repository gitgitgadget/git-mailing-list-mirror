From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git mergetool: Don't repeat merge tool candidates
Date: Fri, 23 Jan 2009 00:16:03 -0800
Message-ID: <7v7i4m1lq4.fsf@gitster.siamese.dyndns.org>
References: <1232569442-12480-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:17:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQHER-0003Ya-Qn
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbZAWIQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZAWIQO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:16:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZAWIQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:16:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 278FE1D13B;
	Fri, 23 Jan 2009 03:16:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2601C1D064; Fri,
 23 Jan 2009 03:16:04 -0500 (EST)
In-Reply-To: <1232569442-12480-1-git-send-email-heipei@hackvalue.de>
 (Johannes Gilger's message of "Wed, 21 Jan 2009 21:24:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1764D2FE-E926-11DD-B3D3-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106855>

Johannes Gilger <heipei@hackvalue.de> writes:

> git mergetool listed some candidates for mergetools twice, depending on
> the environment.
>
> Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
> ---
>  git-mergetool.sh |   13 +++++--------
>  1 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 00e1337..8f09e4a 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -390,21 +390,18 @@ fi
>  
>  if test -z "$merge_tool" ; then
>      if test -n "$DISPLAY"; then
> -        merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
>          if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
> -            merge_tool_candidates="meld $merge_tool_candidates"
> -        fi
> -        if test "$KDE_FULL_SESSION" = "true"; then
> -            merge_tool_candidates="kdiff3 $merge_tool_candidates"
> +            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
> +        else
> +            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
>          fi
>      fi
>      if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
> -        merge_tool_candidates="$merge_tool_candidates emerge"
> +        merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
>      fi
>      if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
> -        merge_tool_candidates="$merge_tool_candidates vimdiff"
> +        merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
>      fi
> -    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
>      echo "merge tool candidates: $merge_tool_candidates"
>      for i in $merge_tool_candidates; do
>          init_merge_tool_path $i

Doesn't this change the order of the tools listed in the variable,
affecting which one ends up being used?  I think that is a worse
regression than repeating the same name twice in an otherwise no-op
informational message.

Please spend a few minutes to see if there are active developers who are
familiar with the area of code you are touching and Cc them to ask their
input.

    git blame -L390,+20 git-mergetool.sh

tells me that most of this came from 301ac38 (git-mergetool: Make default
selection of merge-tool more intelligent, 2007-06-10), so I am Cc'ing Ted.
