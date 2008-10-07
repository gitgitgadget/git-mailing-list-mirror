From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Tue, 07 Oct 2008 18:15:24 +0200
Message-ID: <48EB8B1C.9060201@viscovery.net>
References: <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr> <20081007012044.GA4217@coredump.intra.peff.net> <48EAF902.3040402@viscovery.net> <20081007060014.GA7965@coredump.intra.peff.net> <vpqprmdlylq.fsf@bauges.imag.fr> <20081007154646.GB26531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnFEm-0001Fa-B5
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 18:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbYJGQP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 12:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYJGQP2
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 12:15:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43808 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYJGQP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 12:15:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KnFDZ-0005rQ-FV; Tue, 07 Oct 2008 18:15:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 179A154D; Tue,  7 Oct 2008 18:15:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081007154646.GB26531@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97724>

Jeff King schrieb:
> On Tue, Oct 07, 2008 at 08:15:45AM +0200, Matthieu Moy wrote:
> 
>> One proposal: have a diff.<driver>.activate with several values:
>>
>> * "always": activate the diff driver in any porcelain
>> * "diff": activate it only for "git diff", as currently
>> * "singlefile": Johannes's heuristic proposal
>>
>> That way, one could say easily "activate exiftags filter all the time,
>> but MS-Word only when I request a diff for a single file", and this
>> leaves room for other values if the need be. Well, there's no room for
>> "use MS-Word native diff tool in git-gui but antiword/catdoc +
>> textconv in 'git log -p'" here, but do we want it?
>>
>> Or is all that just overkill?
> 
> Actually, as soon as I read the first part of your mail I thought of the
> "ms-word vs antiword" situation. The example you gave seems plausible.
> And it seems to me that it is really a superset of the problem we are
> discussing. That is, gitattributes is really just saying "this is a
> 'foo' type file". And if we have a mechanism flexible enough to say "in
> this situation, this is how you handle 'foo' type files", then that
> would work as the basis for implementing these heuristics.
> 
> For example, maybe you could set up some mapping like:
> 
>   git diff --diffdriver=foo,bar
> 
> where a file with gitattribute diff=x would look for the driver config
> for x.foo, then x.bar, and then finally fall back to just x. Then you
> could easily have (ignoring the fact that I'm not sure about the config
> syntax for having _3_ section parts):
> 
>   git config diff.doc.graphical.command ms-word-diff-script
>   git config diff.doc.textconv antiword
> 
> and then git-gui would be configured to diff with:
> 
>   git diff --diffdriver=graphical
> 
> whereas a regular "git diff" would always fall back to
> "diff.doc.textconv". Make sense?

I think you are complicating things. We already have

   diff.doc.command ms-word-diff-script

and with your 4-patch-series-under-discussion we would have

   diff.doc.texconv antiword

and that should be sufficient. I'm proposing this heuristics:

 * If only textconv is given, all porcelains pick it.
 * If only command is given, all porcelains pick it.
 * If both are given, then
   - git log picks textconv.
   - git show and git diff:
     . if exactly one pathspec was given, pick command;
     . otherwise pick textconv

Plumbing never picks any of them, just like today, nor should git
format-patch. The are other porcelains that could be sorted into this
list, like git blame and (the summary line of) git commit.

BTW, please don't take git-gui as an example that would lauch MS-Word on
each diff. (Neither would gitk.) Both rely on plumbing, and that's good.
gitk has a menu entry "External diff", where the diff.doc.command could be
hooked into.

-- Hannes
