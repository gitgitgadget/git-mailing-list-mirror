From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 08 May 2014 08:37:43 +0200
Message-ID: <536B2637.2060808@viscovery.net>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>	<1399417144-24864-1-git-send-email-dturner@twopensource.com>	<1399417144-24864-2-git-send-email-dturner@twopensource.com>	<5369CFDE.2070207@viscovery.net> <1399480977.11843.62.camel@stross> <xmqqha51bhxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 08 08:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiHxw-0003OQ-F3
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 08:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbaEHGhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 02:37:55 -0400
Received: from so.liwest.at ([212.33.55.19]:48433 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbaEHGhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 02:37:54 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WiHxf-0002zL-Mt; Thu, 08 May 2014 08:37:43 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6BCCA16613;
	Thu,  8 May 2014 08:37:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqha51bhxg.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248407>

Am 5/7/2014 19:46, schrieb Junio C Hamano:
> David Turner <dturner@twopensource.com> writes:
> 
>> On Wed, 2014-05-07 at 08:17 +0200, Johannes Sixt wrote:
>>>>  		} else if (cache_name_pos(src, length) < 0)
>>>>  			bad = _("not under version control");
>>>> -		else if (lstat(dst, &st) == 0) {
>>>> +		else if (lstat(dst, &dst_st) == 0 &&
>>>> +			 (src_st.st_ino != dst_st.st_ino ||
>>>> +			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {
>>>
>>> Don't do that. st_ino is zero on Windows only because we do not spend time
>>> to fill in the field. Don't use it as an indicator for a case-insensitive
>>> file system; zero may be a valid inode number on other systems.
>>
>> I don't think it is a problem if zero is a valid inode.  The only thing
>> that happens when there is a zero inode, is that we have to compare
>> filenames.  The inode check is just an optimization to avoid doing a
>> bunch of strcasecmp on systems that don't have to.
> 
> Am I correct to rephrase you that the code assumes that any
> filesystem that cannot give unique inum to different files will use
> 0 as the placeholder inum, so if src/dst share the same non-zero
> inum, it is guaranteed that is not a placeholder and we know they
> are different files without comparing the two paths?

"If src and dst share the same non-zero inum, it is guaranteed that it is
not a placeholder and we know they are the same file" is more correct.

What if both inums are zero? Can this happen on any sane POSIX system? I
don't know, but my gut feeling is that inode zero is too special to be
allocated for files or directories.

In that case, it is safe to assume that the st_ino field is just a
placeholder when it is zero, and we have to compare the file name. Then we
can either assume that this happens only for our emulation layer on MinGW
(and the comparison can be case-insensitive) or choose the comparison mode
based on core.ignorecase. This patch does the former, but I think we
should do the latter.

-- Hannes
