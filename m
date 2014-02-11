From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Tue, 11 Feb 2014 16:02:40 +0100
Message-ID: <CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
References: <xmqqr47fx001.fsf@gitster.dls.corp.google.com>
	<20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
	<xmqq61omu96d.fsf@gitster.dls.corp.google.com>
	<20140210.205936.813126606054805390.chriscool@tuxfamily.org>
	<xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 16:02:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDErG-0006bG-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 16:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaBKPCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 10:02:41 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41346 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbaBKPCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 10:02:41 -0500
Received: by mail-vb0-f46.google.com with SMTP id o19so5848540vbm.5
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fo1H74mKxhl0DpCpo712OFETNERvnTnV4Sp1og9ykE4=;
        b=dDk8BBqRHLgt5gPRuZLI5bHEuiXCJlRzgrbR9ng4CyzQit/mQXhq2QulpjI4kAjYT+
         NdTYhdfTfsD4yIBGiKjMRJzKabF+R60vlPH0QRaDT09EgRhJsqXF5RRNRlee4CL3tceR
         yRiBbWNYFLaOAAP3kYeu3D9mSDkW80JcZAkM30rmPzdb42U29gjM0CF9/xBeBv1kclHS
         hre4FcP0jD5DeielaZvPOSPXULqjBdFRoNhbwbERF/NDjRUX5JGB6ppTsGR8/jteoGTk
         NYNwVrQlaZ3hv0p1KroTveq9IOkD/uyDg+pb8/sn3XDbyp7fP3FV26lMhfsKqm2NVali
         mVJQ==
X-Received: by 10.58.169.7 with SMTP id aa7mr2116001vec.24.1392130960205; Tue,
 11 Feb 2014 07:02:40 -0800 (PST)
Received: by 10.58.173.231 with HTTP; Tue, 11 Feb 2014 07:02:40 -0800 (PST)
In-Reply-To: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241946>

On Mon, Feb 10, 2014 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Many entries with the same key but distinct values can be configured
>> using:
>>
>> if_exists = add_if_different
>> if_missing = add
>>
>> Many entries with the same key but values that can be the same can be
>> configured using:
>>
>> if_exists = add
>> if_missing = add
>
> While the above certainly can express the combinations, I am still
> puzzled about the value of having "under this condition" (i.e.
> if-exists/if-missing) and "do this" (i.e. add/add-if-different) as
> two separate concepts.

It is because there are many possible conditions under which the user
might want to do different things, and the syntax of our configuration
files is not a programming language, so it is not well suited to
nicely express what the user might want under different conditions.

That's what I tried to show in my last message in the thread I sent
the link to in my previous message.

(http://thread.gmane.org/gmane.comp.version-control.git/237278/)

So we have to choose a few conditions to avoid possible combinatorial
explosion in the number of possible values.

> If you do not have an existing entry with the same key, no new entry
> can be the same as an existing one---therefore, the former "allow
> only distinct values for the same key" can just say
>
>   trailer."Fixes".action = add_if_different
>
> or something, without any if_exists/if_missing.  In a similar way,
> the latter "duplicated values allowed for the same key" can say
>
>   trailer."Sob".action = add
>
> You can throw into the mix other actions like "add_if_missing", you
> can also express "only one value allowed for the same key---the
> first one wins", "replace" to mean "replace if there is one with the
> same key", and "replace_or_add" to mean "same as 'replace', but add
> if there is no existing entries with the same key".  Will we lose
> expressiveness by simplifying the semantics, getting rid of this
> "under this condition" part and instead making "do this" part more
> intelligent?

I don't think we will lose expressiveness, but I think there might be
a combinatorial explosion in the number of choices.

Right now there are 2 choices for "if_missing" and 5 choices for
"if_exists". This means that if we use only one "action" config
variable and want to have the same expressiveness, we need 10 choices.

It doesn't seem a big difference now, but, if we add more choices,
then the difference will increase a lot.

> Even if we assume, for the sake of discussion, that it *is* a good
> idea to separate "under this condition" part and "do this" part, I
> do not think the above is the only or the best way to express
> "distinct values allowed for the same key".  How do we argue that
> this from your example
>
>   if_exists = add_if_different
>   if_missing = add
>
> is a better design than this, for example?
>
>   if_key_value_exists = ignore ; exact matching <key,val> exists
>   if_key_exists = add          ; otherwise
>   if_missing = add

The question is what happens if we want to say "if the same <key,
value> pair exists but not near where we would add.

With the solution I implemented, that is:

if_exists = add_if_different_neighbor

With the solution you suggest, should we have:

  if_key_value_exists_not_neighbor = add ; exact matching <key,val>
exists but not near where we would add
  if_key_value_exists = ignore ; exact matching <key,val> exists
  if_key_exists = add          ; otherwise
  if_missing = add

or:

  if_key_value_exists = ignore_if_neighbor ; exact matching <key,val> exists
  if_key_exists = add          ; otherwise
  if_missing = add

And what happens if we want to say "if key exists and value matches
<regex>", how do we express that then?
Or what happens when we want to say "if key exists and <command> succeeds"?

With what I suggest, we can still say:

if_exists = add_if_values_matches <regex>

or

if_exists = add_if_succeeds <cmd>

With the solution you suggest, should it be:

  if_key_value_exists = ignore
  if_key_exists = add_if_values_matches <regex>

and

  if_key_value_exists = ignore
  if_key_exists = add_if_succeeds <cmd>

?

Doesn't it look like redondant between the 2 lines?

And then people might ask if they can also use something like this:

  if_key_value_exists = add_if_succeeds <cmd1>
  if_key_exists = add_if_succeeds <cmd2>
  if_key_missing = add_if_succeeds <cmd3>

and it will look like we are trying too much to do what should be done
in only one script.

> The latter splits remaining conditional logic from "do this" part
> (no more "add_if_different" that causes "add" action to see if there
> is the same key and act differently) and moves it to "under this
> condition" part.
>
> I am trying to illustrate that the line to split the "under this
> condition" and "do this" looks arbitrary and fuzzy here, and because
> of this arbitrary-ness and fuzziness, it is not very obvious to me
> why it is a good idea to have "under this condition" as a separate
> concept from "do this" settings.
>
> What is the advantage of having such an extra axis?  Does it make it
> easier to manage?  Does it allow us to express more?

It will be complex anyway, but at least, with what I implemented,
there are only 2 cases in the "under this condition part" and they are
completely disjoint, which means that they are hopefully not very
difficult to understand.

I agree that it may look arbitrary and fuzzy to split things this way,
but I think it's a good compromise between avoiding combinatorial
explosion in the number of choices, keeping it easy to understand and
allowing many features now and more in the future.

Thanks,
Christian.
