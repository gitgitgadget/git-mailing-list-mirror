From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 18:48:49 -0700
Message-ID: <7vr6jk3qwu.fsf@gitster.siamese.dyndns.org>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net>
	<7vwstc68bk.fsf@gitster.siamese.dyndns.org>
	<20071024193954.GA5280@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Martin F Krafft <madduck@madduck.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 03:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkrqR-000678-QQ
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 03:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbXJYBs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbXJYBs7
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 21:48:59 -0400
Received: from rune.pobox.com ([208.210.124.79]:43160 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbXJYBs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 21:48:58 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0115814F79D;
	Wed, 24 Oct 2007 21:49:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E6FF14F87E;
	Wed, 24 Oct 2007 21:49:15 -0400 (EDT)
In-Reply-To: <20071024193954.GA5280@steel.home> (Alex Riesen's message of
	"Wed, 24 Oct 2007 21:39:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62257>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Oct 24, 2007 13:49:51 +0200:
>> Perhaps....
>> 
>>  git-remote.perl |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>> 
>> diff --git a/git-remote.perl b/git-remote.perl
>> index 9ca3e7e..4cee044 100755
>> --- a/git-remote.perl
>> +++ b/git-remote.perl
>> @@ -244,7 +244,8 @@ sub show_remote {
>>  	print "* remote $name\n";
>>  	print "  URL: $info->{'URL'}\n";
>>  	for my $branchname (sort keys %$branch) {
>> -		next if ($branch->{$branchname}{'REMOTE'} ne $name);
>> +		next if (!$branch->{$branchname}{'REMOTE'} ||
>
> just you never call yor branches "0".

Ok, that is about remote name '0' but whatever...

-- >8 --
[PATCH] git-remote: fix "Use of uninitialized value in string ne"

martin f krafft <madduck@madduck.net> writes:

> piper:~> git remote show origin
> * remote origin
>   URL: ssh://git.madduck.net/~/git/etc/mailplate.git
> Use of uninitialized value in string ne at /usr/local/stow/git/bin/git-remote line 248.

This is because there might not be branch.<name>.remote defined but
the code unconditionally dereferences $branch->{$name}{'REMOTE'} and
compares with another string.

Tested-by: Martin F Krafft <madduck@madduck.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 8e2dc4d..11630b1 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -244,7 +244,8 @@ sub show_remote {
 	print "* remote $name\n";
 	print "  URL: $info->{'URL'}\n";
 	for my $branchname (sort keys %$branch) {
-		next if ($branch->{$branchname}{'REMOTE'} ne $name);
+		next unless (defined $branch->{$branchname}{'REMOTE'} &&
+			     $branch->{$branchname}{'REMOTE'} eq $name);
 		my @merged = map {
 			s|^refs/heads/||;
 			$_;
-- 
1.5.3.4.1324.ga7925
