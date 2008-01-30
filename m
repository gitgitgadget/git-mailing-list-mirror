From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-relink: avoid hard linking in objects/info directory
Date: Wed, 30 Jan 2008 00:01:06 -0800
Message-ID: <7vd4rjivy5.fsf@gitster.siamese.dyndns.org>
References: <479FAB9A.9040009@nrlssc.navy.mil>
	<b77c1dce0801292334p7c348744re6a7fdbb0f17d5b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 09:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7tI-0006L7-6p
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 09:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYA3IBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 03:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbYA3IBT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 03:01:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYA3IBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 03:01:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A07D6389F;
	Wed, 30 Jan 2008 03:01:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C053899;
	Wed, 30 Jan 2008 03:01:08 -0500 (EST)
In-Reply-To: <b77c1dce0801292334p7c348744re6a7fdbb0f17d5b3@mail.gmail.com>
	(Rafael Garcia-Suarez's message of "Wed, 30 Jan 2008 08:34:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72049>

"Rafael Garcia-Suarez" <rgarciasuarez@gmail.com> writes:

>>  opendir(D,$master_dir . "objects/")
>>         or die "Failed to open $master_dir/objects/ : $!";
>>
>> -my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
>> +my @hashdirs = grep !/^(\.{1,2}|info)$/, readdir(D);
>
> That looks a bit fragile. If the intent is to get a list of files in
> $master_dir, why not simply say:
>
> my @hashdirs = grep -f, readdir(D);
>
> That will appropriately skip ., .. and any other dirs.

The statement is trying to find directories whose names match
/^[0-9a-f]{2}$/ (two hexdigits) or /^pack$/.

But I do agree that listing things to skip is a fragile approach
than listing things you know are safe to relink.

How about doing it this way instead?

 git-relink.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-relink.perl b/git-relink.perl
index f6b4f6a..9101926 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -40,7 +40,7 @@ my $master_dir = pop @dirs;
 opendir(D,$master_dir . "objects/")
 	or die "Failed to open $master_dir/objects/ : $!";
 
-my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
+my @hashdirs = grep { ($_ eq 'pack') || /^[0-9a-f]{2}$/ } readdir(D);
 
 foreach my $repo (@dirs) {
 	$linked = 0;
