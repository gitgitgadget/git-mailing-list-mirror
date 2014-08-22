From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] teach fast-export an --anonymize option
Date: Fri, 22 Aug 2014 19:39:59 +0100
Organization: OPDS
Message-ID: <9E69746EFF0048FF84631A9794206566@PhilipOakley>
References: <20140821070130.GA15930@peff.net> <xmqqiollqzel.fsf@gitster.dls.corp.google.com> <20140821224910.GB21105@peff.net> <20140821232100.GA27849@peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Duy Nguyen" <pclouds@gmail.com>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtkp-00048A-NP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbaHVSj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:39:59 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:8713 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750726AbaHVSj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2014 14:39:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgczACSN91NOl3jIPGdsb2JhbABZgw1TV4J8hTvAWoNNh0IGAgKBEBcFAQEBATg2g34FAQEFCAEBGRUeAQEhCwIDBQIBAw4HAgECAgUhAgIUAQQaBgcDDAgGARIIAgECAwGINQmvYYZ/jgwTBIEsjiCDADaBHQWFBAKMIFeDUoFvS50rPC+CTwEBAQ
X-IPAS-Result: AgczACSN91NOl3jIPGdsb2JhbABZgw1TV4J8hTvAWoNNh0IGAgKBEBcFAQEBATg2g34FAQEFCAEBGRUeAQEhCwIDBQIBAw4HAgECAgUhAgIUAQQaBgcDDAgGARIIAgECAwGINQmvYYZ/jgwTBIEsjiCDADaBHQWFBAKMIFeDUoFvS50rPC+CTwEBAQ
X-IronPort-AV: E=Sophos;i="5.04,382,1406588400"; 
   d="scan'208";a="567882258"
Received: from host-78-151-120-200.as13285.net (HELO PhilipOakley) ([78.151.120.200])
  by out1.ip05ir2.opaltelecom.net with SMTP; 22 Aug 2014 19:39:56 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255692>

From: "Jeff King" <peff@peff.net>: Friday, August 22, 2014 12:21 AM
> On Thu, Aug 21, 2014 at 06:49:10PM -0400, Jeff King wrote:
>
>> The few things I don't anonymize are:
>>
>>   1. ref prefixes. We see the same distribution of refs/heads vs
>>      refs/tags, etc.
>>
>>   2. refs/heads/master is left untouched, for convenience (and 
>> because
>>      it's not really a secret). The implementation is lazy, though, 
>> and
>>      would leave "refs/heads/master-supersecret", as well. I can 
>> tighten
>>      that if we really want to be careful.
>>
>>   3. gitlinks are left untouched, since sha1s cannot be reversed. 
>> This
>>      could leak some information (if your private repo points to a
>>      public, I can find out you have it as submodule). I doubt it
>>      matters, but we can also scramble the sha1s.
>
> Here's a re-roll that addresses the latter two. I don't think any are 
> a
> big deal, but it's much easier to say "it's handled" than try to 
> figure
> out whether and when it's important.
>
> This also includes the documentation update I sent earlier. The
> interdiff is a bit noisy, as I also converted the anonymize_mem 
> function
> to take void pointers (since it doesn't know or care what it's 
> storing,
> and this makes storing unsigned chars for sha1s easier).
>

Just a bit of bikeshedding for future improvements..

The .gitignore is another potential user problem area that may benefit 
form not being anonymised when problems strike. For example, there's a 
current problem on the git-users list 
https://groups.google.com/forum/#!topic/git-users/JJFIEsI5HRQ about "git 
clean vs git status re .gitignore", which would then also beg questions 
about retaining file extensions/suffixes (.txt, .o, .c, etc).

I've had a similar problem with an over zealous file compare routine 
where the same too much vs too little was an issue.

One thought is that the user should be able to, as an option, select the 
number of initial characters retained from filenames, and similarly, the 
option to retain the file extension, and possibly directory names, such 
that the full .gitignore still works in most cases, and the sort order 
works (as far as it goes on number of characters).

All things for future improvers to consider.

Philip

> -- >8 --
> Subject: teach fast-export an --anonymize option
>
> Sometimes users want to report a bug they experience on
> their repository, but they are not at liberty to share the
> contents of the repository. It would be useful if they could
> produce a repository that has a similar shape to its history
> and tree, but without leaking any information. This
> "anonymized" repository could then be shared with developers
> (assuming it still replicates the original problem).
>
> This patch implements an "--anonymize" option to
> fast-export, which generates a stream that can recreate such
> a repository. Producing a single stream makes it easy for
> the caller to verify that they are not leaking any useful
> information. You can get an overview of what will be shared
> by running a command like:
>
>  git fast-export --anonymize --all |
>  perl -pe 's/\d+/X/g' |
>  sort -u |
>  less
>
> which will show every unique line we generate, modulo any
> numbers (each anonymized token is assigned a number, like
> "User 0", and we replace it consistently in the output).
>
> In addition to anonymizing, this produces test cases that
> are relatively small (compared to the original repository)
> and fast to generate (compared to using filter-branch, or
> modifying the output of fast-export yourself). Here are
> numbers for git.git:
>
>  $ time git fast-export --anonymize --all \
>         --tag-of-filtered-object=drop >output
>  real    0m2.883s
>  user    0m2.828s
>  sys     0m0.052s
>
>  $ gzip output
>  $ ls -lh output.gz | awk '{print $5}'
>  2.9M
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
[...] 
