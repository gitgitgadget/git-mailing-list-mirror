From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 20:21:15 +0100
Message-ID: <CAMP44s2ZgbZkjnrNA0ry-koZbTtqRgO5JrJtk-UtDuvdR0k0PA@mail.gmail.com>
References: <1353557598-4820-1-git-send-email-marc.khouzam@gmail.com>
	<CAFj1UpF2wh0imcqW7Ez_J14R_07a_A1-YWESaGrHRNa7Nsv-xg@mail.gmail.com>
	<CAMP44s3qpr11JXi-znddAH2BWYbM_kp+nZnTa8CQgCzrBmfzmA@mail.gmail.com>
	<CAFj1UpHAqrNvpF+HAxJUPiWAiHbCn=7r1GDw3iMKy8FDW_-D_A@mail.gmail.com>
	<CAMP44s2bMub6T1YcUfsYWPQFU1bY4iU1WfSf+jFa7jSXAKTNaw@mail.gmail.com>
	<CAFj1UpH8h6c7xHuRG6F+pLy5YMvsJ0QdXsotCpLKnht0PsdiNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 20:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbyoe-0006lu-LF
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 20:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab2KWTVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 14:21:17 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61182 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab2KWTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 14:21:16 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9147049oag.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 11:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cqfxfZOyRlFMJlIYP5NalfzlIE9TL7yyGBcSOg1HpjY=;
        b=Wplh9CZyAZMBki9+0jqYYe9DEu3cFkPZakD9ODAoako6l88QdT6JiV/edGoo6lJ7PB
         2eGv9spLrQe8jBKLh4jMNWD7J0s000uRwh/aMJbbcd9lno3Ee9Qccxvappw+Judb/44W
         5ZOdSaSLL+a5Hjuc0a4n/A7A4CLhTQTQfc+V9aXGwq9vZVoBYQLc4AUkBWwYsG3YZLcF
         UZpQLPDSM97UlWTJfrPKMqBskt5hSdSQr3Lw6/4uVqIDU+F1cTfFkrHEG7Gik3u5FB9j
         z2AHxX6fabphNy5HBUfsvocr+80ylAIE3s10/3sqw4pyh3vTQuqiJRLsY8W1zzLCppL6
         XXIQ==
Received: by 10.60.169.173 with SMTP id af13mr3593996oec.97.1353698476126;
 Fri, 23 Nov 2012 11:21:16 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 23 Nov 2012 11:21:15 -0800 (PST)
In-Reply-To: <CAFj1UpH8h6c7xHuRG6F+pLy5YMvsJ0QdXsotCpLKnht0PsdiNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210271>

On Fri, Nov 23, 2012 at 3:02 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> The user can be presented with invalid completion results
> when trying to complete a 'git checkout' command.  This can happen
> when using a branch name prefix that matches multiple remote branches.
>
> For example, if available branches are:
>   master
>   remotes/GitHub/maint
>   remotes/GitHub/master
>   remotes/origin/maint
>   remotes/origin/master
>
> When performing completion on 'git checkout ma' the user will be
> given the choices:
>   maint
>   master
>
> However, 'git checkout maint' will fail in this case, although
> completion previously said 'maint' was valid.  Furthermore, when
> performing completion on 'git checkout mai', no choices will be
> suggested.  So, the user is first told that the branch name
> 'maint' is valid, but when trying to complete 'mai' into 'maint',
> that completion is no longer valid.
>
> The completion results should never propose 'maint' as a valid
> branch name, since 'git checkout' will refuse it.
>
> The reason for this bug is that the uniq program only
> works with sorted input.  The man page states
> "uniq prints the unique lines in a sorted file".
>
> When __git_refs uses the guess heuristic employed by checkout for
> tracking branches it wants to consider remote branches but only if
> the branch name is unique.  To do that, it calls 'uniq -u'.  However
> the input given to 'uniq -u' is not sorted.
>
> Therefore, in the above example, when dealing with 'git checkout ma',
> "__git_refs '' 1" will find the following list:
>   master
>   maint
>   master
>   maint
>   master
>
> which, when passed to 'uniq -u' will remain the same.  Therefore
> 'maint' will be wrongly suggested as a valid option.
>
> When dealing with 'git checkout mai', the list will be:
>   maint
>   maint
>
> which happens to be sorted and will be emptied by 'uniq -u',
> properly ignoring 'maint'.
>
> A solution for preventing the completion script from suggesting
> such invalid branch names is to first call 'sort' and then 'uniq -u'.
>
> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>

Looks good. Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
