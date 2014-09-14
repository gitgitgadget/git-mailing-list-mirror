From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] t1503: test rev-parse --verify --quiet with deleted
 reflogs
Date: Sun, 14 Sep 2014 11:54:04 -0700
Message-ID: <20140914185403.GA93515@gmail.com>
References: <1410683442-74523-1-git-send-email-davvid@gmail.com>
 <5415C069.9000702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 20:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTEw9-0002vb-LD
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 20:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbaINSyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 14:54:09 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:65129 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaINSyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 14:54:08 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so4733268pdj.20
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NpkA85jotnId8oakUvJvWerB5yY8MqupGm4vMBMpzJs=;
        b=DmfM8Hnp7sDLGvO02+joGCXPl7xtvCrseEO327/ugBA6nlD7UzmqAAdDEahQ/HdRd3
         qgxM0pGajGZOGdBRgsQoLaexEO+wOQfRSFXApYBn0ezko89qtWMeZZoVY6p1zBZ13s0o
         D4043nRAKOts1KNOEiVuC87XrnBnkBsMIt3F78BWIp3d2OZcAJckt4r8kE7Wt/yIjBl8
         b4so6h13zODFqhlSMsQ0V1dMf56hFbtPY+lLRMC27frukCrQi/hJUQ96tAOAbVyLmO7P
         5u9YllHQ/RjyNhoa1kmcYCBsp3wuphLADn8VzCbyC98qwaqySsaO4HGwRSGOuvItbSjr
         4ufg==
X-Received: by 10.66.236.38 with SMTP id ur6mr31986493pac.49.1410720847578;
        Sun, 14 Sep 2014 11:54:07 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ow8sm9351104pbb.62.2014.09.14.11.54.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 11:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5415C069.9000702@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257022>

On Sun, Sep 14, 2014 at 06:20:57PM +0200, Fabian Ruch wrote:
> Hi David,
> 
> On 09/14/2014 10:30 AM, David Aguilar wrote:
> > Ensure that rev-parse --verify --quiet is silent when asked
> > about deleted reflog entries.
> > 
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > This verifies and depends on "refs: make rev-parse --quiet actually quiet".
> > 
> >  t/t1503-rev-parse-verify.sh | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> > index 813cc1b..731c21c 100755
> > --- a/t/t1503-rev-parse-verify.sh
> > +++ b/t/t1503-rev-parse-verify.sh
> > @@ -83,6 +83,15 @@ test_expect_success 'fails silently when using -q' '
> >  	test -z "$(cat error)"
> >  '
> >  
> > +test_expect_success 'fails silently when using -q with deleted reflogs' '
> > +	ref=$(git rev-parse HEAD) &&
> > +	: >.git/logs/refs/test &&
> > +	git update-ref -m test refs/test "$ref" &&
> 
> I'm just curious, why not simply
> 
>    git branch test
> ?

Maybe it's a bad reason, but I wanted to replicate the behavior
that git stash expects -- it writes to a ref outside of
refs/heads/.  I thought it'd be good to exercise that same
machinery since it will involve different code paths.

> > +	git reflog delete --updateref --rewrite refs/test@{0} &&
> > +	test_must_fail git rev-parse --verify --quiet refs/test@{0} 2>error &&
> 
> Is it a shortcoming of the specification that it doesn't consider
> whatever might be written to stdout? Is it acceptable that if the
> git-rev-parse command succeeds, the error message from test_must_fail
> will be written to the file "error" and, therefore, somewhat hidden from
> the user running the tests?

Good point. The --quiet spec doesn't say anything about stdout,
but for this test it probably wouldn't hurt to capture both
stdout and stderr and assert emptiness.

I can reroll this patch so that 2>error becomes >error 2>&1.

> > +	test -z "$(cat error)"
> 
> test(1) comes with an option (-s) to perform such tests and test-lib.sh
> defines test_must_be_empty which additionally outputs the given file's
> contents if its not empty.

test_must_be_empty would be a good fit here.  That said, none of
the other tests in this file use test_must_be_empty.

It might be worth doing a follow-up patch that converts all of the
tests in this file to use test_must_be_empty instead of
test -z "$(cat error)".  I'll reroll.

Thanks,
-- 
David
