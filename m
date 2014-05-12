From: Jeff King <peff@peff.net>
Subject: Re: Git abuses qt4-ssh-askpass
Date: Mon, 12 May 2014 16:46:42 -0400
Message-ID: <20140512204642.GC2329@sigill.intra.peff.net>
References: <CAMw+j7L1YkwjYZibOpuJDnC3FjaRZgBCKBMQcUyT9uRis3heFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris =?utf-8?B?4oCcS3dwb2xza2HigJ0=?= Warrick 
	<kwpolska@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 22:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjx7Z-0002zR-9E
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 22:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758625AbaELUqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 16:46:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:50180 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756136AbaELUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 16:46:44 -0400
Received: (qmail 23887 invoked by uid 102); 12 May 2014 20:46:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 15:46:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 16:46:42 -0400
Content-Disposition: inline
In-Reply-To: <CAMw+j7L1YkwjYZibOpuJDnC3FjaRZgBCKBMQcUyT9uRis3heFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248732>

On Sat, May 10, 2014 at 10:41:28AM +0200, Chris =E2=80=9CKwpolska=E2=80=
=9D Warrick wrote:

> when I=E2=80=99m using the HTTPS protocol to access repositories, a w=
indow
> from /usr/bin/qt4-ssh-askpass comes up.  It asks for my =E2=80=9CSSH =
pass
> phrase=E2=80=9D, twice.  Sadly, it=E2=80=99s wrong.  The actual thing=
s it wants is the
> username in the first case, and the password used to access the remot=
e
> repository (eg. my GitHub password) in the second question.  This is =
a
> bug, and very misleading behavior.

If you have GIT_ASKPASS or SSH_ASKPASS set and git needs to prompt for =
a
username or password, it will call that program rather than prompting o=
n
the terminal. It does pass a meaningful label to the askpass program,
but it sounds like your askpass program does not actually display it.

E.g., try setting GIT_TRACE=3D1. I get:

  $ GIT_TRACE=3D1 SSH_ASKPASS=3Dssh-askpass-fullscreen git fetch
  trace: built-in: git 'fetch'
  trace: run_command: 'git-remote-https' 'origin' 'https://github.com/p=
eff/test'
  trace: run_command: 'ssh-askpass-fullscreen' 'Username for '\''https:=
//github.com'\'': '
  trace: run_command: 'ssh-askpass-fullscreen' 'Password for '\''https:=
//peff@github.com'\'': '

and the askpass program shows me those prompts. You may want to file a
bug report with qt4-ssh-askpass, as most other askpass programs
(including the original ssh-askpass that comes with ssh) respects the
prompt arguments.

That being said, we may be able to improve git, depending on what you
actually wanted to happen. For example, I don't think there is a way to
tell git "even though I have SSH_ASKPASS set, still prompt me on the
terminal". It's been generally assumed that you would only set that
variable if you preferred an external prompt to a terminal prompt.

You may also want to look into git's credential support (see "git help
credential"), which can let you store the username and password in
secure system-provided storage (however from the qt4 above, I guess you
might be using KDE, and I do not know of a KDE Wallet helper; there is
one for GNOME keyring).

-Peff
