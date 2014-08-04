From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 05/19] rebase -i: Implement reword in terms of
 do_pick
Date: Mon, 04 Aug 2014 17:45:51 +0200
Message-ID: <53DFAAAF.20705@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<a82fd64f943d4b59a01509ae52fc2d7a05d51f4a.1404323078.git.bafain@gmail.com> <vpqzjfki8t8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEKSd-0005CO-GH
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 17:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaHDPp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 11:45:59 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:49079 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbaHDPp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 11:45:57 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so7848839wgg.28
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ID1rOf4/I6LYe5aadz7NACBcOsp4ptgHDev/02Z5Vw4=;
        b=DcJ91A9W27NQ9LYT70j+UHh/fW3UOCLMXO4O565pOglgip2W+5ZN2VvqP/ChEtro/g
         3ZtXkj8IebMyRdoAhwc4aae3Vq1SZCSiOsKrJdsgSWNMEvM8Bdooq7HaCP4+a1YtGIPL
         6T/YB67H/+zl7JZtRDQenlH06Vjc3k+KNe2lpNc4Gl925l4olr0UCwzp7liDQrUql90r
         6BbSvdvXlJXvHHEHaWh68dmVRxP1rKNhNfwy49fN+KuoeSti+UluAOrdJOcYWDN0ntFH
         dl6mewyKwwRtTCZsa8/Y+dWCkSjqgDu86XznG4H9aJAmfqnOAtuHdmSUwluM2yHoOEOX
         IKEA==
X-Received: by 10.180.93.8 with SMTP id cq8mr30166461wib.17.1407167155294;
        Mon, 04 Aug 2014 08:45:55 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id l7sm44386341wjx.7.2014.08.04.08.45.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 08:45:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqzjfki8t8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254741>

Hi Matthieu,

thanks for taking a look at this patch series. I might have caused some
confusion by starting with version v1 again after removing the RFC tag.
The current reroll[1] is tagged with PATCH v1, not PATCH RFC v2.

I'm sorry if this is the reason why your reply appears on this sub-thread.

Your concerns below are of course noted.

   Fabian

[1] http://article.gmane.org/gmane.comp.version-control.git/254361

Matthieu Moy writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -555,20 +555,7 @@ do_next () {
>>  		comment_for_reflog reword
>>  
>>  		mark_action_done
>> -		do_pick $sha1 "$rest"
>> -		# TODO: Work around the fact that git-commit lets us
>> -		# disable either both the pre-commit and the commit-msg
>> -		# hook or none. Disable the pre-commit hook because the
>> -		# tree is left unchanged but run the commit-msg hook
>> -		# from here because the log message is altered.
>> -		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
>> -			if test -x "$GIT_DIR"/hooks/commit-msg
>> -			then
>> -				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
>> -			fi || {
>> -				warn "Could not amend commit after successfully picking $sha1... $rest"
>> -				exit_with_patch $sha1 1
>> -			}
>> +		do_pick --edit $sha1 "$rest"
> 
> I would have found this easier to review if squashed into the previous
> patch. My reaction reading the previous patch was "Uh, why duplicate
> code?", and reading this one "Ah, that's OK". A single patch doing both
> would have avoided the confusion.
