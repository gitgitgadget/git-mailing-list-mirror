From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Fri, 5 Dec 2014 11:41:05 -0800
Message-ID: <CAGZ79kbf_Ze6JR33Y6-N3JZTUQqTyqc-feQZ-__h7JkeUTzUvg@mail.gmail.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
	<1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
	<20141205002331.GJ16345@google.com>
	<20141205191829.GB16682@google.com>
	<xmqqoarhq4dc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:41:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwyl3-0005Tk-F3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbaLETlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:41:09 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33864 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbaLETlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:41:07 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so1360342ier.34
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V3XM8TDmoSeo0uDHT7HSRNIOLKW3h6xLPtstsT2Agkc=;
        b=OOlro2KI0CUxWspKGEJFIx3y6q4XfEdDdCzgGNBXLYdfWYxM1/mhSlOr892JyHT3fw
         94/GGyi/+ZTwLJmZI4cIszNsYaNpW6jQjSHuCWNwOwHzJyRmn6X7ausymG/9L5IkgmJ9
         oce58zX2yimdEREaM1tIlFhbZJTxUZ68mnqBsEyedt6VOe8e9xgeXRDAV08Eb0dBuNWW
         PZ/Px6SJGOFDzcbmE/ew6b+VI4KMKmn5L/O+hZr0kLXYK0lXsfZKkl5wWlYC6MOqhhKv
         kQMTfC5G2qnVUBmXpL5r5ZP7PDqYRfyswnO6c3xWNA2mq39nOJwRhhQVp2RklawkzFFj
         We0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=V3XM8TDmoSeo0uDHT7HSRNIOLKW3h6xLPtstsT2Agkc=;
        b=cvpbGHlhUIs8K1jct/P98Znr7I2kl3QKRESx/XOlrI6RBoCTWkimoPajv81RI0Yw0w
         jc8ncCTUZF02Pudgw3ljPiyY2+hmxIcBXvg95h4+yDflzOIDj7cpHxFqIe0Kp8OJy5gg
         3ag8sCtjOyrxpE8ljfVxEQNhZktpjWucQxUbQxjc4Lwl2iVFeCLl/M8bEFVhgyZx9ac9
         6SEgalH/SH2gjizrbbK+HEqriskBHSZk2+JO2DoKeSz19hJduQVBkKB0X8nYd8H9xFTr
         Ans7udt2s13zErBB7SqRoMqdBrImnCpd3QnIXEC0jP7ie+uB6hBVth+15H8lUZVBiSAy
         sZWQ==
X-Gm-Message-State: ALoCoQmR7iOTFJDkOisLUbabhbTng3GxZK8IOZ7B0UJCzgHrx7gyZpDEhysx0meFBTgMGpId3Mlw
X-Received: by 10.42.172.194 with SMTP id o2mr16846684icz.95.1417808466027;
 Fri, 05 Dec 2014 11:41:06 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Fri, 5 Dec 2014 11:41:05 -0800 (PST)
In-Reply-To: <xmqqoarhq4dc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260886>

On Fri, Dec 5, 2014 at 11:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> > +static struct lock_file reflog_lock;
>>>
>>> If this lockfile is only used in that one function, it can be declared
>>> inside the function.
>>>
>>> If it is meant to be used throughout the 'git reflog' command, then it
>>> can go near the top of the file.
>>>
>>
>> After the series completes, this lock is only used in reflog_expire.
>> So I'd rather move it inside the function? Then we could run the reflog_expire
>> function in parallel for different locks in theory?
>
> I am not sure about the "parallel" part, but I would imagine that it
> is an essential prerequisite to move this outside the "client" code
> if we want to later replace the backing storage of refs and reflogs
> outside the filesystem, so from that point of view,  I think the
> suggestion makes sense.
>
> Thanks.
>

Sorry for the confusion. With parallel I mean, that in theory we could have
multiple threads running reflog expire at the same time in the same program.
Having the "static struct lock_file reflog_lock;" around, we can only
process one
reflog at a time, as that is holding the lock_file struct.

I am not saying we want to go multi-threading any time soon if at all.
Just that it would
be easier to do, if not having the lock file as a file-global variable
instead of a
variable inside a function.

Thanks,
Stefan
