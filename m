From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow to control the namespace for replace refs
Date: Wed, 10 Jun 2015 21:55:30 -0700
Message-ID: <xmqqlhfqhmil.fsf@gitster.dls.corp.google.com>
References: <1433987235-17385-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 06:55:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2uWg-00045w-UL
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 06:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbbFKEzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 00:55:35 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:33929 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbFKEzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 00:55:33 -0400
Received: by iebtr6 with SMTP id tr6so614937ieb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 21:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i8ng8h5D0ouzf99bN8ABFncrShZzCb39CPr5NhIQozE=;
        b=kaO6kCehP4KSep1/lv35DNxcbREjOTK6cOl/2aDO9b/5Eaf1hn+tXHu0NqC1IbT4+n
         DNqbS7683cwtaTE6TFaNYc/IAWOmzrmnjZMa3vmjuedpY1kM1rM2gPoeaYQBWfpydps6
         TOoUH7Xr32nWhTGEyo0kkcwD7bJ/tuRcpKvTEL60Iyk6N5V8bnAJP8Qp8ADBenpkCPky
         yoQ5OLdaN77sjfT+jxAAhqnRDFaEgCskQvWGHlW0k0iz4bAUD78mj4hsdWG0kBpP69n0
         42xJz181/TUowz7YHf9s4pFJVG0WkVlJOd8UVANN1+zLmsWCDGqHQbQlWZafXGlQ9vGY
         pUiQ==
X-Received: by 10.107.155.74 with SMTP id d71mr8684586ioe.29.1433998532958;
        Wed, 10 Jun 2015 21:55:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id e10sm4692462igy.11.2015.06.10.21.55.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 21:55:31 -0700 (PDT)
In-Reply-To: <1433987235-17385-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Thu, 11 Jun 2015 10:47:15 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271375>

Mike Hommey <mh@glandium.org> writes:

> It can be useful to have grafts or replace refs for specific use-cases while
> keeping the default "view" of the repository pristine (or with a different
> set of grafts/replace refs).
>
> It is possible to use a different graft file with GIT_GRAFT_FILE, but while
> replace refs are more powerful, they don't have an equivalent override.
>
> Add a GIT_REPLACE_NAMESPACE environment variable to control where git is
> going to look for replace refs.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
> I'm not sure if I need to care about avoiding strlen in log-tree.c, or if I
> should handle the lack of a / at the end of GIT_REPLACE_NAMESPACE.

First, let me agree with you that being able to say "I usually use
refs/replace/ hierarchy as my object replacement database, but for
this particular invocation of Git (or 'all Git invocations from this
subprocess' for that matter), I want to use refs/replace-2/ hierarchy
instead" is a good thing.

I however doubt that it is a good idea to use the word "namespace"
anywhere in the name for that mechanism.  Let me explain, and please
listen with skepticism, as I do not use the ref namespace mechanism
myself---it is entirely possible that my understanding of how the
ref namespace mechanism is meant to be used is faulty, and if that
is the case please correct me.

The ref namespace mechanism is to be used when you want to serve one
or more "virtual repositories" via upload-pack/receive-pack server
side programs from a single repository.  By having two hierarchies,
each of which is similar to the usual HEAD, refs/heads/, refs/tags/,
etc., under refs/namespaces/a and refs/namespaces/b, you can allow
two instances of upload-pack to serve two "virtual repositories".

What is in refs/namespaces/a/{HEAD,refs/heads/*,refs/tags/*,...} is
exposed by one instance of upload-pack to its clients as if they are
the entire world (i.e. HEAD,refs/heads/*,refs/tags/*,...), the other
one does the same to its clients from refs/namespaces/b/*.  And they
do share the same object store (thereby allowing you to implement a
cheap "forks" without having to worry about object borrowing).

The usual server side housekeeping such as "gc" can and must be
arranged to happen without limiting them to either namespace, so
that anything reachable by any ref from either "virtual repository"
will be retained.

Now, does the "For this invocation, please use refs/replace-2/ as
the object replacement database" feature have anything common to the
ref namespace mechanism?  I do not see any commonality, and that is
why I do not think it is a good idea to use that word.  It will
confuse the users and the developers alike.

To me, this mechanism looks very similar to the way you specify a
non-default notes tree is to be used with the --notes=<ref>
parameter, core.notesRef configuration and GIT_NOTES_REF environment
variable.  Modeling after that, perhaps using core.replaceRef and
GIT_REPLACE_REF would be more appropriate, I think.

Thanks.
