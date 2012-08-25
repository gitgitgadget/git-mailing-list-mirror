From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH RFC 0/2] Mixing English and a local language
Date: Sun, 26 Aug 2012 02:26:54 +0700
Message-ID: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 21:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5M7M-0007SI-JC
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 21:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab2HYTdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Aug 2012 15:33:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44666 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab2HYTdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 15:33:11 -0400
Received: by pbbrr13 with SMTP id rr13so5316467pbb.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WipE5aQtkghqedXFSxjKqVo/M24MwoUh+Mp8KqL5OZ8=;
        b=k3YA3VriwgMz9wmKmSYWC6C3NV8kFlDhdFJQ2ZrSB+cxUAgL/ghYFQeqAQJRbh6pnW
         wp81MaJMK1kr4LAXEMbVKvJYzwh/6ltt9KkWQVmFWMv5CBol075Dp5JCiq/3T1r7jztM
         KQfaVh3qibQLC6ZceEgOZjC8HTVGrfy7yDkBwIeNBI53FbMStjIUi4pAPtwOC452xDXA
         R7TrtLHM41u4UWtikBAV+j7bigScyCH8r2wdFEKKHVkKFTARS/r4m6oiJxZBYGnNNuRF
         cYu0DcUprw5VK2A2Zszx4QQjhd+w8perue9coWt+g2RX/iT/e98luqSrmTo5npmnKJC+
         RIJw==
Received: by 10.68.138.166 with SMTP id qr6mr22413309pbb.69.1345923190692;
        Sat, 25 Aug 2012 12:33:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id po4sm7968060pbb.13.2012.08.25.12.33.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 12:33:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 26 Aug 2012 02:27:03 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204285>

The l10n effort leads to a situation where a contributor can submit a
patch with some auto-generated information in his language, which may
not be the team's language. We need to make sure exchange medium like
patch is always in a common language that the team understands.

Now this team language may not necessarily be English. However there
are technical difficulties involved in switching between two
languages. The only way I can think of, on top of gettext, is provide
git translations in multiple domains. Say diff machinery uses
"git-diff" domain while the rest is in "git". We can drive gettext to
use language X for diff machinery, and Y for the rest. For that, we
replace gettext() with dgettext().

It's cumbersome. And there has not been any sign that there will be
a real user for it. So I assume that the "team language" will always
be English. It's simpler and should cover 90% of the user base. If
someday people ask for that, supporting it is simply a matter of
rewriting C_() and CQ_() macros in the first patch to use dgettext()
instead.

Switching between a language and English is easier. We just need an
if/else to decide whether to call gettext(). Which is what the first
patch does, just for certain parts of diff machinery. Error messages
will alway be in native language.

The second patch puts format-patch output in English unconditionally.
Again I'm partly lazy and not so sure that there will be needs for
format-patch to produce in native language. If someone needs it, we
can introduce a new config key that flip no_l10n flag back to 0.

More commands may follow format-patch. I think that 'apply' should also
use English for non-tty output, unless users request it to be in local
language. IOW local language is treated pretty much like coloring.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  Allow to print diffstat in English regardless current locale
  format-patch: always print diffstat in English

 builtin/apply.c |  2 +-
 builtin/log.c   |  1 +
 diff.c          | 19 ++++++++++++-------
 diff.h          |  3 ++-
 4 files changed, 16 insertions(+), 9 deletions(-)

--=20
1.7.12.rc1.27.g6d3049b.dirty
