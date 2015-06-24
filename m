From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Wed, 24 Jun 2015 10:15:08 -0700
Message-ID: <xmqqvbed9gf7.fsf@gitster.dls.corp.google.com>
References: <20150623105042.GA10888@peff.net>
	<20150623105411.GB12518@peff.net>
	<xmqq1th2cezr.fsf@gitster.dls.corp.google.com>
	<20150624075019.GA827@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7oGc-0000ja-AO
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbbFXRPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:15:14 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34882 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbFXRPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:15:11 -0400
Received: by iebrt9 with SMTP id rt9so37709102ieb.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OWL3gKwB+y694BgbTRZYBsCR3mXXmoCF2RxXDq0MerM=;
        b=SfgZhqDcNsPIuKo6sfna4sK4XSF033yc/D3wYpvg9lrTTC14Bdk/BishT7g5Yr0LeI
         AeLaAw2s5sckE8m3UQwEf297d/7tclmb9Jhsen5eMZS/5ZRxUK6jRQw2FGtGI3FN1nHb
         1CK2zmTxzlyAY7MazQ6r1rRHg/ws/f1biEwJt+2XEYBEFuTjHRvHOjr7n+YKaFIs91be
         4aB2x1WL62oYsPVMt1ow4iVIYTMor9hNP68yxd8lNHKwjjieyb9K13/r6kqxzIdkk7qO
         OAs+/6Azcp4Ia/E9u/bwWjmZfc+i7anNIHViF7W2HWEjHbrAeGoourYl434glCK6NADt
         wgQw==
X-Received: by 10.107.134.214 with SMTP id q83mr37099059ioi.91.1435166111251;
        Wed, 24 Jun 2015 10:15:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id e10sm1416332igy.11.2015.06.24.10.15.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 10:15:09 -0700 (PDT)
In-Reply-To: <20150624075019.GA827@peff.net> (Jeff King's message of "Wed, 24
	Jun 2015 03:50:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272567>

Jeff King <peff@peff.net> writes:

>> > +	if (delete_redundant && repository_format_precious_objects)
>> > +		die("cannot repack in a precious-objects repo");
>> 
>> This message initially threw me off during my cursory reading, but
>> the code tells me that this is only about "repack -d".
>> 
>> Unfortunately the users do not get the chance to read the code;
>> perhaps s/cannot repack/& -d/; or something?
>
> I agree that would be better. I originally just blocked all use of
> git-repack, but at the last minute softened it to just "repack -d". I'm
> not sure if that would actually help anyone in practice. Sure, doing
> "git repack" without any options is not destructive, but I wonder if
> anybody actually does it.

Hmph, if you cannot afford to lose objects that are unreachable from
your refs (because you know your repository has borrowers) but are
suffering from too many packs, wouldn't "repack -a" be the most
natural thing to do?  Maybe I am biased, but "git gc" is not the
first thing that comes to my mind in that situation.

> So I think we could squash in the patch below (which also marks the
> strings for translation). But I'd also be OK with the rule covering all
> of `git repack`.

OK, will squash it in.

> [1] One of my proposed uses for this is to revamp the way we handle
>     shared objects on GitHub servers. Right now objects get pushed to
>     individual forks, and then migrate to a shared repository that is
>     accessed via the alternates mechanism. I would like to move to
>     symlinking the `objects/` directory to write directly into the
>     shared space. But the destruction from accidentally running
>     something like `git gc` in a fork is very high. With this patch, we
>     can bump the forks to the v1 format and mark their objects as
>     precious.
>
> ---
> diff --git a/builtin/prune.c b/builtin/prune.c
> index fc0c8e8..6a58e75 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -219,7 +219,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (repository_format_precious_objects)
> -		die("cannot prune in a precious-objects repo");
> +		die(_("cannot prune in a precious-objects repo"));
>  
>  	while (argc--) {
>  		unsigned char sha1[20];
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 8ae7fe5..3beda2c 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -194,7 +194,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				git_repack_usage, 0);
>  
>  	if (delete_redundant && repository_format_precious_objects)
> -		die("cannot repack in a precious-objects repo");
> +		die(_("cannot delete packs in a precious-objects repo"));
>  
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects = write_bitmaps;
