From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t0003: do not chdir the whole test process
Date: Thu, 6 Feb 2014 12:31:01 -0800
Message-ID: <20140206203101.GX30398@google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
 <1391712033-9443-1-git-send-email-gitster@pobox.com>
 <20140206194521.GU30398@google.com>
 <xmqqvbwsxa2b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:31:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVbL-0004N9-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbaBFUbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:31:07 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47085 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550AbaBFUbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:31:05 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so2244119pbc.10
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 12:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BSHygRddIfQr71c420HJX/kUaurW4/iFZIiW0+oyO80=;
        b=xq4DY7bcB1IoAoeCUFUDEu+TTUctJ4zPFCoBlSGmLvTICLkXrn5YXz6U0cSe+SUNgf
         hKyMZ+IV3LwC2BWOw+5sJ3A4iPWoir0gj3yT8ap6FD5Tsp1w3CAAqL/HhrFzJej5ikx/
         q+dVN4Qg+xpjXgzPyX0UdP2DZwvS7VTBDdILaWSM+C5YwiG5QepjaT7OCYzQ2QswkmXl
         +QMCtz6vD0taTXt3ZSwUSLMtRa/c6vk6fLKMTTl8yxe7XbokqMyHyh4vs/UB+oORsvj8
         NtVvJiVjXEUjH//QNXIZwDFAReVQhut9K5INT0A7Qh9NyiYOw9JI+n4liOMKUWGAsYBX
         TuIA==
X-Received: by 10.66.221.103 with SMTP id qd7mr2835800pac.44.1391718664507;
        Thu, 06 Feb 2014 12:31:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pe3sm6408839pbc.23.2014.02.06.12.31.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 12:31:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqvbwsxa2b.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241742>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>>                                                            The test
>>> that contains chdir itself may fail (or by mistake skipped via the
>>> GIT_SKIP_TESTS mechanism) in which case the remainder may operate on
>>> files in unexpected places.
>>
>> ... but this logic seems wrong.  I don't think we've ever supported
>> setup tests failing or being skipped in the past.
>
> The first set-up test, yes, but something in the middle added as an
> afterthought?

Even set-up in the middle added as an afterthought, yes.

For a while I've been wanting to teach GIT_SKIP_TESTS not to skip
tests with 'setup' or 'set up' in their name, but I never got around
to it.  If I try to skip the setup test this patch touches, then there
is no bare.git and lots of later tests fail.  Perhaps it would be
better for each test to do

	rm -fr bare.git &&
	git clone --bare . bare.git &&
	(
		cd bare.git &&
		...
	)

for itself to make the state easier to think about.

On the other hand I agree that the 'cd' here is a bad practice.  I
just don't think it's about skipping setup --- instead, it's about it
being hard to remember the cwd in general.

Thanks,
Jonathan
