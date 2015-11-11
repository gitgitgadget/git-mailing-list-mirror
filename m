From: Thomas Berg <merlin66b@gmail.com>
Subject: Fwd: Question: .idx without .pack causes performance issues?
Date: Wed, 11 Nov 2015 15:58:09 +0100
Message-ID: <CABYiQpmYP=x-Urbwd0e_aa=iAMM4wP2bvdXwDN0=htEr5iOZAw@mail.gmail.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
	<CABYiQpn7r2Vcf=S5RaWHBN85eBYGPV_e02+BY=4L98qfUzDT1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Doug Kelly <dougk.ff7@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 15:58:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwWql-0003Ri-PA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 15:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbbKKO6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 09:58:11 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33557 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbKKO6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 09:58:10 -0500
Received: by obbww6 with SMTP id ww6so23623664obb.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B3NNSwwqRx1ArpovjMwqi8dCprsP0u4pbY5qx0haX6Y=;
        b=JCK0KM+/ba2lNlNSt3zwWKuMQxnx1CIpb7rBqe+rhMhI8eJPZrpHPtB5tS+O/f5sHO
         2vLTprAwPFq4sGaSC5E1HOlGkCD0TZZEo1g30EqaW+1eZ1P1/JZDPUigepGU4LYM1QWq
         4Jq6DHDOmWmRE15/xdnkZNQvA9a+Q8EfKruk0gFOWlxRRf474pkTPuSwr1oXex/iYEI+
         kkBMj+6VTF1MWEsBikQ37L6OiOKHmBdWquDDLD6yl3TEP17e0gfZDr6H5kpe4m7oVTDJ
         CjsDznxppN/O3bl91igtfq+mA5OWN5x/W8px6WK0PIhjJXgt6LLEI5jEo/5FHPm9RLOj
         9LiQ==
X-Received: by 10.60.17.200 with SMTP id q8mr5215713oed.76.1447253889597; Wed,
 11 Nov 2015 06:58:09 -0800 (PST)
Received: by 10.182.44.99 with HTTP; Wed, 11 Nov 2015 06:58:09 -0800 (PST)
In-Reply-To: <CABYiQpn7r2Vcf=S5RaWHBN85eBYGPV_e02+BY=4L98qfUzDT1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281168>

Hi all,

(re-sending because my first e-mail was rejected due to html formatting)

While debugging a git fetch performance problem on Windows I came
across this thread. The problem in our case was also caused by
orphaned .idx files.

On Tue, Jul 21, 2015 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I however do not think that we mark the in-core structure that
> > corresponds to an open ".idx" file in any way when such a failure
> > happens.  If we really cared enough, we could do so, saying "we know
> > there is .idx file, but do not bother looking at it again, as we
> > know the corresponding .pack is missing", and that would speed things
> > up a bit, essentially bringing us back to a sane situation without
> > any ".idx" without corresponding ".pack".
> >
> > I do not think it is worth the effort, though.  It would be more
> > fruitful to find out how you end up with ".idx exists but not
> > corresponding .pack" and if that is some systemic failure, see if
> > there is a way to prevent that from happening in the first place.
>
> While I still think that it is more important to prevent such a
> situation from occurring in the first place, ignoring .idx that lack
> corresponding .pack should be fairly simple, perhaps like this.

I have observed the following: if garbage collection is triggered
during a git fetch, I always get messages like this:

$ git fetch origin
> Auto packing the repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 396468, done.
> Delta compression using up to 12 threads.
> Compressing objects: 100% (98683/98683), done.
> Writing objects: 100% (396468/396468), done.
> Total 396468 (delta 289422), reused 395212 (delta 288289)
> Unlink of file '.git/objects/pack/pack-343b6cfdf58171f53c235b900a75d09bd9219e06.pack' failed. Should I try again? (y/n) n
> Unlink of file '.git/objects/pack/pack-343b6cfdf58171f53c235b900a75d09bd9219e06.idx' failed. Should I try again? (y/n) n
> Unlink of file '.git/objects/pack/pack-63a6cb5e2a9f72eea72b02ac74a167e1d71d417f.idx' failed. Should I try again? (y/n) n
> Unlink of file '.git/objects/pack/pack-9b616a2501bb9c13acecf3e981c39868dd2f5ff7.pack' failed. Should I try again? (y/n) n
> Unlink of file '.git/objects/pack/pack-9b616a2501bb9c13acecf3e981c39868dd2f5ff7.idx' failed. Should I try again? (y/n) n
> Checking connectivity: 396468, done.

Windows has the property that if a file is open it can't be deleted.
If so, it could be that git fetch needs to close the files first. I
can't remember observing this problem when running git gc by itself.

In the repos where we have problems I observed both unnecessary .pack
files and .idx files, but way more .idx files. Maybe, over time,
unnecessary pack files have been cleaned up but not .idx files?

If so, this would explain how we get into this situation. I have been
testing this with very old git versions on Windows (1.7.4 and 1.8.4),
sorry if these problems are already fixed in later versions.

- Thomas
