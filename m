From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Fri, 21 Sep 2012 15:55:13 +0700
Message-ID: <CACsJy8AAjxMN7MX09Eq4Dy6NJHMkyxGJZm9uZquXWTi0goAYLQ@mail.gmail.com>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com> <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <20120920143803.GA9527@lanh> <7v392cd4vi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 10:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEz1i-0000qp-8h
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 10:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab2IUIzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 04:55:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48338 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab2IUIzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 04:55:44 -0400
Received: by ieak13 with SMTP id k13so4890156iea.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9gIRpYthkjeK3Le+KO1znK4SEPF9C/QyTCwSM75TPao=;
        b=T/nSuPK0mGnsjxTvHbX+WJUC1eoqlZgMCogmcy89Fe9dRyf8xBzozKQI/hLd5nTN9u
         epEM02xqK5lb/Kra07TPvRBlJcwImQiFp8q5h8GX5fW9z1z4TvfTYY1NNZ0MKpKm+IDq
         MjNy2fdrF+GYPxpI2ed4IZ1OUYR9CW980HWxZL3gQI1nqQlSXsNqUuBhZ9iTwkWwg2xP
         sTa3agsulbfHh8RLxmP9j6aqsx7Kddb4FGzLxJelBYogIMkQW/4G2oA9GDRCYfbtBe3h
         oX6Y+iOC2Ss3/wLFYyWDQqvtF+mo9n+e5M3JqHsVK8T8lhZqojcgHxocg3BN6LhJvk2g
         93LA==
Received: by 10.50.91.162 with SMTP id cf2mr1025121igb.40.1348217744202; Fri,
 21 Sep 2012 01:55:44 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Fri, 21 Sep 2012 01:55:13 -0700 (PDT)
In-Reply-To: <7v392cd4vi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206116>

On Thu, Sep 20, 2012 at 11:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think this is a great feature at the conceptual level, and you
> know "but" is coming ;-).

I'm still not sure if it's useful beyond my simple example. For
example, will it be useful in multiline log format, not just
--oneline?

>  - Shouldn't it be "everything from there until the end of the
>    current line" than "everything after that"?

The patch does that. I wasn't specific in my patch description.

>  - How is the display width determined and is it fixed once it gets
>    computed?

term_columns(). But I'd rather have a (user-configurable) max limit.
It's really hard to line up two distant text parts of a 200 char line
without a physical ruler. In my patch I just hard code the max limit
around 120 char or so.

>  - How does this interact with the wrapped output?  Should it?

We have to deal with it anyway when the left aligned text takes all
the space. On one hand, I don't want to break the terminal width,
leading to ugly output, so it'll interact. On the other hand, I don't
really wish to turn pretty format machinery into a full feature text
layout engine (by ripping of links/lynx?). So we have a few options:

1. ellipses, line cutting means i18n issues ahead
2. just put the right-aligned text on another line. We do something
similar in parse-options. When the option syntax is too long, we put
help description on the next line.
3. bring in html/css box model for arranging text so that both
left/right aligned texts can share the same line.
4. tell users upfront it's not supported. don't do that

I'd vote 2, or 4.

>  - I am wondering if somebody ever want to do this with a follow-up
>    patch:
>
>         Left %h%|Center %cd%|Right %ad
>
>    Is %| a sensible choice for "flush right"?  I am wondering if it
>    makes more sense to make %|, %< and %> as "multi-column
>    introducer" (the example defines output with three columns) that
>    also tells how text inside each column is flushed inside the
>    column, e.g.
>
>         %>col 1 right flushed%|col 2 centered%< col 3 left flushed
>
>    or something like that (we may want explicit "column width"
>    specifiers if we were to do this kind of thing).

Yeah that crossed my mind. But I'll need to convince myself it's
actually useful. Once you're on that road, you may want >=4 column
tables. We can extend column.c to do that. That hard part is
converting pretty format to use column functions.
-- 
Duy
