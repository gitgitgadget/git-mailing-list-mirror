From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 04 Oct 2011 10:16:32 +0200
Message-ID: <4E8AC0E0.4090000@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org> <201110031212.13900.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 10:16:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB0BH-0008Se-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 10:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab1JDIQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 04:16:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41609 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab1JDIQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 04:16:41 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p948GWh9026750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Oct 2011 10:16:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <201110031212.13900.mfick@codeaurora.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182747>

On 10/03/2011 08:12 PM, Martin Fick wrote:
> On Friday, September 30, 2011 04:06:31 pm Martin Fick wrote:
>> OK, I narrowed it down I believe.  If I comment out the
>> invalidate_cached_refs() line in write_ref_sha1(), it
>> speeds through this section.
>>
>> I guess this makes sense, we invalidate the cache and
>> have to rebuild it after every new ref is added? 
>> Perhaps a simple fix would be to move the invalidation
>> right after all the refs are updated?  Maybe
>> write_ref_sha1 could take in a flag to tell it to not
>> invalidate the cache so that during iterative updates it
>> could be disabled and then run manually after the
>> update?
> 
> Would this solution be acceptable if I submitted a patch to 
> do it?  My test shows that this will make a full fetch of 
> ~80K changes go from 4:50min to 1:50min,

No, no, no.  Let's fix up the refs cache once and for all and avoid
adding special case code all over the place.

* With minor changes, we can make it possible to invalidate single refs
instead of the whole the refs cache.  And we can teach the refs code to
invalidate refs by itself when necessary, so that other code can become
stupider and more decoupled from the refs code.

* With other minor changes (mostly implemented), we can support a
partly-sorted refs list that decides intelligently when to resort
itself.  This will give most of the performance benefit of circumventing
the refs cache API with none of the chaos.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
