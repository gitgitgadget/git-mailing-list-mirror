From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 12:00:19 +0100
Message-ID: <52FB5443.8030200@gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com> <robbat2-20140212T015847-248245854Z@orbis-terrarum.net> <CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 12:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDXYe-00059f-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 12:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbaBLLAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 06:00:23 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44209 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaBLLAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 06:00:20 -0500
Received: by mail-wi0-f174.google.com with SMTP id f8so6710938wiw.13
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bH4lNvS8QPLv4thDJ6JaSlnPGafOcjxB9Z5qayMEjUs=;
        b=DD9nORV92sFNVTv52R3ZsJ7ySAuR6ICESIBMYdOBcOpDXDuqjxh9Uzs2KL+gfapRVC
         rDKfkNoLradGlag+NPQnuNw5/Ji+686GEzI89Qgt+hedhQX8m49Gswrn86kk2s9wjGeP
         TOAAcmnIyKmicdkNykl59jon3QXK/LIG6n66ZFUnhQLLeyJTlbv2JoX/Yh6X9/b7aqN7
         /8DAmzhiPmfvX5f9/kCoFp6MpQ+i1by8DuTYBPd2ZnJM0x9cTXeAmXUjhUJoQJjoChui
         plVDIgBxKDtlaYktKTagt+ru2zFhwnkp/2zkxFmvWK0ctU7qsybQrthtcoCbg02o2gWC
         9HwA==
X-Received: by 10.194.219.132 with SMTP id po4mr29093561wjc.7.1392202819401;
        Wed, 12 Feb 2014 03:00:19 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id u6sm4762578wif.6.2014.02.12.03.00.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 03:00:18 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241983>

Am 12.02.2014 04:43, schrieb Duy Nguyen:
> On Wed, Feb 12, 2014 at 9:02 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
>> On Tue, Feb 11, 2014 at 05:54:51PM -0800,  Stefan Zager wrote:
>>> We in the chromium project have a keen interest in adding threading to
>>> git in the pursuit of performance for lengthy operations (checkout,
>>> status, blame, ...).  Our motivation comes from hitting some
>>> performance walls when working with repositories the size of chromium
>>> and blink:
>> +1 from Gentoo on performance improvements for large repos.
>>
>> The main repository in the ongoing Git migration project looks to be in
>> the 1.5GB range (and for those that want to propose splitting it up, we
>> have explored that option and found it lacking), with very deep history
>> (but no branches of note, and very few tags).
> 
> From v1.9 shallow clone should work for all push/pull/clone... so
> history depth does not matter (on the client side). As for
> gentoo-x86's large worktree, using index v4 and avoid full-tree
> operations (e.g. "status .", not "status"..) should make all
> operations reasonably fast. I plan to make "status" fast even without
> path limiting with the help of inotify, but that's not going to be
> finished soon. Did I miss anything else?
> 

Regarding git-status on msysgit, enable core.preloadindex and core.fscache (as of 1.8.5.2).

There's no inotify on Windows, and I gave up using ReadDirectoryChangesW to keep fscache up to date, as it _may_ report DOS file names (e.g. C:\PROGRA~1 instead of C:\Program Files).
