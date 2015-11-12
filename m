From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] Clone repositories recursive with depth 1
Date: Thu, 12 Nov 2015 10:39:45 +0100
Message-ID: <19CE7136-E1FD-495A-9BAC-636164757E04@gmail.com>
References: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com> <CAGZ79kbfFhCvQW=_7i4KxjWeh7uYRTTNvLzQUq+CJ641g3=UDg@mail.gmail.com> <CAGZ79kazAWj+D85EXUyP9iHgcb=7QpymyaaKEqQRu9a+UO9msw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwoMG-0001RP-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 10:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbbKLJjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 04:39:51 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38412 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbbKLJjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2015 04:39:47 -0500
Received: by wmec201 with SMTP id c201so82732337wme.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 01:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TiHdGfTDozIhQjQlwa1nsOo1DOBgykwG3BaKH6pqcgs=;
        b=nDQWZW7AxhcRXY8whU0S3eSy62TLXQh82Rl5EnaEmnUhKD4bAzZtqA+S+YdEzUkrXm
         tZQptfIpwiIstaLxPv6fFvSwAH5CKtQj/x/8/VN4QkIMKogGRD49ty6lxCSKwUna/Pyq
         WpjR3k7ERVaW6/f+mGzkjyx+Eo5B6zNpAydM37l4dDnWTTOkAN9wkAEdeiltM2QhZSTB
         dLic1dnXqqikJd/lSn20aVezq2uf0m/rshv0m56z9FkZgs9mFscCOWUa+QhdvlpjxOwf
         HJapuleE3Nd3r7tahk1E64K0C7iIopRTZb9Xc2aYIiZMJAa/aai2qFnUU2d7VkVhGVzX
         QTlg==
X-Received: by 10.194.76.9 with SMTP id g9mr14696008wjw.47.1447321186899;
        Thu, 12 Nov 2015 01:39:46 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB6E5E.dip0.t-ipconnect.de. [93.219.110.94])
        by smtp.gmail.com with ESMTPSA id w73sm29749108wme.12.2015.11.12.01.39.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Nov 2015 01:39:46 -0800 (PST)
In-Reply-To: <CAGZ79kazAWj+D85EXUyP9iHgcb=7QpymyaaKEqQRu9a+UO9msw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281215>


On 11 Nov 2015, at 21:09, Stefan Beller <sbeller@google.com> wrote:

> On Wed, Nov 11, 2015 at 11:19 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Nov 11, 2015 at 6:09 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>> Hi,
>>> 
>>> I have a clean build machine and I want to clone my source code to this machine while transferring only the minimal necessary amount of data. Therefore I use this command:
>>> 
>>> git clone --recursive --depth 1 --single-branch <url>
>> 
>> That *should* work, actually.
>> However looking at the code it does not.
>> 
>> citing from builtin/clone.c:
>> 
>>    static struct option builtin_clone_options[] = {
>>        ...
>>        OPT_BOOL(0, "recursive", &option_recursive,
>>           N_("initialize submodules in the clone")),
>>        OPT_BOOL(0, "recurse-submodules", &option_recursive,
>>          N_("initialize submodules in the clone")),
>>        ...
>>    };
>>    ...
>>    static const char *argv_submodule[] = {
>>        "submodule", "update", "--init", "--recursive", NULL
>>    };
>> 
>>    if (!err && option_recursive)
>>        err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
>> 
>> So the --depth argument is not passed on, although "git submodule update"
>> definitely supports --depth.
>> 
>> In an upcoming series (next version of origin/sb/submodule-parallel-update),
>> this will slightly change, such it will be even easier to add the
>> depth argument in
>> there as we construct the argument list in code instead of hard coding
>> argv_submodule.
>> 
>> This may require some discussion whether you expect --depth to be recursed.
>> (What if you only want a top level shallow thing?, What if you want to have only
>> submodules shallow? What is the user expectation here?)
>> 
>>> 
>>> Apparently this does not clone the submodules with "--depth 1" (using Git 2.4.9). As a workaround I tried:
>>> 
>>> git clone --depth 1 --single-branch <url>
>>> cd <repo-name>
>>> git submodule update --init --recursive --depth 1
>>> 
> 
> The workaround works with the origin/master version for me.
> 
> Notice the other email thread, which suggests to include --remote into the
> call to  git submodule update depending on a branch config option being
> present in the .gitmodules file.

Can you check "[PATCH v2] add test to demonstrate that shallow recursive clones fail"? This demonstrates the failure that I see. I also tried the "--remote" flag but this does not work either (see test case).
Can you confirm this behavior?

Cheers,
Lars