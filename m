From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: malloc fails when dealing with huge files
Date: Wed, 10 Dec 2008 16:16:17 -0800
Message-ID: <3ab397d0812101616t770e2a8dj2150cc630946917@mail.gmail.com>
References: <43c10b980812100742t3a65466yb9b7310bfedb2b18@mail.gmail.com>
	 <alpine.LFD.2.00.0812101121401.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Blanton" <jonathan.blanton@gmail.com>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZFJ-0007hr-4F
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYLKAQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYLKAQU
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:16:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40169 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYLKAQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:16:19 -0500
Received: by ug-out-1314.google.com with SMTP id 39so270033ugf.37
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zAdGowoHRJHlzhyO8zPW/8pP2th6NLc8Dp/a0M2wl6w=;
        b=DfFpkiUWE41dLvTTWahWxF9WYZTVF3eDGJaCtJZEybuqmiAby+iSZZqlscwjBuHuGr
         1LTDXyFfE12lXgb3k9uJ1lrsYE1ddwKd3XYKQBlrkd2jdg0ZKm14VtTEmGUUNGNAo8Lo
         eQ75LtZCd8e+XtXR1X2GyCbBFMjFzyiviqHgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IWYBKhTDnktr0U3O6QAsHHNFhryAc/eICWsJudgx8QNmp0fZ4chBQX0+EKnDv4wYP9
         OQ262J04TFRr9gXu7SZ9HG1XeIn1uurXVlnXl3lh1vh0/W+qm0A2ghrAVOOGg9SKp9up
         JxzNfq0TnmJy3Hyo+atJ5KVKv9oFw1P1KJqo4=
Received: by 10.67.116.9 with SMTP id t9mr4496074ugm.61.1228954577434;
        Wed, 10 Dec 2008 16:16:17 -0800 (PST)
Received: by 10.66.220.9 with HTTP; Wed, 10 Dec 2008 16:16:17 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812101121401.3340@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102749>

i tried to do something like that over a year ago, having gotten the
insane idea that i wanted to version my whole harddrive.  binaries
were a huge problem.

checkouts were also a problem over slow connections because there is
no git-clone --resume, so if your connection is interrupted, you're
back at square one.  perhaps git-torrent will fix that.

git wasn't supposed to be file based, as much as line/code based.  let
me know if you find a better alternative to git for filesystems.

it's too bad there's not a better way to keep resources tagged to a
version by a sha1, but keep source separate.

On Wed, Dec 10, 2008 at 11:32 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Wed, 10 Dec 2008, Jonathan Blanton wrote:
>>
>> I'm using Git for a project that contains huge (multi-gigabyte) files.
>>  I need to track these files, but with some of the really big ones,
>> git-add aborts with the message "fatal: Out of memory, malloc failed".
>
> git is _really_ not designed for huge files.
>
> By design - good or bad - git does pretty much all single file operations
> with the whole file in memory as one single allocation.
>
> Now, some of that is hard to fix - or at least would generate much more
> complex code. The _particular_ case of "git add" could be fixed without
> undue pain, but it's not entirely trivial either.
>
> The main offender is probably "index_fd()" that just mmap's the whole file
> in one go and then calls write_sha1_file() which really expects it to be
> one single memory area both for the initial SHA1 create and for the
> compression and writing out of the result.
>
> Changing that to do big files in pieces would not be _too_ painful, but
> it's not just a couple of lines either.
>
> However, git performance with big files would never be wonderful, and
> things like "git diff" would still end up reading not just the whole file,
> but _both_versions_ at the same time. Marking the big files as being
> no-diff might help, though.
>
>
>                        Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
