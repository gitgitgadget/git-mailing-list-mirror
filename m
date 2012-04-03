From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] sha1_name: introduce getn_sha1() to take length
Date: Tue, 3 Apr 2012 17:08:18 -0500
Message-ID: <20120403220817.GE19858@burratino>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
 <1333029495-10034-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBu4-0004dQ-30
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab2DCWIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 18:08:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42993 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab2DCWIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 18:08:34 -0400
Received: by ghrr11 with SMTP id r11so131895ghr.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J2y/LaobVR5B4whXTUjaLsfe5JeR6wq6o7az/SSketQ=;
        b=fM6HowN7CnJAN/zFkLaazY4/kKZA6YDWTLQdi1F1tAKz/aqQLJtp4SqsPSHqsxEGlD
         2xhq/vx7Xq4/j97VWKRn46c1C+aqqoFG9SdTVaOoHvy0Y1PooWn2mINoUsAgmDY/gfvI
         A1uvPEffdAGp8ARbxIMbd4LD1y7BluTLMzsqKbKf2Wg5KvAu/5+3Eef1x/uFUxSNdh5+
         teieJj4sbhB1y6T86QwrP2X8AEqoyCVMrRLuJV0YTkSHC5tTVQuBcxMf3BUM/AOnb4o1
         Mdr/G5wDiv9tU0NP7xtsmBK3cp2Enu54uwUaf5wkLNFdPeAeEf47xhtLj3wN6GPN7pn2
         eDMQ==
Received: by 10.60.24.164 with SMTP id v4mr20980607oef.51.1333490914046;
        Tue, 03 Apr 2012 15:08:34 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id in4sm22947654obb.2.2012.04.03.15.08.32
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 15:08:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333029495-10034-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194655>

(cc-ing Cl=C3=A9ment who is one of the last people to change this famil=
y of
 APIs, and Matthieu who knows these codepaths well and may have been a
 mentor for that project)
Hi,

Ramkumar Ramachandra wrote:

> [Subject: sha1_name: introduce getn_sha1() to take length]

You're probably going to hate this, but oh well:

I love the new function.  I really dislike its name.  Do we have any
other (function that takes a C-style string/function that takes a
buffer with length) pairs in the spirit of strchr/memchr to draw
inspiration from?

> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1019,12 +1019,11 @@ static char *resolve_relative_path(const char=
 *rel)
>  			   rel);
>  }
> =20
> -int get_sha1_with_context_1(const char *name, unsigned char *sha1,
> -			    struct object_context *oc,
> -			    int only_to_die, const char *prefix)
> +static int getn_sha1_with_context_1(const char *name, int namelen,
> +				unsigned char *sha1, struct object_context *oc,
> +				int only_to_die, const char *prefix)

Holy cow this function is going crazy.  So let's take a survey of
the public functions in this family.

 get_sha1(name, sha1)::

	Looks up a sha1 expression like xyz^ and returns the
	corresponding object name in the 20-byte buffer sha1.
	Returns -1 on failure.

 get_sha1_with_mode(name, sha1, mode)::

	Like get_sha1, but when name refers to a path within
	a tree, also returns the mode in *mode.

 get_sha1_with_context(name, sha1, context)::

	Likewise, but also returns the parsed <tree, path>
	pair.=20

 get_sha1_with_mode_1(name, sha1, mode, flag, prefix)::

	Like get_sha1_with_mode, but with some extra features:

	 - flag indicates whether we are in the "detailed diagnosis"
	   codepath and only calling this function for the
	   side-effect of die()-ing with a meaningful message.

	 - prefix indicates the cwd prefix for use in the "did you
	   mean?" diagnostic.

 get_sha1_with_context_1(name, sah1, context, flag, prefix)::

	Variant in the same vein for get_sha1_with_context.

Plus the corresponding variants with "name, namelen" pairs after your
patch.

My first reaction is that the meaning of the _1 suffix is not going to
be obvious to newcomers.  Any ideas for addressing that?

"get_sha1_with_context_1" has no external callers so it could probably
be made private.  So there could be a sequence of functions with
increasing detail:

	get_sha1(name, sha1)
	get_sha1_with_mode(name, sha1, mode)
	get_sha1_with_context(name, sha1, context)
	die_sha1_not_in_index(name, sha1, context, prefix)

The "len" argument could be introduced at some convenient place in
this list to avoid having to change too many callers, for example:

	get_sha1(name, sha1)
	get_sha1_with_mode(name, sha1, mode)
	get_sha1_with_context(name, namelen, sha1, context)
	die_sha1_not_in_index(name, namelen, sha1, context, prefix)

Or maybe it makes sense to bite the bullet and add the length
argument to all callers:

	get_sha1(name, namelen, sha1)
	get_sha1_with_mode(name, namelen, sha1, mode)
	get_sha1_with_context(name, namelen, sha1, context)
	die_sha1_not_in_index(name, namelen, sha1, context, prefix)

If I were doing it, I might just ask the maintainer to make the
decision for me, by making a somewhat funny patch series:

 1. add "how to use the get_sha1 family" to Documentation/technical.
 2. make get_sha1_with_context_1 static.
 3. replace get_sha1_with_mode_1 with simpler die_sha1_not_in_index
    function.
 4. add namelen argument to die_sha1_not_... and
    get_sha1_with_context, adjust callers, and make use of
    get_sha1_with_context with this arg in sequencer code.
 5. add namelen arg to get_sha1_with_mode, adjust callers, and
    make sequencer code use this instead.
 6. add namelen arg to get_sha1, adjust callers, and make sequener
    code use this instead.

That way, the maintainer could take patches 1 - 3 to get the basic API
cleanup, patch 4 to get the sequencer enhancement and make a judgement
call about whether to take patches 5 and 6 depending on how much of a
pain the churn would be given other patches in flight.

What do you think?
Jonathan
