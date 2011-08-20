From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] fast-import: do not write bad delta for replaced
 subtrees
Date: Sat, 20 Aug 2011 12:48:12 -0500
Message-ID: <20110820174812.GD15864@elie.gateway.2wire.net>
References: <20110820154356.GB15864@elie.gateway.2wire.net>
 <1313860946-1596-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 19:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qupef-0002Hp-PS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 19:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab1HTRsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 13:48:17 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62674 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1HTRsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 13:48:16 -0400
Received: by iye16 with SMTP id 16so7560801iye.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UcECCh3iOG7i9uxVd6hatcCJqNRHcYz2DAVUqDQgdWI=;
        b=cp0XkxH7NWZLD2VUEimSQFhMzKLW4CAATQjBP4TIJDNEyJlf6ZeB9OG6xgRRAmhfX7
         QJLCfCqtDTgGZX9TRGaC8fmBdGzBWAA5TEJfWgWTiM74H2sdBCPcMYQsk1MYJN5HtHVv
         omuvFk2DmOf67wJA/giJMnsNLcKSTzEt/rO2c=
Received: by 10.43.53.68 with SMTP id vp4mr669797icb.438.1313862496104;
        Sat, 20 Aug 2011 10:48:16 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-48-207.dsl.chcgil.sbcglobal.net [69.209.48.207])
        by mx.google.com with ESMTPS id x18sm2288195ibe.57.2011.08.20.10.48.15
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 10:48:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313860946-1596-1-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179766>

Dmitry Ivankov wrote:

> How about adding a new bit field "no_delta" instead?

Currently the layout of "struct tree_entry_ms" is:

	uint16_t mode;			two bytes
	unsigned char sha1[20]		20 bytes

which adds up to 22 bytes.  Here is "struct tree_entry":

	struct tree_entry *tree;		one machine word
	struct atom_str *name;			one machine word
	struct tree_entry_ms versions[2];	44 bytes

Although it only looks like it adds one byte per tree entry, in
practice I suspect your patch adds four.  Is that worth it?  (The
answer might be yes.  I'm not sure.)

> The patch is
> smaller this way. Also could 04000 theoretically be S_IFDIR on some
> platform?

No, these modes are part of the format of objects as written on disk
and over the wire, so when we meet a platform with S_IFDIR != 040000,
there will have to be bigger changes (to distinguish between the
platform's idea of file status and git's idea of modes).

> - switch to a separate no_delta bit in tree_entry

If it doesn't cost too much, this is a good idea.

> - when setting no_delta = 1 don't check for S_ISDIR(versions[0].mode),
>   this is a redundant check and logic duplication. Who knows, maybe some
>   day we'll want to delta a tree against blob. :)

Why?  When versions[0] is not a tree, the hack is not needed, since
versions[0].mode and versions[0].sha1 accurately describe the delta
base and are not inconsistent with anything.

Thanks, that was helpful.
