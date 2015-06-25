From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 10:18:09 -0700
Message-ID: <xmqqioabzoz2.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	<1435173388-8346-6-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8AnQ-00061e-Mb
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 19:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbFYRSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 13:18:34 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35545 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbFYRSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 13:18:12 -0400
Received: by igblr2 with SMTP id lr2so101769544igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1ikLT4fHtWwezcTwCHxyoUodZh0a3yg7PpOz84xiOFE=;
        b=t9AHHE/+fIoTuTOEQJkGAT4/CT00wfgS1lFiil8co0VLm1wdDKtVHzixTa7f3EBDji
         KuuTF7lu7h+MWkz+gElacocewUvx95sgT6jb1IMaQ2K5ws5TtAILSKuA1drA79lGEdSa
         P6/XdzJlPk/v1IqOs1aSUWUatmHYkJ+kXHXYgTdyXE0WTi0jttcHPGBlCgWMQWVhDc+1
         IDa/LagyQUXi6/N6NUTt6p/QWPyQOjsafdcAWV5Wg2LwahtoYqGm7ElRjm8yoOawYtdu
         T3Rb755cJIWbKsLqo6qSvBVx8I9z4GND/8uKXt11SWnRWKECqGIDJaX/H06p/TrsLXpj
         n3RQ==
X-Received: by 10.107.135.22 with SMTP id j22mr13078593iod.20.1435252691579;
        Thu, 25 Jun 2015 10:18:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id b73sm19972291iob.25.2015.06.25.10.18.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 10:18:10 -0700 (PDT)
In-Reply-To: <1435173388-8346-6-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Jun 2015 15:16:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272701>

David Turner <dturner@twopensource.com> writes:

> These are necessary because ref backends manage reflogs.

Because?

	Because with core.logAllRefUpdates set to false, creating or
        updating a ref would not log what is done to it, unless a
        reflog already exists for the ref.  There are cases where
        we always want to have a reflog for a ref (e.g. refs/stash)
        regardless of the value of core.logAllRefUpdates, and we
        need a way to ensure that a reflog for a ref exists.
        "reflog create" is the way to do so.

	Also we need to be able to tell if a reflog for a ref
	exists, and "reflog exists" is the way to do so.

Now, going back to 4/6, I think create_reflog() function as an
external API has a few problems.

 * Its name does not tell us what should happen when a reflog
   already exists for the refname the caller asked to "create"
   reflog for.  I understand that this only makes sure it exists and
   does not destroy existing one.  Its old name, log_ref_setup(),
   did not have this problem, but now it does.

 * Its second parameter that is a strbuf is used only internally
   from within log_ref_write_1(); all the external callers do not
   look at it and they are forced to strbuf_init() it before calling
   the function and to strbuf_release() after the function returns.

Oh, also 4/6 incorrectly says that log_ref_write() is renamed to
create_reflog(), but it was log_ref_setup() that was renamed.

I think what 4/6 should have done in order to make the guts of what
log_ref_setup() does available as a more useful external API is to

 * keep log_ref_setup() as-is, make it static to refs.c, and have
   the internal caller that cares about the strbuf (i.e. the path
   to the log file) call that; and

 * Add a thin-wrapper for callers that do not care about the path to
   the log file, e.g.

	int vivify_reflog(const char *refname, struct strbuf *err)
	{
		int ret;
		struct strbuf sb = STRBUF_INIT;

                ret = log_ref_setup(refname, &sb, err);
                strbuf_release(&sb);
                return ret;
	}

Hmm?
    
