From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Mon, 15 Jun 2015 10:54:36 -0700
Message-ID: <xmqqoakgamcj.fsf@gitster.dls.corp.google.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-4-git-send-email-pyokagan@gmail.com>
	<xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
	<CACRoPnR28kNvxk6sdYaNkPYx7wi=j4wCbaXYrx62AGhjpQiPVA@mail.gmail.com>
	<xmqqwpz4ao6l.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9fkNQTB8bEKdOBqFgV1E1Mff7oE8rBFDUK+c-woxqZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Yaq-0002mH-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbbFORyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 13:54:40 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38094 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbbFORyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 13:54:39 -0400
Received: by igblz2 with SMTP id lz2so56184700igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=U+EbA+D0IgD9JRennpkTkjTWXcO12pGJGTrsgE7kNRo=;
        b=DMS8TOtjpJoJVnJAGCmFvttkW4lG24YIeApMGHxFnuvqJVrBgqClm4nxC/ZvRUZbkW
         hkX/IzHpPHB9DIYdfwrbY7JsWZ37/W4eyy6re82RYVTUeMfo0ZnNJ5/mpO0YMbyzcyfE
         L3j01XOp/fCAVU1v3KxFjH8EWGxAuqTwy2kAZbpafDW1lRas2b9GlR5n8sNrruNUbjNh
         JDKg9qYu6Oj8PWjUREiEYO4bIVIXOrfFHZtXHyqBnWpF1bIDJfJ33ncZt9MtK4h/t9nf
         Qefp/uetqt7nE2CaC0qNEeYpECQqpJ4yfkscFDSJs+Gh6CC4AHxvQJ27rbMRI2a6lpda
         1ZzA==
X-Received: by 10.107.47.224 with SMTP id v93mr18129880iov.86.1434390878597;
        Mon, 15 Jun 2015 10:54:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id ie1sm3740422igb.5.2015.06.15.10.54.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 10:54:38 -0700 (PDT)
In-Reply-To: <CACRoPnS9fkNQTB8bEKdOBqFgV1E1Mff7oE8rBFDUK+c-woxqZg@mail.gmail.com>
	(Paul Tan's message of "Tue, 16 Jun 2015 01:20:17 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271694>

Paul Tan <pyokagan@gmail.com> writes:

>> The scripted Porcelain is spawned after applying patches 1-3 from
>> here, when you do not have _GIT_USE_BUILTIN_AM exported.  Haven't
>> RUN_SETUP code did its thing by that time?
>
> Ah right, the RUN_SETUP code would have chdir()-ed to the working
> directory root, so git-am.sh will be unable to find the original
> working directory. To aid it, we would have to chdir() back to the
> original working directory, and unset GIT_DIR.

I do not think that is a correct workaround, though.  GIT_DIR may
have come from the end user, i.e.

	$ GIT_WORK_TREE=somewhere GIT_DIR=somewhere.else git am ...

As the RUN_SETUP|REQUIRE_WORK_TREE bit is merely a convenence in
git.c, one workable way to keep these dual implementations is to do
what built-in commands used to do before these were invented.
Perhaps studying how cmd_diff(), which is run from git.c without
either RUN_SETUP or NEED_WORK_TREE, and taking good bits from it
would help.  I think the implementation roughly would look like
this:

	int cmd_am(int ac, const char **av, const char *prefix)
	{
                /*
                 * NEEDSWORK: once we retire the dual-mode
                 * implementation, this preamble can be removed...                
                 */
		if (... want to do scripted ...) {
                	... spawn the scripted thing ...
		}
		prefix = setup_git_directory();
                setup_work_tree();
                /* ... up to this point */

		... your real "git am in C" comes here ...
	}
