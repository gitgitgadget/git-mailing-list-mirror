From: Thomas Miller <jackerran@gmail.com>
Subject: Re: [PATCH 1/3] builtin/fetch.c: Add pretty_url() and print_url()
Date: Thu, 19 Dec 2013 11:41:09 -0600
Message-ID: <CAECD2aGPbJEUD5Vr0XH23eP_353hKwzRs7Q3sJ65LRjFKMr6Yw@mail.gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
	<xmqq8uvhhlwg.fsf@gitster.dls.corp.google.com>
	<20131219011817.GA31924@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 18:41:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vthb2-00019d-3r
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 18:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab3LSRlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 12:41:11 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:54223 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab3LSRlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 12:41:10 -0500
Received: by mail-qc0-f169.google.com with SMTP id r5so1253508qcx.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rJc4IhHZHMC9oObdwT/CzNwiU9HVLFFuYKSi8TlwsYs=;
        b=nYA9p5IQpLNnVx+vB1zV0C+9wm9l+ZmJtjY0VAYBfSp72FriNXSzJ1UjYz/oN5J99E
         Wv/zo5etMmjDzt1TyEjfH2KeSalM8+74BvLwkEywcWyvg48wm04yuogvC9Ow6EKzt7eC
         N3ZujFmLGOIkeOEq1jtdSe625YwH+P3UCoB00cKn+EZhAL1z1lejffph2xJRcBZADej8
         KT8z7755yOsDwbXHP4PLd8Rb27JIlu2C7Sq24AfiJOvi2JdpWTQ4C4oEdkjTWvrSjvmX
         juJ6Mc+IjZCyHeN2wdmyeNA0dBCDJIV/3Fa/rNH8kZvPh5ayA9reFxAYcgMYofrthrIg
         bfPQ==
X-Received: by 10.49.105.138 with SMTP id gm10mr5230495qeb.7.1387474869674;
 Thu, 19 Dec 2013 09:41:09 -0800 (PST)
Received: by 10.229.238.131 with HTTP; Thu, 19 Dec 2013 09:41:09 -0800 (PST)
In-Reply-To: <20131219011817.GA31924@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239528>

On Wed, Dec 18, 2013 at 7:18 PM, Tom Miller <jackerran@gmail.com> wrote:
> On Wed, Dec 18, 2013 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Tom Miller <jackerran@gmail.com> writes:
>>
>>> In order to fix branchname DF conflicts during `fetch --prune`, the way
>>> the header is output to the screen needs to be refactored. Here is an
>>> exmaple of the output with the line in question denoted by '>':
>>>
>>>       $ git fetch --prune --dry-run upstream
>>>>      From https://github.com/git/git
>>>          a155a5f..5512ac5  maint      -> upstream/maint
>>>          d7aced9..7794a68  master     -> upstream/master
>>>          523f7c4..3e57c29  next       -> upstream/next
>>>        + 462f102...0937cdf pu         -> upstream/pu  (forced update)
>>>          e24105a..5d352bc  todo       -> upstream/todo
>>>        * [new tag]         v1.8.5.2   -> v1.8.5.2
>>>        * [new tag]         v1.8.5.2   -> v1.8.5.2
>>>
>>> pretty_url():
>>> This function when passed a transport url will anonymize the transport
>>> of the url. It will strip a trailing '/'. It will also strip a trailing
>>> '.git'. It will return the newly formated url for use. I do not believe
>>> there is a need for stripping the trailing '/' and '.git' from a url,
>>> but it was already there and I wanted to make as little changes as
>>> possible.
>>
>> OK.  I tend to agree that stripping the trailing part is probably
>> not a good idea and we would want to remove that but that definitely
>> should be done as a separate step, or even as a separate series on
>> top of this one.
>
> I think that removing the trailing part will greatly reduce the complexity
> to the point were it is unnecessary to have pretty_url().  My goal with
> extracting this function is to isolate the complexity of formatting the
> url to a single spot. I am thinking along the lines of the following
> commit order:
>
> 1. Remove the "remove trailing part"
> 2. Add print_url()
> 3. Always print url when pruning
> 4. Reverse order of prune and fetch
>
>>> print_url():
>>> This function will convert a transport url to a pretty url using
>>> pretty_url(). Then it will print out the pretty url to stderr as
>>> indicated above in the example output. It uses a global variable
>>> named "gshown_url' to prevent this header for being printed twice.
>>
>> Gaah.  What is that 'g' doing there?  Please don't do that
>> meaningless naming.
>
> I am not familiar with C conventions and I was trying to stay consistent.
> I saw other global variables starting with 'g' and made an assumption.
> It will use the original name in the upcoming patches.
>
>> I do not think the change to introduce such a global variable
>> belongs to this refactoring step.  The current caller can decide
>> itself if it called that function, and if you are going to introduce
>> new callers in later steps, they can coordinate among themselves,
>> no?
>
> I agree, there is no reason for introducing it in this step. Thanks for
> pointing that out.

After working on this some more and realizing there is more work to
be done on the "fetch --prune should prune before fetching" issue. Also,
seeing Jeff's response opened my eyes even more. I believe you are
correct. The "trailing parts" piece should be split off into another patch set.
I think it would make sense to add the "fetch --prune should print the header
url" to that patch set. Should I submit those patches as a separate thread
or reply to this thread with just those patches?

-- 
Tom Miller
jackerran@gmail.com
