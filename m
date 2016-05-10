From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside
 of tests
Date: Tue, 10 May 2016 23:01:11 +0200
Message-ID: <20160510230111.Horde.JpLRouwWbSCYp7yuvqhy5SS@webmail.informatik.kit.edu>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
 <20160510052055.32924-6-sunshine@sunshineco.com>
 <20160510183955.GA16211@sigill.intra.peff.net>
 <CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
 <CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 23:01:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EmY-0002se-MG
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbcEJVBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 17:01:25 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52671 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466AbcEJVBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 17:01:25 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b0EmL-0002fL-Fw; Tue, 10 May 2016 23:01:17 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b0EmF-0004bb-B5; Tue, 10 May 2016 23:01:11 +0200
Received: from x4db0dd69.dyn.telefonica.de (x4db0dd69.dyn.telefonica.de
 [77.176.221.105]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 10 May 2016 23:01:11 +0200
In-Reply-To: <CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462914077.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294192>


Quoting Eric Sunshine <sunshine@sunshineco.com>:

> On Tue, May 10, 2016 at 3:12 PM, Eric Sunshine  
> <sunshine@sunshineco.com> wrote:
>> On Tue, May 10, 2016 at 2:39 PM, Jeff King <peff@peff.net> wrote:
>>> On Tue, May 10, 2016 at 01:20:54AM -0400, Eric Sunshine wrote:
>>>>       while :
>>>>       do
>>>>               case "$1" in
>>>>               -C) dir="-C $2"; shift; shift ;;
>>>>               -b) bare="$2"; shift; shift ;;
>>>> +             -g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;
>>>> @@ -36,6 +38,8 @@ test_rev_parse () {
>>>>       do
>>>>               expect="$1"
>>>>               test_expect_success "$name: $o" '
>>>> +                     test_when_finished "sane_unset GIT_DIR" &&
>>>> +                     eval $env &&
>>>
>>> This will set up the sane_unset regardless of whether $env does
>>> anything. Would it make more sense to stick the test_when_finished
>>> inside $env? You could use regular unset then, too, since you know the
>>> variable would be set.
>>
>> I didn't worry about it too much because the end result is effectively
>> the same and, with all the 'case' arms being short one-liners, I think
>> the code is a bit easier to read as-is; bundling 'test_when_finished'
>> into the 'env' assignment line would probably require wrapping the
>> line. I do like the improved encapsulation of your suggestion but
>> don't otherwise feel strongly about it.
>
> Actually, I think we can have improved encapsulation and maintain
> readability like this:
>
>     case "$1" in
>     ...
>     -g) env="$2"; shift;  shift ;;
>     ...
>     esac
>
>     ...
>     test_expect_success "..." '
>         if test -n "$env"
>         do
>             test_when_finished "unset GIT_DIR"
>             GIT_DIR="$env"
>             export GIT_DIR
>         fi
>         ...
>     '

I wonder if is it really necessary to specify the path to the .git
directory via $GIT_DIR.  Would 'git --git-dir=/over/there' be just as
good?  If yes, then how about

   git ${gitdir:+--git-dir="$gitdir"} rev-parse ...
