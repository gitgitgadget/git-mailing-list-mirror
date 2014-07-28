From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/5] refs.c: return error instead of dying when locking
 fails during transaction
Date: Mon, 28 Jul 2014 12:01:34 -0700
Message-ID: <CAL=YDWmCGMKgmc6NOhHuf-1QXFvnF25yT-WgxJBntu+DGAbBmg@mail.gmail.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
	<1406307521-10339-3-git-send-email-sahlberg@google.com>
	<20140725194023.GH12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBqB1-00080n-DC
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 21:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbaG1TBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 15:01:35 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:55348 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbaG1TBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 15:01:35 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so11880124vcb.7
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=71RSzZ6DXvVu0aCXSklnPaDRL6haQeT3/YIng922xSg=;
        b=AEbXMIS7NDLk4hrAJgFaAV7Ir2qkGOlyRBXkm5eTpzQhvaPUcy0aYYw0cuEj7+ZlxG
         E1so5S65wjIVzYIlIwI3AZ1MrUHjjf+ZC82MijZFcPfKtWxWkrxe9D9d/IWHUD3wtDS7
         RjeGouRtda8stVTss8GVMOdb/f+7H5rGM4N/148cuE5+wWRoytCaFAucYUbXCpHT1TSr
         39NJ0sDHxc5eKmW2y4tQ6V/qDrF5NgpBYYC7UGN+xUjlCCY8gD9gXoLOHRUCJ2A1zfoU
         qbWIlKdceTycRMtQc8LWgZgpAUzUuLiowlWpJC9yeyYW2KyXXV4i9RfvmBxhUKNpgzEl
         hd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=71RSzZ6DXvVu0aCXSklnPaDRL6haQeT3/YIng922xSg=;
        b=EdaJGgNqPm/cIfo7HlGPZrGKdr4PGhkcBZ5rURUdTrCqDoJxQNtKoEz3NBLZbKDLFc
         z0S/ZKlpYGSuKadMbPRAE1yvLl6zIx+9+Uqm+o/Wqo494YvKm6Ol+NCoqjBdDkVWg8yG
         bxrozvPYQtBU9vPGQAcK4bzp2oynqsXaIEgU7J2/hMvJFpfHXA1S1uo+WcC9+/mD9lZy
         wZTj7wGWNzca+KhhTjAVxbcufKpda61qdN3XXlB/KwIUvICutzil8hHgIuWFZrhXSf0y
         EYcBTerdk7J5hyH7RPSBXU7r7tq3Rbw9bajtqW+ijID7RsVRmkiQoc10HcPgFNls1SRQ
         P1rA==
X-Gm-Message-State: ALoCoQknOHR4IYhESsWp4GeUjopde0Ce97p0XivG27RIEZN1thzgccp6ZNmnbsXe1bDlVkF6hGbU
X-Received: by 10.221.69.8 with SMTP id ya8mr2943367vcb.39.1406574094230; Mon,
 28 Jul 2014 12:01:34 -0700 (PDT)
Received: by 10.52.180.6 with HTTP; Mon, 28 Jul 2014 12:01:34 -0700 (PDT)
In-Reply-To: <20140725194023.GH12427@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254347>

On Fri, Jul 25, 2014 at 12:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2214,7 +2214,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>                        */
>>                       goto retry;
>>               else
>> -                     unable_to_lock_index_die(ref_file, errno);
>> +                     goto error_return;
>
> Should probably save last_errno so error_return can pass that
> information back.

Done. Thanks.

>
> Can the caller recover from this error?  Does it have enough information
> to produce the same helpful message as unable_to_lock_index_die?
>
> If this could be done without regressing behavior (e.g., by passing
> back error information as a message instead of through errno) then I
> think it would make sense.

The callers should all be able to cope with this returning error (and
now logging error() since this function is only called from within
transaction_commit() and it knows how to deal with these errors.


>
> Jonathan
