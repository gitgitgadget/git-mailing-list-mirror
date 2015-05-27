From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] showing existing ws breakage
Date: Tue, 26 May 2015 23:30:28 -0700
Message-ID: <1432708232-29892-1-git-send-email-gitster@pobox.com>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 08:30:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxUrQ-0001XR-IK
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbE0Gaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:30:35 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35486 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbE0Gaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:30:35 -0400
Received: by igbyr2 with SMTP id yr2so77274729igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 23:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=FcoMvWWzLWTO22E+5M05TNJMLClKlCTJ04sCtvc8C5E=;
        b=MfyUJ0E6M4NiJkpMfcCKMIaMjnpketq6aktyqueM+6ELSnkStpnDtpnbugAJCWVt+F
         Gt8xMcZxXkDzhdHdqHUftYg13JdmsEdkqQkA7PY1eGWN8FPNaE0+47CrR7iiQdF91Jvb
         HeT6cSd6R2bhdQjQRv5U/wQFHelp8yNowH/TgTfDMZEn3pKSXleVxG83YibvodTW5pT/
         4x/RX1tvJh/CKj30z7ZYnMt9/B+TpMrged1ye5IMnsjAAK1Cm44eLmkMejRoBZRXTyw3
         3nV5H+3AonD5FBIMAQf1JMOaC+lnLH1kpEgC7QrBYqJrXq6pi0W3ip+qGEiL4a7q8g2E
         c+Ww==
X-Received: by 10.50.50.148 with SMTP id c20mr34482891igo.0.1432708234400;
        Tue, 26 May 2015 23:30:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id qh9sm1145287igb.20.2015.05.26.23.30.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 23:30:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2-503-g2442661
In-Reply-To: <1432669584-342-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270019>

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

This series is a reroll of the previous one

  http://thread.gmane.org/gmane.comp.version-control.git/269972

which built on Christian'sidea, but with a different implementation
(Christian's original painted trailing whitespaces only).

The first two patches are unchanged since v2; they are preliminary
clean-ups.

The third one extends the corresponding patch since v2; not only a
helper for "deleted" lines but also another helper for "context"
lines is added.

The fourth one in v2 used a new option "--[no-]ws-check-deleted",
but in this round a new option "--ws-error-highlight=<kinds>" is
defined instead.  With that, you can say

	diff --ws-error-highlight=new,old

to say "I want to see whitespace errors on new and old lines", and

	diff --ws-error-highlight=new,old,context
	diff --ws-error-highlight=all
	
can be used to also see whitespace errors on context lines.  Being
able to see whitespace errors on context lines, i.e. the ones that
were there in the original and you left intact, would help you see
how prevalent whitespace errors are in the original and hopefully
would make it easier for you to decide if a separate preliminary
clean-up to only fix these whitespace errors is warranted.

Junio C Hamano (4):
  t4015: modernise style
  t4015: separate common setup and per-test expectation
  diff.c: add emit_del_line() and emit_context_line()
  diff.c: --ws-error-highlight=<kind> option

 Documentation/diff-options.txt |  10 +
 diff.c                         | 122 ++++++++--
 diff.h                         |   5 +
 t/t4015-diff-whitespace.sh     | 508 ++++++++++++++++++++++-------------------
 4 files changed, 385 insertions(+), 260 deletions(-)

-- 
2.4.2-503-g3e4528a
