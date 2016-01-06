From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Wed, 6 Jan 2016 19:23:05 +0700
Message-ID: <CACsJy8AOxs9EizWabdPdEpx6PkPFmv-ZiAtQbdXWV9zDia13Lw@mail.gmail.com>
References: <cover.1451298323.git.mostynb@opera.com> <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
 <5681D02C.1040609@opera.com> <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
 <5684702C.3040802@opera.com> <xmqqy4cbbh5e.fsf@gitster.mtv.corp.google.com>
 <5684FE61.4010701@opera.com> <xmqqmvslp799.fsf@gitster.mtv.corp.google.com> <568C690C.7050007@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Mostyn Bramley-Moore <mostynb@opera.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGn7t-0004rj-Et
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 13:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbcAFMXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 07:23:38 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34943 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcAFMXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 07:23:37 -0500
Received: by mail-lb0-f174.google.com with SMTP id bc4so189506187lbc.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=esqsUfHzHxWAZF19f1S6tR0AKHNqFOfa1Du8Xh2aRFk=;
        b=08rnXX5At1npJfa0u/i+PzBc59J+izo+X/bvdHwh2GhPMTpBcwKEKrQbai66tz95Rv
         3sWbmWNySZ9EsdUc52wXBm/0Wonv6+zje27Hohg9w0/U8oGfTsAPx6r3Y56gs5Myuth4
         /tbCjXCu3wO/RO03ZyrJynX8AgmT2iIZvZc/yxlk81L2JoINH6Aq+MxzllWrLkIjb1EE
         t5MyPGpubrsp5ZYlDa9EE4DpA7XYgDSXpF8GhJmcZCiIHtMsS5fUPbh4MCXOQdC02D5w
         O10nVV1EUaFZgJX2oAk+rPD3SJ8lIzh63Toy/XSOROE7zuNcJ05ILdmv1vlxR81RdZ8l
         LVXA==
X-Received: by 10.112.172.233 with SMTP id bf9mr35672276lbc.137.1452083015551;
 Wed, 06 Jan 2016 04:23:35 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 04:23:05 -0800 (PST)
In-Reply-To: <568C690C.7050007@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283435>

On Wed, Jan 6, 2016 at 8:08 AM, Mostyn Bramley-Moore <mostynb@opera.com> wrote:
> On 01/04/2016 06:46 PM, Junio C Hamano wrote:
>>>> Magic pattern annotation like we do for pathspecs Duy raised may not
>>>> be a bad idea, either, and would probably be easier to teach people.
>>>> Just like in Perl "(?i)$any_pattern" is a way to introduce the case
>>>> insensitive match with $any_pattern, we may be able to pick an
>>>> extensible magic syntax and decorate the pattern you would specify
>>>> for matching refnames to tell Git what kind of pattern it is, e.g.
>>>>
>>>>     $ git mgrep -P -e foo --refs '/?glob/release_*'
>>>>
>>>> I am not suggesting that we must use /?<pattern type name>/ prefix
>>>> as the "extensible magic syntax" here--I am just illustrating what
>>>> I mean by "extensible magic syntax".
>>>
>>>
>>> I hadn't seen the pathspec magic patterns before- interesting.  We
>>> could possibly share syntax with pathspecs, ie
>>> :(?pattern-options...)pattern
>>
>>
>> Even though we have DWIM between revisions and paths on the command
>> line when the user omits "--" for disambiguation, I do not think we
>> look at the shape of the string to DWIM/decide that it is a pattern,
>> so as long as the magic syntax cannot be a valid pattern to match
>> against refs right now (and your ":(?...)"  qualifies as such, as a
>> refname would not contain a component that begins with a colon), it
>> would be possible to introduce it as the magic syntax for matching
>> refs.
>>
>> Or did you mean to use this syntax also for patterns that match
>> strings in contents, e.g.
>>
>>      $ git grep -e ':(?perl-regexp)...'
>
>
> I think it would be nice to support this syntax in every command that does
> pattern matching.
>
> Corner case: what if we want to search for ":(?perl-regexp)", eg in git's
> own source?  I suppose this would do:
> git grep -e ":(?fixed-strings):(?perl-regexp)"

We can also override it with command line options. If you define
--perl-regexp as "if no regex syntax is specified in the pattern, pcre
is used", then you can have something like --force-perl-regexp that
says "all patterns are in pcre, there's no magic whatsoever to choose
a different regex syntax". Though I think --perl-regexp should play
the role of --force-perl-regexp so you don't surprise current scripts,
and have a new option --default-syntax=<type> instead.
-- 
Duy
