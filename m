From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] resolve_ref_unsafe(): close race condition reading
 loose refs
Date: Fri, 14 Jun 2013 09:17:49 +0200
Message-ID: <51BAC39D.5030201@alum.mit.edu>
References: <20130507023802.GA22940@sigill.intra.peff.net> <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu> <1370960780-1055-5-git-send-email-mhagger@alum.mit.edu> <87d2rqs9ma.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 14 09:18:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnOGl-0005rx-0L
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 09:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab3FNHRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 03:17:55 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53854 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434Ab3FNHRy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 03:17:54 -0400
X-AuditID: 12074413-b7f136d000006de1-6f-51bac3a15df0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.CD.28129.1A3CAB15; Fri, 14 Jun 2013 03:17:53 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5E7Hn0r031833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Jun 2013 03:17:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <87d2rqs9ma.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqLvw8K5Ag++9GhZdV7qZLBp6rzBb
	zLu7i8niR0sPs8Xdy6vYHVg9Lr38zuZx+/V8Zo9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtjR+thxoJdXBUf93UzNjCu5+hi5OSQEDCR2DXlADuELSZx4d56ti5GLg4hgcuMEqt2
	nGKEcK4xSez72cUCUsUroC1xffNzMJtFQFVi24ZWJhCbTUBXYlFPM5gtKhAm8X7ZVFaIekGJ
	kzOfANVzcIgIKEtsW1gDMpNZoIlR4vaF1WA1wgIREs+nroDafJVR4uypx2AJTgFziUl7roDZ
	zAI6Eu/6HjBD2PIS29/OYZ7AKDALyY5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8v
	tUjXXC83s0QvNaV0EyMkzIV3MO46KXeIUYCDUYmHl+PczkAh1sSy4srcQ4ySHExKoryhh3YF
	CvEl5adUZiQWZ8QXleakFh9ilOBgVhLhDf8LVM6bklhZlVqUD5OS5mBREudVW6LuJySQnliS
	mp2aWpBaBJOV4eBQkuCdDzJUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSt8cXA
	eAVJ8QDt3QbSzltckJgLFIVoPcWoy3Hgx5b3jEIsefl5qVLivAtBigRAijJK8+BWwJLaK0Zx
	oI+FeXeAVPEAEyLcpFdAS5iAlhRlbAdZUpKIkJJqYFyWonSz7tbbHo5r0TbVxmp/gze7ztsS
	o73s3LS/s8Tc/4gVnVgWfK19st0x099iXsFZr9+kLBJ3XcpQYH0gZKF+m7et9ZX4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227790>

On 06/13/2013 10:22 AM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> One race is still possible and undetected: another process could
>> change the file from a regular file into a symlink between the call to
>> lstat and the call to open().  The open() call would silently follow
>> the symlink and not know that something is wrong.  I don't see a way
>> to detect this situation without the use of the O_NOFOLLOW option,
>> which is not portable and is not used elsewhere in our code base.
>>
>> However, we don't use symlinks anymore, so this situation is unlikely.
>> And it doesn't appear that treating a symlink as a regular file would
>> have grave consequences; after all, this is exactly how the code
>> handles non-relative symlinks.
> 
> You could fstat() the fd you got from open(), and verify that it is
> still the same inode/device.  That's wasting one syscall per ref for
> pretty much everyone, but perhaps if we really cared about this (and I
> gather from the above that we don't), we could conditionally use
> O_NOFOLLOW if available, otherwise do that fstat().

Yes, that would work.  For now I think I will not worry about it, but
I'll keep your trick in mind.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
