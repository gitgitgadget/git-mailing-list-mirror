From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] showing existing ws breakage
Date: Tue, 26 May 2015 12:46:20 -0700
Message-ID: <1432669584-342-1-git-send-email-gitster@pobox.com>
References: <xmqq1ti3kz5v.fsf@gitster.dls.corp.google.com>
Cc: Christian Brabandt <cblists@256bit.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 21:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKo4-0001jY-1e
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbEZTq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:46:27 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36833 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbEZTq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:46:26 -0400
Received: by igbpi8 with SMTP id pi8so67264857igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BZYTJkZJDkXX1N3SyGCsYcIlCCKE5+HgnSWmVHEY8AY=;
        b=1BMiHK2StUOe8kuX2uT4uhm9vBjSr0dJQ6nk8800PkGJjHPr/wxNYjnw/BN9xbdDZk
         DNcvB/Wuubxkuxb6NuoFZPZkWNViltmvmaM3U3S2Dm6uPREtcWxPaXepXLjTjfWXKTwx
         d5aa6E0Xk5npmmQuMZ4jIG+eoRjiWDtxhTYLl9Z0aJG6kQN+Sr5wN2shfU5CJDBkdd7u
         RZyPfSIfQbGgTG0VFsl8lijZv29R6M5R6cbYBultsZWdRS45MTe/JP4HiKzCUlScfuYZ
         eR2+YpWIHW4tuRiqZTRqjELzqVmsd1PIpvt9V+j1kLeDzzSatgornX0xhC2Gt37kmd5F
         Dp0w==
X-Received: by 10.107.7.195 with SMTP id g64mr6959549ioi.81.1432669586245;
        Tue, 26 May 2015 12:46:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id rr5sm31399igb.7.2015.05.26.12.46.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 12:46:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.1-511-gc1146d5
In-Reply-To: <xmqq1ti3kz5v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269972>

We paint whitespace breakages in new (i.e. added or updated) lines
when showing the "git diff" output to help people avoid introducing
them with their changes.  The basic premise is that people would
want to avoid touching existing lines only to fix whitespace errors
in a patch that does other changes of substance, and that is why we
traditionally did not paint whitespace breakages in existing
(i.e. deleted or context) lines.

However, some people would want to keep existing breakages when they
are doing other changes of substance; "new" lines in such a patch
would show existing whitespace breakages painted, and it is not
apparent if the breakages were inherited from the original or newly
introduced.

Christian Brabandt had an interesting idea to help users in this
situation; why not give them a mode to paint whitespace breakages
in "old" (i.e. deleted or was replaced) lines, too?

http://thread.gmane.org/gmane.comp.version-control.git/269912/focus=269956

This series builds on that idea but with a different implementation
(Christian's original painted trailing whitespaces only).

The first three patches are preliminary cleanups.  The last one is
the interesting bit.

Having done this series, I am starting to suspect that painting ws
breakages only in deleted lines may not be such a useful thing to
do.  In order to decide if fixing ws breakages "while at it" is more
appropriate, you would need to know if such breakages are prevalent
in the original.  After all, the line you are updating might be one
of only few lines that the original had breakages, in which case you
may want to go back to your editor and fix them all while you are at
it, or fix only these few ws breakages as a preliminary step.  In
order to help users do that, the new option may be better not to
limit itself to "deleted" lines, but "context and deleted",
i.e. "preimage" lines.

Junio C Hamano (4):
  t4015: modernise style
  t4015: separate common setup and per-test expectation
  diff.c: add emit_del_line() and update callers of emit_line_0()
  diff.c: --ws-check-deleted option

 Documentation/diff-options.txt |   7 +
 diff.c                         |  58 +++--
 diff.h                         |   1 +
 t/t4015-diff-whitespace.sh     | 474 ++++++++++++++++++++---------------------
 4 files changed, 290 insertions(+), 250 deletions(-)

-- 
2.4.1-511-gc1146d5
