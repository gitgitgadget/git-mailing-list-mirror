From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v14 01/11] trailer: add data structures and basic functions
Date: Wed, 17 Sep 2014 10:26:52 +0200
Message-ID: <CAP8UFD1XaDEbOjWgkQHPzSLu8X3wxsoayNQ7vWt2i85TPcU9VQ@mail.gmail.com>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
	<20140915053142.26573.86374.chriscool@tuxfamily.org>
	<xmqqsijs4o02.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3wi2KCZhDAF7vqMpb72DbLMbHNDiDGi0tFLW+vzsQqSA@mail.gmail.com>
	<20140917075838.GA16200@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:27:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUAZy-0001Px-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 10:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbaIQI06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 04:26:58 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:58548 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbaIQI0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 04:26:53 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn15so814100igb.15
        for <git@vger.kernel.org>; Wed, 17 Sep 2014 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aMzjb5JuYRkMc1GtZDQiIzxK6lRjNjYdFV8Ymla3WeQ=;
        b=pQQpM/s5q123Xl/1FA/aHfjdATN16QyF7Gw9MfuBYYiwIt7eb+24Dd8lwtXujJasg/
         zr20eixhYnLnTJcuuPS62ljkiNvYqiNz1IgSPqZflYB44ss5zajvqJfcT8eFrtOUWSDY
         qlhelK/LSRACvKDCQ29SifYBGnZt1VaCEgFbNfm7W6IiwvDNqt1K7RUqWCc+FM8INa7K
         e5k2mahkxrWa4ny21XaksNwi+PgPTylxkVPy1FbPzoSH3vOpaOFTisNBXYZ2KUGLBgvb
         rLpNxVdP98rtMc8/TySX8udeDjgPSb5BJ1cLxvkSOvx3Wr9VYh6GTdsElDve5JieDoji
         XNvA==
X-Received: by 10.50.103.106 with SMTP id fv10mr37820928igb.40.1410942412936;
 Wed, 17 Sep 2014 01:26:52 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Wed, 17 Sep 2014 01:26:52 -0700 (PDT)
In-Reply-To: <20140917075838.GA16200@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257218>

On Wed, Sep 17, 2014 at 9:58 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 16, 2014 at 10:01:11AM +0200, Christian Couder wrote:
>
>> On Mon, Sep 15, 2014 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Christian Couder <chriscool@tuxfamily.org> writes:
>> >
>> >> +/* Get the length of buf from its beginning until its last alphanumeric character */
>> >
>> > That makes it sound as if feeding "abc%de#f@" to the function returns
>> > 3 for "abc", but
>>
>> For me the last alphanumeric character in "abc%de#f@" is "f", so it is
>> the length from the beginning to "f" so it should return 8.
>
> FWIW, I parsed the comment as you intended, but I do think it is a bit
> unclear (especially given the name, as it is skipping over more than
> just alnums). From reading the calling code, it looks like the intent is
> to take a token string like "Signed-off-by:" and find that the ":" is
> part of the ending punctuation, but that the "-" are retained as
> internal punctuation.
>
> Would it make sense as:
>
>   /*
>    * Return the length of the string not including any final
>    * punctuation. E.g., the input "Signed-off-by:" would return
>    * 13, stripping the trailing punctuation but retaining
>    * internal punctuation.
>    */
>   int token_len_without_separator(const char *token)
>   ...
>
> The name is a bit clunky, but hopefully it is more clear what the point
> is.

Ok, I will use that in the next version.

Thanks,
Christian.
