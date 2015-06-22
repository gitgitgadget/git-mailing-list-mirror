From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: broken repo after power cut
Date: Mon, 22 Jun 2015 08:31:35 -0400
Message-ID: <20150622123135.GU29480@thunk.org>
References: <5585C1B6.50407@nod.at>
 <330ab8f498e1b435d5b210384200b649@www.dscho.org>
 <5586B71D.2070407@nod.at>
 <20150622003551.GP29480@thunk.org>
 <5587EF5F.90207@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, David Gstir <david@sigma-star.at>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
X-From: linux-fsdevel-owner@vger.kernel.org Mon Jun 22 14:31:46 2015
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Envelope-to: lnx-linux-fsdevel@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-fsdevel-owner@vger.kernel.org>)
	id 1Z70t5-0003bO-Tn
	for lnx-linux-fsdevel@plane.gmane.org; Mon, 22 Jun 2015 14:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbbFVMbl (ORCPT <rfc822;lnx-linux-fsdevel@m.gmane.org>);
	Mon, 22 Jun 2015 08:31:41 -0400
Received: from imap.thunk.org ([74.207.234.97]:48234 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853AbbFVMbk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
	Mon, 22 Jun 2015 08:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=p1C2yZM8GJ5ALlXfCqvg4upgPa2Z9J0U3YKguV/6gXM=;
	b=T/jZ5wwRKlStVGxn9n2F/2d1VCJYaJhRgaAAV1gw1QmWgMGeUhnzC/V7+W4BGKbxtdUAnH+h0+gJJgyLDNUXkLyJZXTsvN6ByI2UGywLhhw580ECj0OOFUsh3xOFTj84o3P/ywRhMpAk8WNkz7oRY/405El05Qb0aPxbBJFHcVg=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1Z70sx-0008Pd-86; Mon, 22 Jun 2015 12:31:35 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 72CDA5803FF; Mon, 22 Jun 2015 08:31:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5587EF5F.90207@nod.at>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272335>

On Mon, Jun 22, 2015 at 01:19:59PM +0200, Richard Weinberger wrote:
> 
> > The bottome lins is that if you care about files being written, you
> > need to use fsync().  Should git use fsync() by default?  Well, if you
> > are willing to accept that if your system crashes within a second or
> > so of your last git operation, you might need to run "git fsck" and
> > potentially recover from a busted repo, maybe speed is more important
> > for you (and git is known for its speed/performance, after all. :-)

I made a typo in the above.  s/second/minute/.  (Linux's writeback
timer is 30 seconds, but if the disk is busy it might take a bit
longer to get all of the data blocks written out to disk and
committed.)

> I think core.fsyncObjectFiles documentation really needs an update.
> What about this one?
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 43bb53c..b08fa11 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -693,10 +693,16 @@ core.whitespace::
>  core.fsyncObjectFiles::
>  	This boolean will enable 'fsync()' when writing object files.
>  +
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not use
> -journalling (traditional UNIX filesystems) or that only journal metadata
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
> +For performance reasons git does not call 'fsync()' after writing object
> +files. This means that after a power cut your git repository can get
> +corrupted as not all data hit the storage media. Especially on modern
> +filesystems like ext4, xfs or btrfs this can happen very easily.
> +If you have to face power cuts and care about your data it is strongly
> +recommended to enable this setting.
> +Please note that git's behavior used to be safe on ext3 with data=ordered,
> +for any other filesystems or mount settings this is not the case as
> +POSIX clearly states that you have to call 'fsync()' to make sure that
> +all data is written.


My main complaint about this is that it's a bit Linux-centric.  For
example, the fact that fsync(2) is needed to push data out of the
cache is also true for MacOS (and indeed all other Unix systems going
back three decades) as well as Windows.  In fact, it's not a matter of
"POSIX says", but "POSIX documented", but since standards are held in
high esteem, it's sometimes a bit more convenient to use them as an
appeal to authority.  :-)

(Ext3's data=ordered behaviour is an outlier, and in fact, the reason
why it mostly safe to skip fsync(2) calls when using ext3 data=ordered
was an accidental side effect of another problem which was trying to
solve based on the relatively primitive way it handled block
allocation.)

Cheers,

						- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
