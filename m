From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 11:21:03 -0400
Message-ID: <20060530152103.GB8931@trixie.casa.cgf.cx>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net> <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net> <7vu0782e33.fsf@assigned-by-dhcp.cox.net> <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 30 17:21:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl61u-0007vU-LL
	for gcvg-git@gmane.org; Tue, 30 May 2006 17:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWE3PVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 11:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWE3PVF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 11:21:05 -0400
Received: from pool-71-248-179-19.bstnma.fios.verizon.net ([71.248.179.19]:56784
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S932312AbWE3PVD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 11:21:03 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 4CD3413C020; Tue, 30 May 2006 11:21:03 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>, Ryan Anderson <rda@google.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21033>

On Tue, May 30, 2006 at 03:23:30PM +0200, Alex Riesen wrote:
>>--- a/git-send-email.perl
>>+++ b/git-send-email.perl
>>@@ -387,7 +387,9 @@ X-Mailer: git-send-email $gitversion
>>                my $pid = open my $sm, '|-';
>>                defined $pid or die $!;
>>                if (!$pid) {
>>-                       exec($smtp_server,'-i',@recipients) or die $!;
>
>This construction (perl pipe+fork) will not work on ActiveState Perl
>(it does not even parse the construct).
>Last time the problem arised it was suggested to replace readers
>with "qx{command}". Regretfully there were no writer case back
>then. I'd suggest using IPC::Open2 for portability. Like this:
>
> use IPC::Open2;
> my $fw;
> my $pid = open2(">&1", $fw, "perl", "-w");
> print $fw "exit 0\n";
> close($fw);'
>
>But I wont. It was never portable in windows, no matter how hard
>I tried. The best result was getting output from "cat -v", but "cat"
>froze afterwards anyway, as "wc" or "perl" did. Besides, it the
>command often freezes that poor imitation of xterm windows has.

I assume that "the poor imitation of xterm" is referring to cygwin's
xterm here.  It's really too bad that you can't get into the mindset of
reporting problems to the cygwin mailing list when you notice them.

I can't comment on the proposed patch since, AFAIK, using cat, wc, and
(cygwin's) perl should all work just fine but I don't think it is ever
correct to complain about a platform in released software.

cgf

>---
> t/t9001-send-email.sh |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)
>
>diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>index a61da1e..c3a3737 100755
>--- a/t/t9001-send-email.sh
>+++ b/t/t9001-send-email.sh
>@@ -25,6 +25,11 @@ test_expect_success \
>      git add fake.sendmail
>      GIT_AUTHOR_NAME="A" git commit -a -m "Second."'
> 
>+if test "$(uname -o)" = Cygwin; then
>+    say "git-send-mail tests disabled on Windows"
>+    # because of windows being such a crap
>+else
>+
