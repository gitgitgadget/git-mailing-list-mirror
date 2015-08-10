From: Junio C Hamano <gitster@pobox.com>
Subject: Re: resolving a (possibly remote) branch HEAD to a hash
Date: Mon, 10 Aug 2015 11:41:45 -0700
Message-ID: <xmqq614nugt2.fsf@gitster.dls.corp.google.com>
References: <55c47766.dDi8LaxdDqOeptUd%perryh@pluto.rain.com>
	<xmqq8u9nyptx.fsf@gitster.dls.corp.google.com>
	<55c5aa2a.sK/tpvXyORYGVq0d%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: perryh@pluto.rain.com (Perry Hutchison)
X-From: git-owner@vger.kernel.org Mon Aug 10 20:41:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOs1B-00057W-7K
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 20:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbbHJSls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 14:41:48 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33516 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbbHJSls (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 14:41:48 -0400
Received: by pabyb7 with SMTP id yb7so111918015pab.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zC0uMZ5nswdcUD/ZbTdKDc7Kaj3vMMp0aK7abexY53A=;
        b=YIrI9OuVnhwTRWNtTAyLKciPFrx3vPst8/gu1073XSe6wQK6lWdptRs91hMy5LhMpn
         lfidlS2CIquBem9UUfwmk/sZPiMuLOU5+PqkbIeR22HPVBXoPu0oemNiENr6944U3Pnl
         3NA8Tz0T7FOO9IMGKDW2RdqKVhLYopwaxVjbkg7wPJTNxipYszzOXkAQvdgW0twvEZxe
         8EIjxVf+Bg+wfl3HwsbQSijYfH6SWiE5GBuhwu2WunLr4DgnscN4Byr2cdmtmsTPm4mG
         SWqWNqbxRlljc6N/2hwsJPhPcQx4QkRfUow6Y12gDY0iCd+f+iotc85LZ542CNQhb84S
         SFjA==
X-Received: by 10.68.205.232 with SMTP id lj8mr47906970pbc.116.1439232107616;
        Mon, 10 Aug 2015 11:41:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id iw2sm20727125pbb.67.2015.08.10.11.41.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 11:41:46 -0700 (PDT)
In-Reply-To: <55c5aa2a.sK/tpvXyORYGVq0d%perryh@pluto.rain.com> (Perry
	Hutchison's message of "Sat, 08 Aug 2015 00:05:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275647>

perryh@pluto.rain.com (Perry Hutchison) writes:

>> ... we do not say "append 'refs/remotes/<anything>/' for various
>> values of <anything> and see if such a ref exists" when resolving
>> an abbreviated refname 'master'.
>
> checkout appears to.

You are referring to this part of the documentation:

    If <branch> is not found but there does exist a tracking branch in
    exactly one remote (call it <remote>) with a matching name, treat as
    equivalent to

        $ git checkout -b <branch> --track <remote>/<branch>

A reader needs to read this part of the documentation a bit more
carefully in order to notice that it never says it is equivalent to:

        $ git checkout -b <branch> -t <branch> ;# NOT CORRECT

This behaviour was brought in by somebody who thought that, in the
context of "checkout" (and only in that context), it is clear that
missing <branch> that can only mean the sole <remote>/<branch> and
make that signal something more than what the user told "checkout"
to do: "If you want to check out a <branch>, and it does not exist
yet, you must wanted to create your own <branch> and start it at the
same commit as somebody else has at the tip of his <branch>".

This "clever" dwim is very specific to the way you interact with
"checkout" and generally does not apply when you want to run
anything other than "checkout", e.g. "rev-parse" or "log".

But it is _so_ convenient a short-cut, that it lets new people form
into an illusion that <branch> could be naming <remote>/<branch>.
That is an incorrect perception.

The rationale behind "signal something more" above goes like this:
if the user wanted to detach the head at the same commit as somebody
else's <branch>, she would explicitly have written

	$ git checkout <remote>/<branch>

to do so.  Because <remote>/<branch> is the shortest valid way to
name that remote-tracking branch (i.e. exactly because <branch> is
not a valid abbreviation for <remote>/<branch>), we can treat

	$ git checkout <branch>

when <branch> is not a local branch name specially.

It is sad and ironic that this checkout-specific DWIM works only
because <branch> does not mean <remote>/<branch>, but presence of
the DWIM gives a wrong illusion that it does X-<.
