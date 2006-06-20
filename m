From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Tue, 20 Jun 2006 01:58:56 -0700
Message-ID: <7vr71kcien.fsf@assigned-by-dhcp.cox.net>
References: <1150609831500-git-send-email-octo@verplant.org>
	<Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>
	<20060619212116.GL1331@verplant.org>
	<7vac8860z9.fsf@assigned-by-dhcp.cox.net>
	<4497AED4.5060505@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 10:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsc4n-00078t-AV
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 10:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWFTI66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 04:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWFTI66
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 04:58:58 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20162 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965082AbWFTI65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 04:58:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620085857.EXFK11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 04:58:57 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4497AED4.5060505@lsrfire.ath.cx> (Rene Scharfe's message of
	"Tue, 20 Jun 2006 10:16:20 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22182>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> BTW, I think we would probably want to have this patch on top of
>> Rene's patch.  In all instances, the variable "buf" is of type
>> "const char *" and the existing casts do not make sense to me.
>> 
>> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
>> index 5c8a5f0..39a61b6 100644
>
> Your patch reverts builtin-tar-tree.c to the version which is
> currently both in master and next, which I think is a good
> change.  However, could it be avoided at merge time?

Sorry for attributing those "casts [that] do not make sense to
me" to you -- it is not your code but part of Florian's patch.

I think applying the patch in question on top of Florian's 11172e
would be the most sensible, since that is currently the tip of ff/c99
topic branch whose early parts have been merged to "next" and
the tip to "pu".  When Linus feels as sympathetic as I do, we
can pull the rest of ff/c99 branch to "next" and then eventually
to "master" and the patch will be merged together without
introducing the nonsense casts.

Another possibility is to amend the tip of ff/c99 topic branch,
since it is not merged to "next" yet.  I promised not to rewind
"master" nor "next", but never made promises not to rewind "pu",
so it is a fair game.  I think it is simpler and cleaner, so
that will be what I will do.

> OT: I found the blobs 5c8a5f0 and 39a61b6 by guessing (they are
> builtin-tar-tree.c in pu and master, respectively).  OK, that
> was easy.  But is there a way to reversely look up an object
> without guessing, i.e. find out which commit(s) introduced a
> certain blob?

You could do something like this (totally untested).

Going from the above "diff --git" index line you have object
name abbreviations and pathnames as clues.  To take advantage of
it, you could use "git rev-list pu -- builtin-tar-tree.c"
instead of unlimited list.

$ git rev-list pu |
  git diff-tree -r --stdin --pretty |
  perl -e '
	my @lines = ();
        sub flush_em {
        	my @found = ();
                my @comment = ();
		for my $l (@lines) {
                	if ($l !~ /^:/) {
				push @comment, $l;
				next;
			}
                        for (@ARGV) {
                        	if ($l =~ / $_/) {
                                	push @found, $l;
					last;
				}
                        }
                }
		if (@found) {
			print join("", @comment, @found);
                }
                @lines = ();
	}
        while (<STDIN>) {
        	if (/^commit [0-9a-f]{40}$/) { flush_em(); }
                push @lines, $_;
	}
        flush_em();
  ' 39a61b6 5c8a5f0
