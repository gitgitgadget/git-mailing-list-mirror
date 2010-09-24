From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t/t3903-stash: improve testing of git-stash show
Date: Fri, 24 Sep 2010 17:49:11 -0400
Message-ID: <953B8952-8928-43B3-A05D-6AEDC5D4B565@gernhardtsoftware.com>
References: <00400143-1A23-4245-9D7C-4AC9093785F5@gernhardtsoftware.com> <BVPnfVXRBMtK-9WPRRt3RH05x0aSmoFQsrb6lVp2uyULwHxOV-DnAXrmucCvrGrPQX_-AdS0fnA@cipher.nrlssc.navy.mil> <47BAA71F-CF5C-4A98-BBB9-C502C81E3230@silverinsanity.com> <UNSmPBO95_JSGKkZEyMl028XH9fmWCis39YCV_49wZs7FghyXRqw2Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: jon.seymour@gmail.com, robbat2@gentoo.org, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 24 23:49:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzG8v-0005tL-R3
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708Ab0IXVtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 17:49:17 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57622 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab0IXVtQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 17:49:16 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 9EE221FFC6B6; Fri, 24 Sep 2010 21:49:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 922491FFC544;
	Fri, 24 Sep 2010 21:49:06 +0000 (UTC)
In-Reply-To: <UNSmPBO95_JSGKkZEyMl028XH9fmWCis39YCV_49wZs7FghyXRqw2Q@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157066>


On Sep 24, 2010, at 4:50 PM, Brandon Casey wrote:

> I hope you're just abandoning the tests you were creating, and _not_
> abandoning the search for a fix.  The "solution" I offered is flawed
> and breaks some of the other tests. :)

Actually, I think the solution you offered exposed what could be considered a bug in git-rev-parse.  The fact that it worked before was just an happy accident, I think...

$ ARGS="-q --index stash@{0}"
$ # Get only the revision arguments
$ git rev-parse --no-flags --symbolic $ARGS
stash@{0}
$ # What git-stash currently uses to get flags
$ git rev-parse --no-revs -- $ARGS
--
-q
--index
stash@{0}
$ # That was a lot more than just the flags
$ # What git-stash "should" use to get flags
$ git rev-parse --no-revs --flags $ARGS
--index
$ # Huh, it ate -q, let's try --
$ git rev-parse --no-revs --flags -- $ARGS
$ # No, that's not right either...

git-stash's current code "FLAGS=$(git rev-parse --no-revs -- "$@")" simply returns all of the arguments including a starting --.  The issue is that git-rev-parse eats a -q parameter.  There's no way to distinguish between arguments for rev-parse and arguments it's supposed to parse.  Generally this isn't an issue.

The simple way to deal with this is to check for -q before using rev-parse.  The better way is to either get rev-parse to stop eating the -q somehow or to switch git-stash to parseopts.

Simple patch coming soon.

~~ Brian
