From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Refactor git_tcp_connect() functions a little.
Date: Tue, 06 Jun 2006 21:53:04 -0700
Message-ID: <7vy7w9lg7j.fsf@assigned-by-dhcp.cox.net>
References: <E1FnpBp-00043u-Uc@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 06:54:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnq3S-00041w-80
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 06:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWFGExH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 00:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWFGExH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 00:53:07 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:30116 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750855AbWFGExG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 00:53:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607045305.HDWB12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 00:53:05 -0400
To: Jon Loeliger <jdl@jdl.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21428>

Jon Loeliger <jdl@jdl.com> writes:

> Add client side sending of "\0host=%s\0" extended
> arg for git native protocol, backwards compatibly.
>
> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> ---
>  connect.c |   42 ++++++++++++++++++++++++++++++++----------
>  1 files changed, 32 insertions(+), 10 deletions(-)
>
> I've tested this against an "old" daemon, and my new daemon
> running on jdl.com that understands the new host=%s parameter.
> Both appear to work still.

Thanks.

> However, I don't have a setup to test a proxy connection,
> and I left FIXME: down there asking the question if it is
> even needed in this case as well.  I _think_ so, but I am
> just not sure.  (It should be a straight pass-through to
> another git: native protocol, right?)

I think so.

> And if it is needed there too, do you want to refactor
> these two packet_writes() for commonality again?

Let me munge that part and push it out.  I've tested it lightly
both with and without proxy.  My proxy was a single liner shell
script:

	nc -o /var/tmp/nc.log localhost 9418

whose dump started with this nice request packet:

> 00000000 30 30 35 62 67 69 74 2d 75 70 6c 6f 61 64 2d 70 # 005bgit-upload-p
> 00000010 61 63 6b 20 2f 6f 70 74 2f 70 61 63 6b 72 61 74 # ack /opt/packrat
> 00000020 2f 70 6c 61 79 70 65 6e 2f 70 75 62 6c 69 63 2f # /playpen/public/
> 00000030 69 6e 2d 70 6c 61 63 65 2f 67 69 74 2f 67 69 74 # in-place/git/git
> 00000040 2e 6a 75 6e 69 6f 00 68 6f 73 74 3d 6c 6f 63 61 # .junio.host=loca
> 00000050 6c 68 6f 73 74 3a 34 34 33 33 00                # lhost:4433.

for a request "peek-remote git://localhost:4433/opt/.../git.junio".

I suspect that a real git proxy, if somebody ever writes one,
would read the first outgoing packet reads the request
(including this host= stuff) and connect to the true destination
intelligently after sending out a modified request packet.

Takers?
