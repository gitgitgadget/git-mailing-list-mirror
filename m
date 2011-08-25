From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: clean error message for --continue after failed exec
Date: Thu, 25 Aug 2011 09:09:26 +0200
Message-ID: <vpqzkiydl21.fsf@bauges.imag.fr>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>
	<1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v62lmps6k.fsf@alter.siamese.dyndns.org>
	<7vy5yiod1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 09:09:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwU4N-0005Dl-Mi
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 09:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab1HYHJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 03:09:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41897 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab1HYHJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 03:09:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7P7963q016059
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 25 Aug 2011 09:09:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QwU46-0001is-Iz; Thu, 25 Aug 2011 09:09:26 +0200
In-Reply-To: <7vy5yiod1h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 24 Aug 2011 11:54:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Aug 2011 09:09:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7P7963q016059
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1314860946.51425@xgx5KU3dX+q6SgB/BmBqLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180062>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> If after a failed "exec" instruction there are staged changes,...
>>
>> I have to wonder why whatever "exec" runs is mucking with the index in the
>> first place. Shouldn't we forbid it?
>
> I suspect your patch amounts to the same thing of forbidding, but
> detecting the lack of $author_script feels like it is covering up the
> symptom and not directly going for the cause of the symptom.
>
> I wonder if doing something like this would be more direct approach to
> achieve the same thing.

Not the same thing, but both patches could go well together.

Mine covers

  pick deadbeef
  exec make test
  # :-( make test failed, I'm going to fix it
  hack hack hack
  git add changes
  # OK, seems fixed.
  git rebase --continue
  # --> rebase tells me I forgot to commit my fixup patch

i.e. the user changed the index interactively, not within exec. Yours
covers the case where the command itself changes the index.

> +		# Run in subshell because require_clean_work_tree can die.
> +		dirty=f
> +		(require_clean_work_tree "rebase") || dirty=t

This will display error messages like

  Cannot rebase: You have unstaged changes

and right after

>  			warn "Execution failed: $rest"
> +			test "$dirty" = f ||
> +			warn "and made changes to the index and/or the working tree"

which sounds redundant. This should probably be

(require_clean_work_tree "rebase" 2>/dev/null) || dirty=t

but looking more closely at the patch, you're not the one introducing
this, it was already there since 92c62a3f.

>  		fi
> +
>  		;;
>  	*)

I think this one can be removed, there's usually no blank line before ;;
in the code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
