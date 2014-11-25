From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/2] git-send-email: add --transfer-encoding option for conversion to specified encoding
Date: Tue, 25 Nov 2014 15:00:25 +0100
Message-ID: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
Cc: lersek@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 15:00:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtGfZ-0007Jb-6u
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbaKYOAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 09:00:36 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33286 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaKYOAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:00:35 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so908457wgh.26
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=nsqquoE6ZKqo2H/vkbkGVnoJnke7aY6OY2tQ+PhKdgg=;
        b=y+4AtuhPo9dkxynkuczwlC7f4/lLRLRqO+lffleCWRP6/b43g58OWCeQoO7UGpSSS5
         GqHJF3FM4lWJMWJ7+dH1i5yetEWt7eb1smtSVcSSw9bJDrHHG3OB2x9T/D91gKbYY3X8
         lRI5Q9mmiYmHWP3hB3Fkwr0ce+vXIqtSKGRFvqDCCN/739lNwsDHG7fPEyWmav/d5byD
         XoWSLEkcDqZelYP8ck3pISgJHCAYaB417R6bqdrtSik9MK87/eoHCiBaxA8Y8puSxnIG
         /TsCEAFdz1TCA9SJvndofExf3WZcTv0qydPRCrjvqaqztu5huh+h3iqydqkMMYYAHhw9
         DItA==
X-Received: by 10.180.21.210 with SMTP id x18mr32000214wie.19.1416924034442;
        Tue, 25 Nov 2014 06:00:34 -0800 (PST)
Received: from donizetti.redhat.com (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id cq4sm2005989wjc.35.2014.11.25.06.00.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 06:00:33 -0800 (PST)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260215>

From: Paolo Bonzini <pbonzini@redhat.com>

The thread at http://thread.gmane.org/gmane.comp.version-control.git/257392
details problems when applying patches with "git am" in a repository with
CRLF line endings.  In the example in the thread, the repository originated
from "git-svn" so it is not possible to use core.eol and friends on it.

Right now, the best option is to use "git am --keep-cr".  However, when
a patch create new files, the patch application process will reject the
new file because it finds a "/dev/null\r" string instead of "/dev/null".

The problem is that SMTP transport is CRLF-unsafe; "git am --keep-cr" is
mostly working by chance and it would be very problematic to have a "git
am" workflow in a repository with mixed LF and CRLF line endings.  It is
more robust to forgo readable patch files[1] and use the quoted-printable
transfer enconding.  This series adds an option and configuration key
to git-send-email that lets it automatically produce quoted-printable
or base64 messages.

Paolo

[1] A useful oneliner to decode quoted-printable files is the following:
    perl -pe 'use MIME::QuotedPrint; $_=MIME::QuotedPrint::decode($_);'

Paolo Bonzini (2):
  git-send-email: delay creation of MIME headers
  git-send-email: add --transfer-encoding option

 Documentation/config.txt               |   1 +
 Documentation/git-send-email.txt       |  10 +++
 contrib/completion/git-completion.bash |   4 +
 git-send-email.perl                    |  61 +++++++++++--
 t/t9001-send-email.sh                  | 157 +++++++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+), 6 deletions(-)

-- 
2.1.0
