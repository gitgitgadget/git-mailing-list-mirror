From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Thu, 24 Jun 2010 12:39:56 -0500
Message-ID: <20100624173956.GA1600@burratino>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 19:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqPY-0002ml-V7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0FXRkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 13:40:18 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:45483 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab0FXRkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:40:17 -0400
Received: by wwi17 with SMTP id 17so438953wwi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Lc8IwD0STC0eLGEVtvgNT/dH9QE9AInwXv5pulSFjTU=;
        b=C30/AXqFmA+alS/QfURYTwTYpFAgq0irieOFjxXLYagi51BoCkf94t9resgxkWiaYP
         HK2bsGDoAqh7iX/4RGmqGBZr5110OVWCgmfCxf/gtb4O0hNoaYjAk0qv9LHBV9NmLItn
         GJFP7/MYlhWh8zcgR5XDfXjsyFQO0yjxA1Vmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PMdJNShCusIkmtH6C0gedvHT6vmPv5iSDavcwSKts0Kdw3V0eyaYl6ACGcnTn6FGn2
         um2WZlep5+lxGuDGLcalfq6jF5BxrmuFn/hevUqdPRs9oofUCt1nTgs/I0xNZxuFwg0u
         Zx+Q9RS3Vxoe5/Jm9tjLL7jKTDQKWgs2PPUzs=
Received: by 10.216.184.136 with SMTP id s8mr4122410wem.4.1277401215338;
        Thu, 24 Jun 2010 10:40:15 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g17sm1722610wee.29.2010.06.24.10.40.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 10:40:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149607>

Ramkumar Ramachandra wrote:

> David and I felt that the chatlog was
> valuable enough to go on the Git mailing list for later reference, so
> here it is.

Thanks. :)

> <artagnon> SRabbelier: Background -- I generated a delta dumpfile
> fine. barrbrain's exporter can't build full text from that, and I
> can't do it in my client either. We are looking for some kind of
> filesystem -- the Git store is the answer. Can we import revisions
> one by one through fast-import and ask Git to generate the full
> text?

Ah, this is something I was worried about with respect to persistence.
Git has all the blobs and all the trees, so except for the mapping
between marks, subversion revs, and git revs, svn-fe does not need to
persist much data at all.

Of course, that requires that the fast-import stream is going directly
to git.  fast-import streams can be used by other VCSes, too, but that
problem can be addressed later, I think.

> <barrbrain> so, if you have pipes to fast-import and cat-file
> --batch, can you read-write from the repo safely?
> <SRabbelier> barrbrain: yes, git is concurrency safe
> <barrbrain> what about the timing issue - if I write to fast import
> the blob might be delayed in a buffer somewhere
> <SRabbelier> barrbrain: I think what we'll need to do is to extend
> fast-import to also write the object names to stdout
> <SRabbelier> barrbrain: as soon as it's done writing the object

FWIW, I like the idea.

If you want to keep stdout unpolluted, this could work like

	git fast-import --print-marks=<fd>

We would have to make sure output to the fd is always flushed to
prevent deadlock.

> <barrbrain> I think I've lost track of which pipe goes where

Yeah.

> <SRabbelier> ask Shawn if he's ok with having git-fast-import learn a new '--print-marks' flag
> <SRabbelier> if so, I'll get on that :)

Thanks for the insights.

Regards,
Jonathan
