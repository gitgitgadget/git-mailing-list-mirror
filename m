From: Paul Betts <paul@paulbetts.org>
Subject: Path character encodings
Date: Mon, 5 Mar 2012 13:26:57 -0800
Message-ID: <20120305212657.GA17903@jupiter.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 22:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fQz-0006Ul-H2
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 22:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab2CEV1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 16:27:04 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:61921 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab2CEV1C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 16:27:02 -0500
Received: by dadp12 with SMTP id p12so5632460dad.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 13:27:02 -0800 (PST)
Received-SPF: pass (google.com: domain of paul@paulbetts.org designates 10.68.230.229 as permitted sender) client-ip=10.68.230.229;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of paul@paulbetts.org designates 10.68.230.229 as permitted sender) smtp.mail=paul@paulbetts.org
Received: from mr.google.com ([10.68.230.229])
        by 10.68.230.229 with SMTP id tb5mr41093590pbc.0.1330982822089 (num_hops = 1);
        Mon, 05 Mar 2012 13:27:02 -0800 (PST)
Received: by 10.68.230.229 with SMTP id tb5mr35548570pbc.0.1330982821921;
        Mon, 05 Mar 2012 13:27:01 -0800 (PST)
Received: from localhost (c-67-169-43-61.hsd1.ca.comcast.net. [67.169.43.61])
        by mx.google.com with ESMTPS id g4sm14288142pbs.17.2012.03.05.13.26.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 13:27:00 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlVvBJNBEmG3PHZoiUfvowU/pdvWNyH0u95gTZXQK4N0dZybOsPlZgCCQjaZZDbffKBHF4Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192273>

Hi guys,

As part of trying to fix the problems in MSysGit around tree encodings, I
would like to start a discussion on mitigating the backwards compatibility
problems associated with tree path encodings being unspecified.

## History

For those folks unfamiliar with the issue, I'll provide a quick refresh - Git
has traditionally not specified the string encoding of paths inside the tree
object - whatever strings the OS provided from the readdir syscall was used
verbatim to write out tree objects. For most operating systems, this was UTF-8
(though even on certain POSIX OS's there are some caveats with normalized
sequence points, such as OS X).

However, on Windows until *very* recently (and on non-Unicode Linux locales),
the strings returned by the OS are from a locale-specific OEM Code Page (i.e.
Shift-JIS, Windows-1252, etc) and *not* Unicode. These repositories are
currently incorrectly interpreted on other OSs (or even the same OS with a
different locale configured).

Note that *blob* (i.e. content) encoding is a separate issue and is
out-of-scope at the moment.

This will become a bigger problem in the near future , because MSysGit is
seeking to fix this mistake on Windows by explicitly writing all tree objects
in UTF-8. While this is great for new repositories, this will create a
compatibility problem: people who upgrade their Git installation on their
local machine will now have issues with their existing repos.

## Proposed Mitigation

For an initial mitigation plan, I'd like to propose adding a warning to either
git clone or git checkout, that if invalid UTF-8 strings are detected, a
warning is printed to the user.

However, without an actionable solution, it's not much of a help other than to
suggest that they downgrade to a lower version of Git. Possible solutions that
we've discussed are:

  * Add a git-config setting to explicitly set the code-page, defaulted to
    UTF-8. With this, the error message could instruct them to set this
    config locally. This has the additional benefit of enabling Linux users
    to use these existing Windows repositories.

  * Creating a conversion utility to rewrite all trees to use UTF-8. This is
    problematic for obvious reasons, even disregarding the fact that the
    result will be incompatible with the original repo - mainly that it may be
    non-trivial to detect which encoding the strings were originally written
    in. libicu (http://site.icu-project.org/) has code to do this.

-- 
Paul Betts <paul@paulbetts.org>
