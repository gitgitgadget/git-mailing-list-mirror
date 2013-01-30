From: Caspar Zhang <caspar@casparzhang.com>
Subject: [BUG] incorrect search result returned when using git log with a
 future date parameter
Date: Wed, 30 Jan 2013 19:28:04 +0800
Message-ID: <510903C4.6060809@casparzhang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gris Ge <fge@redhat.com>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 12:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0VqL-0005QH-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 12:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab3A3L2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 06:28:19 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52225 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141Ab3A3L2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 06:28:18 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so163098pbc.39
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 03:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding:x-gm-message-state;
        bh=EydpjvF7mXL73tSlpnHe93nV4Yq1JCjp1RZuCbrDg1Y=;
        b=jW0CSPXj96CQTpFsSg+lgjv7Jyqx9cqpZ+SO9fBlkY7ErWwAcfCNegHst3c8O4Ebex
         sqEi+tE4sd4Vdg0XAwHlfWplGpRTU1JsLeG4OzwGbHvT6mu4YDFj/Fa/eGpYi1sp1tMi
         UulBDjfgph4yqXz5gv/Gmfu/JgvJmaakvf+HokQhxCqVSrUQEOG6hCA09v4BiAfhiO9u
         DKaBP0J+zPZs2Pf6LkfDpP8KUek4YztVI4OwTKWxD6G9S4eh4wGKvK0sp+QXnGylnvVh
         FiYM5YmBQr9S/YtkA1Oi2wyUZHchWEabb8802jXpNe/5nzP4z0P9hL6uAkDBfvB6yIwk
         yWww==
X-Received: by 10.68.220.198 with SMTP id py6mr11619329pbc.119.1359545297567;
        Wed, 30 Jan 2013 03:28:17 -0800 (PST)
Received: from [10.208.11.194] (nat-pool-sin2-t.redhat.com. [209.132.188.254])
        by mx.google.com with ESMTPS id i5sm1788260pax.13.2013.01.30.03.28.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 03:28:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Gm-Message-State: ALoCoQlRZcJfURInxJjtqYL4yr2t3YrULQdW1TQLEIfAihGjt1DAQ4Kx8TStDAt1zkpCsDbD9i6j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215008>

Hi there,

when I'm using the commit limit option `--before/--until` when doing 
`git log` search, I meet a bug when the upper-bound date is 10days later 
in the future. Here is an example:

$ date +%F
2013-01-30
$ git log --oneline --since=2013-01-01 --until=2013-02-01
<several git log entry from 2013-01-01 to 2013-01-30 printed>
$ git log --oneline --since=2013-01-01 --until=2013-02-13
<null>

I debugged into the problem with ./test-date program in git source tree, 
got:

$ ./test-date approxidate 2013-02-01
2013-02-01 -> 2013-02-01 10:47:13 +0000   // correctly parsed
$ ./test-date approxidate 2013-02-13
2013-02-13 -> 2013-01-02 10:47:20 +0000   // incorrectly parsed

When looking into the codes of date.c, in is_date() function, I found:

  382         /* Be it commit time or author time, it does not make
  383          * sense to specify timestamp way into the future.  Make
  384          * sure it is not later than ten days from now...
  385          */
  386         if (now + 10*24*3600 < specified)
  387                  return 0;
  388         tm->tm_mon = r->tm_mon;
  389         tm->tm_mday = r->tm_mday;
  390         if (year != -1)
  391                 tm->tm_year = r->tm_year;
  392         return 1;

If I comment Line 386 & 387 out, the parsing works correctly. So I guess 
here is the cause of the problem.

Then I checked the git history, the change was introduced in commit 
38035cf4 by Junio C Hamano (cc-ed):

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
commit 38035cf4a51c48cccf6c5e3977130261bc0c03a7
Author: Junio C Hamano <junkio@cox.net>
Date:   Wed Apr 5 15:31:12 2006 -0700

     date parsing: be friendlier to our European friends.

     This does three things, only applies to cases where the user
     manually tries to override the author/commit time by environment
     variables, with non-ISO, non-2822 format date-string:

      - Refuses to use the interpretation to put the date in the
        future; recent kernel history has a commit made with
        10/03/2006 which is recorded as October 3rd.

      - Adds '.' as the possible year-month-date separator.  We
        learned from our European friends on the #git channel that
        dd.mm.yyyy is the norm there.

      - When the separator is '.', we prefer dd.mm.yyyy over
        mm.dd.yyyy; otherwise mm/dd/yy[yy] takes precedence over
        dd/mm/yy[yy].

     Signed-off-by: Junio C Hamano <junkio@cox.net>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It seems like the original commit was going to fix European date style, 
but it fixed(?) the future date problem as well. However, this part of 
fix is not perfect:

1) it makes date parsing not working correctly. (see my test examples 
above).

IMO, it should be in another place (maybe in commit.c or somewhere 
else?) we check if commit date is valid or not, instead of in the date 
parsing function. A date parsing function should parse _all dates with 
correctly format_, despite if it's an old date, or the date in the future.

2) from the test example I gave above, in fact the codes don't really 
prevent git from accepting the changes with illegal date, e.g., if there 
is a commit recorded as "2013-02-13", it will be parsed to "2013-01-02", 
which is a legal (old) date, thus, this commit will be accepted, but 
this is wrong.

My suggestion is we might need to revert the first part of commit 
38035cf4 since this part of code doesn't work correctly and causes 
problems; then we should create a new checking mechanism to prevent 
those "future date commits" to be accepted in other functions. I'm not 
able to do the second part since I'm not familiar with git codes yet.. :-(

Thoughts?

Caspar
