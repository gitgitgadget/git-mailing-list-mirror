From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
Subject: Incremental use of fast-import may cause conflicting notes
Date: Wed, 23 Nov 2011 13:09:34 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-544561601-1322050174=:5099"
Cc: Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 13:39:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTC78-0001LS-US
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 13:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab1KWMjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 07:39:40 -0500
Received: from mail.roxen.com ([212.247.29.220]:40813 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab1KWMjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 07:39:39 -0500
X-Greylist: delayed 1795 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Nov 2011 07:39:39 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 9B06B6280CC;
	Wed, 23 Nov 2011 13:09:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2L+e8gshYKz; Wed, 23 Nov 2011 13:09:34 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id AE3F6628188;
	Wed, 23 Nov 2011 13:09:34 +0100 (CET)
X-X-Sender: grubba@shipon.roxen.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185845>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-544561601-1322050174=:5099
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Hi.

Background: I have an incremental repository-walker creating a 
corresponding documentation repository from a source repository
that uses git-notes to store its state, a use for which notes
seem very suitable.

Problem: When the number of notes in the root of the notes branch
increases beyond a threshold, fast-import changes the fanout. This 
is as designed, but the problem is that when fast-import is restarted
it won't remember the fanout, and will start writing files in the root 
again. This means that there may be multiple notes-files for the same 
commit, eg both de/adbeef and deadbeef.

This is not what the user expects, and is not good practice, even if it in 
this case actually works, since the latter is defined to have priority.
I'm however not sure if eg fast_import.c:do_change_note_fanout() will do 
the right thing if/when the fanout is changed again.

The problem is probably due to b->num_notes not being initialized properly 
when the old non-empty root commit for the notes branch is loaded in 
parse_from()/parse_new_commit().

My workaround for now is to use filedeleteall and restore all the notes
by hand in the first new commit on the notes branch.

Version of git: 1.7.6.4 (gentoo)

Thanks,

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-544561601-1322050174=:5099--
