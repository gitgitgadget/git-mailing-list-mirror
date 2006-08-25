From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Problem with pack
Date: Fri, 25 Aug 2006 14:31:24 +0200
Organization: ARCES - =?ISO-8859-15?Q?Universit=E0_di_Bologna?=
Message-ID: <44EEED9C.1010000@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 14:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGaqZ-00062A-1v
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 14:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWHYMb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWHYMb2
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 08:31:28 -0400
Received: from arces.unibo.it ([137.204.143.6]:65198 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S1750766AbWHYMb1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 08:31:27 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7PCiFq6017171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 14:44:17 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_50,USER_IN_WHITELIST 
	autolearn=unavailable version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1728/Fri Aug 25 07:55:58 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25998>

>
> Andreas Ericsson <ae@op5.se> writes:
>
> >> Btw, even without that, if I understand correctly, git packs are
> >> collections of compressed objects, each of which has its own header
> >> stating how long is the compressed object itself. In my case, the
> >> error is in inflating one object (git unpack-objects says inflate
> >> returns -3)... so shouldn't there be a way to try to skip to the
> >> next object even in this case?
> >
> > It should be possible, assuming the pack index is still intact. The
> > pack index is where the headers are stored, afaik.
>
> The problem Sergio seems to be having is because somehow he does
> not have a base object that another object that is in the pack
> depends on, because the latter object is stored in deltified
> form.
>
> This should never happen unless .pack itself is corrupted
> (git-pack-objects, unless explicitly told to do so with --thin
> flag to git-rev-list upstream, would not make a delta against
> objects not in the same pack).
>
> When a delta is written to the pack file, unless its base object
> has already written out, git-pack-objects writes out the base
> object immediately after that deltified object.  So one
> possibility is that the pack was truncated soon after the delta
> that is having trouble with finding its base object.  In such a
> case, the proposed recovery measure of skipping the corruption
> and keep going would not buy you that much.  On the other hand,
> if the corruption is in the middle (e.g. a single disk block was
> wiped out), having .idx file might help you resync.
>
> Does the pack pass git-verify-pack test, I wonder?
If I try to verify the pack I get:

git verify-pack -v pack-ebcdfbbda07e5a3e4136aa1f499990b35685bab4.idx
fatal: failed to read delta-pack base object 
2849bd2bd8a76bbca37df2a4c8e8b990811d01a7


the package length seems reasonable, however... (no evident sign of 
truncation, but I haven't looked inside the index to check the exact 
positions of objects)...
and git unpack-object dies with error code -3 in inflate...
If I am not wrong (but I might easily be so) this should not be relative 
to truncation...

Sergio
