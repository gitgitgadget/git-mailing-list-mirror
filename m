From: Caspar Zhang <caspar@casparzhang.com>
Subject: [BUG] incorrect search result returned when using git log with a
 future date parameter
Date: Wed, 30 Jan 2013 19:30:46 +0800
Message-ID: <51090466.9070105@casparzhang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gris Ge <fge@redhat.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 12:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Vsz-0006U6-TT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 12:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab3A3LbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 06:31:05 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36406 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab3A3LbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 06:31:01 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so915938pbc.35
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 03:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding:x-gm-message-state;
        bh=EydpjvF7mXL73tSlpnHe93nV4Yq1JCjp1RZuCbrDg1Y=;
        b=g4TgJgQSYPHSMDtEnfIIptxqDazpchD5z5sUiVO7Drpg0Odl0TImQb7o6GMWwnVNyz
         LYzyNwJkHBZYtZFSHV9T9D2aD4U1Dc7OUVF40RtTrZqgmfPw77A6OY40npRssS3xxq7B
         h4hPDDXs/BgvwWXchD/lKQvE93c71MPPuAMQVUbh5h9IbkKm7jsf15C62KJeJpuv0Q1t
         dGJokfww9cluk0hoj/k5Zqu0r9Bom2B1/pvhRF/XybwtQz9BuKcWZbK/+ECYtjjUpsOX
         8Jfm0qvS28SSIMimHdsXOvdHU7yozgCIREHspo4rbpWOe3i+7YUhzs4E19rJ4mChOEjb
         BuxQ==
X-Received: by 10.68.220.197 with SMTP id py5mr11640476pbc.13.1359545460333;
        Wed, 30 Jan 2013 03:31:00 -0800 (PST)
Received: from [10.208.11.194] (nat-pool-sin2-t.redhat.com. [209.132.188.254])
        by mx.google.com with ESMTPS id l5sm1795081pax.10.2013.01.30.03.30.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 03:30:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Gm-Message-State: ALoCoQkzI82LgEQRotuS5ng+SWrYk4yg3z6WONRJs+0fVr2VThpvOKwnb84t1rUejm7Ve5IQ215u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215009>

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
