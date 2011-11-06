From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: do not refer to non-existing marks
Date: Sat, 5 Nov 2011 23:45:14 -0500
Message-ID: <20111106044514.GN27272@elie.hsd1.il.comcast.net>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 06:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMus7-0004p9-4A
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 06:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab1KFEp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 00:45:26 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63503 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1KFEpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 00:45:25 -0400
Received: by ggnb2 with SMTP id b2so4014576ggn.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 21:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wAlPfw4bZdU1XorT6cb2YewMNwWrFUWaOJQhSI6y764=;
        b=CmVgPc07vKnB36Od542hfVXSIs62cZdl+4r+GCoX8iYA3rdqSn/WRrov+hIniV/6aS
         OjFa5LVCP2hnR9Fx1NDGBumDbJHbalRKpd4vuTpEEuRCGkxggeAoq6LWXZClZiloopPr
         /V5y0JlVe3R+id2WkZZN4yXNPOG4VealmhUww=
Received: by 10.50.161.131 with SMTP id xs3mr28673326igb.23.1320554724764;
        Sat, 05 Nov 2011 21:45:24 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fu10sm14444408igc.6.2011.11.05.21.45.22
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 21:45:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320535407-4933-3-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184899>

Hi,

Sverre Rabbelier wrote:

> When calling `git fast-export a..a b` when a and b refer to the same
> commit, nothing would be exported, and an incorrect reset line would
> be printed for b ('from :0').

Hm, seems problematic indeed.

> Extract a handle_reset function that deals with this, which can then
> be re-used in a later commit.

So, does this patch drop the confusing behavior and add one that is
more intuitive for remote helpers?  It's not clear from this
description what sort of deal the patch makes and whether it is a good
or bad one.

[...]
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -529,9 +529,20 @@ static void get_tags_and_duplicates(struct object_array *pending,
>  	}
>  }
>  
> +static void handle_reset(const char *name, struct object *object)

Nit: the other handle_* functions are about acting on objects
encountered during revision traversal from the object store.  In other
words, the things being handled are the git objects.

By contrast, this function is about writing a "reset" command to the
fast-import stream.  I'd be tempted to call it reset_ref() or
something like that.

> +{
> +	int mark = get_object_mark(object);
> +
> -	commit = (struct commit *)object;
> -	printf("reset %s\nfrom :%d\n\n", name,
> -	       get_object_mark(&commit->object));
> +	if (mark)
> +		printf("reset %s\nfrom :%d\n\n", name,
> +		       get_object_mark(object));
> +	else
> +		printf("reset %s\nfrom %s\n\n", name,
> +		       sha1_to_hex(object->sha1));

Ah --- the functional change is to use a sha1 when there is no mark
corresponding to the object.

Why is this codepath being run at all when b is excluded by the
revision range (a..a a = ^a a a)?  Is this the same bug tested
for in patch 1/3 or something separate?
