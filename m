From: Eugene Petrenko <eugene.petrenko@gmail.com>
Subject: deadlock git upload-pack command when GIT_TRACE is enabled
Date: Mon, 9 May 2016 19:49:01 +0200
Message-ID: <CAJNyVBAr7dJFxXA2+dXCJUMs=mB9u3-Ja7r4wemk9C_HBZ3W2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 19:49:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpJ9-0000rv-1w
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbcEIRtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:49:23 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35410 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcEIRtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:49:22 -0400
Received: by mail-lf0-f53.google.com with SMTP id j8so208122424lfd.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=qnezhRrN43xBLeKV73lTaEXekbimX8osro9D6d7LlUw=;
        b=yzvXdJ0nmWFLkQnuvUxSDEkLKXdLp1HnSBeX8nYP649uQQ+COLNYboKfRULEM6pwqD
         NN6Hal9sjbnLyXF5aHmOSaoj2ofiUPK6ckBn2m5Qn5Z9ECWxt2OQK8KjaQy68Kriw9+p
         ImM1s9KTpnzEJem7ELEFjz6GgJGyo9OQ1OmpWUwBuqPZhounTS4jwdV1exzqTzeiRvXn
         izfWvYBeAk0vgIc9qgzknyIKA9DshcFytxri1BCW3ZbHewVuMRfW7og2geJVxlt3+w0V
         kwdlV9oIhRRvoTVV3kr7z4eZpNi9E4WBOm/krOuKFbNj/crUpC5SXtp5njB5tlQmXoxR
         P6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qnezhRrN43xBLeKV73lTaEXekbimX8osro9D6d7LlUw=;
        b=TGnA12o6RO55+c/QJ3OL6BaIiD/oKPCeyXqBrqXpFwztubEr3NOCFSPmTRoguNyqIt
         SKx11G2vmRpChd+HnK4V1fHa7nD0osERZyWOAtaAC/L8H0jkGUZ/L55vL/nWGCjyWZCd
         3B8E6OV0U632uD8caih9D/8TxeGSI6P9jeMrOzDfP8dnN4feYQcqD/3L0Kf/qGgFoSjc
         AsM8ryvP3AO4Tu+SlTAE6GQJXdE8ILOCtO2TrhcBFypD+HIqMEEESABEujNiWNgyeJA+
         6Q++i3jZjDGk83b5ZgNIBtsgoBivReQchX/nUgCY7YYniwcHLXTycQ9vn66Rnd2bqG7p
         qgng==
X-Gm-Message-State: AOPr4FWVbYb2dQr1NIEiQZmhcQt1bNE1WsT3tjCtIDLFDy4Ae1kCME1jrdkYAwoMMpXyzNALVqZP2pjdqJ8w+w==
X-Received: by 10.112.7.137 with SMTP id j9mr15042259lba.4.1462816160709; Mon,
 09 May 2016 10:49:20 -0700 (PDT)
Received: by 10.112.61.4 with HTTP; Mon, 9 May 2016 10:49:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294029>

Hello,

I stuck around the deadlock inside git when running git upload-pack .
command. A debugging shown that the bottom process (it starts several
processes to implement the task) hangs writing to stderr. I managed to
reproduce the issue with a tiny bash script. The repository and the
script is found here
https://github.com/jonnyzzz/git-upload-pack-deadlock

I saw the issue reproducing both under Windows and Linux/Mac.

Windows thread dumps are available here
https://github.com/jonnyzzz/git-upload-pack-deadlock/tree/master/debug


According to those thread dumps I see the following problem around
upload-pack.c line 129. There the pack_objects command is executed.
First the wants block is pushed to the command, next the stdout
processing is started. This means, that pack_objects process output is
not processed until all output is put there. In the case I have, the
pack_objects process writes TRACE logging into stderr and eventually
(on hug repo) the OS buffer runs-out deadlocking the execution.


Best regards,
Eugene Petrenko
