From: Kevin Ballard <kevin@sb.org>
Subject: Re: [BUG] git-add doesn't apply filepatterns to tracked files
Date: Wed, 8 Dec 2010 15:27:41 -0800
Message-ID: <3A1EAFC5-8D24-4E4F-B1BB-B1E153964EB0@sb.org>
References: <47FCD78C-5D8C-4FA5-88DC-26FDCC7361AD@sb.org> <7vipz3j228.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 00:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQTQs-0003PG-W0
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 00:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0LHX1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 18:27:49 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47742 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0LHX1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 18:27:49 -0500
Received: by pwj3 with SMTP id 3so395164pwj.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 15:27:48 -0800 (PST)
Received: by 10.142.136.3 with SMTP id j3mr3310569wfd.38.1291850868331;
        Wed, 08 Dec 2010 15:27:48 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm1521219wfa.11.2010.12.08.15.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 15:27:47 -0800 (PST)
In-Reply-To: <7vipz3j228.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163243>

On Dec 8, 2010, at 3:07 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> It seems that git-add doesn't match filepatterns against tracked files,
> 
> This is an issue known for a long time (and the one I had been bitching
> about every time I had a chance).  Tracked ones obey diff-index pathspec
> rules (leading path match only) while untracked ones use gitignore
> pathspec rules.

If I understand you correctly, you're saying tracked files don't understand
patterns because git-diff-index doesn't handle patterns? Is there some reason
that git-diff-index doesn't support patterns? I tried a handful of commands
and here's the pattern-matching behavior I saw:

git-add: patterns match untracked, but not tracked
git-rm: patterns match tracked files, command doesn't work on untracked
git-status: patterns match untracked, but not tracked
git-ls-files: patterns match tracked, command doesn't work on untracked
git-ls-tree: no pattern support
git-check-attr: no pattern support

Documentation is a bit sporadic here as well. git-add lists <filepattern>
in its synopsis and options and defines this as supporting
"fileglobs". No mention whatsoever of the tracked file limitation.
git-rm only lists <file> in synopsis/options, but does document this
as being a "fileglob". git-status uses <pathspec> in the synopsis, and
doesn't even document this in the options. It only makes a reference
in the description, calling it "paths". git-ls-files calls it <file>
in both synopsis and options, and makes no mention whatsoever of globs.
git-ls-tree uses <path> in both synopsis/options, but explicitly claims
that this is really a pattern in the option documentation. Curious,
given its complete lack of pattern matching. git-check-attr uses
<list-of-paths> in the synopsis, with no mention in the options.

Overall, there's a few problems here. The first is that git-add and
git-ls-files apply the git-diff-index rules for tracked files, but
apply actual patterns to untracked files. The second is the documentation
is inconsistent, both in the name of the argument, and in making it
clear which commands actually support patterns (plus the documentation
for git-ls-tree is explicitly wrong about pattern support). The third
is we're inconsistent in which commands support patterns at all.

-Kevin Ballard
