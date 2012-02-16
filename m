From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 0/8] gitweb: Faster and improved project search
Date: Thu, 16 Feb 2012 22:53:47 +0100
Message-ID: <201202162253.49000.jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com> <7vmx8iy0ix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 22:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry9H4-0005bs-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 22:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab2BPVxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 16:53:53 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63416 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2BPVxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 16:53:52 -0500
Received: by eekc14 with SMTP id c14so1102028eek.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 13:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=DCL894EgMn9wLBjznKHBH9HLzS/SW+a+vR3zJAw7Snw=;
        b=tVN+ASOl3nbGt0PMYiIzfMkMXcuVYF64TB+AhwdjcR3N7P48tF58e+qGPcoIS/g2x5
         1uPUPDtVfqpqhc//EPvDCALY3XJ3JnTvQsX2AaLFvbT1wVvwCdEliUdomNKOjlOl5Mm9
         w0GEaWQT6BUFwZ9w8QyMzHy1wORMLA/fPCwVo=
Received: by 10.14.95.8 with SMTP id o8mr2459158eef.111.1329429231457;
        Thu, 16 Feb 2012 13:53:51 -0800 (PST)
Received: from [192.168.1.13] (abwb118.neoplus.adsl.tpnet.pl. [83.8.225.118])
        by mx.google.com with ESMTPS id n52sm29695995eea.5.2012.02.16.13.53.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 13:53:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmx8iy0ix.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190915>

On Thu, 16 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > [Cc-ing Junio because of his involvement in discussion about first
> >  patch in previous version of this series.]
> >
> > First three patches in this series are mainly about speeding up
> > project search (and perhaps in the future also project pagination).
> > Well, first one is unification, refactoring and future-proofing.
> > The second and third patch could be squashed together; second adds
> > @fill_only, but third actually uses it.
> >
> > Next set of patches is about highlighting matched part, making it
> > easier to recognize why project was selected, what we were searching
> > for (though better page title would also help second issue).
> >
> > Well, fourth patch (first in set mentioned above) is here for the
> > commit message, otherwise it could have been squashed with next one.
> >
> > Last patch in this series is beginning of using esc_html_match_hl()
> > for other searches in gitweb -- the easiest part.
> 
> Notice that you never said anything about what you wanted to achieve with
> this entire series?  " -- the easiest part." does not mean anything.
> The easiest part of what?

Gitweb, besides project search, supports searching in a give repository
of a commit message ('commit', 'author', 'committer'), of files ('grep')
and of changes ('pickaxe').  From those 'grep' was easiest.  This is
mentioned in comments in 8/8.

What I'd like to achieve is unification of match highlighting code, which
reduces code duplication.  esc_html_match_hl() is also better than current
hand-written code: it highlights all matches, and not only last match.

> Where in the series do the "faster" and "improved" come from?  What do you
> exactly mean by "faster" and "improved"?  In which commit would we find
> the answers to the questions like:
> 
>  - What operation was slow and how you tackled that slowness?
>  - What are the benchmark results?

Those series make project search faster because they reduce number of
git commands that gitweb runs when generating project search results.
Before number of commands was 2*<number of projects> + 1, after 3/8
it is 2*<number of results> + 1.


For search that selects 2 repositories out of 12 total

* Before (warm cache):

  "This page took 0.867151 seconds  and 27 git commands to generate."

* After (warm cache):
 
  "This page took 0.673643 seconds  and 5 git commands to generate."

The improvement in performance is even better for larger number of
repositories, and for cold cache / evicted cache.


Should I do benchmark of git_project_list_body() subroutine before
and after?

> In general, "improve" is such a loaded word (after all, patches sent to
> the list are almost always meant to "improve" things) that it almost does
> not convey a single bit of information.  Are you fixing bugs?  Are you
> tidying up an unreadable piece of code?  Are you fixing styles?  Are you
> producing prettier output?  Are you refactoring cut-and-pasted repetition
> into a common helper function?  Are you adding a new feature?

I'm sorry about vague "improved".  What I meant is that I have added
highlighting of matched part in project search, just like e.g. Google
does unobtrusive highlighting of search phrase in page snippets.

This is especially important because project search matches either
project name or project description, and it might be not obvious why
the match... especially that match on description might be in shortened
chopped-out part.


I'll improve commit messages and cover letter in a re-roll.
-- 
Jakub Narebski
Poland
