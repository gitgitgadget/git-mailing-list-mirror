From: Doug Bell <madcityzen@gmail.com>
Subject: Re: [PATCH] show-ref: make --head always show the HEAD ref
Date: Fri, 12 Jul 2013 21:01:50 -0500
Message-ID: <59D4F790-70BA-41DB-80A3-13AD397B3FCF@gmail.com>
References: <1369894105-48434-1-git-send-email-madcityzen@gmail.com> <7v38rlt88j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 04:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxpJN-00036A-Nm
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 04:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036Ab3GMCLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 22:11:31 -0400
Received: from gremmie.emeraldkingdom.com ([199.48.129.190]:65490 "EHLO
	mail.digitalarcadia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946Ab3GMCLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 22:11:30 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2013 22:11:30 EDT
Received: from gremmie.emeraldkingdom.com (unknown [127.0.0.1])
	by mail.digitalarcadia.com (Postfix) with ESMTP id D20F79BA91;
	Sat, 13 Jul 2013 01:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at digitalarcadia.com
Received: from mail.digitalarcadia.com ([127.0.0.1])
	by gremmie.emeraldkingdom.com (gremmie.emeraldkingdom.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tTlr6_bhFQH1; Sat, 13 Jul 2013 01:30:10 +0000 (UTC)
Received: from [192.168.1.34] (c-67-162-112-255.hsd1.il.comcast.net [67.162.112.255])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: doug@doublecluepon.com)
	by mail.digitalarcadia.com (Postfix) with ESMTPSA id D4D7C9B9D8;
	Sat, 13 Jul 2013 01:30:08 +0000 (UTC)
In-Reply-To: <7v38rlt88j.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230275>

On Jul 11, 2013, at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Doug Bell <madcityzen@gmail.com> writes:
> 
>> The docs seem to say that doing
>> 
>> 	git show-ref --head --tags
>> 
>> would show both the HEAD ref and all the tag refs. However, doing
>> both --head and either of --tags or --heads would filter out the HEAD
>> ref.
>> 
>> Signed-off-by: Doug Bell <madcityzen@gmail.com>
>> ---
> 
> I think this patch fell through the cracks, and looking at it, I am
> somewhat torn.
> 
> The command help for "--head" says "show the HEAD reference", which
> may mean:
> 
> (1) in addition to everything else the command would do if there
>     weren't this option specified, show HEAD;
> 
> (2) show the HEAD and nothing else; or
> 
> (3) add HEAD to the candidates to be shown, but apply the usual
>     filtering rule based on --heads, --tags and/or pattern
>     arguments.
> 
> While the last interpretation is what we have used since the
> beginning of the command at 358ddb62 (Add "git show-ref" builtin
> command, 2006-09-15), I tend to agree with you that the first
> interpretation may make more sense, at least from the end user's
> point of view.

> 
> But at a deeper level, it makes the command somewhat inconsistent.
> 
> What happens in the command is
> 
> - We iterate over "candidates to be shown", which is usually
>   "everything under refs/", but with "--head", HEAD is added to
>   this set.  For each of these candidates:
> 
>   - if one or more <pattern> parameters are given, reject the
>     candidate ref if it does not tail-match with any of the
>     patterns;
> 
>   - if either "--heads" or "--tags" is given, among the ones that
>     pass <pattern> filter, check if they:
> 
>     - begin with "refs/heads/" (if "--heads" is given); or
>     - begin with "refs/tags/" (if "--tags" is given).
> 
>     and reject those that don't.
> 
>   - show it if it is still surviving after these two tests.
> 
> And taht is why "git show-ref --tags master v1.3.0" shows only the
> v1.3.0 tag without showing the master branch, and giving "--heads"
> instead of "--tags" yields only the master branch without the tag.
> 
> The semantics your patch wants, by changing the definition of
> "--head" from (3) to (1), is:
> 
> - If "--head" is given, show HEAD no matter what.
> 
> - Iterate over everything under refs/, and for each of them, do the
>   same filter-and-show as we currently do (see above).
> 
> While I think the new semantics is also understandable as the
> current one, and personally I think it is a better behaviour than
> the current one, it will require an update to the document to
> highlight that "--head" is special-cased in a big way, to bypass all
> the filtering that is applied to normal refs.
> 
> A few additional observations (these are not complaints to this
> patch and please do not take them as such):
> 
> - The command help says "(can be combined with heads)" for "--tags"
>   and vice versa, but does not mention their interaction with
>   "--head".  This is because we take interpretation (3) above and
>   do not treat "--head" as a mechanism to add to <pattern>
>   parameter like these two.
> 
> - The command help for "--heads" and "--tags" says "only show
>   heads/tags", which technically does not contradict with "can be
>   combined with" above, but a logical consequence of combining
>   ought to be showing nothing, as a ref cannot be a head (an old
>   nomenclature for a "branch") and a tag at the same time.  
> 
> I think we should find a word better than "only" to use here, but I
> am not sure what would be a good phrase to use.
> 

The reason I had initially wanted both --tags and --head was I wanted to compare HEAD against all the tags to see which one(s) I was on (if any). I was eventually pointed to `git describe`, but I ended up just using show-ref without any options and filtering the result using Perl (the entire application is in Perl, so this wasn't a big deal). Then, yeah, I figured it was confusing enough to either patch the code or the docs.

For the doc changes, I think if it's explained that by default it show-ref shows refs/{tags,heads,remotes}, it becomes easier to explain what the options will end up doing. I'll put together a second patch.