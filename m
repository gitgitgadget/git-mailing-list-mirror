From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Thu, 18 Jun 2015 16:44:32 +0800
Message-ID: <CACRoPnRfTCyTj=WnygzwSNu7s_2iGrtygPEh7u2d1Hqchd1ZxQ@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-4-git-send-email-pyokagan@gmail.com>
	<xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
	<CACRoPnR28kNvxk6sdYaNkPYx7wi=j4wCbaXYrx62AGhjpQiPVA@mail.gmail.com>
	<xmqqwpz4ao6l.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9fkNQTB8bEKdOBqFgV1E1Mff7oE8rBFDUK+c-woxqZg@mail.gmail.com>
	<xmqqoakgamcj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:44:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5VRA-0001km-97
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 10:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbbFRIog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 04:44:36 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34202 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbFRIoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 04:44:34 -0400
Received: by lbbti3 with SMTP id ti3so47904763lbb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yAzrIdxg2EY8Hjyzu1Ybhjl36a3eH1j05tEjbEnqLT8=;
        b=WD5NcoVMNmH+rtp7A+GY/QWiWGpfCbLeQrUFXxzEzHPrt3wdhAkve1HNlrLdo4BEOT
         4hKF95lTvK99ih1MYTwDFbmACNg9RnEerpcWmGHQYjFM7ep+Nymf+88/w6osyV7Mp4Px
         3bBh8lHzMmnxtkrR4MPJx/+OrGxRtdzEQPeb8zaelfsbAGrfXojavlcQN1ZP727nuvgv
         /4LUtWMWYC/G7qy/Fg77fc0d/5RaKB3+eIrpT0rJRUQWZh5t6IzgvwyQBvWR1A8h2Nq6
         +VZH3MmZSEAfza+TcSIynPXuFp4+QmJNaYeeK6W63rSCdTTjver5EQnjwO9efrjWpgOj
         vPsw==
X-Received: by 10.152.164.193 with SMTP id ys1mr11967280lab.65.1434617072642;
 Thu, 18 Jun 2015 01:44:32 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 18 Jun 2015 01:44:32 -0700 (PDT)
In-Reply-To: <xmqqoakgamcj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271938>

On Tue, Jun 16, 2015 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>>> The scripted Porcelain is spawned after applying patches 1-3 from
>>> here, when you do not have _GIT_USE_BUILTIN_AM exported.  Haven't
>>> RUN_SETUP code did its thing by that time?
>>
>> Ah right, the RUN_SETUP code would have chdir()-ed to the working
>> directory root, so git-am.sh will be unable to find the original
>> working directory. To aid it, we would have to chdir() back to the
>> original working directory, and unset GIT_DIR.
>
> I do not think that is a correct workaround, though.  GIT_DIR may
> have come from the end user, i.e.
>
>         $ GIT_WORK_TREE=somewhere GIT_DIR=somewhere.else git am ...

Ah, forgot about that ><

> As the RUN_SETUP|REQUIRE_WORK_TREE bit is merely a convenence in
> git.c, one workable way to keep these dual implementations is to do
> what built-in commands used to do before these were invented.
> Perhaps studying how cmd_diff(), which is run from git.c without
> either RUN_SETUP or NEED_WORK_TREE, and taking good bits from it
> would help.  I think the implementation roughly would look like
> this:
>
>         int cmd_am(int ac, const char **av, const char *prefix)
>         {
>                 /*
>                  * NEEDSWORK: once we retire the dual-mode
>                  * implementation, this preamble can be removed...
>                  */
>                 if (... want to do scripted ...) {
>                         ... spawn the scripted thing ...
>                 }
>                 prefix = setup_git_directory();
>                 setup_work_tree();
>                 /* ... up to this point */
>
>                 ... your real "git am in C" comes here ...
>         }
>

Ah OK. Just to be sure, I took a look at run_builtin() in git.c, and
indeed it only just does:

prefix = setup_git_directory();
trace_repo_setup(prefix);
setup_work_tree();

which is not bad at all. Thanks.

Regards,
Paul
