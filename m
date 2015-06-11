From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Thu, 11 Jun 2015 07:57:45 -0700
Message-ID: <xmqqa8w6gumu.fsf@gitster.dls.corp.google.com>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com>
	<xmqq7frbi4uv.fsf@gitster.dls.corp.google.com>
	<vpqk2vaoa2t.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z33vV-0004K4-9M
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 16:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbFKO5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 10:57:49 -0400
Received: from mail-ie0-f193.google.com ([209.85.223.193]:34804 "EHLO
	mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbFKO5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 10:57:47 -0400
Received: by iebtr6 with SMTP id tr6so2394454ieb.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mLtymy84g0Y1xzT6gpiSSK2rhMRNy3KAlEHD4B8sQ4U=;
        b=JmsRDlKGv+DaLzBMjcxWjelT2IHmlL9S8JlBUakP62W7/hsoKQYOo3mgfi8Uv5hY9R
         bUaikjUOTPtzh5HECBZZWjrZtZASgpsdjQsYrTVwzO16b7jUmCKj7QLS+vNxfXANGy0r
         DTbj5S51WSrFjoHTn5Wi86nSQOcRrhVU7nGxdes/po1FDSCmf11Rmft4DEggNKtI6Ajz
         KGtK+08Ja7i0h21JzfmU1t0Os8CbckmEtPwIEC5XV4S7dBaOAwQeBTX3lFnSv4uheHj8
         hgYoKjGtFVEJCLopnP57dHMVFwxyLiWVB+GgWbknjKW/63pJ2Bh6xDQn7j+cExpSdeOK
         YEZw==
X-Received: by 10.50.138.136 with SMTP id qq8mr3944625igb.27.1434034667283;
        Thu, 11 Jun 2015 07:57:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id e10sm678020igy.11.2015.06.11.07.57.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 07:57:46 -0700 (PDT)
In-Reply-To: <vpqk2vaoa2t.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	11 Jun 2015 11:42:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271413>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> +bisect_terms () {
>>> +	test $# -eq 2 ||
>>> +	die "You need to give me at least two arguments"
>>> +
>>> +	if ! test -s "$GIT_DIR/BISECT_START"
>>> +	then
>>> +		echo $1 >"$GIT_DIR/BISECT_TERMS" &&
>>> +		echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
>>> +		echo "1" > "$GIT_DIR/TERMS_DEFINED"
>>> +	else
>>> +		die "A bisection has already started, please use "\
>>> +		"'git bisect reset' to restart and change the terms"
>>> +	fi
>>> +}
>>> +
>>
>> I think "git bisect terms" is a good way to help a user to recall
>> what two names s/he decided to use for the current session.  So
>> dying 'already started' with suggestion for 'reset' is OK, but at
>> the same time, helping the user to continue the current bisection by
>> giving a message along the lines of "You are hunting for a commit
>> that is at the boundary of the old state (you are calling it
>> '$NAME_OLD') and the new state ('$NAME_NEW')" would be a good idea.
>
> I'd put a very verbose message explaining the situation and the way out
> (use 'git bisect') for the second "die", and I would consider "git
> bisect terms" without arguments as a valid command to ask "please tell
> me what the terms are".

Of course you are right.  The "remind me what I was doing" help
should be given when the user asks "git bisect terms" without any
parameters, not in "else die" part.

Thanks for a correction.
