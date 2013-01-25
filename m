From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v4 3/4] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Fri, 25 Jan 2013 13:07:08 +0400
Message-ID: <20130125130708.75224a8b@ashu.dyn1.rarus.ru>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com>
	<7vr4la9uqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:07:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfGB-0001N7-4B
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab3AYJHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:07:17 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37660 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3AYJHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:07:13 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so308742lbb.40
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=p+CPgHqmfOmTzvag2jKXCj6cdS6c9e3CetK2PYziVG4=;
        b=VM1lX5ZWCpEXG+GyKyDTRPRErP/bmprHYiEGlzr1HOnLVJ9avNZtkwUQcqrJXUKXVu
         XFCnzB9DV9xoOiyXY1/j1Cl9ni6Wo66MgRAvF7SUhFZaqfZEX+OQfI+PbtPlOrDQpxPW
         NLpBwv+4fsgg+ZX6giH7HfqBa0V/ffnQz8X5yTv0mhFAGUASuStJWgLG3S96zJA25j9v
         djLaKANWWqvQ5duRF4DZhDiks3W5jf47y0CKotRTk0s2Ft4MD85pgE34JB7h5GQrJiom
         sN7CNOa0TcL6sXiT2RFOlPpmsq6zzl63GMf3njuzha712i93t8wOmXIa7S4SY/HJGzhC
         9jqA==
X-Received: by 10.112.26.70 with SMTP id j6mr1929818lbg.55.1359104831442;
        Fri, 25 Jan 2013 01:07:11 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id gi3sm168248lab.7.2013.01.25.01.07.10
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:07:11 -0800 (PST)
In-Reply-To: <7vr4la9uqo.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214521>

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > The following two commands are expected to give the same output to
> > a terminal:
> >
> > 	$ git log --oneline --no-color
> > 	$ git log --pretty=format:'%h %s'
> >
> > However, the former pays attention to i18n.logOutputEncoding
> > configuration, while the latter does not when it format "%s".
> > Log messages written in an encoding i18n.commitEncoding which
> > differs from terminal encoding are shown corrupted with the latter
> > even when i18n.logOutputEncoding and terminal encoding are the same.
> >
> > The same corruption is true for
> > 	$ git diff --submodule=log
> > and
> > 	$ git rev-list --pretty=format:%s HEAD
> > and
> > 	$ git reset --hard
> >
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > ---
> >  t/t4041-diff-submodule-option.sh | 33 ++++++++-------
> >  t/t4205-log-pretty-formats.sh    | 43 +++++++++++++++----
> >  t/t6006-rev-list-format.sh       | 90
> > ++++++++++++++++++++++++++--------------
> > t/t7102-reset.sh                 | 32 +++++++++++--- 4 files
> > changed, 138 insertions(+), 60 deletions(-)
> >
> > diff --git a/t/t4041-diff-submodule-option.sh
> > b/t/t4041-diff-submodule-option.sh index 32d4a60..e7d6363 100755
> > --- a/t/t4041-diff-submodule-option.sh
> > +++ b/t/t4041-diff-submodule-option.sh
> > @@ -1,6 +1,7 @@
> >  #!/bin/sh
> >  #
> >  # Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
> > +# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding
> > tests) #
> >  
> >  test_description='Support for verbose submodule differences in git
> > diff @@ -10,6 +11,7 @@ This test tries to verify the sanity of the
> > --submodule option of git diff. 
> >  . ./test-lib.sh
> >  
> > +added=$(printf
> > "\320\264\320\276\320\261\320\260\320\262\320\273\320\265\320\275")
> 
> Please have an in-code comment before this line to explain what this
> variable is about, e.g.
> 
> 	# String "added" in Russian, encoded in UTF-8, used in
>         # sample commit log messages in add_file() function below.
>         added=$(printf "...")
Ok!

> 
> >  add_file () {
> >  	(
> >  		cd "$1" &&
> > @@ -19,7 +21,8 @@ add_file () {
> >  			echo "$name" >"$name" &&
> >  			git add "$name" &&
> >  			test_tick &&
> > -			git commit -m "Add $name" || exit
> > +			msg_added_cp1251=$(echo "Add $name ($added
> > $name)" | iconv -f utf-8 -t cp1251) &&
> > +			git -c 'i18n.commitEncoding=cp1251' commit
> > -m "$msg_added_cp1251" done >/dev/null &&
> >  		git rev-parse --short --verify HEAD
> >  	)
> 
> Does this patch make the all tests in this script fail for people
> without cp1251 locale installed?  We already have tests that depend
> on 8859-1 and some other locales, and we'd be better off limiting
> such dependency to the minimum.
Hmmm, I'll try to feign something to avoid using cp1251

> 
> Same comment applies to the changes to other test scripts.
> 
> Thanks.
