From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Fri, 14 Aug 2015 10:04:36 -0700
Message-ID: <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	<1439416645-19173-2-git-send-email-dturner@twopensource.com>
	<55CC5DED.5050304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQIPJ-0001PU-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 19:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbbHNREi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 13:04:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34805 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113AbbHNREh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 13:04:37 -0400
Received: by paccq16 with SMTP id cq16so19981136pac.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yL14Uum5iQP1uTF0zoINFtA+KiDC6UD2GSuWVreIYPk=;
        b=JPGzcR6Raah1Ms3W7N9LI7hQu9DtPKg/4nr2m5d/LDD9qJ8wJLb6oGbR95uTPuYueQ
         8P8+E5jqeOD946eXalfvZyR34rE9utVAV6ua+auZbyUYqTFTacWeBwQw3fvT0z59wui8
         O+IIemsWWTTljBz6+IoDZbOrSeYDAyKIVHpNlUyigLSQPYjYdeM3p0AtWvq8ORHeQ5Q+
         mSxyMX+bDfckS+z5iUM0yPoCRJcpOa91PbROG1bFH0x/V3kU4EaGnpCPDhMogRCtlcaO
         wKPW1k3+LSHkdqSuE0NJroh7Md+Nki0ULoxVAL5vkR2eTfi7v/Tp3VSlzBdhXjuwEzh9
         K5YA==
X-Received: by 10.68.253.65 with SMTP id zy1mr37120826pbc.159.1439571877246;
        Fri, 14 Aug 2015 10:04:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id fm10sm6641216pab.0.2015.08.14.10.04.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 10:04:36 -0700 (PDT)
In-Reply-To: <55CC5DED.5050304@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 13 Aug 2015 11:05:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275911>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Let's take a step back.
>
> We have always had a ton of code that uses `git_path()` and friends to
> convert abstract things into filesystem paths. Let's take the
> reference-handling code as an example:
> ...
> This seems crazy to me. It is the *reference* code that should know
> whether a particular reference should be stored under `$GIT_DIR` or
> `$GIT_COMMON_DIR`, or indeed whether it should be stored in a database.

It is more like:

 1. The system as a whole should decide if HEAD and refs/heads/
    should be per workspace or shared across a repository (and we say
    the former should be per workspace, the latter should be shared).

 2. The reference code should decide which ref-backend is used to
    store refs.

 3. And any ref-backend should follow the decision made by the
    system as a whole in 1.

I'd imagine that David's ref-backend code inherited from Ronnie
would still accept the string "refs/heads/master" from the rest of
the system (i.e. callers that call into the ref API) to mean "the
ref that represents the 'master' branch", and uses that as the key
to decide "ok, that is shared across workspaces" to honor the
system-wide decision made in 1.  The outside callers wouldn't pass
the result of calling git_path("refs/heads/master") into the ref
API, which may expand to "$somewhere_else/refs/heads/master" when
run in a secondary workspace to point at the common location.

I'd also imagine that the workspace API would give ways for the
implementation of the reference API to ask these questions:

 - which workspace am I operating for?  where is the "common" thing?
   how would I identify this workspace among the ones that share the
   same "common" thing?

 - is this ref (or ref-like thing) supposed to be in common or per
   workspace?

I agree with you that there needs an intermediate level, between
what Duy and David's git_path() does (i.e. which gives the final
result of deciding where in the filesystem the thing should go) and
your two stupid functions would do (i.e. knowing which kind the
thing is, give you the final location in the filesystem).  That is,
to let the caller know if the thing is supposed to be shared or per
workspace in the first place.

With that intermediate level function, a database-based ref-backend
could make ('common', ref/heads/master) as the key for the current
value of the master branch and (workspace-name, HEAD) as the key for
the current value of the HEAD for a given workspace.

> We should have two *stupid* functions, `git_workspace_path()` and
> `git_common_path()`, and have the *callers* decide which one to call.

So I think we should have *three* functions:

 - git_workspace_name(void) returns some name that uniquely
   identifies the current workspace among the workspaces linked to
   the same repository.

 - is_common_thing(const char *) takes a path (that is relative to
   $GIT_DIR where the thing would have lived at in a pre-workspace
   world), and tells if it is a common thing or a per-workspace
   thing.

 - git_path() can stay the external interface and can be thought of:

	git_path(const char *path)
        {
		if (is_common_thing(path))
			return git_common_path(path);
		return git_workspace_path(git_workspace_name(), path);
	}

   if you think in terms of your two helpers.

But I do not think that git_common_path() and git_workspace_path()
need to be called from any other place in the system, and that is
the reason why I did not say we should have four functions (or five,
counting git_path() itself).
