From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Bug: git-push crash due to double-close of file descriptor
Date: Tue, 22 Oct 2013 12:25:03 +0200
Message-ID: <CAEef6Wx59OBQPG38Ww59vse7n1Xb=tpJANcM8iT66zpL9-dS1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 22 12:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYZ9F-0001ez-RW
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 12:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab3JVKZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 06:25:07 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41082 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3JVKZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 06:25:06 -0400
Received: by mail-la0-f47.google.com with SMTP id ep20so3747512lab.34
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 03:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=+3NqNix0mAqAlx14SlBgQUDF42aXDiYNwYYuZQ5RKss=;
        b=NFHK/U3sHXMuKcq7Z35KwZbN/vmgpbqLU2/9Om5+o/StGcJrg8M5B0KjZFikN6nZlp
         RtGLP1+u0rTLORe5iUhTTW9jyC9IJMaBW9A9wpotdlmgNeZs0pGjlWubVSoJokYwif23
         XTr01SKRuQ6SziYGOsjIih0f2e/Bd9zViZLfGI34DNMqHGEeAlfr8Jmj47PPZAct229j
         0xCns1CMdKDAR1Jv+Sng6+EqJ6FfFX8hA3Du2+EKhSHW5m6WuDIUqbOWBaDmJ+PaX6uB
         VAnRG9gcvq5VXwl4+MwAPyGIx3r8JxCyS73cw3LE29kff3K0Cfc/P6CBZtH8VjUXSSS9
         3D6w==
X-Gm-Message-State: ALoCoQkkYRx6gRS8SOu6bjyBMh7MuG3voaMfrfbXJNi/Ka+1E7MinoWL5/XyKVzJdvLnZqC7dn81
X-Received: by 10.112.72.197 with SMTP id f5mr393781lbv.59.1382437503944; Tue,
 22 Oct 2013 03:25:03 -0700 (PDT)
Received: by 10.112.56.171 with HTTP; Tue, 22 Oct 2013 03:25:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236461>

In a repository, I have a repeatable crash when pushing a ref to a
remote. The cause seems very simple, and it's more unclear to me why
this doesn't happen more often.

The cause, as I understand it:

git_transport_push() calls send_pack() which calls pack_objects()
which calls start_command(), which closes the output file descriptor
(known in start_command() as "cmd->out" and in git_transport_push() as
"data->fd[1]".)

git_transport_push(), immediately following the call to send_pack(),
also closes the file descriptor. Adding error handling to this close()
call shows that it fails with EBADF for a normal push (one that
doesn't crash.)

In my crashing scenario, the file descriptor has been reused between
the first close() and the second incorrect close(), for opening a pack
file. So the second close() closes the pack file, leaving a 'struct
packed_git' object with a "dangling" pack_fd member. Later on, mmap()
is called to map the contents of the pack file, but at this point the
file descriptor has been reused yet again for a zero-length lock file,
and so mmap() succeeds but returns no accessible memory, and we crash
when accessing it.

It would be trivial to fix this by simply removing the close() call in
git_transport_push(), but I imagine this might cause a file descriptor
leak in other cases instead.

Thoughts on this?

/ Jens
