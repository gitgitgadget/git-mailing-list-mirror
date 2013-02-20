From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 14:01:14 -0800
Message-ID: <20130220220114.GB24236@google.com>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <20130220215043.GA24236@google.com>
 <20130220215845.GB817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Hjk-0002RQ-2s
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 23:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab3BTWBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 17:01:20 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:63183 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3BTWBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 17:01:19 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so3140894pbc.36
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 14:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kmPbMkme5J6+4dLvlqtY3vbbc7rlmnlNoP6LycDAd94=;
        b=xNNvowiB4osx6HkfxAnicaksYkuE3mR/4UIZHKZd98RRHbNJiQL14qxzXOyc7Gmw0R
         cW7RVyJhM+v3Wmy47dX+n3MXEizi58iwrYkaR1KORGtu0Ptj3ieNX6H+9rdUYgNU52K2
         4tZO+t9S2Z9H2jRFm4I/G5Vi8+6vAjrPV4O9LBmZhkO+hcMCJru+2XqGKZ8RUGejheEa
         IGQjseo9sRhSKHTnww2kBVZdRemek5ZRfrSaRoh2H053I/TCy5B360r4uaVjxzmgsSJi
         /tWfB2sZsEx2p0grN8wcpG8HXnRNczMoHwcxGEv5zy56LDCQPwgv1MmFmjCRk7q8ADwa
         wJMw==
X-Received: by 10.66.74.234 with SMTP id x10mr56189495pav.10.1361397678665;
        Wed, 20 Feb 2013 14:01:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id jp9sm22870869pbb.7.2013.02.20.14.01.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 14:01:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130220215845.GB817@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216739>

Jeff King wrote:
> On Wed, Feb 20, 2013 at 01:51:11PM -0800, Jonathan Nieder wrote:

>>> +	if (err == EPIPE) {
>>> +		signal(SIGPIPE, SIG_DFL);
>>> +		raise(SIGPIPE);
>>> +		/* Should never happen, but just in case... */
>>> +		exit(141);
>>
>> How about
>>
>> 		die("BUG: another thread changed SIGPIPE handling behind my back!");
>>
>> to make it easier to find and fix such problems?
>
> You mean for the "should never happen" bit, not the first part, right? I
> actually wonder if we should simply exit(141) in the first place. That
> is shell exit-code for SIGPIPE death already (so it's what our
> run_command would show us, and what anybody running us through shell
> would see).

Yes, for the "should never happen" part.  Raising a signal is nice
because it means the wait()-ing process can see what happened by
checking WIFSIGNALED(status).

Jonathan
