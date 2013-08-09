From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 15:15:32 -0700
Message-ID: <7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 00:15:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uyB-0007LC-KN
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031304Ab3HIWPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:15:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031204Ab3HIWPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:15:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60FD237B56;
	Fri,  9 Aug 2013 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S1PKBtm9++fDst5fPFU8YRywPec=; b=D70qUU
	020v5MPDZIy5iO+x6+xPNO051wnKJVZIGUp98Agj5eub8GEVfOv7fOs/zLgFiqR7
	kufN9uOg2aSSX7vzqBRuneSKlF2fLmC8dSfDR79WqJIMn0OrivGNuZORdf0sQfL6
	/Z8gL5LpHON5jtwFnWKaHqMMVlaVNdifQq37I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QpOLgdLA1lXDlIf8qIbtfFZm1WNpKhj8
	lskzde1hpZsa/q51eUTr6lHOUj8ETh19o/bgE7yFFa2BBYL95B7Og/k+cQUC/OqY
	P9kquGipB3//U3BCIcFp1SYuRPkyH6nVIVkkB4lZZsMjiarXZ/nUpkhk8ZW/dSZz
	6gjIAG3u3MM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5723937B54;
	Fri,  9 Aug 2013 22:15:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9225C37B51;
	Fri,  9 Aug 2013 22:15:33 +0000 (UTC)
In-Reply-To: <CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 9 Aug 2013 16:55:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35A9EFD2-0141-11E3-A5EE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232043>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> OK, I think I see why you are puzzled.
>>
>> Cloning works fine because we "fix the path" *after* the clone is done
>> successfully, for the following reason:
>
> So if we didn't store a different path, it would work. So instead of
> expanding '~' ourselves, it would be better to don't expand anything,
> and leave it as it is, but how to detect that in fix_path()?

I think that the patch relies on that os.path.expanduser(), if
url.path is such a path that begins with "~" (or "~whom"), returns
an absolute path.  When given an absolute path, or "~whom/path",
fix_path returns without running 'git config' on remote.<alias>.url
configuration.

Presumably this "git config" is to "fix" what is already there, and
in the case where the path is already absolute
(e.g. "/home/ap/hgrepo" as opposed to "~ap/hgrepo") the resulting
repository has a correct value for the variable set already without
the need to fix it (that is why the original code just returns from
the function), so doing the same for "~whom" case with this patch
should leave the setting, which presumably is "hg::~ap/hgrepo"?
