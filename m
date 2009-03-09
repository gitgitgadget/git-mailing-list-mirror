From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http: add_fill_function checks if function has been added
Date: Mon, 9 Mar 2009 20:01:32 +0800
Message-ID: <be6fef0d0903090501m21ee33b6pc3b45680324d932c@mail.gmail.com>
References: <49B266B0.4020304@gmail.com>
	 <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
	 <be6fef0d0903071249s42ac7f94o82461ca32dcdfcd5@mail.gmail.com>
	 <7vd4ctm29m.fsf@gitster.siamese.dyndns.org>
	 <be6fef0d0903080327u551c0b4mcb86f2ba76473efc@mail.gmail.com>
	 <7vd4crls8q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 13:03:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgeCG-0000Ji-FX
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 13:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbZCIMBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 08:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZCIMBf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 08:01:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:5934 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZCIMBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 08:01:34 -0400
Received: by rv-out-0506.google.com with SMTP id g9so1718138rvb.5
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s0NEs04ww/Fbt6x1Iff8+l1YX7yzv0YldHCaIvo4kIk=;
        b=s66n8sSVF9bPNhYblmZATTBEQJHfi4bTlK7rhZyN7lmhHAhuyC/9qXVvILm1TguDbp
         KspT3x0i+Zj0rnavbLVs9AiFvJPeIh8XSUaFht0UKf1wP44QCPKwsqpej1emAdWEjbax
         gSK+VgQxkke28lpQZBMr5rrezJ77bR68CotdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=po27ugd+uuzcf9eugELCks4A49eg+bq7aZYfzCXUMDU4MhATEVdUvIhPC6PMe9TmrU
         WkRcp4VRI4PG3xSbLkp6f5tul4fKqi6cTdG9xz0R37HmHKCfIUo/cTs3noBctaU9SODv
         uyGBgFLOtXBAjb0wPFUgwelPhObqC3qlW16MQ=
Received: by 10.115.18.3 with SMTP id v3mr3478095wai.141.1236600092052; Mon, 
	09 Mar 2009 05:01:32 -0700 (PDT)
In-Reply-To: <7vd4crls8q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112691>

Hi,

On Mon, Mar 9, 2009 at 3:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> That is not what I was worried about.  There are two callsites to
> add_fill_function().

I'm sorry I didn't catch this from your earlier message; on a
re-reading I caught it.

> But it is not immediately obvious in http-walker.c callchain if multiple
> calls to add_fill_function(), if they were ever made, give the same
> "walker" as the callback data.  Your patch only looks at the function but
> not the callback data for its filtering.  Doesn't it mean that if a caller
> made two calls to add_fill_function() with walker#1 and then walker#2 as
> the callback data, you would discard the request for walker#2 and call the
> callback function fill_active_slot() with walker#1 inside run_active_slot
> repeatedly, without ever calling it for walker#2?

You're right, in addition to checking whether the callback is the
same, I should also have checked the callback data, before discarding
the invocation of add_fill_function as a duplicate.

> If it is the former, then your change is introducing a bug. If it is the
> latter, your change won't break anything immediately, but still introduces
> a potential bug waiting to happen, as the API looks as if you can call
> add_fill_function() to ask for callback functions to be called with
> different callback data and the caller can rely on both of them to be
> called at appropriate times, but in reality that guarantee does not hold.

That indeed is true, but afaik, none of the two instances of the API
usage does that -- calling callback functions with different callback
data to change behaviour. The fill functions are basically used to
"clear" the request queue.

Look at the fill function in http-walker.c. Yes, it's true that
callback data is passed on by the fill function, unlike the one in
http-push.c, which is passed NULL. But it doesn't really seem to use
the callback data. It loops through the request queue to find requests
that have yet to start (ie. their state is WAITING), and starts them
if they haven't start yet. The request object (struct file_request)
already contains a pointer to the callback data (walker), so it
doesn't really need it.

Nevertheless, I'll make add_fill_function additionally check the callback data.

-- 
Cheers,
Ray Chuan
