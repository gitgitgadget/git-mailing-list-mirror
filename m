From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sat, 1 Mar 2008 13:46:39 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803011010480.17889@woody.linux-foundation.org>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com> <m3d4qejroy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 22:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZjf-0003Nj-0q
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 22:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756913AbYCAV6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 16:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbYCAV6M
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 16:58:12 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34902 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751235AbYCAV6M (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2008 16:58:12 -0500
X-Greylist: delayed 685 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Mar 2008 16:58:11 EST
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m21Lke0H006892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Mar 2008 13:46:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m21LkdYU006171;
	Sat, 1 Mar 2008 13:46:40 -0800
In-Reply-To: <m3d4qejroy.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.312 required=5 tests=BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75706>



On Sat, 1 Mar 2008, Jakub Narebski wrote:
> > 
> > From what I can tell it seems that dates can be specified relatively,
> > e.g. "2 hours ago", or with any ISO 8601 or RFC 2822 date syntax. Is
> > this correct, and are there any docs on specifying relative dates?
> 
> I don't know why git doesn't use getdate_r for this, instead rolling
> out its own date parsing routines: approxidate*, parse_date. From what
> I remember it should accept any date "date" (from coreutils) accepts,
> but it does (from comments) for date to be in "C" locale.

strptime() and getdate() are totally unusable for any real date parsing 
where you don't already know the exact format(s) of the string. And 
neither of them can do any of the useful things that approxidate() does, 
ie handle strings like "two months ago".

So yes, we do our own date parsing, where the "exact" format is the Unix 
epoch timestamp (potentially together with explicit TZ information), but 
we try to parse a wide variety of user-supplied strings that match any of 
the standard formats (and do that loosely, so that when emails etc 
invariably get things wrong and don't actually follow rfc2822 exactly, for 
example, it still tries to make sense of it).

And then when the more-or-less exact format check fails, we fall back on 
the really approximate guessing, which accepts any random input and turns 
it into a date (ie "two days ago at noon" will give you *some* results, 
but whether they are the results you meant or not is debatable: I think 
"noon" will always round down to the previous noon, for example, so it 
migth be closer to three days ago).

So the "timestamp" is a pure integer (seconds since epoch), and in most 
other places git will accept dates that are more or less any half-way sane 
format for interchange.

Of course, the only reason for --max-age=timestamp, --min-age=timestamp 
existing int he first place is that *historically* normal git commands 
could only parse the strict "seconds since epoch", and we had that magical 
special "git rev-parse" function that turned the human-readable date into 
an exact timestamp.

You can still see it:

	[torvalds@woody git]$ git-rev-parse  --until="2.hours.ago"

outputs

	--min-age=1204387613

which is the machine-readable format, but that's purely historical, since 
now all commands that take that machine-readable format also take the 
human format directly, so it might make more sense to just not even 
document that "--[min|max]-age=timestamp" thing.

			Linus
