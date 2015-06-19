From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/19] fsck: Introduce fsck options
Date: Fri, 19 Jun 2015 12:03:25 -0700
Message-ID: <xmqqd20r8qrm.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<1befa0a0f1feead1ef9b332bdb175182db1c4b4c.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:03:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61Zc-0000lF-0y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbbFSTD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:03:28 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33875 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbFSTD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:03:27 -0400
Received: by iebmu5 with SMTP id mu5so80660019ieb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6tLGayrzCD3Fw5BaJ9DO5fZWF2v8zqu2sOwLMCi2RK4=;
        b=hruukKJmlVujRWIwh6VBDeIODPotlUtQCt2zczEwRBqNly21FbVI67/vUP9XWKdvHQ
         axlte75fFaniS/+tVBf7N4XzExSB9dZ4yB8CDO+K+xkDB+PIOslwerQo1BnAWRna91YU
         Eg8G2kfOPnOewtr4UjM3XmA2mbsB+s6os3oCcFBQZNf41VoO9SJaAB9oLze9l93nPTiB
         IzNMjlNFIv3E7ErnS61PohEqWfB4J4XrDj9HxeiC5Qirp171gubKx7Q8nUiEWXJPX32k
         urzhkFiPXhA2NYu+zp1IMXAMHZke950vgqbmiDhj1LDCeNvlhWqiRSXphJglpkSfe1ku
         QCDQ==
X-Received: by 10.50.62.148 with SMTP id y20mr6470046igr.17.1434740606899;
        Fri, 19 Jun 2015 12:03:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id m193sm7595275iom.19.2015.06.19.12.03.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:03:26 -0700 (PDT)
In-Reply-To: <1befa0a0f1feead1ef9b332bdb175182db1c4b4c.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:32:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272184>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 48fa472..87ae9ba 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -75,6 +75,7 @@ static int nr_threads;
>  static int from_stdin;
>  static int strict;
>  static int do_fsck_object;
> +static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;

So there is a global fsck_options used throughout the entire
session here.

> @@ -838,10 +839,10 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  			if (!obj)
>  				die(_("invalid %s"), typename(type));
>  			if (do_fsck_object &&
> -			    fsck_object(obj, buf, size, 1,
> -				    fsck_error_function))
> +			    fsck_object(obj, buf, size, &fsck_options))
>  				die(_("Error in object"));

And that is used here to inspect each and every object we encounter.

> -			if (fsck_walk(obj, mark_link, NULL))
> +			fsck_options.walk = mark_link;

Then we do a call to fsck_walk() starting from this object, letting
mark_link() to inspect it and set the LINK bit.

> +			if (fsck_walk(obj, NULL, &fsck_options))
>  				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));

Since nobody else sets fsck_options.walk to any other value, and
nobody else calls fsck_walk(), shouldn't that assignment be done
only once somewhere a lot higher in the callchain?  The apparent
"overriding while inspecting this object" that does not have any
corresponding "now we are done, so revert it to the original value"
puzzled me, and I am sure it would puzzle future readers of this
code.
