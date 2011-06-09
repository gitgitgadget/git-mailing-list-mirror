From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 9 Jun 2011 08:56:50 -0700
Message-ID: <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com> <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:57:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhbn-0001w2-6t
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab1FIP5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:57:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44629 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab1FIP5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:57:11 -0400
Received: by gxk21 with SMTP id 21so869785gxk.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 08:57:10 -0700 (PDT)
Received: by 10.236.44.39 with SMTP id m27mr1191663yhb.92.1307635030132; Thu,
 09 Jun 2011 08:57:10 -0700 (PDT)
Received: by 10.147.182.11 with HTTP; Thu, 9 Jun 2011 08:56:50 -0700 (PDT)
In-Reply-To: <4DF0EC32.40001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175543>

On Thu, Jun 9, 2011 at 08:52, A Large Angry SCM <gitzilla@gmail.com> wrote:
> On 06/09/2011 11:23 AM, Shawn Pearce wrote:
>> Having a reference to every commit in the repository is horrifically
>> slow. We run into this with Gerrit Code Review and I need to find
>> another solution. Git just wasn't meant to process repositories like
>> this.
>
> Assuming a very large number of refs, what is it that makes git so
> horrifically slow? Is there a design or implementation lesson here?

A few things.

Git does a sequential scan of all references when it first needs to
access references for an operation. This requires reading the entire
packed-refs file, and the recursive scan of the "refs/" subdirectory
for any loose refs that might override the packed-refs file.

A lot of operations toss every commit that a reference points at into
the revision walker's LRU queue. If you have a tag pointing to every
commit, then the entire project history enters the LRU queue at once,
up front. That queue is managed with O(N^2) insertion time. And the
entire queue has to be filled before anything can be output.

-- 
Shawn.
