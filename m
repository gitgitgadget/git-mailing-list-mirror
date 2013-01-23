From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Wed, 23 Jan 2013 08:04:50 +0700
Message-ID: <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com> <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
 <7v1udcn84w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 02:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txomd-00020c-0r
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 02:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3AWBFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 20:05:22 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39642 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab3AWBFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 20:05:21 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so7782898oag.7
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 17:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=51ilElIqRKXzn6oT3nHKg1bNoQnhxAQ2hV505AmO2gc=;
        b=t2EUQlJDEgsM8wk0rqznjA+sGQYBKgYKdH5WoVAg05yos+wO/aF/zPRjJ7UNiIalHa
         BT8Mp7N0ZikpKcpCBbvfyIuQlbOwiDkB2OXKpoaR/W2tEwtickkKftRnogA1gg+JmzGf
         B2Dk9pqhrm+RlL862kwC900O9T8KuNVIrZ8VEtThcDU3Gf1Pf70ANMSRpzD3lh+108m0
         loU7mlwe3iVxDicA1oIGWhfXxdS2MGcetM1cLJVsUbLlMb2iGH1/R9GmFw80la8ZRf9O
         M6+wjBgaevxUOwrBevZu+x22MmZHFQXOZL/qCRsjOGDG87QxeZaWc2kMlQKcYMvPggez
         k5Vg==
X-Received: by 10.182.131.3 with SMTP id oi3mr18252564obb.84.1358903120744;
 Tue, 22 Jan 2013 17:05:20 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 22 Jan 2013 17:04:50 -0800 (PST)
In-Reply-To: <7v1udcn84w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214269>

On Wed, Jan 23, 2013 at 5:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> We obviously do not want to set FNM_PATHNAME when we are not
>> substituting fnmatch() with wildmatch(), but I wonder if it may make
>> sense to unconditionally use WM_PATHNAME semantics when we build the
>> system with USE_WILDMATCH and calling wildmatch() in this codepath.
>> Users can always use "*/**/*" in place of "*" in their patterns
>> where they want to ignore directory boundaries.

If we do that, we need to do the same in tree_entry_interesting(). In
other words, pathspec learns the new glob syntax. It's fine for an
experimental flag like USE_WILDMATCH. But after fnmatch is replaced by
wildmatch unconditionally (thus USE_WILDMATCH becomes obsolete), then
what? Should people who expects new syntax with USE_WILDMATCH continue
to have new syntax? How does a user know which syntax may be used in
his friend's "git" binary?

On a related subject, I've been meaning to write a mail about the
other use of patterns in git (e.g. in git-branch, git-tag,
git-apply...) but never got around to. Some use without FNM_PATHNAME,
some do and the document does not go into details about the
differences. We might want to unify the syntax there too. It'll
probably break backward compatibility so we can do the same when we
switch pathspec syntax.

> Another possibility, which _might_ make more practical sense, is to
> update dowild() so that any pattern that has (^|/)**(/|$) in it
> implicitly turns the WM_PATHNAME flag on.  There is no reason for
> the user to feed it a double-asterisk unless it is an attempt to
> defeat some directory boundaries,

They may also put "**" by mistake (or realize they just put "**" but
too lazy to remove one asterisk).

> so we already know that the user
> expects WM_PATHNAME behaviour at that point.  Otherwise, the user
> would have simply said '*' instead, wouldn't he?

The only problem I see is, without the version string, there's no way
to know if "**" is supported. Old git versions will happily take "**"
and interpret as "*". When you advise someone to use "**" you might
need to add "check if you have this version of git". This problem does
not exist with pathspec magic like :(glob)

> I said "_might_" because it sounds a bit too magical to my taste.
> I dunno.
-- 
Duy
