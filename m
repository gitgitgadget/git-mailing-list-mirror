From: Jeffrey Middleton <jefromi@gmail.com>
Subject: Re: approxidate parsing for bad time units
Date: Thu, 6 Sep 2012 14:01:30 -0700
Message-ID: <CAFE6XREG5-gwjzvyP9r_hfyY3bWSV2=Bjv9ZbXkejXQRoqYERA@mail.gmail.com>
References: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com>
 <7vehme3n49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:02:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jD5-0003Ao-7e
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933111Ab2IFVBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:01:52 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35934 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933096Ab2IFVBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 17:01:51 -0400
Received: by ieje11 with SMTP id e11so3839880iej.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bnAiJgSsndBNYj0NXTIEMfvXmxWpOI8ePe55fHaTrt8=;
        b=pJh5vgT8cyCncW4tL3ZKn7ScQ8XBB3TsnLSjpQum9Dq33X9qLoLk1ld+L4cvsPB8uT
         yBTloW92YxiF7c6xqnpmPZ194WJ8XU9NNzoqZUigwIaQFNADlNNlEYKvjFQno4X5dfTV
         dbWPT+rt1ty2XuFxu8Mkdq2zHgQNcoAO+oziCH2gl77LEb3SoTiu7zV4hnx9Pea94Cr3
         CthpRh0BicxzOSgLrKbTnHtOn67H/hhRHMvAEtgZG13bVXeobrIf40+PLzSiLROAx7rZ
         824j9ceEk6CXnUcy5NX+cFqzKLOM406CY9059SIO12cN5LCuvhIDj91mbtAACRZlbQ0W
         mtZw==
Received: by 10.43.46.194 with SMTP id up2mr4170174icb.22.1346965310691; Thu,
 06 Sep 2012 14:01:50 -0700 (PDT)
Received: by 10.50.30.36 with HTTP; Thu, 6 Sep 2012 14:01:30 -0700 (PDT)
In-Reply-To: <7vehme3n49.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204922>

I'm generally very happy with the fuzzy parsing. It's a great feature
that is designed to and in general does save users a lot of time and
thought. In this case I don't think it does. The problems are:
(1) It's not ignoring things it can't understand, it's silently
interpreting them in a useless way. I'm pretty sure that "n units ago"
is equivalent to "the same time of day on the last day of the previous
month, plus n days."
(2) Though in some cases it's really obvious, in others it's quite
possible not to notice, e.g. if `git rev-list --since=5.dyas.ago` is
silently the same as `git rev-list --since=4.days.ago`.

So I do think it's worth improving. (Yes, I know, send patches; I'll
think about it.)


On Thu, Sep 6, 2012 at 1:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Middleton <jefromi@gmail.com> writes:
>
>> In telling someone what date formats git accepts, and how to verify it
>> understands, I noticed this weirdness:
>>
>> $ export TEST_DATE_NOW=`date -u +%s --date='September 10'`;
>> ./test-date approxidate now; for i in `seq 1 10`; do ./test-date
>> approxidate "$i frobbles ago"; done
>> now -> 2012-09-10 00:00:00 +0000
>> 1 frobbles ago -> 2012-09-02 00:00:00 +0000
>> ...
>> 10 frobbles ago -> 2012-09-11 00:00:00 +0000
>>
>> Which gets more concerning once you realize the same thing happens no
>> matter what fake unit of time you use... including things like "yaers"
>> and "moths". Perhaps approxidate could be a little stricter?
>
> "Could be stricter", perhaps.
>
> Do we care deeply?  I doubt it, and for a good reason.  The fuzzy
> parsing is primarily [*1*] for humans getting interactive results
> who are expected to be able to notice when the fuzziness went far
> off.
>
> As long as we have ways for scripts and humans to feed its input in
> a more strict and unambiguous way [*2*], it does not hurt anybody if
> the fuzzy parser ignored crufts that it does not understand.
>
>
> [Footnotes]
>
> *1* ... and of course some coding fun and easter egg values. Think
> of it as our own Eliza or Zork parser ;-).
>
> *2* And of course we do.
