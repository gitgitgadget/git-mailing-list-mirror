From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] svn test: escape peg revision separator using empty peg
 rev
Date: Tue, 9 Oct 2012 01:41:45 -0700
Message-ID: <20121009084145.GA19784@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
 <50143E34.8090802@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 10:42:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLVOF-000456-V8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 10:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab2JIIl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 04:41:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39228 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2JIIly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 04:41:54 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4837579pad.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=idQNDwzZSDcyT38fr4g7DRsPCnADG/1LfMx8Izfz/38=;
        b=ZmZhWfJkDnchd0YvHmHWLL6rnxzcJuMoQhbcCMoRuuJNl9DOqCQ9XCNUgBuvnqioCd
         BrRFlntbx21JLpxRQsf234qcI1lELGAldaLyqa/uvgKQ2UuArPzECSJ7m+V3hCPll3A4
         9hVO6EDVzn6J3bWSC1rL2v8pV1DohDBI+DSi3hQxjQX9BTTGkJvEeJOg0DOrUkVPZuil
         65CGaW1IPpOMfdNCUozUTlSEnuMC4ePJI/37SJyiy3RRexksJFQK6le0FqLnAx13lP83
         3qKvvkHk5s5kS+POkfghVaauUeP8PECnrXSggbh1VG07cvR35zbJZAlW7PdgRg9TSTRn
         rscw==
Received: by 10.68.222.37 with SMTP id qj5mr60752445pbc.132.1349772114193;
        Tue, 09 Oct 2012 01:41:54 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qq9sm12081206pbb.24.2012.10.09.01.41.51
        (version=SSLv3 cipher=OTHER);
        Tue, 09 Oct 2012 01:41:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50143E34.8090802@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207309>

This test script uses "svn cp" to create a branch with an @-sign in
its name:

	svn cp "pr ject/trunk" "pr ject/branches/not-a@{0}reflog"

That sets up for later tests that fetch the branch and check that git
svn mangles the refname appropriately.

Unfortunately, modern svn versions interpret path arguments with an
@-sign as an example of path@revision syntax (which pegs a path to a
particular revision) and truncate the path or error out with message
"svn: E205000: Syntax error parsing peg revision '{0}reflog'".

When using subversion 1.6.x, escaping the @ sign as %40 avoids trouble
(see 08fd28bb, 2010-07-08).  Newer versions are stricter:

	$ svn cp "$repo/pr ject/trunk" "$repo/pr ject/branches/not-a%40{reflog}"
	svn: E205000: Syntax error parsing peg revision '%7B0%7Dreflog'

The recommended method for escaping a literal @ sign in a path passed
to subversion is to add an empty peg revision at the end of the path
("branches/not-a@{0}reflog@").  Do that.

Pre-1.6.12 versions of Subversion probably treat the trailing @ as
another literal @-sign (svn issue 3651).  Luckily ever since
v1.8.0-rc0~155^2~7 (t9118: workaround inconsistency between SVN
versions, 2012-07-28) the test can survive that.

Tested with Debian Subversion 1.6.12dfsg-6 and 1.7.5-1 and r1395837
of Subversion trunk (1.8.x).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Michael G Schwern wrote:
> On 2012.7.28 7:16 AM, Jonathan Nieder wrote:
>> Michael G. Schwern wrote:

>>> -		git rev-parse "refs/remotes/not-a%40{0}reflog"
>>> +		git rev-parse "refs/remotes/$non_reflog"
>>
>> Doesn't this defeat the point of the testcase (checking that git-svn
>> is able to avoid creating git refs containing @{, following the rules
>> from git-check-ref-format(1))?
>
> Unless I messed up, entirely possible as I'm not a shell programmer, the test
> is still useful for testing SVN 1.6.  Under SVN 1.6 $non_reflog should be
> 'not-a%40{0}reflog' as before.

Here's a patch to make the test useful again for SVN 1.7.  Sensible?

 t/t9118-git-svn-funky-branch-names.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 193d3cab..15f93b4c 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup svnrepo' '
 	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
 	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
-			"$svnrepo/pr ject/branches/not-a%40{0}reflog" &&
+			"$svnrepo/pr ject/branches/not-a@{0}reflog@" &&
 	start_httpd
 	'
 
-- 
1.7.10.4
