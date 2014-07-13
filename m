From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: [Bug] data loss with cyclic alternates
Date: Sun, 13 Jul 2014 12:44:25 +0200
Message-ID: <53C26309.5040401@gmail.com>
References: <53BFB055.206@gmail.com> <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 12:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6HGh-0008KY-8y
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 12:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbaGMKo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 06:44:27 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:63808 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaGMKoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 06:44:25 -0400
Received: by mail-we0-f180.google.com with SMTP id k48so1990766wev.11
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QWoNnt8iGjNmu3h56G8HWbAeVDZ8Hg6eImoFRPBf8gs=;
        b=DU7l3A5ZoDk1CNw4T5cUIig4fHwlZx4ILWvAcIiXych0fbDy7+agABxybGFAaaMmLO
         ppQeshcTRI7d6hr+ISj0yznNtrAELFnSvxxRB8canKY+eClZPxFfbNUvF/4w7e+ZWMs3
         L4sIDrBSW338oMtUv6cNty+L9u1RyQ0GfFMYygJm6SnNQCu+Bm2FsFcM3pzhrecEzIT2
         6LytLDxb+REIwxnxfuZwEzupHnDFVwQADT3iRWp7UdDg5M6O5AL1oOgXdlh2l+v0gobX
         +tixd2yPOFrzcNq8IPZCgkJDmftDnrFlXfxC7Ki1R6PI+7OCvMzd+7Ntaf29AfPv4s+4
         dVAQ==
X-Received: by 10.180.81.37 with SMTP id w5mr17061160wix.65.1405248264190;
        Sun, 13 Jul 2014 03:44:24 -0700 (PDT)
Received: from floh-wuff-book.speedport_w723_v_typ_a_1_01_001 (p57B36443.dip0.t-ipconnect.de. [87.179.100.67])
        by mx.google.com with ESMTPSA id i12sm17756597wjr.32.2014.07.13.03.44.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jul 2014 03:44:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253446>

Am 11.07.14 18:01, schrieb Junio C Hamano:
> Ephrim Khong <dr.khong@gmail.com> writes:
>
>> git seems to have issues with alternates when cycles are present (repo
>> A has B/objects as alternates, B has A/objects as alternates).
>
> Yeah, don't do that.  A thinks "eh, the other guy must have it" and
> B thinks the same.  In general, do not prune or gc a repository
> other repositories borrow from, even if there is no cycle, because
> the borrowee does not know anythning about objects that it itself no
> longer needs but are still needed by its borrowers.

It seems that there is a safeguard against this in sha1_file.c, 
link_alt_odb_entry(), that doesn't work as intended:

	if (!strcmp(ent->base, objdir)) {
		free(ent);
		return -1;
	}

However, printf-debugging tells me that ent->base is absolute and objdir 
is relative (".git/objects") at this point, so the strings are different 
even though the files are the same.

I never submitted a patch to git. Do you think someone can fix this 
hickup, otherwise I'll give it a shot next week.
