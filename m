From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH/RFC] sideband: remove line padding (was: Re: [PATCH]
 progress: use \r as EOL only if isatty(stderr) is true)
Date: Thu, 30 Jun 2011 23:13:29 +0200
Message-ID: <20110630211329.GC63317@sherwood.local>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
 <20110629174220.GA36658@sherwood.local>
 <alpine.LFD.2.00.1106291414140.2142@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jun 30 23:13:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcOYR-0001Z5-1u
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 23:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab1F3VNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 17:13:39 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43611 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1F3VNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 17:13:38 -0400
Received: by fxd18 with SMTP id 18so2628666fxd.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FY7XWCuCwdFAy3SS7ggKKuatDnA+g1wadBJsmMIwUDE=;
        b=BJgFY7OrxcX90Pq+Lszluse/DbuD1dsDc22a5rOGqvGTMucjxRJEl3jmjr7VzbBoEt
         NQEOFbdNmnGgyH7SDjbVezndFFDMWgKW8kZrlveBXofzYufJ6vfnlCL+BN9sfVzUzmxz
         yI0dNnRAJehEMvmHlz1TwaUzh6ixDWB7MT6nM=
Received: by 10.223.143.17 with SMTP id s17mr3634383fau.34.1309468417438;
        Thu, 30 Jun 2011 14:13:37 -0700 (PDT)
Received: from sherwood.local ([82.113.99.168])
        by mx.google.com with ESMTPS id f15sm712238fai.22.2011.06.30.14.13.33
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 14:13:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1106291414140.2142@xanadu.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176510>

@ Nicolas Pitre <nico@fluxnic.net> wrote (2011-06-29 20:15+0200):
> Why?

Ok, they don't.  (Your initial patch was from 2008, and since
git(1) is evolving very fast, it might have been that padding is
no longer of any use at all.)
So, then, i'm the right person to turn the big wheel:

- Move color.* and even progress.* stuff into new visual.[hc].
- Add a vis[ual]_init() which does check isatty() for [012] and
  does the TERM check (i.e. "dumb" or otherwise).
  There could also be flags which could be used to restrict what
  is checked ...
- Replace calls to isatty(xy) by std{in,out,err}_is_tty(), defined
  in visual.h.
  Calling vis[ual]_init() would not be needed for these.
  (But they could be inline if it would be.)
- Add a series of vis_print functions in equal spirit to the
  color series which use detected terminal capabilities to ensure
  that a line consists only of the printed data.

I (almost) had that state hour ago, but it's ...  (The problem with
that print series is that in the dumb case the data is to be injected
before a possibly contained NL/CR sequence, so that already inspected
data is to be reinspected.  Or data has to be copied around.  Or
writes have to be splitted, but here i'm talking about stderr, and
that's unbuffered, and so each invocation goes through the OS.)

So what else could be done to remove TERM and ANSI escape sequence
knowledge from a nice multiband stream splitter, and to avoid that
it writes the escape sequence if output is stupidly redirected to a
file?  Well, visual.h could consist of a single function only:

    const char *ansi_el_if_tty_and_termok_else_null(void);
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
