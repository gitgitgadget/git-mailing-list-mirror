From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 09:07:32 -0700
Message-ID: <xmqqbnfx89iz.fsf@gitster.dls.corp.google.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-7-git-send-email-dturner@twopensource.com>
	<CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9y4T-0003o5-9V
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbbF3QHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 12:07:36 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35733 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbF3QHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:07:35 -0400
Received: by igblr2 with SMTP id lr2so78406943igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9/zVHzBjREBddV9/izpnCT3IIwrrWGr4TGhJe1MdRVg=;
        b=D/0cE+4HOrv4+YFWig5cGEQCAycCC0vpmplWI2QwhpmxxTYYq/P+eSai9CUqjILRfQ
         6IoPc8uom05Sa1YTrejg83sVmWTx39zmYaVTbFztAN7LYk8Ck6rEOKLo0LI7vFQUMwKo
         RO0PlKQ6ZJ2kbMvGSkL/ouIIYWvYTVC5W/7w7FsjYBiuLwkXHYT811hENqci66nDD9Mg
         Eh8ExGwHcDG6aCiijqXRglpibF+xq9Mh3Kh9VKSFFQroZFReOd2j21b4ek11D1hiS9qG
         EN78/pGBdxZkd6fKgks7OdWf9SDg82Bdd4pjgxZooFVR7UZsBBSZOE9hXA42e9k2KIhM
         htzA==
X-Received: by 10.50.136.197 with SMTP id qc5mr24744005igb.6.1435680454215;
        Tue, 30 Jun 2015 09:07:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id b140sm1283249ioe.9.2015.06.30.09.07.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 09:07:33 -0700 (PDT)
In-Reply-To: <CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 30 Jun 2015 03:34:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273077>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       for (i = start; i < argc; i++) {
>> +               if (safe_create_reflog(argv[i], &err, 1)) {
>> +                       error("could not create reflog %s: %s", argv[i],
>> +                             err.buf);
>> +                       status = 1;
>> +                       strbuf_release(&err);
>
> This feels a bit dirty.

Hmm, I do not share that feeling.  I wouldn't be surprised if you
found a lot of existing codepaths that run _init() a strbuf once,
work on it and then _release() once a section of code is done with
it, reuse it for further (unrelated) processing, knowing that
_release() implicitly did _init() and the strbuf is ready to use
after that.  I thought that was a very well established pattern.

> While it's true that the current
> implementation of strbuf_release() re-initializes the strbuf (so
> you're not technically wrong by re-using it), that's an implementation
> detail; and indeed, the strbuf_release() documentation says:
>
>     Release a string buffer and the memory it used. You should not
>     use the string buffer after using this function, unless you
>     initialize it again.

Hmph. Perhaps the doc is wrong? ;-)

> Alternatives would be strbuf_reset() or declaring and releasing the
> strbuf within the for-loop scope.

Because _reset() just rewinds the .len pointer without deallocating,
you would need an extra _release() before it goes out of scope. If
it is expected that the strbuf will be reused for a number of times,
the length of the string each iteration uses is similar, and you
will iterate the loop many times, "_reset() each time and _release()
to clean-up" pattern would save many calls to realloc/free.
