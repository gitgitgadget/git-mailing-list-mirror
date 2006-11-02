X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Thu, 2 Nov 2006 09:44:10 +0100
Message-ID: <200611020844.12357.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <200611012309.42675.andyparkins@gmail.com> <7vejsmzqh6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 08:44:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uJt/XfG9Pai3/iOzkdK52p0KdKfMLRDOB66wW+1M5YIVH9gqHUpRIvLK3IAuQaJY+hpGIkGA8PhEvfDbODACJ3/QBJ86Vzi2cJbPIyPqfAE4BRIEY4bAlOHO+kh+FKfKbD89a9+TeTgXyaGU8ElWH2SzXn56uKFDPYJ+KbkNf7A=
User-Agent: KMail/1.9.5
In-Reply-To: <7vejsmzqh6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30691>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYBX-0000j5-Rn for gcvg-git@gmane.org; Thu, 02 Nov
 2006 09:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752411AbWKBIoY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 03:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbWKBIoY
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 03:44:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:49680 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752411AbWKBIoY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 03:44:24 -0500
Received: by ug-out-1314.google.com with SMTP id m3so65334ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 00:44:22 -0800 (PST)
Received: by 10.67.96.14 with SMTP id y14mr254874ugl.1162457062704; Thu, 02
 Nov 2006 00:44:22 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 29sm1629711uga.2006.11.02.00.44.22; Thu, 02 Nov 2006 00:44:22 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 01 23:39, Junio C Hamano wrote:

> That is not something other git commands with pathspec does.
> Path limiters tell command to "do your thing only for paths that
> match these patterns, while you usually handle all paths; your
> behaviour shall otherwise not be any different in other aspects
> between the case you got no limiter and the case you got _all_
> paths as limiters."  So I do not think making path-only mode and
> pathless mode behave differently is a good idea from the UI
> point of view.

Surely if you move HEAD you have implicitly affected every path?  In which 
case what effect did the path limiter have?

Given

 x --- y --- (z--Z)

With z being the index and Z being the working directory - both uncommitted.  
The file foo will be different in x, y, z, and Z.  We decide that z-foo is 
incorrect and that it was right in x; however, there are changes in Z-foo 
that we want to keep.

 git-reset --mixed HEAD^ foo

This would reset z-foo (because --mixed) to its state in HEAD^; i.e. x-foo.  
If HEAD changes as well then all the rest of y will be lost - not just y-foo.  
Remember the original problem was a way of selectively manipulating the index 
without altering the working directory.

I'm perfectly happy if git-reset is not the place to do this, because 
git-reset is only allowed to fiddle with HEAD/index; I moved to git-reset 
only because you mentioned that "reset historically is _not_ HEAD 
manipulator".

I think we're back to square one: there is no appropriate command to take on 
this functionality:

 git-ls-tree HEAD^ foo | git-update-index --index-info

 * git-reset can't have it because it makes no sense to alter HEAD /and/
   revert a file.  It also occurs to me that "git-reset --hard HEAD^ foo"
   (using my suggested git-reset implementation) would be redundant anyway
   because it's the same as "git-checkout -f HEAD^ foo".
 * git-checkout can't have it because it doesn't target the index.
 * git-update-index can't have it because it is plumbing and doesn't know
   about commits, only about objects.

I'm stumped now.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
