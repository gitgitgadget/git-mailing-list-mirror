From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH 0/9] War on blank-at-eof
Date: Sat, 5 Sep 2009 16:28:22 -0500 (CDT)
Message-ID: <alpine.WNT.2.00.0909051534380.7040@GWNotebook>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 23:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mk327-00008v-A9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 23:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZIEVmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbZIEVmo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 17:42:44 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:36457 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZIEVmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 17:42:44 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mk31w-000113-21; Sat, 05 Sep 2009 16:42:44 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127827>

On Fri, 4 Sep 2009, Junio C Hamano wrote:

> Patch 5 corrects the definition of blank-at-eof.  If a patch adds an
> non-empty line that consists solely of whitespaces at the end of file, we
> should diagnose and strip it just line a new empty line.  After all, both
> are blank lines.
>

Thank you. Thank you, thank you. Thank you!  And did I mention thank you?

Tested this out after cherry-picking:
3b5ef0e xutils: Fix xdl_recmatch() on incomplete lines
78ed710 xutils: Fix hashing an incomplete line with whitespaces at the end

It worked as nicely!  I'm throwing away the --allow-whitelines-at-eof 
patch! :D  Converting a _real_ dirty whitespace branch into an 'almost' 
whitespace policy compliant branch with validation of the diffs was 
able to be done like so:
	git diff -b DIRTY CLEAN
	git diff DIRTY^ CLEAN > diff1
	git diff CLEAN^ DIRTY > diff2
	git diff -b diff1 diff2

I mention 'almost' above because unfortunately this type of conversion 
leaves extra line-spaces at the end of some files that you might not want 
to have in a whitespace policy.

While thinking about what appeared in:

http://article.gmane.org/gmane.comp.version-control.git/124138
Junio C Hamano <gitster <at> pobox.com> writes:
>Bruno Haible <bruno <at> clisp.org> writes:
>> In some GNU projects, there are file types for which trailing spaces in a line
>> ...
>> Currently the user has to turn off the 'trailing-space' whitespace attribute
>> in order for 'git diff --check' to not complain about such files. This has
>> the drawback that trailing spaces are not detected.
	
>Very good problem description.  Thanks.

I thought it might be interesting to throw this out there...  What do you 
think of an additional attribute value like
	core.whitespace blank-at-eof-min-<some 0 to N #>
	core.whitespace blank-at-eof-max-<some 0 to N #>
that could be read in when core.whitespace blank-at-eof is set.

If neither are present then use current. (No new eof blanks).
If min but not max is set then allow new blanks and ensure at least min.
If max but not min is set then only allow max blanks at eof.
If both then treat it as a boundary.

This could ensure a whitespace policy without the repository maintainer 
having to correct this type of minutia and without having to nit-pick 
contributors into submission.

Then perhaps diff could also recognize an in range blank-at-eof so a diff 
using one of the ignore whitespace options would ignore eof whitelines 
that are in range?


> The series applies to v1.6.0.6-87-g82d97da; merging the result to 'master'
> needs some conflict resolution.
>


-- 
Thell
