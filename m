From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] pretty: support placeholders %C+ and %C-
Date: Fri, 21 Sep 2012 15:36:29 +0700
Message-ID: <CACsJy8Azsg_EQvnm0L4AyZbnaDPcjtrr_+8u5eOAGjKFg9BBRQ@mail.gmail.com>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com> <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <7vy5k4bpzh.fsf@alter.siamese.dyndns.org> <7vehlwbn76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 10:37:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEyjl-00021W-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 10:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965Ab2IUIhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 04:37:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37164 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab2IUIg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 04:36:59 -0400
Received: by ieak13 with SMTP id k13so4863017iea.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e3MGdUvUfWFvIhj06WWiQkYeZEsyrRSCPfVftsh6yGM=;
        b=ChWjcliVaU/te8WcEGhbR74/AhbCt+fdHwAFUJg9usx3MUyhziQn0bSS/LdWW/Q9QK
         s7RDlpS1ToRUa2aaNnJuCHUAjDzBlQcpM+jt2D6lBxYY5xVQcBK3HP6KX+YkbqA4z2za
         dihOyfNk2VdDj4gj3TuQ/FflMWhjx9aHnDehcsyqJm/grzi60GJtdZTbsjLL/XZCkFPr
         /v7Byoaes6VX49XLiJMxg/8u8W1Qc2H3vdCYnL1wnSkK9us3AILsz+gTgfTdiooni6DT
         CJjZadW/nUem1ZUEpZJa33mRygAQQWEGOYj+MdEwr+C+zt6Ux6OJSmLX4JOj4DgyS3Dm
         lpjQ==
Received: by 10.42.129.83 with SMTP id p19mr3462513ics.9.1348216619237; Fri,
 21 Sep 2012 01:36:59 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Fri, 21 Sep 2012 01:36:29 -0700 (PDT)
In-Reply-To: <7vehlwbn76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206115>

On Fri, Sep 21, 2012 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +- '%C+': enable coloring on the following placeholders if supported
>>> +- '%C-': disable coloring on the following placeholders
>>
>> OK, so typically you replace some format placeholder "%?" in your
>> format string with "%C+%?%C-", because you cannot get away with
>> replacing it with "%C+%? and other things in the format you do not
>> know if they support coloring%C-".
>>
>> If that is the case, does it really make sense to have %C-?

"%C+%?" should work. if %? does not support coloring, the %C+ effect
is simply ignored. In my use case, I don' really use %C- because I
always want color wherever possible. Though I suspect a user might
want to turn off coloring for certain part of the format string.

Replacing every %? with %C+%?%C- is really annoying in my "always color" case..

>> It smells as if it makes more sense to make _all_ %? placeholder
>> reset the effect of %C+ after they are done (even the ones that they
>> themselves do not color their own output elements), so that you can
>> mechanically replace "%?" with "%C+%?".

.. or even "%C+%?". My format string would become "%C+%h %C+%s%C+%d",
much harder to read.

> Thinking about this a bit more, perhaps we would want a generic
> mechanism to give parameters to various %? placeholders. This is not
> limited to "I can do color but there is no mechanism for the user to
> tell me that I should do color" %H, %h and %d may want to say.  An
> obvious and immediate example is that %h might want to be told how
> many hexdigits it should use.

Yeah that'd be nice. We already use %?(..) for %C. Maybe we can generalize that.

Still I'd like a way to define attributes for a group of placeholders
instead of just individuals. Continuing with the %?(...) syntax above
for specifying attributes for a specific placeholder, %(...) may be
used to specify global attributes that affect all following
placeholders until another %(...) stops the effect, or %?(...)
overrides it.
-- 
Duy
