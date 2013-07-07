From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Git.pm: add new temp_is_locked function
Date: Sat, 6 Jul 2013 17:11:48 -0700
Message-ID: <20130707001148.GD30132@google.com>
References: <D34E9C76-89B8-44E6-B364-C71B2FC2AC52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>, Daniel Shahaf <danielsh@apache.org>
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 02:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvcaN-0002TU-6u
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 02:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab3GGALz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 20:11:55 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:55518 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3GGALy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 20:11:54 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3138568pbc.21
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 17:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2LOuZ5v8s960SLihhc6ubn9A2aRXEZtRapYYISPGn3Q=;
        b=ITuYz/x2T4jXKjmXnj/ZmXXbFwqV6gmwW0q503MgkBe2kF9X3GR4UGrwKuEs7Lg3WL
         y4L2ixGFaOucxt2FeSj8SRqvlQrOV9DmIAgaIaR6LB/II//JHB4HeywnLP9ZHSl20qVe
         lAak5A2/FPcHpMgoz8qNHW2Hu3CYj4FwB8VjrnhBoksT+y/GUGXZWxqA8VCGt7cu1+Vn
         2HCk1lXrLhK9T2zesFtxb8wWPaTEkhsGWU4xwV0/t3swV1ZHHKZVZEGMei1Gh3VMVxi6
         4Pt5kcvv3obINdKSTIx7ZCQTtc+ErJ+iYczfnX+DtdO7W4m9sSAUIYspQby5ZMogjmt1
         5H5w==
X-Received: by 10.66.234.232 with SMTP id uh8mr16855015pac.155.1373155914182;
        Sat, 06 Jul 2013 17:11:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id p2sm15550284pag.22.2013.07.06.17.11.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 17:11:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <D34E9C76-89B8-44E6-B364-C71B2FC2AC52@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229706>

Hi,

Kyle McKay wrote:

> The temp_is_locked function can be used to determine whether
> or not a given name previously passed to temp_acquire is
> currently locked.
[...]
> +=item temp_is_locked ( NAME )
> +
> +Returns true if the file mapped to C<NAME> is currently locked.
> +
> +If true is returned, an attempt to C<temp_acquire()> the same
> C<NAME> will
> +throw an error.

Looks like this was line-wrapped somewhere in transit.

More importantly, it's not obvious from the above description what
this function will do.  What is a typical value of NAME?  Is it a
filename, an arbitrary string, a reference, or something else?  Is
this a way of checking if a file is flocked?  What is a typical way to
use this function?

Looking more closely, it looks like this is factoring out the idiom
for checking if a name is already in use from the _temp_cache
function.  Would it make sense for _temp_cache to call this helper?

When is a caller expected to call this function?  What guarantees can
the caller rely on?  After a call to temp_acquire(NAME), will
temp_is_locked(NAME) always return true until temp_release(NAME) is
called?  Does this only work within the context of a single process or
can locks persist beyond a process lifetime?  Do locks ever need to be
broken?

I didn't spend a lot of time trying to find the answers to these
questions because I want to make sure that people using Git.pm in the
future similarly do not have to spend a lot of time.  So hopefully a
documentation change could fix this.

Thanks and hope that helps,
Jonathan
