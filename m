From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/Makefile: remove cmd-list.made before redirecting to it.
Date: Mon, 06 Aug 2007 23:33:42 -0700
Message-ID: <7vlkcn97ll.fsf@assigned-by-dhcp.cox.net>
References: <86vebsby27.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIdd-0006U4-2G
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbXHGGdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbXHGGdt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:33:49 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33843 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbXHGGds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:33:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807063343.UPIT1335.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 02:33:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YuZi1X00a1kojtg0000000; Tue, 07 Aug 2007 02:33:43 -0400
In-Reply-To: <86vebsby27.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Mon, 6 Aug 2007 15:05:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55223>

David Kastrup <dak@gnu.org> writes:

> If cmd-list.made has been created by a previous run as root, output
> redirection to it will fail.  So remove it before regeneration.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  Documentation/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 97ee067..120e7c0 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -120,6 +120,7 @@ $(cmds_txt): cmd-list.made
>  
>  cmd-list.made: cmd-list.perl $(MAN1_TXT)
>  	perl ./cmd-list.perl
> +	$(RM) $@
>  	date >$@
>  
>  git.7 git.html: git.txt core-intro.txt

Although I understand that it would be a problem if you built as
root earlier, which would have left files unmodifyable by you, I
think this is getting out of hand.  The cmd-list.perl script
itself, for example, does "creat in $out+, if the contents have
changed from the last round then rename $out+ to $out" sequence
in order to avoid unnecessary rebuild of files that depend on
the generated command list.  If it is interrupted in the middle
while running as root, and then you try to do another build, I
suspect "creat in $out+" part would fail.

Maybe you can simply recover from such an error with a "make
clean"?

Also I'd prefer $(RM) before actually running the command to
generate the list, but that is just the matter of taste.
