From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: git-push crash due to double-close of file descriptor
Date: Tue, 22 Oct 2013 17:49:05 +0700
Message-ID: <CACsJy8AxfFzL+2LGmqqyAm9dt7BZDpOYyrj4rgkXxgtozF7qiw@mail.gmail.com>
References: <CAEef6Wx59OBQPG38Ww59vse7n1Xb=tpJANcM8iT66zpL9-dS1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 12:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYZWu-0006oi-1F
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 12:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab3JVKtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 06:49:36 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40665 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab3JVKtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 06:49:35 -0400
Received: by mail-qc0-f174.google.com with SMTP id v1so5298361qcw.33
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PNmyHH1JkM19uBhuhiPiYkiBq/PI5xO2/GMqjXOF/Bw=;
        b=q7EoW0B5pmwv6yqdmQNlDkeHhnMG485ceiF8r4KTgNT0UhOh+xSmtqxI0/oXzTMNjV
         gbYSCTf0zPZT/PpDYdHlL5nnvS/ZIhBVMti2zEQY7aV0U6xV6KleDtrkFse7+fcnlNI1
         Q9UZTJ8ddcVPHdsJLJu7nKLWPhaCFxSRJSVjACnblZ1Lkwp5cTamI6x266Y+CyPEp7Ak
         tDN6n0FVX34raqIDtUn3VSo98Y2AkXvfUDPBkPyO1oaJ4V/eY2Pd6e6cj3IqHzlx/OAW
         masLZ4peX+u11qbtExLHBvONLfQlkS3+W1XdzthAtSEK1vUUrihx8uMWXB1KS4ur5wK+
         TbjQ==
X-Received: by 10.224.7.194 with SMTP id e2mr29501267qae.46.1382438975052;
 Tue, 22 Oct 2013 03:49:35 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Tue, 22 Oct 2013 03:49:05 -0700 (PDT)
In-Reply-To: <CAEef6Wx59OBQPG38Ww59vse7n1Xb=tpJANcM8iT66zpL9-dS1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236462>

On Tue, Oct 22, 2013 at 5:25 PM, Jens Lindstr=C3=B6m <jl@opera.com> wro=
te:
> In a repository, I have a repeatable crash when pushing a ref to a
> remote. The cause seems very simple, and it's more unclear to me why
> this doesn't happen more often.
>
> The cause, as I understand it:
>
> git_transport_push() calls send_pack() which calls pack_objects()
> which calls start_command(), which closes the output file descriptor
> (known in start_command() as "cmd->out" and in git_transport_push() a=
s
> "data->fd[1]".)
>
> git_transport_push(), immediately following the call to send_pack(),
> also closes the file descriptor. Adding error handling to this close(=
)
> call shows that it fails with EBADF for a normal push (one that
> doesn't crash.)
>
> In my crashing scenario, the file descriptor has been reused between
> the first close() and the second incorrect close(), for opening a pac=
k
> file. So the second close() closes the pack file, leaving a 'struct
> packed_git' object with a "dangling" pack_fd member. Later on, mmap()
> is called to map the contents of the pack file, but at this point the
> file descriptor has been reused yet again for a zero-length lock file=
,
> and so mmap() succeeds but returns no accessible memory, and we crash
> when accessing it.
>
> It would be trivial to fix this by simply removing the close() call i=
n
> git_transport_push(), but I imagine this might cause a file descripto=
r
> leak in other cases instead.
>
> Thoughts on this?

set fd[1] =3D 0 after calling pack_objects() in send_pack() so that the
close() in git_transport_push() becomes no-op (with EBADF)? Another
option is dup() it first before passing to send_pack(), but I'm not
sure if it has any bad effects on start_command() and friends, or
Windows.
--=20
Duy
