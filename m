From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 12/48] t6036: criss-cross + rename/rename(1to2)/add-source
 + modify/modify
Date: Wed, 20 Jul 2011 19:15:12 -0400
Message-ID: <4E276180.1050406@cisco.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com> <1307518278-23814-13-git-send-email-newren@gmail.com> <7vvcuzcg73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 01:16:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjg06-0000AX-8W
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 01:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab1GTXQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 19:16:14 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:16298 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab1GTXQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 19:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3978; q=dns/txt;
  s=iport; t=1311203773; x=1312413373;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=gEjfHeRRg52HsLTPfJ0Q+Ny+3lFQjgTye8AY4seOZS8=;
  b=ZwlJNyGYdrue1+S9yFwiMz6Olt4tNwnGktqZJGa6/GTArJHGf4lGgvwQ
   toCHHoMbtcWgvb3t2GPl9dmzRPD13IxkyWfPlfhnqz12mGjg8NPRP4pNO
   jC8TodX6A3SpMz2QzbTTnhihUF9Ojz3mfc1t3CxD+hG0lKdjMdH51slom
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAG9gJ06tJV2c/2dsb2JhbABTp2R3p2CeGYY9BJJuhQeEYYcR
X-IronPort-AV: E=Sophos;i="4.67,238,1309737600"; 
   d="scan'208";a="4908771"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-8.cisco.com with ESMTP; 20 Jul 2011 23:16:13 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p6KNGCvw012380;
	Wed, 20 Jul 2011 23:16:12 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <7vvcuzcg73.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177561>

On 07/18/2011 07:38 PM, Junio C Hamano wrote:
> Elijah Newren<newren@gmail.com>  writes:
>
>> Now THAT's a corner case.
>> ...
>> +# criss-cross with rename/rename(1to2)/add-source + resolvable modify/modify:
>> +#
>> +#      B   D
>> +#      o---o
>> +#     / \ / \
>> +#  A o   X   ? F
>> +#     \ / \ /
>> +#      o---o
>> +#      C   E
>> +#
>> +#   Commit A: new file: a
>> +#   Commit B: rename a->b
>> +#   Commit C: rename a->c, add different a
>> +#   Commit D: merge B&C, keeping b&c and (new) a modified at beginning
>> +#   Commit E: merge B&C, keeping b&c and (new) a modified at end
> THAT may be a corner case, but is it a useful corner case?  What on earth
> the person who did D (or E) was thinking to keep both b and c that are
> derived from A:a to begin with?

I think this may happen rather commonly in one of our repos.  I must say 
I was quite surprised when I recognized it in this discussion.

The details are boring, so feel free to ignore the rest of this message 
unless you just want to understand or contradict me.  There is one 
difference in my real workflow, but for now I'll imagine this difference 
is not there.

Ciao.


Begin boring details:

We have an expensive, enterprise, config control system that tracks 
"low-volume" file revisions by unique filenames in a specific format.  
Here's the life story of a file named foo:

    foo_00    # Revision 00 (initial rev)
    foo_01    # Revision 01
    foo_02    # Revision 02
    foo_A     # Revision A (first 'published' version)
    foo_B     # Revision B (all subsequent versions get published)

When we transition to an externally published version (a one-time 
event), the revisions change from numbers to letters.

We often need to refer to a specific file version by 'versioned name', 
so we keep all the revisions around in a pool of files.

If I have pending changes not yet in the "config control" system, I keep 
a source file in git to hold them until I'm ready to label them with the 
next revision number.

I have some tools that promote my current edition into the next 
appropriately named-revision.

   'next' is used to promote the current source to the next appropriate 
revision-named file.

   'publish' does the same thing, but it explicitly promotes the file to 
revision 'A' from the current numeric revision.

A few weeks ago, this is how foo showed up in my repo:

     pending/foo
     deploy/foo_00
     deploy/foo_01

Here's a greatly simplified overview of the tools with this state:

     next foo        # "mv -n pending/foo deploy/foo_02"
     publish foo     # "mv -n pending/foo deploy/foo_A"

[Elijah's "Commit A: new file: a": a=pending/foo]

The story begins.

[Elijah's "Commit B: rename a->b": b=deploy/foo_01]

Changes in pending/foo need to be released, so I prep with 'next foo'.


     $ next foo        # "mv pending/foo deploy/foo_02"
     deploy/foo_00
     deploy/foo_01
     deploy/foo_02

Then I commit and push.
     $ git add -u . && git add . && git commit -m "next foo" && git push

[Elijah's "Commit C: rename a->c, add different a": c=deploy/foo_A]

My boss has been told (but he forgot to tell me) that we need to go to rev A in this release so the package can be published externally.  So, in his repo he preps with 'publish foo'.

     $publish foo     #"mv -n pending/foo deploy/foo_A"
     deploy/foo_00
     deploy/foo_01
     deploy/foo_A


My boss also has some changes for a future version (probably rev B) so 
he adds those, too.
     $ echo Frabnotz > pending/foo

Then he commits and pushes.
     $ git add -u . && git add . && git commit -m "publish foo" && git push

It's easy to embellish the rest.  It's so easy, I won't.  But you can imagine it.

The only deviation in this story from my real workflow is that I never delete pending/foo.  But if it changed radically each time, I probably would.

Phil
