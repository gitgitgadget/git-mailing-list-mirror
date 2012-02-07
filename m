From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 11:22:50 -0800
Message-ID: <20120207192135.GC6264@tgrennan-laptop>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruqd2-0005UI-V0
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab2BGTW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:22:56 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55393 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab2BGTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 14:22:55 -0500
Received: by ggnh1 with SMTP id h1so3654794ggn.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6gHhYhsdpSpZEoJZ3Hno+7ceAoQKq72CjoPzOM5J8XQ=;
        b=cx4opwWyIBRM/ZeSEz+9RrE/Y8439wK43Sg7GBl5pOcKm1MTNKO+U9ylYBF3hbj9Tb
         +FW+88qyZFvNPBFv2o28MiQghnUdz1MJzrQ5z0Ml8GU1UdKEgjkbN4i+hWgrRj6wIyIz
         YvLtKuLbyH8VO5V5OFO44FXBWPYZv4+wNogMY=
Received: by 10.182.164.7 with SMTP id ym7mr3548680obb.68.1328642574575;
        Tue, 07 Feb 2012 11:22:54 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id n4sm14029266obv.10.2012.02.07.11.22.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 11:22:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120207191202.GA496@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190203>

On Tue, Feb 07, 2012 at 02:12:02PM -0500, Jeff King wrote:
>On Tue, Feb 07, 2012 at 11:02:28AM -0800, Tom Grennan wrote:
>
>> >Would using sha1_array save us from having to create our own data
>> >structure? As a bonus, it can do O(lg n) lookups, though I seriously
>> >doubt anyone will provide a large number of "--points-at".
>> 
>> Thanks, but I now realize that I also need to save the pointed at
>> refname to detect lightweight tags that have matching sha's but
>> different names.
>
>I'm not sure I understand. Wouldn't you match lightweight tags by the
>sha1 they point at? Something like:

I think the following would show the pointed at tag too.
  $ git tag my-v1.7.9 v1.7.9
  $ ./git-tag -l --points-at v1.7.9
  my-v1.7.9
  v1.7.9

vs.

  $ ./git-tag -l --points-at v1.7.9
  my-v1.7.9

I found that I had to filter matching refnames.

>  static int tag_points_at(struct sha1_array *sa,
>                           const unsigned char *sha1)
>  {
>          struct object *obj;
>
>          /* Lightweight tag of an interesting sha1? */
>          if (sha1_array_lookup(sa, sha1) >= 0)
>                  return 1;
>
>          /* Otherwise, maybe a tag object pointing to an interesting sha1 */
>          obj = parse_object(sha1);
>          if (!obj)
>                 return 0; /* or probably we should even just die() */
>          if (obj->type != OBJ_TAG)
>                 return 0;
>          if (sha1_array_lookup(sa, ((struct tag *)obj)->tagged->sha1) < 0)
>                 return 0;
>          return 1;
> }
>
>> >Also, should you check "unset"? When we have options that build a list,
>> >usually doing "--no-foo" will clear the list. E.g., this:
>> >
>> >  git tag --points-at=foo --points-at=bar --no-points-at --points-at=baz
>> >
>> >should look only for "baz".
>> 
>> Ahh, so I just need to:
>> 	if (unset) {
>> 		if (*opt_value)
>> 			free_points_at(*opt_value);
>> 		*opt_value = NULL;
>> 		return 0;
>> 	}
>
>Yes, exactly.
>
>> >> +		{
>> >> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
>> >> +			"print only annotated|signed tags of the object",
>> >> +			PARSE_OPT_LASTARG_DEFAULT,
>> >> +			parse_opt_points_at, (intptr_t)NULL,
>> >> +		},
>> >
>> >I think you can drop the LASTARG_DEFAULT here, as it is no longer
>> >optional, no?
>> 
>> You mean flags = 0 instead of PARSE_OPT_LASTARG_DEFAULT, right?
>
>Right. Though without flags, you can probably just use the OPT_CALLBACK
>wrapper, like:
>
>  OPT_CALLBACK(0, "points-at", &points_at, "object",
>               "print only annotated|signed tags of the object",
>               parse_opt_points_at)
>
>Note that if you are going to handle lightweight tags, that description
>should probably be updated.
>
>-Peff

-- 
TomG
