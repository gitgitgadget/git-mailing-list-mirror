From: Kevin Ballard <kevin@sb.org>
Subject: `git status --porcelain` disagrees with documentation about quoting filenames with spaces
Date: Wed, 27 Oct 2010 16:57:52 -0700
Message-ID: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 28 01:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBFsd-0001H6-04
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 01:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757543Ab0J0X6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 19:58:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45738 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522Ab0J0X56 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 19:57:58 -0400
Received: by gxk23 with SMTP id 23so875836gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 16:57:58 -0700 (PDT)
Received: by 10.90.3.24 with SMTP id 24mr1751022agc.63.1288223877992;
        Wed, 27 Oct 2010 16:57:57 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id z23sm241169yhc.32.2010.10.27.16.57.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 16:57:56 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160137>

According to the manpage for git-status:

       The fields (including the ->) are separated from each other by a single
       space. If a filename contains whitespace or other nonprintable
       characters, that field will be quoted in the manner of a C string
       literal: surrounded by ASCII double quote (34) characters, and with
       interior special characters backslash-escaped.

This is no longer true for filenames with spaces in them. I did some digging and I believe this changed 5 years ago in 28fba290 (Do not quote SP). My inclination is to say that the documented behavior should be restored, at least for the case of a copy/rename, simply for the sake of removing ambiguity in weird cases like the following:

> ls
a  b
> git mv a 'a -> a with spaces'
> git status --porcelain
R  a -> a -> a with spaces

Given that --porcelain is supposed to be machine-readable, this last line is unexpected, as it can be parsed in two different ways. Restoring the behavior of quoting filenames with spaces, at least for copies/renames, would fix this problem.

Given that the removal of quoting for filenames with spaces was an intentional change, does anybody have any strong opinions about whether we should restore the quotes in this scenario? The alternative is to simply change the documentation, but the un-parsability of the --porcelain format has me worried.

Note: this was prompted by a user on the #git IRC channel who was trying to parse the --porcelain format, specifically for parsing renames, and was surprised by the output not conforming to the documentation. I pointed him at the -z flag, but I still believe the non-z case should be fixed.

-Kevin Ballard