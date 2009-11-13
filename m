From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git in next is broken
Date: Fri, 13 Nov 2009 09:14:28 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0911130910150.17726@reaper.quantumfyre.co.uk>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home> <4AFC8960.9090808@lsrfire.ath.cx> <alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0911122345450.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 10:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8sFo-0007pn-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 10:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbZKMJP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 04:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbZKMJP0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 04:15:26 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:60605 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754820AbZKMJPY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 04:15:24 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5D513364524
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 09:15:29 +0000 (GMT)
Received: (qmail 10728 invoked by uid 103); 13 Nov 2009 09:14:28 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/10020. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.056672 secs); 13 Nov 2009 09:14:28 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 13 Nov 2009 09:14:28 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.2.00.0911122345450.16711@xanadu.home>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132827>

On Thu, 12 Nov 2009, Nicolas Pitre wrote:

> On Thu, 12 Nov 2009, Julian Phillips wrote:
>
>> On Thu, 12 Nov 2009, Ren? Scharfe wrote:
>>
>>> Nicolas Pitre schrieb:
>>>> Simply issuing a "git fetch" in my copy of git.git makes glibc complain
>>>> with this:
>>>>
>>>> *** glibc detected *** git: corrupted double-linked list:
>>>> 0x0000000000974180 ***

>>> Can't reproduce because I don't know how to create duplicate refs, but does
>>> the following help?
>
> Nope.
>
>>> remote.c |    2 ++
>>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/remote.c b/remote.c
>>> index 4f9f0cc..10cc985 100644
>>> --- a/remote.c
>>> +++ b/remote.c
>>> @@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
>>> 			prev->next = ref_map->next;
>>> 			free(ref_map->peer_ref);
>>> 			free(ref_map);
>>> +			ref_map = next;
>>
>> You don't need this line (this is taken care of in the for(...)).
>>
>>> +			continue;
>>
>> Ack. This one however, you do need.  Good catch.
>
> Without the "ref_map = next" there is no change: glibc still complains
> about corruption and abort the execution.  With the "ref_map = next"
> then git simply segfaults.
>
> I simply have zero time to investigate the issue myself now
> unfortunately.

I was half right about "ref_map = next", I had forgotten about setting 
prev in the for(...).  For me, the following fixes it on MacOS (I don't 
have time to test on Linux right now):

diff --git a/remote.c b/remote.c
index 4f9f0cc..6195a58 100644
--- a/remote.c
+++ b/remote.c
@@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
                         prev->next = ref_map->next;
                         free(ref_map->peer_ref);
                         free(ref_map);
+                       ref_map = prev; // Keep the same prev.
+                       continue;
                 }

                 item = string_list_insert(ref_map->peer_ref->name, &refs);

-- 
Julian

  ---
C'est magnifique, mais ce n'est pas l'Informatique.
 		-- Bosquet [on seeing the IBM 4341]
