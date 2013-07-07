From: Kyle McKay <mackyle@gmail.com>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 18:24:35 -0700
Message-ID: <1D11122F-5C75-4FAC-80EA-D5DC65902403@gmail.com>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com> <51D7C47D.5070700@acm.org> <20130707002804.GF30132@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Rothenberger <daveroth@acm.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 03:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvdik-0005C0-5Z
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 03:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab3GGBYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 21:24:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:46629 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3GGBYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 21:24:39 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so3251540pac.26
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=c0pAk1+7sQyJ0BmjLGBht2GgySWYSN0Ol9s+BYtkiQQ=;
        b=jj+74cBwjZa5YNJZGOhUKdR1KvwjxRJy5srKck5TBkI/khj7Flgm424O6EFYcHWl6J
         CbEqrksIcTTygExYTCkLYg4EEvbyxWSS+hoagnH7ykNyAdQ2MoAXtHiDgJ5S4BBTCTHo
         /L/GZeCUZuVgk0RQQCjJJYhFrBlxdtSscvqSgbSWcipSSMRgoMv51sNDN5cGaq93OTzK
         2PV1F7bpDWPoCOe0YBBmCOopqBJWKmbe+oyemXTMnll11jPokpGCDXuALt0VW9n8+ng5
         1crX6GMfrK/G44hUOX/5y10bZDN8MrhvQsOvJZDpEn/GjPQ0CBmWjwDPL4OEe71qKJox
         tv4g==
X-Received: by 10.68.251.234 with SMTP id zn10mr15209004pbc.188.1373160278500;
        Sat, 06 Jul 2013 18:24:38 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id py6sm14544520pbb.33.2013.07.06.18.24.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 18:24:37 -0700 (PDT)
In-Reply-To: <20130707002804.GF30132@google.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229713>

On Jul 6, 2013, at 17:28, Jonathan Nieder wrote:
> David Rothenberger wrote:
>> On 7/5/2013 8:41 PM, Kyle McKay wrote:
>
>>> Daniel Shahaf has suggested also setting
>>> "servers:global:http-bulk-updates=on".
>>
>> I have a patch that does this, but since turning on bulk updates has
>> a possible performance penalty, I prefer your approach.
>
> I assume that's because http-bulk-updates defeats caching.  If so,
> makes sense.
>
> Please forgive my ignorance: is there a bug filed about ra_serf's
> misbehavior here?  Is it eventually going to be fixed and this is
> just a workaround, or is the growth in temp file use something we'd
> live with permanently?

Apparently it will not be fixed:

Begin forwarded message:
> From: David Rothenberger <daveroth@acm.org>
> Date: July 5, 2013 16:14:12 PDT
> To: git@vger.kernel.org
> Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in  
> use" and skelta mode
>
> I traced git-svn and discovered that the error is due to a known
> problem in the SVN APIs. ra_serf does not drive the delta editor in
> a depth-first manner as required by the API [1]. Instead, the calls
> come in this order:
>
> 1. open_root
> 2. open_directory
> 3. add_file
> 4. apply_textdelta
> 5. add_file
> 6. apply_textdelta
>
> This is a known issue [2] and one that the Subversion folks have
> elected not to fix [3].
>
> [1]
> http://subversion.apache.org/docs/api/latest/structsvn__delta__editor__t.html#details
> [2] http://subversion.tigris.org/issues/show_bug.cgi?id=2932
> [3] http://subversion.tigris.org/issues/show_bug.cgi?id=3831

The summary of [3] which is marked RESOLVED,FIXED is "Add errata / 
release note noise around ra_serf's editor drive violations".

Kyle
