From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] git submodule update: Announce uninitialized modules on stderr
Date: Fri, 16 Oct 2015 13:54:29 -0700
Message-ID: <xmqq7fmmedq2.fsf@gitster.mtv.corp.google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnC1R-0007tT-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbbJPUyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:54:32 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36666 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbbJPUyb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:54:31 -0400
Received: by pacfv9 with SMTP id fv9so32450075pac.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YELTjmw4yCby4AN9HVO8eZU59rqmloha7B6xVQpDm/0=;
        b=ayN/8fQJ4Fws+IbX2A6dCVh3L9xLlWaDHZGe1587BeXOZzm3LTssiwFMpas9OF2OtY
         9y09jQQFNmWdsSc0lEPRTlHcd2lvqw85ZvIeizz8YifVEqESLTcwjT3D6koEtzB4ZWL3
         R1xtqjup71jBv7SXal9sDJiAUEQac03aA+B5nMhm8/mzR5ECbA9j3zrGdgfQWqH1LtRL
         QW7TgodeUdRvrnVgUNxJ893tw8bzLk4h6swiWVEVAc3NV7S1SP8F6uyJ7JZ9SWOy+8kP
         wdhhhB+Wq+6fJchJY7zOV53T6skPF/p5MWhKAioQKyMCDa6iDTuhtSUByjkdoSF4N1w/
         JyDA==
X-Received: by 10.68.232.162 with SMTP id tp2mr18926437pbc.162.1445028871262;
        Fri, 16 Oct 2015 13:54:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id rm9sm22989602pab.14.2015.10.16.13.54.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 13:54:30 -0700 (PDT)
In-Reply-To: <1444960333-16003-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 15 Oct 2015 18:52:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279768>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh           |  2 +-
>  t/t7400-submodule-basic.sh | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 578ec48..eea27f8 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -693,7 +693,7 @@ cmd_update()
>  			# Only mention uninitialized submodules when its
>  			# path have been specified
>  			test "$#" != "0" &&
> -			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
> +			say >&2 "$(eval_gettext "Submodule path '\$displaypath' not initialized
>  Maybe you want to use 'update --init'?")"
>  			continue
>  		fi

There are quite a few other calls to "say" in this script, and you
are changing only this one to emit it to the standard error output.

My quick eyeballing of the script tells me that most of them, other
than the ones that are used in cmd_status to report the information
that the user asked to be shown on the standard output, are of "Now
I am doing this" kind fo output, which I feel are the same category
as this one that shouldn't be on the standard output.

Another thing (which relates to the one in 01/12) is that not all
output from this command comes from "say".

Perhaps the first thing to do before doing 01/12 is to sift these
messages into types and have them consistently use helpers designed
for different purposes, e.g.

 - a progress, like this one, the one in 01/12, and many other uses
   of "say"; which may want to become e.g. "say_progress".

 - an error or a warning, like "Could not remove working tree", "not
   initialized, maybe you want to do 'init' first?"; which may want
   to become something else e.g. "say_warning".

 - the real output from the program, e.g. output from cmd_status,
   would use yet another, e.g. "printf '%s\n'".

instead of converting each message that you happened to have noticed.

Note that "say" is squelched under GIT_QUIET (i.e. --quiet).  The
former two helpers we would want to make quiet (or for errors we may
not---I don't know offhand).  I do not think of any valid reason why
we want to squelch the output from cmd_status under --quiet; it is
not like the the while loop on the downstream of "list |" pipe tells
some status via its exit code.
