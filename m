From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] git-send-email.perl: Don't add header "In-Reply-To:" when --no-chain-reply-to set
Date: Wed, 1 Jul 2009 08:18:56 +0200
Message-ID: <200907010818.57050.markus.heidelberg@web.de>
References: <cover.1246404999.git.joe@perches.com> <a19204c574f407d98be74d54cfd899b43fdc7d26.1246404999.git.joe@perches.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 08:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLtAo-0006Fi-D4
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 08:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbZGAGTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 02:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbZGAGTv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 02:19:51 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47444 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbZGAGTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 02:19:50 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id D83F11079B6CD;
	Wed,  1 Jul 2009 08:18:28 +0200 (CEST)
Received: from [89.59.114.130] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MLt9I-0004rA-00; Wed, 01 Jul 2009 08:18:28 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <a19204c574f407d98be74d54cfd899b43fdc7d26.1246404999.git.joe@perches.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18WMyllspZohDwFX6u3wJLN8xRkEcUbP48kZ3DO
	6Zcfp71zQB2qc9gb65lk7O6mRe6R215pa1PoPLWSpTicllDtx+
	iiXvr4f+cFoJLGN/G7Fw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122565>

Joe Perches, 01.07.2009:
> using
>   git format-patch --thread=shallow -o <foo>
> and
>   git send-email --no-thread --no-chain-reply-to <foo>

I guess you meant --thread here.

> duplicates the headers
> 
>   In-Reply-To:
>   References:

I noticed the duplicated headers when fixing two bugs some weeks ago. I
guess to get rid of the duplicated headers, you have to parse the mail
that format-patch produces, since you don't have a clue, what
format-patch did. I'm not sure if it's worth it, if the duplicated
headers don't harm the email standard. It only complicates the tool.

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  git-send-email.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8ce6f1f..1b9b27e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1151,7 +1151,8 @@ foreach my $t (@files) {
>  
>  	# set up for the next message
>  	if ($thread && $message_was_sent &&
> -		($chain_reply_to || !defined $reply_to || length($reply_to) == 0)) {
> +	    ($chain_reply_to && 
> +	     (!defined $reply_to || length($reply_to) == 0))) {
>  		$reply_to = $message_id;
>  		if (length $references > 0) {
>  			$references .= "\n $message_id";

This part of git-send-email seems to be prone for errors, blame it and
you will see in the latest commits.

You should run at least the test from the test suite for the particular
command you change. Test 49 (threading but no chain-reply-to) from t9001
now fails.

That means, this will fail now (covered by test 49):

  git format-patch -o <foo>
  git send-email --thread --no-chain-reply-to <foo>

and also this (not covered by any test, maybe we should add one):

  git format-patch -o <foo>
  git send-email --thread --chain-reply-to <foo>
