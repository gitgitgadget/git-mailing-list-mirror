From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Wed, 14 May 2014 05:54:40 +0700
Message-ID: <CACsJy8CVK1codmuSvUyeVYo1d-nQ6thoV8pn1WN_8D8doYXu5g@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
 <1399747109.11843.137.camel@stross> <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
 <1399848982.11843.161.camel@stross> <CACsJy8C_j2bKVwqOQtOqGFkc_-_AmY=bQXquRfL-aqk=z9YKdw@mail.gmail.com>
 <1400020707.14179.13.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:55:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLbV-0006ZY-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbaEMWzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:55:18 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:51745 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaEMWzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:55:16 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so1483431qge.22
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3RIELRyiqwMjUGpxFGSVXtME7rroJ5y5ReivAvuKrvU=;
        b=XCIxdqP2wnTX5/MQpkTjkZ4/bo7lpnq+ipScdDfun+hsVDWCBhUtwIL2jSsn47x0Qr
         eiZh0r1wOe8sw3Lz3/9GbsImfnb0jUuwzh77HsAJo7IO0zYkp2bk2NeIkgM2qJRxNHJn
         Hn3ZActmT0nKKGbAYTULa3IKPYkVZc6FGVopfAyU7kQdElIYgpmZ7THlIbqxGNFcCxmE
         dgPQrX6XFs4IfxaEsyGKmJjOan6GUcRFy7FcHGDvMFd1gAnKnEnnQ2gKtPzno/o+ATKO
         F3VRr5iOQ93oXmyJ7m967vm4H+POs+mP6eQyvE82hnfbc76Gdz4tlYr5+Hy2Ltm1LXFb
         T8bg==
X-Received: by 10.140.107.198 with SMTP id h64mr49392993qgf.30.1400021710999;
 Tue, 13 May 2014 15:55:10 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 13 May 2014 15:54:40 -0700 (PDT)
In-Reply-To: <1400020707.14179.13.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248881>

On Wed, May 14, 2014 at 5:38 AM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2014-05-12 at 17:45 +0700, Duy Nguyen wrote:
>> This is your quote from above, moved down a bit:
>>
>> > update_fs_cache should only have to update based on what it has learned
>> > from watchman.  So if no .gitignore has been changed, it should not have
>> > to do very much work.
>> >
>> > I could take the fe_excluded check and move it above the
>> > last_exclude_matching check in fs_cache_is_excluded; it causes t7300 to
>> > fail when run under watchman but presumably that's fixable
>>
>> So you exclude files early and make the real read_directory() pass do
>> pretty much nothing. This is probably not a good idea. Assume that I
>> touch $TOP/.gitignore then do something other than "git status" (or
>> "git add") then I have to pay read_directory() cost.
>
> I'm not sure I understand this. read_directory does something: it checks
> the fs_cache (instead of the filesystem) for untracked files.

A lot of commands do read_cache() that that eventually calls
update_fs_cache, which does part of read_directory's work (the
fe_excluded thing). But not many of those commands actually call
read_directory(). It'd better if there's a way to mark that "this
.gitignore is changed", but delay the actual exclude processsing until
we are sure read_directory() will be used.
-- 
Duy
