From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 0/5] gitweb: Improve search code
Date: Wed, 22 Jun 2011 13:10:39 -0400
Message-ID: <4E02220F.10800@cisco.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 19:11:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZQx9-0003ua-Sx
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 19:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab1FVRKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 13:10:53 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:54996 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab1FVRKw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 13:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2873; q=dns/txt;
  s=iport; t=1308762652; x=1309972252;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=H1k8oXnF7q3pVO50ksJ1mthF+mnNEwHxUku+yGnD/28=;
  b=hg5byPEDU89J7OKV52dbCbaRjYFhE/JyYomzb6ZxgFOukw4BuN2nY49U
   EPxc2YNiIjoA3l8qek+r2U6H6MWtlZIYPXHX/vpyS28VfNbVwEOPgG0u6
   VNlLSpQ65d6pPZjmWyodgfiHaeasHtb/qNiIdxfAhMB17lPmUnTLiHIRO
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EANogAk6rRDoH/2dsb2JhbABUpxB3qlmeTYYtBJFqhGWLQw
X-IronPort-AV: E=Sophos;i="4.65,407,1304294400"; 
   d="scan'208";a="719690896"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by sj-iport-6.cisco.com with ESMTP; 22 Jun 2011 17:10:41 +0000
Received: from [10.117.80.99] (rtp-hordp-8912.cisco.com [10.117.80.99])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p5MHAePc028245;
	Wed, 22 Jun 2011 17:10:40 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110622131039607
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176248>

Admin note: Should I have changed the subject or kept it?

On 06/22/2011 11:28 AM, Jakub Narebski wrote:
> P.S. Another addition that I sometimes wanted git to have would be
> 'filename' or 'find' search: searching for file by name.
>
> What do you think of it?

I like it.  +1 from me.

I normally revert to 'git log --name-status | less <CR> /filename.foo',
which is awful, of course.  I've always assumed there's a better way I
haven't discovered yet.  But if there is, well... I haven't discovered
it yet.

This syntax works on some files, but is limited and/or broken:
   # Finds all commits touching the file named './foo.bar', iff
./foo.bar exists in the current commit.
   git log -- foo.bar

I say 'broken', but maybe it's not; it feels like it is when I do this:

   # Returns zero logs
   git log -- some-deleted-file.txt

   # Returns at least two logs
   git log --all -- some-deleted-file.txt

I think I understand why that happens (search optimization), but it is
unexpected from the user's perspective.  I also suspect it will miss the
'pre-resurrection' commits for files which were deleted and resurrected
in the past.


What do you think of these as new 'Commit limiters' for git log:

       --name=<pattern>, --name-glob=<glob>
           Limit the commits output to ones touching files that match the
           specified pattern (regular expression) or glob (shell glob
pattern).

This could be further modified by --diff-filter, --all-match, etc.

   # Find all commits which deleted a file named **/foo.**
   git log --name="/foo[.]" --diff-filter=D

   # Find all commits which deleted a file named **/foo.**
   #   or one named **/bar.**
   git log --name="/foo[.]" --name="/bar[.]" --diff-filter=D

   # Find all commits which touched both a file named **/foo.**
   #   and one named **/bar.**
   git log --name="/foo[.]" --name="/bar[.]" --all-match


Or this alternate form:

       --name-pattern, --name-glob
           Treat all <path> selectors as pattern (regular expression) or
glob (shell glob pattern).

I think I prefer the former, since the latter does not allow for a
combination of raw names, pattern names and glob names.  Also, it does
not (intuitively) support --all-match.

   # Find all commits which deleted a file named **/foo.**
   git log --name-pattern --diff-filter=D -- "/foo[.]"
   git log --name-glob --diff-filter=D -- "/foo.*"

   # Find all commits which deleted a file named **/foo.**
   #   or one named **/bar.**
   git log --name-pattern --diff-filter=D -- "/foo[.]" "/bar[.]"

   # Find all commits which touched both a file named **/foo.**
   #   and one named **/bar.**
   #  -- Can't be done?

Finally, do the extensions belong on rev-list as well?  The 'git
rev-list' command seems underpowered compared to 'git log'.

Phil
