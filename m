From: Shawn Pearce <spearce@spearce.org>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Mon, 3 Oct 2011 09:05:06 -0700
Message-ID: <CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 18:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAl3I-00075R-M3
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 18:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab1JCQHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 12:07:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41678 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab1JCQHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 12:07:31 -0400
Received: by qadb15 with SMTP id b15so1648341qad.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 09:07:30 -0700 (PDT)
Received: by 10.42.133.130 with SMTP id h2mr144669ict.101.1317657926083; Mon,
 03 Oct 2011 09:05:26 -0700 (PDT)
Received: by 10.42.3.69 with HTTP; Mon, 3 Oct 2011 09:05:06 -0700 (PDT)
In-Reply-To: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182668>

On Mon, Oct 3, 2011 at 07:43, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> I'm having poor git gc (pack-object) performance. Please read below
> for details. What can I do to improve the performance/debug the reason
> for the slowness? Should I leave the process running over night, or
> should I stop it (for debugging)?
> CCing people who posted some patches/benchmarks for pack-objects recently.
>
> git gc was first run automatically by git svn clone. It found 1544673
> objects and worked for 50 minutes until I've killed it.
>
> Then I've run it by hand with --aggresive (because I've found on
> Internet it helped in some cases). It found 1742200 objects this time.
> At this moment it's been working for about 90 minutes.

Packing time depends on a number of factors. One of them is the number
of unpacked objects to process. With 1.7 million objects, yes, its
going to take some time. Another factor is how much RAM you have on
your system. Packing requires a lot of memory, especially with the
--aggressive flag, as the packer tries up to 250 different
combinations of two objects searching for a good delta compression
format, and all 250 of those are typically in-memory at once. If you
have insufficient physical RAM, the system will swap, unless you
decrease the window size.

> The large number of unpacked objects is probably caused by me - I've
> disabled auto gc when I was cloning from svn (I though it might speed
> up things if it didn't repack several times during clone, only once
> afterwards).

Yes, this the reason `git svn` runs GC during its import. If you defer
all of the repacking work until the end, with everything loose, it can
take a very, very long time to repack. If you repack as you go, the
incremental repacks are less expensive than a full repack, and the
entire process will go faster overall.

-- 
Shawn.
