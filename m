From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 08 May 2014 10:55:28 +0200
Message-ID: <536B4680.1010806@web.de>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>	<1399417144-24864-1-git-send-email-dturner@twopensource.com>	<1399417144-24864-2-git-send-email-dturner@twopensource.com>	<5369CFDE.2070207@viscovery.net> <1399480977.11843.62.camel@stross> <xmqqha51bhxg.fsf@gitster.dls.corp.google.com> <536B2637.2060808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 08 10:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiK7B-0004so-5a
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 10:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbaEHIzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 04:55:36 -0400
Received: from mout.web.de ([212.227.15.3]:60857 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbaEHIze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 04:55:34 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MC1fA-1WZYgd06Ou-008nne; Thu, 08 May 2014 10:55:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <536B2637.2060808@viscovery.net>
X-Provags-ID: V03:K0:B3zB4Iy6oqgy7HnHzqTSu2TtrKB86qV2bO+i54ViaOiPYRp1/xl
 RDelRajbkdv7I7AcAbyg6dSnxzGf2C1ht5/wFmA0PcN2KtgYkqNBz1dGqDIGWdx5AaE0XoZ
 FYnu0NP+61SOLv62Hf2hqrJ02xLfqOYJRRZWiiOm/tSr5ymDJrYKg1zexMDuWLwyh/E9jYy
 zC/4Vq2AJChElojEOVNAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248415>

On 05/08/2014 08:37 AM, Johannes Sixt wrote:
> Am 5/7/2014 19:46, schrieb Junio C Hamano:
>> David Turner <dturner@twopensource.com> writes:
>>
>>> On Wed, 2014-05-07 at 08:17 +0200, Johannes Sixt wrote:
>>>>>   		} else if (cache_name_pos(src, length) < 0)
>>>>>   			bad = _("not under version control");
>>>>> -		else if (lstat(dst, &st) == 0) {
>>>>> +		else if (lstat(dst, &dst_st) == 0 &&
>>>>> +			 (src_st.st_ino != dst_st.st_ino ||
>>>>> +			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {
>>>> Don't do that. st_ino is zero on Windows only because we do not spend time
>>>> to fill in the field. Don't use it as an indicator for a case-insensitive
>>>> file system; zero may be a valid inode number on other systems.
>>> I don't think it is a problem if zero is a valid inode.  The only thing
>>> that happens when there is a zero inode, is that we have to compare
>>> filenames.  The inode check is just an optimization to avoid doing a
>>> bunch of strcasecmp on systems that don't have to.
>> Am I correct to rephrase you that the code assumes that any
>> filesystem that cannot give unique inum to different files will use
>> 0 as the placeholder inum, so if src/dst share the same non-zero
>> inum, it is guaranteed that is not a placeholder and we know they
>> are different files without comparing the two paths?
> "If src and dst share the same non-zero inum, it is guaranteed that it is
> not a placeholder and we know they are the same file" is more correct.
>
> What if both inums are zero? Can this happen on any sane POSIX system? I
> don't know, but my gut feeling is that inode zero is too special to be
> allocated for files or directories.
>
> In that case, it is safe to assume that the st_ino field is just a
> placeholder when it is zero, and we have to compare the file name. Then we
> can either assume that this happens only for our emulation layer on MinGW
> (and the comparison can be case-insensitive) or choose the comparison mode
> based on core.ignorecase. This patch does the former, but I think we
> should do the latter.
Whatever we do, we should "protect" the strcasecmp() with ignore_case:

!ignore_case || strcasecmp(src, dst)

(And once that is done, you don't need to look at st_ino at all)
