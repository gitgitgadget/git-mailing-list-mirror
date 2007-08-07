From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Fix support for symlinks.
Date: Tue, 07 Aug 2007 01:40:53 -0700
Message-ID: <7vtzrb68kq.fsf@assigned-by-dhcp.cox.net>
References: <200708071025.47965.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Han-Wen Nienhuys" <hanwen@google.com>,
	Brian Swetland <swetland@google.com>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 10:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIKce-0000lz-5Z
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 10:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbXHGIk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 04:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757977AbXHGIk4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 04:40:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64895 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738AbXHGIkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 04:40:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807084054.WSWP7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 04:40:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ywgt1X00L1kojtg0000000; Tue, 07 Aug 2007 04:40:54 -0400
In-Reply-To: <200708071025.47965.simon@lst.de> (Simon Hausmann's message of
	"Tue, 7 Aug 2007 10:25:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55233>

Simon Hausmann <simon@lst.de> writes:

> Detect symlinks as file type, set the git file mode accordingly and strip off the trailing newline in the p4 print output.
>
> Signed-off-by: Simon Hausmann <simon@lst.de>
> ---
>  contrib/fast-import/git-p4 |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 41e86e7..9c6f911 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -839,11 +839,15 @@ class P4Sync(Command):
>              if file["action"] == "delete":
>                  self.gitStream.write("D %s\n" % relPath)
>              else:
> +                data = file['data']
> +
>                  mode = 644
>                  if file["type"].startswith("x"):
>                      mode = 755
> -
> -                data = file['data']
> +                elif file["type"] == "symlink":
> +                    mode = 120000
> +                    # p4 print on a symlink contains "target\n", so strip it off
> +                    data = data[:-1]
>  
>                  if self.isWindows and file["type"].endswith("text"):
>                      data = data.replace("\r\n", "\n")

Thanks for a quick fix.

Brian, does this resolve the issue for you?  I do not have an
access to p4 myself so I won't make a good judge in this area
myself.  An Ack is appreciated.

Simon, just a style nit.

Every time I see decimal integers 644 and/or 755, it interrupts
my flow of thought and forces me to read the change and its
surrounding text needlessly carefully.

If you read the code, you can see that this "mode" variable is
formatted with ("%d" % mode) for writing out, and is not used as
permission bit pattern in any bitwise operations, so you can
tell that these constants _are_ safe.  But it takes extra
efforts to convince yourself that they indeed are.

I would prefer this kind of thing to be written as either:

	mode = 0644
        "%o" % mode

or

	mode = "644"
        "%s" % mode

to make it clear that the author knew what he was doing when he
wrote the code.
