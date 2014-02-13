From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 01:06:46 +0100
Message-ID: <52FC0C96.6080909@gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com> <robbat2-20140212T015847-248245854Z@orbis-terrarum.net> <CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com> <52FB5443.8030200@gmail.com> <20140212230338.GA7208@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 01:06:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDjpO-0002ar-VF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 01:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbaBMAGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 19:06:49 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:53606 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbaBMAGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 19:06:47 -0500
Received: by mail-ee0-f52.google.com with SMTP id e53so4664575eek.11
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 16:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FlYoIQQHeavIUnsdZ+EJoTWha3zXjuG5WHdk+TQ3SzQ=;
        b=FtWnQ5g3Pfz+XEnZyDBfeec7KOoNxSkfNwwXIkbYih6AJ/HZBOtDWhOMfeDHIDhE1e
         K1YGhxDraCvdLrdpXpjDQcvJno0UIYgeJyipYcALdJ+e3pHknGOwQFV0CevUg43qGgqP
         QkysKlhtCMEiL1RMxVJL/8/k/Zrc4eUsbkwPLwMWg0fUKYM5f3EM3zJ5ud7LVxtn3TGg
         t2ZA6TgtcCV+Sx4vwa5oo+bmeGy12iHHVs9pbofTHhReg9HpCybXoVorUdLeqXqBbAfh
         b7n9eFfQuxoEOYNp3UGDGonTIAbhFpPt7I9QX5e8eHNMujT+vLldaWTkbjoVtNAry9KY
         9siQ==
X-Received: by 10.14.246.203 with SMTP id q51mr6234560eer.86.1392250005982;
        Wed, 12 Feb 2014 16:06:45 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id g1sm66037eet.6.2014.02.12.16.06.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 16:06:45 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140212230338.GA7208@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242036>

Am 13.02.2014 00:03, schrieb Mike Hommey:
> On Wed, Feb 12, 2014 at 12:00:19PM +0100, Karsten Blees wrote:
>> Am 12.02.2014 04:43, schrieb Duy Nguyen:
>>> On Wed, Feb 12, 2014 at 9:02 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
>>>> On Tue, Feb 11, 2014 at 05:54:51PM -0800,  Stefan Zager wrote:
>>>>> We in the chromium project have a keen interest in adding threading to
>>>>> git in the pursuit of performance for lengthy operations (checkout,
>>>>> status, blame, ...).  Our motivation comes from hitting some
>>>>> performance walls when working with repositories the size of chromium
>>>>> and blink:
>>>> +1 from Gentoo on performance improvements for large repos.
>>>>
>>>> The main repository in the ongoing Git migration project looks to be in
>>>> the 1.5GB range (and for those that want to propose splitting it up, we
>>>> have explored that option and found it lacking), with very deep history
>>>> (but no branches of note, and very few tags).
>>>
>>> From v1.9 shallow clone should work for all push/pull/clone... so
>>> history depth does not matter (on the client side). As for
>>> gentoo-x86's large worktree, using index v4 and avoid full-tree
>>> operations (e.g. "status .", not "status"..) should make all
>>> operations reasonably fast. I plan to make "status" fast even without
>>> path limiting with the help of inotify, but that's not going to be
>>> finished soon. Did I miss anything else?
>>>
>>
>> Regarding git-status on msysgit, enable core.preloadindex and core.fscache (as of 1.8.5.2).
>>
>> There's no inotify on Windows, and I gave up using ReadDirectoryChangesW to
>> keep fscache up to date, as it _may_ report DOS file names (e.g. C:\PROGRA~1
>> instead of C:\Program Files).
> 
> You can use GetLongPathNameW to get the latter from the former.
> 
> Mike
> 

Except if its a delete or rename notification...my final ReadDirectoryChangesW version cached the files by their long _and_ short names, but was so complex that it slowed most commands down rather than speeding them up :-)
