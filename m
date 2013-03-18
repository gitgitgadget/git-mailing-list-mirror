From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] remote.c: introduce a way to have different remotes
 for fetch/ push
Date: Mon, 18 Mar 2013 20:26:46 +0530
Message-ID: <CALkWK0mc3HN4jT24QKP2Bt49fPtSd4=3wO0xFA7-4gt2n7ih-g@mail.gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
 <1363612575-7340-3-git-send-email-artagnon@gmail.com> <20130318143121.GB23075@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 15:57:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHbVU-00014M-Lg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 15:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab3CRO5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 10:57:07 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:39909 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3CRO5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 10:57:06 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so1615399iag.41
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=P5vTpoFBITmYWF7wM4+ON2W3y29AjeWqbF1I05i8pvM=;
        b=0hSPuXajOPsqz5X89hISmT9fp41hcnWW0286iUHcxgoc/93DwVd/dPGOvKX//jfX6v
         sx2J0RCf9etIOZpS856Us1p1pmG6/wXWKsFdtHt6nFeQsEaF0QGEahtXz5MVPMS+dPU0
         uI8KYiOj1uyRIfJK8WruF6A3q7AhwOY8s62KXbBNrbgI5QP739n9ACVFJI85anOlb1n2
         7Kvol38EcN9bxu9GtrgTqrkRDghDzJ5VZhdHTUV2v0jr+WyA6kAKQFdDSczz2p6IToE9
         HdpG9fsYAQ44tnYp6720C7VI74/B/BLUwzUdKWosUils8slEnv4DiiCmRcOgZSll5U+S
         8vRg==
X-Received: by 10.50.17.201 with SMTP id q9mr27083866igd.107.1363618626079;
 Mon, 18 Mar 2013 07:57:06 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 07:56:46 -0700 (PDT)
In-Reply-To: <20130318143121.GB23075@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218421>

Jeff King wrote:
> On Mon, Mar 18, 2013 at 06:46:13PM +0530, Ramkumar Ramachandra wrote:
>
>> +struct remote *remote_get(const char *name)
>> +{
>> +     int name_given = 0;
>> +
>> +     read_config();
>> +     if (name)
>> +             name_given = 1;
>> +     else {
>> +             name = default_remote_name;
>> +             name_given = explicit_default_remote_name;
>> +     }
>> +     return remote_get_1(name, name_given);
>> +}
>> +
>> +struct remote *pushremote_get(const char *name)
>> +{
>> +     int name_given = 0;
>> +
>> +     read_config();
>> +     if (name)
>> +             name_given = 1;
>> +     else {
>> +             if (pushremote_name) {
>> +                     name = pushremote_name;
>> +                     name_given = 1;
>> +             } else {
>> +                     name = default_remote_name;
>> +                     name_given = explicit_default_remote_name;
>> +             }
>> +     }
>> +     return remote_get_1(name, name_given);
>> +}
>
> Can we get rid of this duplication by having remote_get_1 take a
> service-specific default argument? And then each service calls it like:
>
>   struct remote *remote_get(const char *name)
>   {
>           read_config();
>           return remote_get_1(name, NULL);
>   }
>
>   struct remote *pushremote_get(const char *name)
>   {
>           read_config();
>           return remote_get_1(name, pushremote_name);
>   }

Thanks for the dose of sanity.  While at it, why not move
read_config() to remote_get_1() as well?
