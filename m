From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: `git revert` on empty commit fails silently
Date: Thu, 18 Jun 2015 22:05:20 -0700
Message-ID: <xmqqioakb84v.fsf@gitster.dls.corp.google.com>
References: <A18BC2A3-C9A6-4D03-B929-D821E90B812D@othernation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alistair Lynn <alistair@othernation.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 07:05:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5oUa-0008S4-En
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 07:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbbFSFFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 01:05:24 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36381 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbFSFFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 01:05:22 -0400
Received: by iecrd14 with SMTP id rd14so68292626iec.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 22:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=8xRCfIUslLXkjbUsGVdrLOoImlT3NDQTEIqCbrKbwFE=;
        b=LQqfa8oY4v6ls8Q7Pi5xJNLVJWXsxQi9venvEMtU4dHfMvQYjjms1MF85TqVFQHK0M
         qHkS8r3keRktdGwY9UyaULMYKnYFKTbNbD6wm48Aun4OZqLusUBfm7lBRjc+7F6/IbDt
         J1WTCjKJbw+VxzgQIiQxKfkEBAWZiiMxq35WFuNT/cZ55S2r8rFFZ8CaUie1iRCnVQbt
         tvGrkyl7+WNvL3lgKJlaZXbqHDpzXbjtDblVRbmzD672ZXYNMIVo16/zkv9Gy9l+Xzru
         oQ++6HTA40oVnTXlA94S0N8SsKWmmJhS3NaI4h/Z/uFw7aWsEgF7Bdt7/0qllIAV5t6e
         hxvA==
X-Received: by 10.50.178.133 with SMTP id cy5mr1927596igc.5.1434690322043;
        Thu, 18 Jun 2015 22:05:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id u35sm6360442iou.7.2015.06.18.22.05.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 22:05:21 -0700 (PDT)
In-Reply-To: <A18BC2A3-C9A6-4D03-B929-D821E90B812D@othernation.com> (Alistair
	Lynn's message of "Thu, 18 Jun 2015 16:27:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272102>

Alistair Lynn <alistair@othernation.com> writes:

> $ git commit --allow-empty -m =E2=80=98test=E2=80=99
> $ git revert HEAD
>
> The latter fails silently, leaving HEAD pointing at the commit create=
d
> by the first command.

I do not necessarily think it is a bug to ignore reverting a no-op.
"revert a no-op" should probably fail by default, and the command
should require --force or --allow-empty.

But I agree that silently ignoring is not good.  It should warn the
user, saying that reverting no-op is nonsense, when refusing the
request.

> A subsequent `git commit --allow-empty` has the revert message as the
> default commit message when starting the editor.

And leaving a populated MERGE_MSG file to be picked up by the next
commit, which is an unrelated operation, is clearly wrong, I would
think.  If we deem the "revert a no-op" as a nonsense and ignore it,
we should ignore it completely and should not leave MERGE_MSG.

But leaving MERGE_MSG is internally consistent, I think.  When
"revert" stops due to conflicts and returns the control to the user,
it would explain the situation to the user loudly, and then after
user helps Git by resolving the conflict, the user uses "commit",
and the message is picked up from MERGE_MSG.  I'd view what you saw
very similar to that situation.  Instead of seeing a conflict (with
which the command cannot automatically continue), the command saw a
"no-op" (which it is dubious that the user really meant to revert).
Asking the user to help and then allowing the user to signal that
s/he is now done with "git commit" is the right way to continue,
and for that to work seamlessly, the message has to be in MERGE_MSG.

So perhaps the only buggy part of this whole experience is that the
command "silently" failed, instead of explaining the situation
(i.e. "No changes to revert"); in case the user still does want to
commit the revert of no-op by "commit --allow-empty", it did the
right thing by leaving the message in MERGE_MSG to be picked up
later.

I dunno.

> Hope this is the right place for bugs.

Yes, this is the right place for bugs.

Thanks.
