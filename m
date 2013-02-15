From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Fri, 15 Feb 2013 11:32:59 -0800
Message-ID: <7vd2w1gyok.fsf@alter.siamese.dyndns.org>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 <7vd2w1wmdo.fsf@alter.siamese.dyndns.org>
 <CACsJy8A6oBjbaX=3iQcSxcwed28KLTk_tN+iuWDLsC512Z2V1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 20:34:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6R36-0005Al-3w
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 20:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab3BOTdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 14:33:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab3BOTdL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 14:33:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F17AE3E;
	Fri, 15 Feb 2013 14:33:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jw10fkdLCUneNif6rQYymU9DhD4=; b=BWY+CY
	SwgZRvGGagrQf0rsc6eiuhGy7HiIspJ+WUvyN80T3m0yZVsRD9ALBBW+ajSaqaFV
	7aMeranliIIqtkXBfyhBtDIg/g4rmddlVLetTinXdHiL0h/Xds7I13cURecJxOAR
	llAmIISJJjDGVhSCVYlCvhBGr7yo/iDvdgaww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u9t9dgIE4TGMlzRMukYXCSVRDiEtywsf
	cAnVyZqwq38Gr7/NMwp4Fhsaoy2uPDag89XNNvixJD0nA9pvLQCH0TYOfE8R5xLi
	kfEfdF4vs74Nmc93wpTZYT5aekhGaKV5V5RlsI5G+9uOlIvw00eNbn/yDanMwoH2
	HMgxWgU/TCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E66AE3D;
	Fri, 15 Feb 2013 14:33:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C9C0ADFC; Fri, 15 Feb 2013
 14:33:00 -0500 (EST)
In-Reply-To: <CACsJy8A6oBjbaX=3iQcSxcwed28KLTk_tN+iuWDLsC512Z2V1Q@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 16 Feb 2013 01:30:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82216914-77A6-11E2-83CD-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216353>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 15, 2013 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> In the current code, we always check if a path is excluded, and when
>> dealing with DT_REG/DT_LNK, we call treat_file():
>>
>>  * When such a path is excluded, treat_file() returns true when we
>>    are not showing ignored directories. This causes treat_one_path()
>>    to return path_ignored, so for excluded DT_REG/DT_LNK paths when
>>    no DIR_*_IGNORED is in effect, this change is a correct
>>    optimization.
>>
>>  * When such a path is not excluded, on the ther hand, and when we
>>    are not showing ignored directories, treat_file() just returns
>>    the value of exclude_file, which is initialized to false and is
>>    not changed in the function.  This causes treat_one_path() to
>>    return path_handled.  However, the new code returns path_ignored
>>    in this case.
>>
>> What guarantees that this change is regression free?
>
> If you consider read_directory_recursive alone, there is a regression.
> The return value of r_d_r depends on path_handled/path_ignored. With
> this patch, the return value will be different.

That is exactly what was missing from the proposed log message, and
made me ask "Do all the callers that reach this function in their
callgraph, when they get path_ignored for a path in the index,
behave as if the difference between path_ignored and path_handled
does not matter?"  Your answer seems to be

 - r-d-r returns 'how many paths in this directory match the
   criteria we are looking for', unless check_only is true.  Now in
   some cases we return path_ignored not path_handled, so we may
   return a number that is greater than we used to return.

 - treat_directory, the only user of that return value, cares if
   r-d-r returned 0 or non-zero; and

 - As long as we keep returning 0 from r-d-r in cases we used to
   return 0 and non-zero in cases we used to return non-zero, exact
   number does not matter.  Overall we get the same result.

I think all of the above is true, but I have not convinced myself
that r-d-r with the new code never returns 0 when we used to return
non-zero.

> ...
> It's a bit tricky. I'm not sure if I miss anything else.

Hrm...
