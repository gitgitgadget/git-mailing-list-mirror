From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 02:41:41 +0100
Message-ID: <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 02:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZAwO-00073J-5o
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 02:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab2KPBlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 20:41:42 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35857 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab2KPBll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 20:41:41 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2347912obb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 17:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qp5mow3kuqlcY2wioQWM4ajfDp0i0FsS+USbqCb1Y/Q=;
        b=PStFDthPztWJ46L25G/xGycXvXwmCi7YgAVjNYb0N772y5Rf2+ZZv6phEza+2NFOUT
         myjT2L6ZmCOrNSOIXwW6T95Zt0XGZkSPF3RxmWjWjhKZlfEvVf0qOGgir4ZJChN66c0Q
         U6grIvWCvS0hhV79ySrDAvmbxCTg/J8DLxrO/qqv0CcBxuYLUNV0E2vfDwFDXXXiNe7W
         +1BsUSCqN+7CP4t60BWV6cO19TTV2z45c6BuIH6/Xp99RhsPPwv54zU5+xm6k4FKNZrI
         T6+QiW7tpvBISf+6bAit+hmfZaEMGYahqyAct4/LpH4iFnqgrxN2AfarVrUIXyWaV0dG
         5kyQ==
Received: by 10.182.38.101 with SMTP id f5mr2628546obk.80.1353030101257; Thu,
 15 Nov 2012 17:41:41 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Thu, 15 Nov 2012 17:41:41 -0800 (PST)
In-Reply-To: <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209856>

On Thu, Nov 15, 2012 at 12:51 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> The current tcsh-completion support for Git, as can be found on the
> Internet, takes the approach of defining the possible completions
> explicitly.  This has the obvious draw-back to require constant
> updating as the Git code base evolves.
>
> The approach taken by this commit is to to re-use the advanced bash
> completion script and use its result for tcsh completion.  This is
> achieved by executing (versus sourcing) the bash script and
> outputting the completion result for tcsh consumption.
>
> Three solutions were looked at to implement this approach with (A)
> being retained:
>
>   A) Modifications:
>           git-completion.bash and new git-completion.tcsh

As I said, I don't think this is needed. It can be done in a single
stand-alone script without modifications to git-completion.bash.

This works:

set called = ($_)
set script = "${called[2]}.tmp"

cat <<\EOF > $script
source "$HOME/.git-completion.sh"

# Set COMP_WORDS in a way that can be handled by the bash script.
COMP_WORDS=($1)

# Set COMP_CWORD to the cursor location as bash would.
if [ -n "${2-}" ]; then
	COMP_CWORD=$2
else
	# Assume the cursor is at the end of parameter #1.
	# We must check for a space as the last character which will
	# tell us that the previous word is complete and the cursor
	# is on the next word.
	if [ "${1: -1}" == " " ]; then
		# The last character is a space, so our location is at the end
		# of the command-line array
		COMP_CWORD=${#COMP_WORDS[@]}
	else
		# The last character is not a space, so our location is on the
		# last word of the command-line array, so we must decrement the
		# count by 1
		COMP_CWORD=$((${#COMP_WORDS[@]}-1))
	fi
fi

# Call _git() or _gitk() of the bash script, based on the first
# element of the command-line
_${COMP_WORDS[0]}

IFS=$'\n'
echo "${COMPREPLY[*]}"
\EOF

complete git  'p/*/`bash ${script} "${COMMAND_LINE}" | sort | uniq`/'
complete gitk 'p/*/`bash ${script} "${COMMAND_LINE}" | sort | uniq`/'

-- 
Felipe Contreras
