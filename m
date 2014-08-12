From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] Re: [PATCH] unpack-tree.c: remove dead code
Date: Tue, 12 Aug 2014 16:57:31 -0700
Message-ID: <20140812235731.GD24621@google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
 <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 01:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHLwk-00051e-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 01:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbaHLX5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 19:57:35 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44743 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaHLX5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 19:57:34 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so13462756pdj.14
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=z2TXsdyxeCy8+Au1RIjkmdGI9BKQYnBpOXsc1me2z78=;
        b=GpSEYUGtaHGFufBzI+E0xxDRmGqZadAs4jLEHZYz+llRujtbLq12A7osFTuaGrA4F5
         dosg+ys6qbkNrlxoyKADrctJkWVnxYyEIE5ZJgXGueCueRVoBqfbU6DLjNbhwaLLmN+/
         vLbOqqpS3J1/UwOCxpza3RYtQxz8t1AwmAYdQa7UR5gOcgAeD9x4XNi9sKqtSGVw05Co
         QQM38FGz6m1g51Jvkw0fa84P8EhCMnmLbUJYOnnsY/5Pfi2liU+RcmzKZJ6x0nf5pgf8
         3m3DMcBAFXc+HFl/sim0NxXDLCKTK14F3e0nlrEeYlyxl/MIIezBfDKSgt96zl5iuIPS
         qnfQ==
X-Received: by 10.70.134.165 with SMTP id pl5mr906518pdb.20.1407887853860;
        Tue, 12 Aug 2014 16:57:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b597:b557:1d91:6675])
        by mx.google.com with ESMTPSA id po5sm246852pdb.55.2014.08.12.16.57.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 16:57:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255176>

Stefan Beller wrote:

> In line 1763 of unpack-tree.c we have a condition on the current tree
[...]

The description is describing why the patch is *correct* (i.e., not
going to introduce a bug), while what the reader wants to know is why
the change is *desirable*.

Is this about making the code more readable, or robust, or suppressing
a static analysis error, or something else?  What did the user or
reader want to do that they couldn't do before and now can after this
patch?

[...]
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1789,15 +1789,11 @@ int twoway_merge(const struct cache_entry * const *src,
>  			/* 20 or 21 */
>  			return merged_entry(newtree, current, o);
>  		}
> +		else if (o->gently) {
> +			return  -1 ;
> +		}

(not about this patch) Elsewhere git uses the 'cuddled else':

		if (foo) {
			...
		} else if (bar) {
			...
		} else {
			...
		}

That stylefix would be a topic for a different patch, though.

>  		else {
> -			/* all other failures */
> -			if (oldtree)
> -				return o->gently ? -1 : reject_merge(oldtree, o);
> -			if (current)
> -				return o->gently ? -1 : reject_merge(current, o);
> -			if (newtree)
> -				return o->gently ? -1 : reject_merge(newtree, o);
> -			return -1;

Does the static analysis tool support comments like

			if (oldtree)
				...
			if (current)
				...
			...

			/* not reached */
			return -1;

?  That might be the simplest minimally invasive fix for what coverity
pointed out.

Now that we're looking there, though, it's worth understanding why we
do the 'if oldtree exists, use it, else fall back to, etc' thing.  Was
this meant as futureproofing in case commands like 'git checkout' want
to do rename detection some day?

Everywhere else in the file that reject_merge is used, it is as

	return o->gently ? -1 : reject_merge(..., o);

The one exception is

	!current &&
	oldtree &&
	newtree &&
	oldtree != newtree &&
	!initial_checkout

(#17), which seems like a bug (it should have the same check).  Would
it make sense to inline the o->gently check into reject_merge so callers
don't have to care?

In that spirit, I suspect the simplest fix would be

		else
			return o->gently ? -1 : reject_merge(current, o);

and then all calls could be replaced in a followup patch.

Sensible?

Thanks,

Jonathan Nieder (2):
  unpack-trees: use 'cuddled' style for if-else cascade
  checkout -m: attempt merge when deletion of path was staged

Stefan Beller (1):
  unpack-trees: simplify 'all other failures' case

 unpack-trees.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)
