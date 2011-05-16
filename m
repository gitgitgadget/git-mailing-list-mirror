From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 3/9] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Mon, 16 May 2011 03:39:25 +0200
Message-ID: <201105160339.25737.johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-4-git-send-email-johan@herland.net>
 <BANLkTingc375Kzm-TBS4aQ_912pg7G03cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 16 03:39:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLmmT-0005NA-Ff
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 03:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab1EPBj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 21:39:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43376 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab1EPBj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 21:39:28 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900K7ZLXQXT70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 03:39:26 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BD3D11EEF911_DD0804EB	for <git@vger.kernel.org>; Mon,
 16 May 2011 01:39:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2A7641EEF737_DD0804EF	for <git@vger.kernel.org>; Mon,
 16 May 2011 01:39:26 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900DF0LXQ9Y10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 03:39:26 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTingc375Kzm-TBS4aQ_912pg7G03cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173699>

On Monday 16 May 2011, Shawn Pearce wrote:
> On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wrote:
> > Currently we refuse combining --max-pack-size with --stdout since
> > there's no way to make multiple packs when the pack is written to
> > stdout. However, we want to be able to limit the maximum size of the
> > pack created by --stdout (and abort pack-objects if we are unable to
> > meet that limit).
> > 
> > Therefore, when used together with --stdout, we reinterpret
> > --max-pack-size to indicate the maximum pack size which - if exceeded
> > - will cause pack-objects to abort with an error message.
> 
> ...
> 
> >                if (pack_to_stdout) {
> > +                       if (nr_written != nr_remaining)
> > +                               die("unable to make pack within the pack size"
> > +                                   " limit (%lu bytes)", pack_size_limit);
> 
> I think this is too late. We have already output a bunch of data, up
> to the size limit at this point. If the size limit is non-trivial
> (e.g. 5 MB) we have already sent most of that to the remote side, and
> its already written some of that out to disk.
> 
> I'd like this to be a soft limit derived from the reused object sizes.
> When planning the pack by looking at where we will reuse an object
> from, sum those sizes. If the sum of these sizes would break this
> limit, then we abort before even writing the pack header out.

I agree, but it's currently late Sunday (early Monday), and after
looking at this for a while, I'm no longer thinking straight.
If someone that groks the pack-objects internal could help out, I'd be
really grateful. AFAICS, we need to drill into prepare_pack() to find
the details needed to estimate the total pack size, but I don't know
exactly which data structure(s) holds the data needed. We probably need
to accumulate a pack size estimate in find_deltas(), and then sum those
across the threads, before we finally compare the total estimate to
pack_size_limit prior to calling write_pack_file().


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
