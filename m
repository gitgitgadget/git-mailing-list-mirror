From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Fri, 23 May 2014 08:53:53 -0700
Message-ID: <20140523155353.GA4065@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-42-git-send-email-sahlberg@google.com>
 <537F67DD.5010101@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 23 17:54:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnrnI-0006hI-UX
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 17:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaEWPyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 11:54:00 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42172 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaEWPx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 11:53:59 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so4349282pbb.27
        for <git@vger.kernel.org>; Fri, 23 May 2014 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/tZJSjiJD1o2fQsBVuC4PScTPB7Br4re21F+guuTBiI=;
        b=zAlRBSZYZy5xu5VtGo0U09CNCMmGEaFlNxU6tRUh3p6f8V5P2FbROefW0nNWIj4ye5
         Pv+LdYSAIKMBgU73mkB5RnboomNrJxayEYtTe0DVNadUBB3lVtK8xRMus5wl5VPgbdjB
         D44IMRTRHVnKJNNfsxV23el5rNCzQCH+4u7IAT9O8bXzlC8BJPNqZD41CDM2EYgDT6ok
         dIqtbTM/rl+BwC1h2/+ADd+0poS1YKR51XFvo3RD5haOC6jy75nJKHfSsqVGKgvxOdki
         i0Kg0aETzMxkYZvJySBIXZUZz0IEOJ/c3Kj9mZDQkXlIJTbz2zjNkVLtR7qNqblYSIud
         VL0g==
X-Received: by 10.66.141.165 with SMTP id rp5mr7246447pab.90.1400860439426;
        Fri, 23 May 2014 08:53:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ec2sm5243394pbc.63.2014.05.23.08.53.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 08:53:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537F67DD.5010101@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249992>

Hi,

Michael Haggerty wrote:

> The status quo is that we have a single reference back end consisting of
> loose references sitting on top of packed references.
>
> But really, loose references and packed references are two relatively
> independent reference back ends [1].  We just happen to use them layered
> on top of each other.
>
> This suggests to me that our current structure is best modeled as two
> independent reference back ends, with a third implementation of the same
> reference API whose job it is to compose the first two.
[...]
> [1] Forget for the sake of this discussion that we can't store symbolic
> references as packed refs.

I find it hard to forget that. ;-)  More to the point, the trouble
with loose refs and packed refs as independent reference backends is
that neither has very good performance characteristics.  Enumerating
many loose refs is slow.  Adding a new packed ref to a large list is
also slow.  Git currently uses both loose and packed refs in a way
that allows each to overcome the limitations of the other, and the
fact that it involves two on-disk data structures seems to me like an
implementation detail of how it achieves that.

So I believe most git code should not have to know about the
difference between loose and packed refs (or the upper and lower
layer) to allow the details of the layering can be tuned in low-level
ref handling code.

On the other hand, from a code structure perspective I can easily
believe that implementing some subset (or maybe even all) of the
reference backend API for loose refs and packed refs separately and
providing a separate file describing how to compose them might be the
cleanest way to write this code.  It's more general layering that
seems to lie in the direction of madness.

Maybe I'm wrong and people will find lots of use for combinations like
 * loose refs shadowing an sqlite database
 * tdb shadowing mysql
 * etc
It's easy to prove a naysayer wrong with code and I don't want to
discourage that.

For the topic at hand it's relevant because packed-refs have
properties that make some operations (certain deletion/ref creation
combinations) much less fussy than loose refs, and it would be nice to
be able to take advantage of that.  In the long term I would like to
see git taking advantage of that when someone tries to fetch refs with
names that would conflict on the filesystem (e.g., topic, topic/a,
topic/b).

Thanks,
Jonathan
