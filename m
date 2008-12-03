From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Wed, 3 Dec 2008 09:35:48 +0100
Message-ID: <4ac8254d0812030035n52fde4b3s29c0f525e175f123@mail.gmail.com>
References: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vej0pheww.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0812030007w3217f6eei3d364ce2272930c3@mail.gmail.com>
	 <7vr64pfyvg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 09:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7nEH-0007Uk-Oh
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 09:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbYLCIfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 03:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYLCIfv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 03:35:51 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:49039 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYLCIfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 03:35:50 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1395624ywe.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 00:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=b62VPLoiF+oxhuXHn1ofX3q+RHzSyxNhwxXIMQh/iQs=;
        b=vV6eSJFP67OeYQGeO+kA/Q8Dn7gYl8GqPY6AibVZQo+u6qc142JDDBG4ezQnfIB9j1
         3S3ewoImmefVYEu8k4Sl0MQloxVDg4TcX5YXa5WSOGA3uKzc19ASrZj+vqT7J/b+0FHZ
         IdekuurLD85f11aSEYzVgJqHiAbsae5OFqmlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IM/ukbZtPjNtj0cP4Km+cb60s9MqGT0zWlm7fwOOHliuwgUNppHYrL+ttR50BXBUCT
         4qqrPv3NViUgrwiicQCjDk8Tv56KInKt0JZWUkCQXcoh5Ga8giKlEjqmtcLOkwYdAxae
         5lr5F/qTUd9obpO0KqEouR18/LtmHHjUoCx2I=
Received: by 10.65.150.2 with SMTP id c2mr13146606qbo.32.1228293348601;
        Wed, 03 Dec 2008 00:35:48 -0800 (PST)
Received: by 10.65.242.16 with HTTP; Wed, 3 Dec 2008 00:35:48 -0800 (PST)
In-Reply-To: <7vr64pfyvg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102229>

On Wed, Dec 3, 2008 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> I mainly use -q in automation where I only want output if something
>> goes wrong. Just like good old cp or mv do.
>> Do you think this is the wrong way to go?
>>
>>> How are you dealing with messages from the actual replaying of each local
>>> commit on top of what is fetched?  In order to be able to tell where you
>>> are when one of them fail in conflicts, you cannot stay silent while doing
>>> so.
>>
>> Fair point.
>
> Ahh, ok, if this is for cron jobs, then it is understandable that:
>
>  (1) You may want a successful "git pull" or "git pull --rebase" to be
>     absolutely silent about what it did; and
>
>  (2) A failed "git pull" and "git pull --rebase" that produces information
>     other than the fact it failed would not help you, the receiver of a
>     cron job report, very much.  You would go to the repository when it
>     fails, reset the mess away, and then do the pull or pull-rebase
>     yourself manually anyway.
>
> If that is the motivation behind the series, I think you would really want
> to squelch output from "format-patch | am -3" pipeline.

You mean I should follow this path and produce a patch series instead?

> Another thing to consider is that, unlike simple single-operation commands
> such as "mv" or "cp" you mentioned, what "git pull" does is much more
> involved and has many different failure modes, so you cannot compare them
> fairly.  Simple commands can have a single "quiet" level, but I have a
> feeling that there is a difference between "quiet mode" I expect when I am
> running "git pull" interactively and "quiet mode" I would want when I

We have the same expectation here and IDE writers also seem to expect that.

> would be driving "git pull" from a cron job.  IOW, you probably would want
> something like "--really-quiet" mode.

Yeah, it gets messy and in the current codebase. I am also not sure whether
the effort/benefit ratio is good enough.

> I would write such a cron-job script to capture the log and send it only
> upon failure from the underlying command if I were doing this myself,
> though.

This is the way I do it now and I'm surprised I found no other simple way
than writing a wrapper script for it. At least not with vixie-cron.
