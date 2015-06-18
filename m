From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized
 hunks
Date: Thu, 18 Jun 2015 16:14:19 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.8.1506181536070.4322@idea>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx> <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com> <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com> <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gCl-0008EJ-4l
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485AbbFRUO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:14:27 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34790 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbFRUO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:14:26 -0400
Received: by qgf75 with SMTP id 75so30063932qgf.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=vTi+6Ldl5LhiRkGIjiZgAMGbNETP7+IELsWUyTcgghc=;
        b=Y6eP9rFRpMIvdChteY5hiIPaI3ncFvCcqyqEaMa0/L9EcZ0jkx1EKmIR8Aeh/c25ha
         FUG0snRt39Q1uozeONUNhT349bzNH942364+HEKibh7wqTuWlC6/yLOVEFApwj438riU
         DKi99kDTKLbcFvkcPOSfPqr3MwZjtBx0Drg88dkxavYwAtrCj1+E3ytViVtl3m2ymuRV
         WMVi6JYEanZSgSAWm2m6LWyvBw6abvY52YkWVN08YnuEUjzRLbaZKWhhsgl08h0C95ww
         h1Gop5H6K9uRvLpqT38B89TWEGjmui/g2SVcCKwZr2MAgoRc9xXoctIMqfMyy4N/5huW
         DuSw==
X-Gm-Message-State: ALoCoQlmy9BkSHxLv27kXjz+ZiZB3epjQcHMQ2y1h0Y0k7BP2qmRxozYGtm4avmWImatD0+qOt5m
X-Received: by 10.55.19.225 with SMTP id 94mr28045859qkt.37.1434658465363;
        Thu, 18 Jun 2015 13:14:25 -0700 (PDT)
Received: from [192.168.1.130] (ool-4353acd8.dyn.optonline.net. [67.83.172.216])
        by mx.google.com with ESMTPSA id i90sm4445057qkh.5.2015.06.18.13.14.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 13:14:24 -0700 (PDT)
X-Google-Original-From: Patrick Palka <patrick@idea>
In-Reply-To: <20150618190417.GA12769@peff.net>
User-Agent: Alpine 2.20.8 (DEB 77 2015-05-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272065>

On Thu, 18 Jun 2015, Jeff King wrote:

> On Thu, Jun 18, 2015 at 11:08:16AM -0700, Junio C Hamano wrote:
>
>> So as I said, I do not think it would hurt to have this as an
>> incremental improvement (albeit going in a possibly wrong
>> direction).
>>
>> Of course, it is a separate question if this change makes the output
>> worse, by comparing unmatched early parts of two hunks and making
>> nonsense highlight by calling highlight_pair() more often.  As long
>> as that is not an issue, I am not opposed to this change, which was
>> what I meant to say by "this might not hurt".
>
> Yes, that is my big concern, and why I punted on mismatched-size hunks
> in the first place. Now that we have a patch, it is easy enough to "git
> log -p | diff-highlight" with the old and new versions to compare the
> results.
>
> It certainly does improve some cases. E.g.:
>
>  -foo
>  +foo &&
>  +bar
>
> in a test script becomes more clear. But some of the output is not so
> great. For instance, the very commit under discussion has a
> confusing and useless highlight. Or take a documentation patch like
> 5c31acfb, where I find the highlights actively distracting. We are saved
> a little by the "if the whole line is different, do not highlight at
> all" behavior of 097128d1bc.

To fix the useless highlights for both evenly and unevenly sized hunks
(like when all but a semicolon on a line changes), one can loosen the
criterion for not highlighting from "do not highlight if 0% of the
before and after lines are common between them" to, say, "do not
highlight if less than 10% of the before and after lines are common
between them".  Then most of these useless highlights are gone for both
evenly and unevenly sized hunks.

Here is a patch that changes the criterion as mentioned.  Testing this
change on the documentation patch 5c31acfb, only two pairs of lines are
highlighted instead of six.  On my original patch, the useless highlight
is gone.  The useless semicolon-related highlights on e.g. commit
99a2cfb are gone.

Ten percent is a modest threshold, and perhaps it should be increased
when highlighting unevenly sized hunks and decreased when highlighting
evenly sized hunks.

Of course, these patches are both hacks but they seem to be surprisingly
effective hacks especially when paired together.

>
> So I dunno. IMHO this does more harm than good, and I would not want to
> use it myself. But it is somewhat a matter of taste; I am not opposed to
> making it a configurable option.

That is something I can do :)

>
> -Peff
>

-- >8 --

Subject: [PATCH] diff-highlight: don't highlight lines that have little in
  common

---
  contrib/diff-highlight/diff-highlight | 13 +++++++++----
  1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 85d2eb0..e4829ec 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -218,8 +218,13 @@ sub is_pair_interesting {
  	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
  	my $suffix_b = join('', @$b[($sb+1)..$#$b]);

-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
-	       $suffix_a !~ /^$BORING*$/ ||
-	       $suffix_b !~ /^$BORING*$/;
+	$prefix_a =~ s/^$COLOR*-$BORING*//;
+	$prefix_b =~ s/^$COLOR*\+$BORING*//;
+	$suffix_a =~ s/$BORING*$//;
+	$suffix_b =~ s/$BORING*$//;
+
+	# Only bother highlighting if at least 10% of each line is common among
+	# the lines.
+	return ((length($prefix_a)+length($suffix_a))*100 >= @$a*10) &&
+	       ((length($prefix_b)+length($suffix_b))*100 >= @$b*10);
  }
-- 
2.4.4.410.g43ed522.dirty
