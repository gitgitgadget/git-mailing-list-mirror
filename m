From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: files deleted with no record?
Date: Thu, 26 Jun 2014 20:53:36 +0100
Organization: OPDS
Message-ID: <7298A047128B405F94F5E73903089107@PhilipOakley>
References: <CAFDwLfyXrUZUUuaciAjamn-cXJ6mAv_D41zLwT4AZE=cmAX7rg@mail.gmail.com> <CABURp0p6amKmhMhOUzdKy0a8TY7bmPoSLM0sUnZfGErhyfLsEQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Phil Hord" <phil.hord@gmail.com>,
	"Jeremy Scott" <jeremy@great-scotts.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Fjp-0002hE-TX
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbaFZTxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:53:38 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:45845 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbaFZTxh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 15:53:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvgYADl5rFNZ8Yfj/2dsb2JhbABagw1Sg0iFO7tpBAEBAgEBgQ4XdYN+BQEBBAEIAQEZBBEeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBxcGARIIAgECAwGIHQMJDAmkbYZ/j2UNhmeBK4swgiWCfjaBFgWEYwKMCIdvg0OMIIYPg0M8
X-IPAS-Result: AvgYADl5rFNZ8Yfj/2dsb2JhbABagw1Sg0iFO7tpBAEBAgEBgQ4XdYN+BQEBBAEIAQEZBBEeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBxcGARIIAgECAwGIHQMJDAmkbYZ/j2UNhmeBK4swgiWCfjaBFgWEYwKMCIdvg0OMIIYPg0M8
X-IronPort-AV: E=Sophos;i="5.01,555,1400022000"; 
   d="scan'208";a="463604410"
Received: from host-89-241-135-227.as13285.net (HELO PhilipOakley) ([89.241.135.227])
  by out1.ip04ir2.opaltelecom.net with SMTP; 26 Jun 2014 20:53:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252522>

From: "Phil Hord" <phil.hord@gmail.com>
> On Mon, Jun 23, 2014 at 9:15 PM, Jeremy Scott 
> <jeremy@great-scotts.org> wrote:
>> I just encountered a situation where a merge was made, with no
>> apparent changes in files (ie no log), but the result was that some
>> files were deleted.
>>
>> person A adds some files
>> person B adds some files from the same point
>
> You mean from the same point in history, right?  Not files with the
> same filename or path?
>
>> person B commits and pushes.
>> person A commits -- now merge is required
>> a few more commits on top of person B's commit
>
> I don't understand this step.  Who adds a few more commits on top of B 
> and why?
>
>> person A merges - this removes the files that B added. There is no 
>> log
>> of the files being deleted

A similar issue, by reference, just came up on the [git-users] list. The 
reference was:
1. http://randyfay.com/content/avoiding-git-disasters-gory-story

In that case the problem was a mixture of tools and  misunderstandings.

It may not be the same as your case, but could give insights into what's 
happening between different developers.

Which Tools are You, person A and Person B using, with --version?

>
> This sounds like an "evil merge" (see man gitglossary, and google),
> but it's not clear to me how you arrived here.
>
> When I tried to reproduce your issue with this script, it did not
> remove any files unexpectedly:
> ------------------->8-----------------------
> #!/bin/sh
>
> set -e
> mkdir foo && cd foo && git init
> echo foo > foo && git add foo && git commit -mfoo
>
> git checkout -b PersonA master
> echo bar > bar && git add bar
> git commit -m"PersonA: bar"
>
> git checkout -b PersonB master
> echo baz > baz && git add baz
> git commit -m"PersonB: baz"
>
> echo foo-conflict >> foo && git add foo
> git commit -m"PersonB: foo"
>
> git checkout PersonA
> echo foo-different >> foo && git add foo
> git commit -m"PersonA: foo (conflicts with PersonB)"
>
> git log --oneline --all --stat
>
> if ! git merge PersonB ; then
>  git checkout PersonA foo
>  git commit --no-edit
> fi
> git log --oneline --graph --stat
> ------------------->8-----------------------
>
> A sneaky issue with merges is that they do not have a clear way to
> show patch information -- the diff between the commit and its ancestor
> -- because they have multiple ancestors.  You can show diffs for a
> merge relative to each of its parents, but it is not usually done for
> you automatically.  This is why making changes in a merge which are
> not actually required for the merge is bad ("evil").
>
>> Clearly this is possible - was this a user error?
>
> Probably, but we'd need to see how the user got there.
> --
Philip 
