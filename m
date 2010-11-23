From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] fast-import: insert new object entries at start of
 hash bucket
Date: Tue, 23 Nov 2010 17:17:18 -0600
Message-ID: <20101123231718.GA4317@burratino>
References: <20101123075348.GA10367@burratino>
 <AANLkTikqUjjjMRzWTcEOs+2PGu=-9VVbdn0YgpabFaDu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 24 00:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL27C-0003sO-It
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 00:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab0KWXR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 18:17:29 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33115 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0KWXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 18:17:28 -0500
Received: by qyk11 with SMTP id 11so2911310qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mdUyh0vbe6u7AFqcB+nIehciQZoscqOgsO1/MRUttCs=;
        b=bHeACBJ/Qrln1LRB1+Y21Dz/7YWCdBSfr4OBSnA8RctwryZrjUPM3kKIQxBJUwEXQt
         YSQO7A/Ia26F7JgnJFoPsb6ZN+nJcMI2aY2BTvqTQCfGIpDqkGQO6yxnRiHAPfeoDlRQ
         QW4fw26OpcNm6kStekZB6wFsAsjISvxJ3Sy6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hm61eLW5I9EpCuDu4IN9L7LDUfPbrCROncXAMSK4dB3RwyM3EvhFlVzI06HkXKYq0b
         aHJ6xAwZNRODYH0KrXs9uLGe+f5UfEo/8LAYv4WrUEuH4ZD9Ys7QTyhdwTlK/Urs15zS
         InzzGI+bshKe4J1at0x1tsmjQ5l35s3QdQsHI=
Received: by 10.224.2.141 with SMTP id 13mr5985934qaj.282.1290554248117;
        Tue, 23 Nov 2010 15:17:28 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm3970589qcp.32.2010.11.23.15.17.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 15:17:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikqUjjjMRzWTcEOs+2PGu=-9VVbdn0YgpabFaDu@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162032>

Shawn Pearce wrote:
> On Mon, Nov 22, 2010 at 11:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Other aspects to investigate: choice of hash function;
>
> Why?  SHA-1 is pretty uniform in its distribution.

I got distracted for a moment by the atom table, but since that does
not have a big effect on performance it's probably not worth spending
time on.  Sorry about that; please ignore.

[...]
>                                                           The way I
> read this store_tree() code, every subdirectory is recursed into even
> if no modifications were made inside of that subdirectory during the
> current commit.

Doesn't the is_null_sha1 check avoid that?

To further explain the workload: svn-fe receives its blobs from svn
in the form of deltas.  So the conversation might go like this:

	S	commit refs/heads/master
	S	mark :10000
	S	committer felicity <felicity@local>
	S	data 74
	S	bug 3097: switch spamd from doing 'fork per message' to a 'prefork' model
	S	cat incubator/spamassassin/trunk/spamd/spamd.raw
	F	89d56462577b8b7b4f4115f2a47f0b3da22b791a blob 63633
	F	#!/usr/bin/perl -w -T
	...
	S	M 100644 inline incubator/spamassassin/trunk/spamd/spamd.raw
	S	data 62114
	...

Current svn-fe in vcs-svn-pu requests the preimage blobs using marks,
but the idea is the same.

If this proves a bottleneck I suppose we could cache the content of
frequently-requested old blobs and keep pointers to that in the
in-core tree.
