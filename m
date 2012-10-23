From: Max Nanasy <max.nanasy@gmail.com>
Subject: [BUG] (git commit --patch --message $MESSAGE) disallows hunk editing
Date: Mon, 22 Oct 2012 22:48:27 -0700
Message-ID: <CAM998vGieYU+8s1ermDJSfT8Zu8jDRS4WLjypraoB3iOf+qH7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQXLz-00052M-O6
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 07:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab2JWFs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 01:48:28 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:60778 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2JWFs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 01:48:27 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2701460iag.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=nofasSgnXJ9f5YyY1jukA6ZM8DorKWRB+kjdWvuFsSI=;
        b=ILUFeuD40zPej5UqkcqzxBiFkT2RX5RNoKYbNSkMupz4oL5H1sduPHY9c6HTQEPtOC
         cMYIO+dpOkjpjUy4yfqKddFE3cDDNeJmDD8nmA7T6KT0ILuCVu+TRfakZnvOBMPc8q/L
         Z85x9+F/uInlnZLGFXtQkdPAGL2txG/XYCtFpAoATPEFrA7Erhd8Uck603b5wylV4jZX
         jB6zYHq11S+fb8AnLIB4m8hfU39Fmv0Poe57jwzqwcDZLmSf8NSzu76P5y1EGCus5id5
         zGMTp3HUaiaho2c8kowDbBR4gQDioPNHPKQXLU1QTnHdte8lCbvrl7O1tj40p/rShCdd
         ccRA==
Received: by 10.50.140.97 with SMTP id rf1mr16998785igb.70.1350971307252; Mon,
 22 Oct 2012 22:48:27 -0700 (PDT)
Received: by 10.64.127.33 with HTTP; Mon, 22 Oct 2012 22:48:27 -0700 (PDT)
X-Google-Sender-Auth: nXcZAwonhzf1IvxcTXAAF-SEZ0k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208213>

Tested against v1.7.12.4

Steps to reproduce:
	A. cd $DIRTY_WORKING_COPY
	B. git commit --patch --message $MESSAGE
	C. Stage this hunk? e
Expected behavior:
	After step C, the hunk opens in the user's editor
Actual behavior:
	After step C, the hunk is selected unedited (as if the user had entered "y")

AFAICT, this occurs because of the following code in
builtin/commit.c:parse_and_validate_options:
	if (... || message.len || ...)
		use_editor = 0;
	...
	if (!use_editor)
		setenv("GIT_EDITOR", ":", 1);
Because --message is specified, GIT_EDITOR is set to ":", which
prevents the user from editing hunks, although the intent is most
likely to just prevent the user from editing the commit message.
