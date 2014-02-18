From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 16:45:25 +0700
Message-ID: <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFhFi-000425-VI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbaBRJqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 04:46:04 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:37269 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbaBRJp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:45:57 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so25134212qcq.18
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xeYUzccXDK6xqCIUE6CveNrfC1C7eYyYsjWUBIdF2Vc=;
        b=X6MhK0t2MkafKihlViioK6TV79ePr5/3ZHBPIcQYF2L0gnyOYSQcILnrAug5th9vo/
         07qqnmn8Q+Bk1VauoW/jMNG6nI2CChmK53HXmtO2Av6fpjPfbQEQXcmOnYyvukFpY0m1
         1+tPBcdTndIaGJNMHqxZJPwDoMzIi2m8oOuvNmdo8wn3F5XopvbHDJYwqVa4Y6dkr8of
         oMOsq7KMuCEukdpDgJPDPRG+nWV5v+syRK9/qGwbVZD02n8g5OqYfzFUVJGItFkJGwlg
         IRtHQpvUE4QbHnsetGtaTCAiX+UsjC/qIV88CAVnh4Fs5LuMbDVWF8/NOYJC/P/wd9bV
         1drA==
X-Received: by 10.224.19.199 with SMTP id c7mr8999331qab.78.1392716756834;
 Tue, 18 Feb 2014 01:45:56 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 18 Feb 2014 01:45:25 -0800 (PST)
In-Reply-To: <87r470ssuc.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242292>

On Tue, Feb 18, 2014 at 3:55 PM, David Kastrup <dak@gnu.org> wrote:
> Christian Jaeger <chrjae@gmail.com> writes:
>
>> I've got a repository where "git log --raw > _somefile" took a few
>> seconds in the past, but after an attempt at merging some commits that
>> were collected in a clone of the same repo that was created about a
>> year ago, I noticed that this command was now taking 3 minutes 7
>> seconds. "git gc", "git fsck", "git clone file:///the/repo/.git" also
>> now each took between ~4-10 minutes, also "git log --raw somefile" got
>> equally unusably slow. With the help of the people on the IRC, I
>> tracked it down to my recent use of "git gc --aggressive" in this
>> repo. Running "git repack -a -d -f" solved it, now it's again taking
>> 4-5 seconds. After running "git gc --aggressive" again for
>> confirmation, "git log --raw > _somefile" was again slowed down,
>> although now 'only' to 1 minute 34 seconds;
>
> [...]
>
>> I've now learned to avoid "git gc --aggressive". Perhaps there are
>> some other conclusions to be drawn, I don't know.
>
> I've seen the same with my ongoing work on git-blame with the current
> Emacs Git mirror.  Aggressive packing reduces the repository size to
> about a quarter, but it blows up the system time (mainly I/O)
> significantly, quite reducing the total benefits of my algorithmic
> improvements there.

Likely because --aggressive passes --depth=250 to pack-objects. Long
delta chains could reduce pack size and increase I/O as well as zlib
processing signficantly. Christian can try "git repack -adf" which is
really close to --aggressive (except it uses default --depth=50) and
see if it makes any difference.

> There is also some quite visible additional time spent in zlib, so a
> wild guess would be that zlib is not really suited to the massive amount
> of directory entries of a Git object store.  Since the system time still
> dominates, this guess would only make sense if Git over zlib kept
> rereading the directory section of whatever compressed file we are
> talking about.  But that's really a rather handwavy wild guess without
> anything better than a hunch to back it up.  I don't even know what kind
> of compression and/or packs are used: I've only ever messed myself with
> the delta coding of the normal "unpacked" operation (there are a few
> older commits from me on that).
>
> --
> David Kastrup
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
