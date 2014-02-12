From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Introduce experimental remote object access mode
Date: Wed, 12 Feb 2014 12:55:20 -0800
Message-ID: <CAJo=hJvx7vRcNk0ZtAtM99gfc-b1k9xjk_cOHco=-GgRMy55qg@mail.gmail.com>
References: <CAJo=hJsO=FBkiOo5fuPbToxE1SR3Lh8oim0eTAR6bH1a-TcdPA@mail.gmail.com>
 <xmqqppmtphx0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 21:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDgqQ-0008L8-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 21:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbaBLUzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 15:55:42 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:56227 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbaBLUzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 15:55:41 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so6420540wes.23
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6BqtL6Yq8ypswrKkaouo7o/4LuSeV2uUnUUxC8JPiyY=;
        b=I5wej8jk4KMw3pjQuA2Jh1ktqmXhLfu/mjwO53xIHhPVlpQ+wDE2rX5DQat4zAkV0N
         h8DnXi7fnkAlE2SHQuZ/MCc8wM7HFVlMVUx98Q++uQp65V21b+b4q5ytrMjuLXqwGfGV
         wKnG0zVD/Th6eU8bKGU+dIHuNkCO0ovSSU95E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6BqtL6Yq8ypswrKkaouo7o/4LuSeV2uUnUUxC8JPiyY=;
        b=F3G88HpDYB19MxntBtok4njpZfxOLsG+kci3s45IRCoEmgoIkyLCzpR53OcSxwr0rQ
         DoGQiERyEGYQ10Vs4yT7O4GC4crn0HbEru+6MEH8FQJRvn3wsgfDwjsuiAbsiaa+QFOG
         yxOIkXzStKAuaKuKlsXg7tbLl36AGygdSEFBnzQB+ZatEayTZSk/Nha+1+fg4qaLwTrK
         6iINZHbqHStQL5I8Tyr1BSUcAt8NMNTSqbJ/Akm+kzxR//45aCgMbKDtE6dYQ4ql9bdI
         WHuDP/L01Avx+AxNOt2jR+bPVnY+5KkfuJFf/Y3ObJNn/e6et8BAsA+yP1+HHRS6vd99
         etVg==
X-Gm-Message-State: ALoCoQmoZ4JpCncsevICqT5WUx4hYEFTvnst0WZfwJfAGfnFjLgwV0fk3zJuWk6YJEz2du6IfytM
X-Received: by 10.180.73.141 with SMTP id l13mr3652656wiv.60.1392238540269;
 Wed, 12 Feb 2014 12:55:40 -0800 (PST)
Received: by 10.227.7.132 with HTTP; Wed, 12 Feb 2014 12:55:20 -0800 (PST)
In-Reply-To: <xmqqppmtphx0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242023>

On Tue, Feb 11, 2014 at 11:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Why would you do this? Perhaps you need more time in your day
>> to consume tea or coffee. Set GIT_RTT and enjoy a beverage.
>
> So the conclusion is that it is not practical to do a lazy fetch if
> it is done extremely naively at "we want this object --- wait a bit
> and we'll give you" level?

Yes, this is what I thought when someone proposed this hack in
sha1_file.c to me on Monday. So I ran a quick experiment to see if my
instinct was right.

> I am wondering if we can do a bit better, like "we want this object
> --- wait a bit, ah that's a commit, so it is likely that you may
> want the trees and blobs associated with it, too, if not right now
> but in a near future, let me push a pack that holds them to you"?

Ah, smart observation. That might work. However I doubt it.

I implemented a version of Git on top of Google Bigtable (and Apache
HBase and Apache Cassandra) multiple times using JGit. tl;dr: this
approach doesn't work in practice.


The naive implementation for these distributed NoSQL systems is to
store each object in its own row keyed by SHA-1, and lookup the object
when you want it. This is very slow and is more or less what this
stupid patch shows. Worse, none of them were able to even get close to
the 1ms latency I used in this example.

In another implementation (which I published into JGit as the "DHT"
backend) I stored a group of related commits together in a row. Row
target sizes were in the 1-2 MiB range when using pack style
compression for commits, so the average row held hundreds of commits.
Reading one commit would actually slurp back a number of related
commits. The idea was if we need commit A now we will need B, C, D, E
(its parents and ancestors) soon as the application walks the revision
history, like rev-list or pack-objects.

For a process like pack-objects this almost seems to work. If commits
are together we can slurp a group at a time to amortize the round trip
latency. Unfortunately the application can still go through hundreds
of commits faster than the real world RTT is. So I tried to fix this
by storing an extra metadata pointer in each row to identify the next
row, so next block of commits could start loading right away. Its
still slow, as the application can scan through data faster than the
RTT.

At least for pack generation the traversal code does commits and
builds up a list of all root trees. The root trees can be async loaded
in batches, but the depth first traversal is still a killer. There are
stalls while the application waits for the next subtree, even if you
cluster the trees also into groups using depth first traversal the way
the packer produces pack files today.


Junio's idea to cluster data by commit and its related trees and blobs
is just a different data organization. It may be necessary to make two
copies of the data, one clustered by commits and another by
commit+tree+blob to satisfy different access patterns. And in the
commit+tree+blob case you may need multiple redundant copies of blobs
near commits that use them if those commits are frequently accessed.
Its a lot of redundant disk space.

We always say disk is cheap, but disk is slow and not getting faster.
SSDs are helping, but SSDs are expensive and have size limitations
compared to spinning disk. Just making many copies of data isn't
necessarily a solution.
