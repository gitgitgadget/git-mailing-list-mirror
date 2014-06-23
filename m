From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [RFC PATCH 1/7] rebase -i: Make option handling in pick_one more
 flexible
Date: Mon, 23 Jun 2014 02:04:14 +0200
Message-ID: <53A76EFE.3080909@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>	<53A258DA.3030903@gmail.com> <53A439B2.7000106@alum.mit.edu> <xmqqvbrvcq8p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 23 02:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyrkP-0005Te-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 02:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbaFWAET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 20:04:19 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:41575 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaFWAET (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 20:04:19 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so6075441wes.13
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hkFhUfOOnrn7JCXpSH9bJrbFUtaN1qbAcWOGbrgRN3o=;
        b=RVKKe5B7RtOOUMUs1+iKlZPrt8LJWh2BPem7G1XJ5kCHoMQ4IA1Nhw5+Prbvxk+Jxn
         ADVe9FvyN2G6hnp2j9u3C6YoghtNA2DlGl6ECVCDAUSHio3Ze+ccwxSGPkoembWz1oyG
         ZD53qJEVsAT2queKbVW9KWLs476RD2QcC54cd8eSVu1CPYWaOyW/vopPZkz1IWHjOgYH
         H69KTi9FTQ1nfIr4CLXfRa8eltXfvJnfLdNNnOxDGxR4gXMAF48ynVVq+c8ZVb25DDlW
         yP3FdELXzz3zA4TgorZK5+nPVv556i30u83ppUaby9vLkw/A2KULZfj0S2z77e/VCJOO
         F/Bg==
X-Received: by 10.180.81.72 with SMTP id y8mr21388322wix.7.1403481857324;
        Sun, 22 Jun 2014 17:04:17 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id jb16sm26774863wic.10.2014.06.22.17.04.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Jun 2014 17:04:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqvbrvcq8p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252315>

Hi Junio,

On 06/20/2014 09:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>  pick_one () {
>>>  	ff=--ff
>>> +	extra_args=
>>> +	while test $# -gt 0
>>> +	do
>>> +		case "$1" in
>>> +		-n)
>>> +			ff=
>>> +			extra_args="$extra_args -n"
>>> +			;;
>>> +		-*)
>>> +			warn "pick_one: ignored option -- $1"
>>> +			;;
>>
>> This is an internal interface, right?  I.e., user input isn't being
>> processed here?  If so, then the presence of an unrecognized option is a
>> bug and it is preferable to "die" here rather than "warn".
>>
>> The same below and in at least one later commit.
> 
> And if this is purely an internal interface, then I really do not
> see the point of allowing -n to be anywhere other than the front.
> If we are planning to accept other random options to cherry-pick in
> later steps, but we are not yet doing so at this step, then I do not
> thin we want to have any loop like this before we actually start
> accepting and passing them to the underlying cherry-pick.

Ok, until we require pick_one to accept options apart from -n, this
patch is postponed, for the presence of a single option is checked
easiest without the loop. It might be the case that rewriting replayed
commits in do_pick is the better alternative anyway and that it will
never be required to relay user-specified options beyond do_pick.

> Furthermore, if the "-n" is currently used as an internal signal
> from the caller to pick_one() that it is executing the end-user
> supplied "squash" in the insn sheet, it may be a good idea to change
> that "-n" to something that is *NOT* a valid option to cherry-pick
> at this step, before we start accepting user-supplied options and
> relaying them to underlying cherry-pick.
> 
> One way to do so cleanly may be to _always_ add the type of pick as
> the first parameter to pick_one, i.e. either "pick" or "squash", and
> do:
> 
>         pick_one () {
>                 ...
>                 n_arg=
>                 case "$1" in
>                 pick) ;;
>                 squash) n_arg=-n ;;
>                 *)	die "BUG: pick_one $1???" ;;
>                 esac
>                 shift
>                 sha1=$1
>                 ...
>                 output eval git cherry-pick $n_arg \
>                         ...
>         }
> 
> Also I suspect that you would need to be careful *not* to allow "-n"
> to be given as part of the "random user-specified options" and pass
> that to cherry-pick in the later steps of your series [*1*], and for
> that you may need a loop that inspects the arguments like you had in
> this patch.

I really like the idea of being explicit about how pick_one shall replay
the named commit and not using the cherry-pick option name for the
squash case. However, pick_one will never receive random user-specified
options. do_pick is the interface function which handles the pick
arguments. If any user-specified options are relayed to pick_one and
cherry-pick, they will be validated by do_pick first (using a loop like
above).

   Fabian

> [Footnote]
> 
> *1* The existing callers of "pick_one -n" very well know and expect
>     that the step will only update the working tree and the index
>     and it is the callers' responsibility to create a commit out of
>     that state (either by amending or committing); similarly the
>     existing callers of "pick_one" without "-n" very well know and
>     expect that the step will make a commit unless there is a
>     problem.  I do not think you would consider it such a "problem
>     to replay the change in the named commit" for the end user's
>     insn sheet to pass a "-n".
