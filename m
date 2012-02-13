From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Mon, 13 Feb 2012 09:27:54 -0800
Message-ID: <20120213172754.GG4903@tgrennan-laptop>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
 <4F3614F6.2000106@alum.mit.edu>
 <20120211191748.GC4903@tgrennan-laptop>
 <4F3898F8.2000201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	jasampler@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 13 18:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwzh7-0006rq-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 18:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab2BMR2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 12:28:00 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43298 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2BMR17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 12:27:59 -0500
Received: by qcqw6 with SMTP id w6so3077324qcq.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rfCq54e9kz9Jc4LYNK3khjGaawguVj4kaVw0l1fdHIw=;
        b=pImFa/POFQQx7c7zUPj5sNMixAxAkD9RZW6GSffEDqVu1n/6VBh3Vyh/XFWYRKrZL8
         0N1+vQ3gp+cWhu29YOBvUIiOz4hpQasrOmmRh54wnmztztdVKi0ZeAMq3nLsFazGNX+Y
         OO2oNu1g/eCm1GpGjt7pNAphOlEUe3XXusnNg=
Received: by 10.229.111.228 with SMTP id t36mr10052860qcp.73.1329154078327;
        Mon, 13 Feb 2012 09:27:58 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id gr8sm6646559qab.19.2012.02.13.09.27.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 09:27:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F3898F8.2000201@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190640>

On Mon, Feb 13, 2012 at 06:00:40AM +0100, Michael Haggerty wrote:
>On 02/11/2012 08:17 PM, Tom Grennan wrote:
>> Yes, I didn't explicitly state that the precedence is the order written
>> and in correctly described the first case. How about?
>> 
>> /**
>>  * Returns in highest to lowest precedence:
>>  *   1 with an empty patterns list
>>  *   0 if refname fnmatch()es any ^ prefaced pattern
>>  *   1 if refname fnmatch()es any other pattern
>>  *   0 otherwise
>>  */
>
>Much better; thanks.
>
>Please note that this choice of semantics limits its power.  For
>example, if the rule were instead (like with gitattributes(5)) "if more
>than one pattern matches a refname, a later pattern overrides an earlier
>pattern", then one could do things like
>
>    refs/remotes/*/* !refs/remotes/gitster/* refs/remotes/gitster/master
>
>to include specific references within a hierarchy that is otherwise
>excluded.
>
>However, since rev-list apparently uses a rule more like the one that
>you are proposing, it might be better to be consistent than to choose a
>different convention.

Hmm, I think it's important to have same respective result in each of
these case's,

  $ git tag -l | grep v1.7.8.*
  $ git tag -l v1.7.8*

  $ git tag -l | grep -v .*-rc*
  $ git tag -l ^*-rc*

  $ git tag -l v1.7.8* | grep -v .*-rc*
  $ git tag -l v1.7.8* ^*-rc*
  $ git tag -l ^*-rc* v1.7.8*

What I propose is somewhat analogous to gitignore's double negative,
      *	An optional prefix !  which negates the pattern; any matching
	file excluded by a previous pattern will become included again. If
	a negated pattern matches, this will override lower precedence
	patterns sources.

I still prefer "^" to "!" b/c A) it doesn't cause the noted regressions;
and B) doesn't need command quoting.  I'd accept the counter proposals
of --exclude or --with[out][-TYPE] but frankly, that's more
code/documentation churn ("less code is always better"[TM]) and worse,
more crap to type on the command line:

  $ git --with-tags v1.7.8* --without-tags '*-rc*' tag -l v1.7.8* 
or
  $ git tag -l --exclude '*-rc*' v1.7.8*
vs.
  $ git tag -l v1.7.8* ^*-rc*

-- 
TomG
