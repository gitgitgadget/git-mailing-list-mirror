From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 13/22] documentation: add documentation of the index-v5 file format
Date: Thu, 11 Jul 2013 14:26:15 +0200
Message-ID: <87k3kxcmfs.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-14-git-send-email-t.gummerer@gmail.com> <CACsJy8ALSBPq1+TP_YxJ=ecUwpKRY-i2O=+q8qMjtXbjShg3mA@mail.gmail.com> <87mwptcom9.fsf@gmail.com> <CACsJy8BT56_DvQ5Y2newJWn4EZjHZnTquypXpO2qDtN1Qh0zRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 14:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFx1-0003pk-RY
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 14:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3GKM0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 08:26:20 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:33682 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab3GKM0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 08:26:19 -0400
Received: by mail-ea0-f173.google.com with SMTP id g15so5659864eak.4
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=LKZQuiDad+6V16hIu6X5ZYVUR2AboRQWt419/7P+hwU=;
        b=Ro08vziiTLC1lKCvxvko/6xatN804v+3YzqlLFXqguf2TKzPLQEwy4LoH3b9n+zJZ5
         R+CEh/ZFjvQ2ANR/EbgBY275UISRcUXdaH3VvhoJvMeC5eLs2b0RTroai28lcdrnlVcC
         8H/OrGra33aspqOZ337ncobP2sgIuxSItO4NwY11vz/0X/ZN1T5iVgNuTezfnjKdzfPh
         pRbD8DjPrgF9XSWnOfF10rhv/nbjgNKuQOKyLt0GNyt0zOI00vRBcboQBDQrWGFK8ukt
         E8QGMyFqphOYDHD/fWhpJgbmQbys4JD/cHLxJ9snAMwUtICRhqzl2jyKq7HFgVxhc0sL
         5Tpg==
X-Received: by 10.14.194.133 with SMTP id m5mr41439972een.109.1373545578271;
        Thu, 11 Jul 2013 05:26:18 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id o5sm68698154eef.5.2013.07.11.05.26.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 05:26:17 -0700 (PDT)
In-Reply-To: <CACsJy8BT56_DvQ5Y2newJWn4EZjHZnTquypXpO2qDtN1Qh0zRg@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230097>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jul 11, 2013 at 6:39 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> Question about the possibility of updating index file directly. If git
>>> updates a few fields of an entry (but not entrycrc yet) and crashes,
>>> the entry would become corrupt because its entrycrc does not match the
>>> content. What do we do? Do we need to save a copy of the entry
>>> somewhere in the index file (maybe in the conflict data section), so
>>> that the reader can recover the index? Losing the index because of
>>> bugs is big deal in my opinion. pre-v5 never faces this because we
>>> keep the original copy til the end.
>>>
>>> Maybe entrycrc should not cover stat fields and statcrc. It would make
>>> refreshing safer. If the above happens during refresh, only statcrc is
>>> corrupt and we can just refresh the entry. entrycrc still says the
>>> other fields are good (and they are).
>>
>> The original idea was to change the lock-file for partial writing to
>> make it work for this case.  The exact structure of the file still has
>> to be defined, but generally it would be done in the following steps:
>>
>>   1. Write the changed entry to the lock-file
>>   2. Change the entry in the index
>>   3. If we succeed delete the lock-file (commit the transaction)
>>
>> If git crashes, and leaves the index corrupted, we can recover the
>> information from the lock-file and write the new information to the
>> index file and then delete the lock-file.
>
> Ah makes sense. Still concerned about refreshing though. Updated files
> are usually few while refreshed files could be a lot more, increasing
> the cost at #1.

Any idea how common refreshing a big part of the cache is?  If it's not
to common, I'd prefer to leave the stat data and stat crc in the
entrycrc, as we can inform the user if something is wrong with the
index, be it from git failing, or from disk corruption.

On the other hand if refresh_cache is relatively common and usually
changes a big part of the index we should leave them out, as git can
still run correctly with incorrect stat data, but takes a little longer,
because it may have to check the file contents.  That will be trade-off
to make here.
