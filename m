From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 7 Oct 2007 22:04:35 -0400
Message-ID: <20071008020435.GA20050@coredump.intra.peff.net>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 04:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IehzF-0007n2-NH
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 04:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbXJHCEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 22:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbXJHCEj
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 22:04:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2493 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbXJHCEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 22:04:38 -0400
Received: (qmail 9066 invoked by uid 111); 8 Oct 2007 02:04:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Oct 2007 22:04:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2007 22:04:35 -0400
Content-Disposition: inline
In-Reply-To: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60275>

On Sat, Oct 06, 2007 at 03:54:06PM -0500, Shawn Bohrer wrote:

> +static int remove_directory(const char *path)
> +{
> [...]
> +		chdir(path);
> [...]
> +	chdir("..");

This doesn't always put you back where you started, due to symlinks. For
example:

cat >foo.c <<'EOF'
int main(int argc, char **argv) {
  chdir(argv[1]);
  chdir("..");
  execlp("ls", 0);
}
EOF
gcc -o foo foo.c
ln -s /tmp sub
./foo sub

will show that you end up in the root directory.  Something like this is
more robust:

  fd = open(".", O_RDONLY);
  chdir(path);
  ...
  fchdir(fd);

In general, you shouldn't end up there because you don't actually
recurse for symlinks, but there is a race condition (and losing it means
you start recursively removing unintended directories -- oops).

On top of which, this line from the same function isn't very portable:

+                       if (dir->d_type == DT_DIR)

since POSIX specifies nothing but dir->d_name (Solaris, for example,
doesn't define d_type). You need to stat the file.

All of that being said, I think a lot of this is already done in
dir.[ch]. At the very least, you should be able to use
remove_dir_recursively, and for bonus points you can get rid of the
start_command call to ls-files by just walking the dir tree yourself.
I don't know if the latter is required, but it's nice when the
C-ification actually cleans up a bit and uses the internal C interfaces
(which are more efficient and often more clear to read) rather than just
converting shell to C.

-Peff
