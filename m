From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 11:10:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806111105150.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>  <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>  <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>  <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
  <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>  <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>  <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>  <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
  <832adb090806102318k5727bb06p6c3211a6aebbfbe9@mail.gmail.com>  <alpine.LFD.1.10.0806110752550.3101@woody.linux-foundation.org> <832adb090806111052p32a750c2n5f2d43e0ed1b910d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Up7-0000JT-IA
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbYFKSLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbYFKSLK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:11:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43190 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932385AbYFKSLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 14:11:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BIAa9A030869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2008 11:10:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BIAYxm010508;
	Wed, 11 Jun 2008 11:10:35 -0700
In-Reply-To: <832adb090806111052p32a750c2n5f2d43e0ed1b910d@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.372 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84630>



On Wed, 11 Jun 2008, Ben Lynn wrote:
> 
> I don't think the memcmp is slow. I think the ce_modified_check_fs in:
> 
> smudge() {
>    ...
>   if (ce_match_stat_basic(ce, &st))
>                 return;
>   if (ce_modified_check_fs(ce, &st))
>                 ce->ce_size = 0;
> }
> 
> is potentially slow, and I'm saying you could replace it with
> 
> smudge() {
>    ...
>   if (ce_match_stat_basic(ce, &st))
>                 return;
>   ce->ce_size = ~0;
> }
> 
> to avoid the ce_modified_check_fs call. But it is an unclean solution,
> which is why I champion having an extra flag per file.

Well, you have to think about what you want to optimize here.

The thing we want to optimize is not the writing of the index file, but 
the subsequent _use_ of it!

As such, the last thing we actually want to do is to smudge the index file 
entry. If it actually has a possibility of being not smudged, we're much 
better off saying "hey, now the index file is newer, and the file it 
refers to is all good!"

That way, we won't have to do the ce_modified_check_fs() call later - we 
do it just once, and the file is up-to-date.

So we don't want to smudge it, but if the stat information says it migth 
match even though it doesn't, we have to. But if the stat information says 
it matches, and the data actually _does_ match, then we shouldn't smudge 
it, we should be happy - and all subsequent users of the index will then 
know that they don't even need to look at the file contents.

			Linus
