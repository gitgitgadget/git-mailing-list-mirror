From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Sun, 15 Nov 2015 13:43:00 +0100
Message-ID: <A8B23B05-CF5D-469A-B8E6-D80B0B3533C5@gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com> <CAGZ79kb3w7STeEdUtGS8wtQdBznhnSOprwTeOx8Csx2bHXX9Rw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 13:43:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxweE-00057g-Mc
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 13:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbbKOMnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 07:43:07 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38865 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbKOMnE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2015 07:43:04 -0500
Received: by wmec201 with SMTP id c201so85728313wme.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ANPQL+I69INVaZoGjMmzG5F3og9W+zhCrcTJSUNLu9U=;
        b=yaui4ygw23d1/ZGnmHGyTujLs+BBj/c54A8jhDtBaSf9skDZgw22jUlJAb/Yu+TvTc
         GRI1iT1nHr3wZLucQlM9DQxE/nAWtU3ZT5GOzadW+oUKgaYvtkxVH1GSXV5+c9knJOQN
         4zc42MsIFC9Xwshvs9EQ7GXBlwcgCJHjiE4XihKe8pZF3tSq10Sysn9y4vpJ0qyylCWi
         zCVn0D7Oem6ifEtf2sxNAjyHubw6DbnM8PFxsIiYgDwDFt7JsW7ql+UjD586Q/ypfu7G
         TiOXYC9pSQG+uRjIfCxig8Ek+ACLtVeJrFExFyFMPdiDSMzYHn19Lg3ADwk8cjy33fbl
         avyg==
X-Received: by 10.194.222.137 with SMTP id qm9mr36395629wjc.30.1447591383249;
        Sun, 15 Nov 2015 04:43:03 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id gl4sm22194405wjd.17.2015.11.15.04.43.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Nov 2015 04:43:02 -0800 (PST)
In-Reply-To: <CAGZ79kb3w7STeEdUtGS8wtQdBznhnSOprwTeOx8Csx2bHXX9Rw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281311>


On 13 Nov 2015, at 00:34, Stefan Beller <sbeller@google.com> wrote:

> On Thu, Nov 12, 2015 at 1:37 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> "git clone --recursive --depth 1 --single-branch <url>" clones the
>> submodules successfully. However, it does not obey "--depth 1" for
>> submodule cloning.
>> 
>> The following workaround does only work if the used submodule pointer
>> is on the default branch. Otherwise "git submodule update" fails with
>> "fatal: reference is not a tree:" and "Unable to checkout".
>> git clone --depth 1 --single-branch <url>
>> cd <repo-name>
>> git submodule update --init --recursive --depth 1
>> 
>> The workaround does not fail using the "--remote" flag. However, in that
>> case the wrong commit is checked out.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
> 
> Thanks for writing these tests. :)
Thanks for looking into the issue :)


> 
>> +test_expect_failure shallow-clone-recursive-workaround '
>> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
>> +       echo $URL &&
>> +       git clone --depth 1 --single-branch $URL clone-recursive-workaround &&
>> +       (
>> +               cd "clone-recursive-workaround" &&
>> +               git log --oneline >lines &&
>> +               test_line_count = 1 lines &&
>> +               git submodule update --init --recursive --depth 1
> 
> Should we prepend the lines with git submodule update with test_must_fail here?
Wouldn't the test fail then? The test is expected to fail (see "test_expect_failure"). Am I missing something?


> 
>> +       )
>> +'
>> +
>> +test_expect_failure shallow-clone-recursive-with-remote-workaround '
>> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
>> +       echo $URL &&
>> +       git clone --depth 1 --single-branch $URL clone-recursive-remote-workaround &&
>> +       (
>> +               cd "clone-recursive-remote-workaround" &&
>> +               git log --oneline >lines &&
>> +               test_line_count = 1 lines &&
>> +               git submodule update --init --remote --recursive --depth 1 &&
>> +               git status submodule >status &&
>> +               test_must_fail grep "modified:" status
> 
> Use ! here instead of test_must_fail.
> 
> IIUC we use test_must_fail for git commands (to test that git does
> return a non null value instead of segfaulting).
> But on the other hand we trust grep to not segfault, so just negating
> its output is enough here.

OK! I will fix that in the next series!

Thanks,
Lars