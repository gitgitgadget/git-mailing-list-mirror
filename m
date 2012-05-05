From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: how to determine version of binary
Date: Sat, 05 May 2012 11:18:13 -0500
Message-ID: <4FA552C5.7090000@gmail.com>
References: <jo2jtd$m6c$1@dough.gmane.org> <20120505092443.GB8172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 05 18:18:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQhgp-0006q2-0Q
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 18:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab2EEQS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 12:18:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55012 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280Ab2EEQSS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 12:18:18 -0400
Received: by obbtb18 with SMTP id tb18so5622336obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MdEj8RIYaNEEcxVoo4Ea4FTdC113WBFh6kuqFMbR190=;
        b=xM9dyMiKhgLK1O0U7/xqB+WoXM2CnSdmFvfCm7Y0YZTWhakDXP++nFlm0f+q+I6AkC
         qnoVzpAlH6Z8kVjzBsYo5mwB7ee/lQbifSplcodMD+j8PFJOtAZ3G0WSpNN1jNyMoQbh
         a2JSr+bkNue3yCYgiQAEvb5Zc/UFHu7uWeScfh+O/fPIxbYyfoqZ9CNLeLCKq76n2MYC
         n99ioxoyj0RFvp7N8iybMTdvl+u3heXhK96KVhTb365iqFDAFQJ7Jg7wv2Nck1fBLlya
         5c3hucAOXwfn03y3yZVBgV1PLi/28ABCvTvv92p5O9sY+lvwLsjkeP0AC3Tc6em2CwBt
         JdsQ==
Received: by 10.182.5.164 with SMTP id t4mr14500340obt.1.1336234697457;
        Sat, 05 May 2012 09:18:17 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h7sm10143595oeh.9.2012.05.05.09.18.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 09:18:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120505092443.GB8172@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197121>

On 5/5/2012 4:24 AM, Jeff King wrote:
> On Sat, May 05, 2012 at 02:12:44AM -0500, Neal Kreitzinger wrote:
>
>> Scenario:  I detect a binary file that is 'dirty'.  I don't know how
>> it got there.  However, I know it came from a git repo.  So I
>> calculate the sha1 of the binary.  What is the git command to
>> determine which commit that binary version first appeared in?  And
>> the last commit that binary appeared in?
> There is no pre-made git commit. I would look at the output of "git log --raw
> --no-abbrev" in a pager and search for the sha1 in question. That will show you
> the commits that made it come and go. Note that there may be multiple instances
> in which the sha1 comes and goes (e.g., two parallel lines of development which
> both introduce or modify a sha1, or even linear development with reverting).
>
> You can script it like this:
>
>    git log --format=%H --no-abbrev --raw |
>    perl -lne '
>      BEGIN { $sha1 = shift }
>      if (/^[0-9a-f]{40}$/) {
>        $commit = $_;
>      }
>      elsif (/^:\d+ \d+ ([0-9a-f]{40}) ([0-9a-f]{40}) \S+\t(.*)/) {
>        if ($2 eq $sha1) {
>          # sha1 on "after" side; content probably came into existence
>          if ($1 eq $sha1) {
>            # unless it was that way before, in which case it was a mode change
>            # or rename. Ignore.
>          }
>          else {
>            print "$commit: $sha1 appears (as $3)";
>          }
>        }
>        elsif ($1 eq $sha1) {
>          # sha1 on "before" side; content went away
>          print "$commit: $sha1 went away (from $3)";
>        }
>      }
>    ' $sha1_of_interest
>
> though I wouldn't bother to do so unless I was going to do some analysis over
> many files.
>
>> Why:  we have people ftp'ing binaries around.  I want to see the
>> commit message and source change of that commit to see what the
>> binary version is.
> This won't necessarily show you the version they have; it will only show you
> the version that introduced that particular version of a file. A more general
> question is "given a set of files, which revision did they come from?".  For
> that, you would want to find the set of commits that contain sha1 A, then
> intersect them with the set of commits that contain sha1 B, and so forth. You
> can do that by scripting around "rev-list" and "ls-tree", but it's a little
> more complicated.
>
What about this recipe:

calculate sha1 of dirty deliverable (binary, html, etc)

grep git tree objects for that sha1

somehow determine which of the tree sha1's is newest.  Not sure how to 
do that.

grep commit objects for that tree sha1

now you have the last commit containing that file so now you know the 
version of that file.

-neal
