From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] clone: regression in error messages in master
Date: Thu, 20 Jun 2013 18:46:55 +0530
Message-ID: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:17:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upek8-0003A5-UB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595Ab3FTNRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:17:37 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46477 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab3FTNRg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:17:36 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so16510995ief.12
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=s+YojzHNHeMdsAmsOPC33JQTRvZbnv6Yl2EEPAN5ZGI=;
        b=u7Ck5kt2dkeeSqx22tylkUEdX0T/2n4EPmzzoWyCRwE4yYKLfdbSlGjzc2a1NDF1uo
         yU0zCoHnd9J6hfNe/S1gi26UnhC91agn1VqVPUTH/lKKGzjD7Zc5OrxZMHjFEmqe51yW
         IJBGs3T6zWq4bkHlKfQzEkuqVsOZc1ytg1esSOpM60KBl2rhaCk/RXQA5AfphPrx4ue6
         cqKTLzWzhC96t6vxE/hb8tm16tMoLMEghh7NBWnDskzCKnbgO2zGBzHsDcOmWZqors4t
         M0N1bEgHvaoa7DGlg+4/5+YrxUuRMKYOfGvJFZQNBcdcywIG/sFUuWEJJ0T9zDq9zfLW
         9K4Q==
X-Received: by 10.50.98.104 with SMTP id eh8mr12314792igb.111.1371734255932;
 Thu, 20 Jun 2013 06:17:35 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 06:16:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228498>

Hi,

So this should explain the problem:

  # using v1.8.3.1
  $ git clone https://google.com
  Cloning into 'google.com'...
  fatal: repository 'https://google.com/' not found

  # using master
  $ git clone https://google.com
  Cloning into 'google.com'...
  fatal: repository 'https://google.com/' not found
  fatal: Reading from helper 'git-remote-https' failed

To figure out where the regression was coming from, I ran a bisect
with this script:

  #!/bin/sh
  make clean &&
  make -j 8 &&
  cd t &&
  sh -v -i clone-message.sh

where clone-message.sh is:

  test_description=clone-message

  . ./test-lib.sh

  test_expect_success setup '

  	rm -fr .git &&
  	test_create_repo src &&
  	(
  		cd src &&
  		>file &&
  		git add file &&
  		git commit -m initial &&
  		echo 1 >file &&
  		git add file &&
  		git commit -m updated
  	)

  '

  test_expect_success 'clone invalid URL' '
  	rm -fr dst &&
  	test_must_fail git clone https://google.com 2>msg &&
  	test_i18ngrep "repository .* not found" msg &&
  	! test_i18ngrep "git-remote-https" msg
  '

  test_done

The bisect pointed me to: 81d340d4 (transport-helper: report errors
properly, 2013-04-10).

  $ git clone https://google.com
  Cloning into 'google.com'...
  fatal: https://google.com/info/refs?service=git-upload-pack not
found: did you run git update-server-info on the server?
  fatal: Reading from remote helper failed

What?!  Okay, the last "Reading from remote helper failed" was
introduced by this commit; my clone-message.sh has a bug.  So I
commented out the first test_i18ngrep and ran it.  Result: c096955
(transport-helper: mention helper name when it dies, 2013-04-10).
This is not the real culprit: it just changed the message string that
81d340d4 originally introduced.

Okay, so am I reporting a valid bug?  Going through remote-curl, I can
see that it dies in remote-curl.c:213 if HTTP_TARGET_MISSING.  If that
is the case, what is the point of printing the second message about
the remote helper program not being present?

Thanks.
