From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v5 0/2] git-prompt.sh: Option to hide prompt for ignored pwd
Date: Tue,  6 Jan 2015 20:22:25 -0500
Message-ID: <1420593747-24110-1-git-send-email-rhansen@bbn.com>
References: <xmqqwq4zmqpt.fsf@gitster.dls.corp.google.com>
Cc: j6t@kdbg.org, jess.austin@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 07 02:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8fKo-0000wW-R8
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 02:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbbAGBWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 20:22:49 -0500
Received: from smtp.bbn.com ([128.33.0.80]:10370 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756321AbbAGBWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 20:22:48 -0500
Received: from socket.bbn.com ([192.1.120.102]:53256)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y8fKe-000Pra-Me; Tue, 06 Jan 2015 20:22:44 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 797A73FFD2
X-Mailer: git-send-email 2.2.1
In-Reply-To: <xmqqwq4zmqpt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262123>

On 2015-01-06T15:31-08:00, Junio C Hamano wrote:
>> This is the patch from:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/258313
>>
>> modified to include the changes I suggested in:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/258355
>>
>> I never heard back regarding my suggested changes.  The feature was so
>> close to ready and I thought it would be a shame for the feature to
>> silently die, so I'm submitting a re-roll with my suggested changes on
>> behalf of the original author.
> 
>> +# If you would like __git_ps1 to do nothing in the case when the current
>> +# directory is set up to be ignored by git, then set
>> +# GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
>> +# repository level by setting bash.hideIfPwdIgnored to "false".
> 
> Perhaps nobody had much interest in the original or the update.
> Occassionally resending with improvements like this is a good way to
> show it to more people who may have missed it the last time to
> solicit comments and supports.
> 
> I am personally not very interested, as you and the original made it
> sound as if this is primarily for those who keep track of $HOME/.dot
> files in $HOME/.git, which is one of the ways I would never use Git.

I do keep my dotfiles in a Git repository (~/.git exists), yet I
wouldn't use this feature either.  (I just use refs/heads/dotfiles as
HEAD so that my prompt is unique when I'm not in some project working
directory.)

However, it doesn't seem like a very invasive change to me, and at
least one person wants this feature (evidenced by Jess Austin going to
the trouble of submitting a patch), so I thought I'd help it along.

If someone has a reasonable objection to this feature, or even if
there's not enough positive interest, I wouldn't be too sad to see it
not get adopted.

>> +	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED}" ] &&
> 
> Many existing checks on variables are written this way with the
> "subsitutute with default value" syntax
> 
>         if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
> 
> to make sure that people with non-standard settings to report
> references to unset variables as errors will not have to suffer.
> Don't you need to do something similar here?

Yes; fixed.

>> +	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
>> +	   git check-ignore -q .
>> +	then
>> +		if [ $pcmode = yes ]; then
>> +			PS1="$ps1pc_start$ps1pc_end"
>> +		fi
>> +		return
> 
> There are already two places where "under pcmode, we need to set PS1
> to this empty thing" is known, and this patch adds yet another.
> Would it be sensible to refactor that into a helper function, or
> open coding them this way is necessary for performance or some other
> reasons?

I thought about factoring it out, but didn't because defining a
function with just three lines seemed awkward.  But I thought of a
better way to eliminate the duplicate code without defining a helper
function; see the new prequel patch.

>> +	echo "ignored_dir/" >> .gitignore &&
> 
> Drop the SP after (but not before) redirection operator >>.

Done.

Thanks for the review,
Richard


Jess Austin (1):
  git-prompt.sh: Option to hide prompt for ignored pwd

Richard Hansen (1):
  git-prompt.sh: if pc mode, immediately set PS1 to a plain prompt

 contrib/completion/git-prompt.sh |  24 ++++++---
 t/t9903-bash-prompt.sh           | 106 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 7 deletions(-)

-- 
2.2.1
