From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] fetch.c: use a single ref transaction for all ref updates
Date: Wed, 23 Apr 2014 16:17:54 -0400
Message-ID: <CAPig+cTxT3gZn+pOwCOyKVVzYrFO7CMeLP_TuCrRsUOQRFYz5w@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<1398192327-21302-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:18:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3cJ-00047P-0F
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbaDWUR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:17:56 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:43546 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbaDWURz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:17:55 -0400
Received: by mail-yk0-f182.google.com with SMTP id 142so1273398ykq.27
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ll58ADAjVAlGXVYzJUSXSl2UWMrBhJ403caVd8IDu5g=;
        b=gtXJyFFcSuAGeAfcFZgBrAcDhDOPMngtq0S4uF9MTpblKRurSMdqcA8KvY78qHPZlh
         fOxlHKv91TmHi6ObYb5fFcgjV2K9oGtI5uep2yyJnawrhCTLpeFN3yYBZe5eVLExhg0k
         O3VAQiQnugTKMN01GTJ31xO1he8zqNirehZfUa2ypdvqC1ZKZMDncb5QqEcgK6yWz8GS
         VwiZZJHTG7BzLvpNhVFdai7foVE9vd5LE3926jlFsTR7QD3PBcygUsBSJN2WTaHX8vkS
         u3GD1VJ9WqrmWm2i8fjij9Ye0KeOcB5zsF4tzWi2gIEnbdOAHDtf0DstT0HFl7vs/xj7
         UqRQ==
X-Received: by 10.236.51.42 with SMTP id a30mr72388476yhc.19.1398284274453;
 Wed, 23 Apr 2014 13:17:54 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Wed, 23 Apr 2014 13:17:54 -0700 (PDT)
In-Reply-To: <1398192327-21302-4-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: 74NnI_-pgkygVaMMgb_KtFSovYY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246886>

On Tue, Apr 22, 2014 at 2:45 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Change store_updated_refs to use a single ref transaction for all refs that
> are updated during the fetch. This makes the fetch more atomic when update
> failures occur.
>
> Since ref update failures will now no longer occur in the code path for
> updating a single ref in s_update_ref, we no longer have as detailed error
> message logging the exact reference and the ref log action as in the old code.
> Instead since we fail the entire transaction we log a much more generic
> message. But since we commit the transaction using MSG_ON_ERR we will log
> an error containing the ref name if either locking of writing the ref would
> so the regression in the log message is minor.
>
> This will also change the order in which errors are checked for and logged
> which may alter which error will be logged if there are multiple errors
> occuring during a fetch.
>
> For example, assuming we have a fetch for two refs that both would fail.

s/assuming/assume/ perhaps?

> Where the first ref would fail with ENOTDIR due to a directory in the ref
> path not existing, and the second ref in the fetch would fail due to
> the check in update_logical_ref():
>         if (current_branch &&
>             !strcmp(ref->name, current_branch->name) &&
>             !(update_head_ok || is_bare_repository()) &&
>             !is_null_sha1(ref->old_sha1)) {
>                 /*
>                  * If this is the head, and it's not okay to update
>                  * the head, and the old value of the head isn't empty...
>                  */
>
> In the old code sicne we would update the refs one ref at a time we would

s/sicne/since/

> first fail the ENOTDIR and then fail the second update of HEAD as well.
> But since the first ref failed with ENOTDIR we would eventually fail the whole
> fetch with STORE_REF_ERROR_DF_CONFLICT
>
> In the new code, since we defer committing the transaction until all refs
> has been processed, we would now detect that the second ref was bad and

s/has/have/

> rollback the transaction before we would even try start writing the update to
> disk and thus we would not return STORE_REF_ERROR_DF_CONFLICT for this case.
>
> I think this new behaviour is more correct, since if there was a problem
> we would not even try to commit the transaction but need to highlight this
> change in how/what errors are reported.
> This change in what error is returned only occurs if there are multiple
> refs that fail to update and only some, but not all, of them fail due to
> ENOTDIR.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
