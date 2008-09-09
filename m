From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2] git-rebase--interactive: auto amend only edited commit
Date: Tue, 9 Sep 2008 11:00:55 +0400
Message-ID: <20080909070055.GB28210@dpotapov.dyndns.org>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> <1220906569-26878-2-git-send-email-dpotapov@gmail.com> <7viqt6cg4t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 09:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcxEt-0007ZT-PY
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 09:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbYIIHBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 03:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYIIHBC
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 03:01:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:30489 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbYIIHBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 03:01:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1740067fgg.17
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rT6oV+X96R/VeKT1t7JKNiXftS2BIRfBHmXl1JClo1o=;
        b=Cl7hsD6U8PSAlvlZpPhM/n01QrvLUkF/6H+ZRMf2kAh/0LWam+oDs/afjUkaMD4oqk
         87BI5waeNm08gZzR8yam88IP032ofy4eEDC7GGV2+ZajdJi9qrAgbU0YfX2FmIkZmeR1
         squHBpnBYEZXy4Iu7s0lZvL4jRqDmUSVUcYk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=taq3yhUAH2EEpF+Rk64/REfzW9sb80db90YcpxQmjrCIn/SLgXoCPhnfEgjjCxZxO3
         Bdxj3v6a8atrOjlTBhXnbHZy9PYYPnhTuGubi5BxLLk+8M/rY4dzI53pNyTxmuriGqyZ
         sBlTRJAbpu0dLmRW5BBfhCR/kG8jYgg5FHC/s=
Received: by 10.86.97.20 with SMTP id u20mr12044862fgb.15.1220943658891;
        Tue, 09 Sep 2008 00:00:58 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id l12sm6338056fgb.6.2008.09.09.00.00.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 00:00:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viqt6cg4t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95343>

On Mon, Sep 08, 2008 at 05:33:22PM -0700, Junio C Hamano wrote:
> I may not be reading your patch correctly; I am confused by what you are
> trying to do.
> 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 5b2b1e5..84721c9 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -284,7 +284,7 @@ do_next () {
> >  		pick_one $sha1 ||
> >  			die_with_patch $sha1 "Could not apply $sha1... $rest"
> >  		make_patch $sha1
> > -		: > "$DOTEST"/amend
> > +		echo $sha1 > "$DOTEST"/amend
> 
> You record the $sha1 from the TODO file.

Oops... I should have gone to bed instead of sending this patch...

> 
> Perhaps you wanted to record the value of the HEAD in the first hunk?

You are asbolutely right. It should be:

	git rev-parse --verify HEAD > "$DOTEST"/amend

> 
> How would this change interact with the workflow of splitting existing
> commits, described at the end of git-rebase documentation?

It is not affected, because accordingly to the documentation, you
commit all your changes "until your working tree is clean."

However, if you forgot to commit your changes, without my patch
you may lose some of your splitting work. Here is the script that
demonstrates the problem

-- >8 --
#!/bin/sh

set -e

rm -rf git-test
mkdir -p git-test
cd git-test

git init
for ((i=0;$i<10;i++)) do echo $i; done > foo
git add foo
git commit -m 'add foo'

sed -e 's/^0$/first line/;s/^9/last line/' < foo > tmp
mv tmp foo
git add foo
git commit -m 'change foo'

echo bar > bar
git add bar
git commit -m 'more changes'

git log
echo '==='

GIT_EDITOR='sed -e '\''s/pick \(.* change foo\)/edit \1/'\'' < "$1" > tmp && mv tmp' git rebase -i HEAD~2

git reset HEAD^

{ echo y; echo n; } | git add -p

git commit -m 'commit chunk 1'

git add foo
# If I commit chunk 2 then everything will be fine with and without
# my patch
#
#   git commit -m 'commit chunk 2'
#
# However, if I forgot to commit chunk 2 then without my patch rebase
# will lose my work on splitting these chunks!
#
# With my patch, it will error out: You have uncommitted changes

GIT_EDITOR=cat git rebase --continue

git log
-- >8 --


Dmitry
