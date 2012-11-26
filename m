From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 00:14:06 +0100
Message-ID: <CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
	<CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
	<20121126220108.GB1713@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 00:14:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td7se-0002XB-2T
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab2KZXOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:14:08 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40052 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222Ab2KZXOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:14:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so11740074oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1/mwvvNhplrs06rGQDM4zo4grkLKaZpjs4zWFq1oHkI=;
        b=MoFQFWpcUSYwT0wYsIo5B//sVkaHcINgHJLQlC/vT+guvJpF5FYQa9hb4nD0nEi07K
         ettYr69aY9sB9V7ctSLc/kCVf8tbWSZIvlZ/1s7ND3jMv40tJsG/4E2SrcNOmPYgXG9Y
         W8Hd/HEvIep3Q5UmFbrggaPGL/cYIbYwfq7DiC3qAUm0VW+gOtl2bpau84gzhesp5TXq
         BvzGa/2f8j2UNPzp3kzXOil8pckCOPVbnfRH/ozSZClRSlsJBNeYQmJcOU4jIT8cTJlI
         wRE8EklMAnCjP7+Gc0xpnItclGPdFL+I+fG/fRlq7JpSwITvRsEjnGOeoM8snt2LDJaR
         /38w==
Received: by 10.60.31.6 with SMTP id w6mr10607748oeh.65.1353971647168; Mon, 26
 Nov 2012 15:14:07 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 15:14:06 -0800 (PST)
In-Reply-To: <20121126220108.GB1713@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210512>

On Mon, Nov 26, 2012 at 11:01 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> 1) I tried it, and it doesn't seem to import (pack?) are repository
>> with sub-directories in it
>
> I'll make sure my regression test checks this case.  The options to git
> ls-files are a bit confusing and it's possible my invocation of it
> needs to change.

Might be easier to just call 'git ls-files --with-three foo', but I
don't see the point of those calls:

% git --work-tree=unpacked/1 checkout master
% git --work-tree=unpacked/1 add -A

Should work just fine.

>> 2) Using 'git fast-import' is probably simpler, and more efficient
>
> That might well be.  I'm not worried about "efficiency" in this context
> but reducing the code size is significant and I'm willing to re-code
> to do that.

I don't see how the code-size would increase dramatically.

>> Here is a proof of concept I wrote in ruby that is half the size, and
>> seems to implement the same functionality.
>
> Not anywhere near the same.  It only handles commits, not tags.

The attached code doesn't handle tags either.

> It doesn't issue delete ops.

What do you mean?

    out.puts 'deleteall' <- All current files are removed

And then added.

> And it doesn't rebuild branch heads.

What do you mean? Your code only exports a single branch, the branch
that is currently checked out. And then:

git reset --hard >/dev/null; git checkout master >/dev/null 2>&1

It's resuming to 'master', which might not be the branch the user had
checkout out, and might not even exist.

> If I were willing to omit those features, I'm sure I could halve
> the size of my implementation, too.  Of course, it would then be
> almost completely useless...

That's what the code currently does.

Do you want me to show you step by step how they do *exactly the
same*? Of course, I would need to fix your version first so that it
doesn't crash with sub-directories.

>>                           The format is exactly the
>> same, but I think it should be modified to be more efficient.
>
> I'm not wedded to the log format as it is, so I'll cheerfully
> take suggestions about it.
>
> Be aware, however, that I consider easy editability by human beings
> much more important than squeezing the last microsecond out of the
> processing time.  So, for example, I won't use data byte counts rather
> than end delimiters, the way import streams do.

Well, if there's a line with a single dot in the commit message ('.'),
things would go very bad.

Personally I would prefer something like this:

tag v0.1 gst-av-0.1.tar "Release 0.1"
tag v0.2 gst-av-0.2.tar "Release 0.2"
tag v0.3 gst-av-0.3.tar "Release 0.3"

And the script in bash would be very simple:

#!/bin/sh

tag() {
	d=`mktemp -d` &&
	(
	cd $d &&
	tar -xf "$orig/$2" &&
	cd * &&
	git add --all &&
	git commit -q -m "$3" &&
	git tag $1) || error=1
	rm -rf $d
	test -n "$error" && exit -1
}

orig="$PWD"
repo="$1"

git init -q $repo
export GIT_DIR="$orig/$repo/.git"

source "$orig/$2"

cd "$orig/$repo" && git reset -q --hard

-- 
Felipe Contreras
