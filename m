From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/19] fast-import: introduce 'done' command
Date: Wed, 8 Jun 2011 15:03:45 -0500
Message-ID: <20110608200345.GJ27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-11-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOyq-0001qU-O1
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1FHUDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 16:03:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51543 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1FHUDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 16:03:51 -0400
Received: by iwn34 with SMTP id 34so717248iwn.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uGDGdB4rTCl+mmLqNytyJG3M8MI/yMAnC6lQ3M6CP28=;
        b=MNMh9Fo3d6JYJFD/IIfMJ9+tkZJ0FYmnIMljPfEP9NR9AZD6jYtaXe1jU8vBvmTJCj
         Y436ArWTSFvsVHh248OzjVgQo9Pwau9O/XdFj/lB/AZnD5Q6fIuCaHvqBsNNjdCNTEDm
         qxpAIcEBze+EI2CDWU/tlvM6XnZpubRT+Zau4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Zkz64BUo/GWaJHgjlN4pT4qDxh5oYrOLnrz+7YV8uoXxm/yMU21nFkcOZ/VUE5+PQ/
         2uNMb0x55CWuaDKSatLESLpVbpy4LngVjxBq4Vr8DEaUzRRsrsOLKYqZpfGY6LVBX2bB
         2xcisgwrTQ4jV8jNlV4qxFcSpnRq9koDQI3qI=
Received: by 10.231.187.232 with SMTP id cx40mr12786838ibb.73.1307563430248;
        Wed, 08 Jun 2011 13:03:50 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.ameritech.net [69.209.61.87])
        by mx.google.com with ESMTPS id fw9sm414643ibb.30.2011.06.08.13.03.48
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 13:03:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-11-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175453>

Sverre Rabbelier wrote:

> Add a 'done' command that causes fast-import to stop reading from the
> stream and exit.
>
> If the new --done command line flag was passed on the command line
> (or a "feature done" declaration included at the start of the stream),
> make the 'done' command mandatory.

Hoorah!  Thanks for reviving this.

> Another possible application of the 'done' command would to be allow a
> fast-import stream that is only a small part of a larger encapsulating
> stream to be easily parsed, leaving the file offset after the "done\n"
> so the other application can pick up from there.  This patch does not
> teach fast-import to do that --- fast-import still uses buffered input
> (stdio).

Possible approaches, two ugly and one sane:

 A) use setvbuf() to make input line-buffered.  Unfortunately, as
    POSIX tells us:

	Applications should note that many implementations only provide
	line buffering on input from terminal devices.

    So making it actually work involves pseudo-tty craziness.  Not a
    good idea.

 B) leave some room for buffering after the "done" command and make
    fast-import use setvbuf() to control the size of the stdio buffer.
    This is disgusting but it probably works.

 C) make sure the upstream of the pipe does not write anything after
    "done\n" until the "done\n" command has been read.  In other
    words:

	transport-helper>	done
	remote-helper>   	yep, I'm done
	transport-helper>	ah, now that you mention that, here are
	                 	a few more things you could do...

As long as there is nothing after the "done\n" in the pipe buffer when
fast-import reads "done\n", it won't read too far.

This is all made complicated to debug by stdio's habit of closing
streams at exit time, flushing streams at close time, and
repositioning the file offset of seekable input (but not pipes) at
flush time.

Hope that helps.
