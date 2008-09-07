From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use GIT_COMMITTER_IDENT instead of hardcoded values in
 import-tars.perl
Date: Sun, 07 Sep 2008 10:09:25 -0700
Message-ID: <7vy723nare.fsf@gitster.siamese.dyndns.org>
References: <7v3arixm8h.fsf@gitster.siamese.dyndns.org>
 <1220777531-28934-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcNmY-000757-Qt
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbYIGRJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYIGRJc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:09:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbYIGRJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:09:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 772B75FEC1;
	Sun,  7 Sep 2008 13:09:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A597C5FEC0; Sun,  7 Sep 2008 13:09:27 -0400 (EDT)
In-Reply-To: <1220777531-28934-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Sun, 7 Sep 2008 10:52:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC11958C-7CFF-11DD-9AAF-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95151>

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
> http://marc.info/?l=git&m=120385776127178&w=2:
>> >  And that made me wonder if it wouldn't be worth, actually, to have
>> > git config user.name and git config user.email return the "magic" values
>> > gotten from guessing in ident.c when no value is in the config. That would
>> > allow scripts, which have no other simple means to get the user name and
>> > email, to have the same feature as builtins.
>>
>> Or perhaps use "git var GIT_COMMITTER_IDENT"?
>
> The only problem I see with this approach is that lots of uses of
> GIT_COMMITTER_IDENT require regex'ing the output to remove the date
> (see git-am, old git-commit and git-tag...)
>
> Maybe adding another variable not containing the date would be a
> good idea?

Looking at the two patches side-by-side makes me think your original from
from February actually is much better.

Why don't we apply your original, reproduced here for a quick round of
comment?

-- >8 --
From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Use user.name and user.email in import-tars.perl
Date: Sun, 24 Feb 2008 13:57:18 +0100

Mimic what is done in git-import.sh and git-import.perl

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 contrib/fast-import/import-tars.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 23aeb25..39c091c 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -14,8 +14,10 @@ die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
 
 my $branch_name = 'import-tars';
 my $branch_ref = "refs/heads/$branch_name";
-my $committer_name = 'T Ar Creator';
-my $committer_email = 'tar@example.com';
+chomp(my $committer_name = `git config user.name`);
+chomp(my $committer_email = `git config user.email`);
+die 'You need to set user name and email'
+  unless $committer_name && $committer_email;
 
 open(FI, '|-', 'git', 'fast-import', '--quiet')
 	or die "Unable to start git fast-import: $!\n";
