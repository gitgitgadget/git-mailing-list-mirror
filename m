From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 23:20:07 -0700
Message-ID: <xmqq4mkawbc8.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqqpp2ywwj1.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaGe59=z4Eeuno8DRuWWRD12OyLETi7NA+utfoLsJ4+=A@mail.gmail.com>
	<xmqqlhdmwrxx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 08:20:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNxUl-0004Ha-An
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 08:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbbHHGUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 02:20:12 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36560 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbbHHGUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 02:20:11 -0400
Received: by pdco4 with SMTP id o4so52604817pdc.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dtrapFfLVub7hjDpsfNvwL9LDDZv/Igl0vG5NtHtiQs=;
        b=a+sXWMDHnUuRFK1bBVcf4tR8pBAmmImBuuThQfTR9EXgDfSQ7KCgKvYA7qvAdmIvkO
         RXRaUCgYP2JVntLcQctxvY4eVBB+xLob+v3JFVfGDytN15oofk5/YieJcWJ0H5pqt02g
         DsZSM2gYPCU9ZzYG0GfFYVh1xT+cH4Bzneae4zAqbKjOGe5KNdr91WriloLuax9gzPUB
         PNu4yPYkEgkUbtoZjHwhsuhMV8OZFbmBWw2DVT0jS66VBBl5sioAZW3d0sDP+kU4rxI8
         lJTZgB52KVBHHmyHfeytfRKPVdWfInZ0YiE4l4fg4f7Kl/MT0kkfNXIVvknvAfoKzqBg
         eC5g==
X-Received: by 10.70.130.34 with SMTP id ob2mr22803765pdb.15.1439014810298;
        Fri, 07 Aug 2015 23:20:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id x12sm12188269pbt.56.2015.08.07.23.20.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 23:20:08 -0700 (PDT)
In-Reply-To: <xmqqlhdmwrxx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 07 Aug 2015 17:21:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275506>

Junio C Hamano <gitster@pobox.com> writes:

>>> ... if
>>> you really want to go the "thread" route, the first thing to try
>>> would be to see if a few places we already use threads for
>>> parallelism (namely, "grep", "pack-objects", "preload-index" and
>>> "index-pack") can be factored out and model your new API around the
>>> commonality among them.
>
> And obviously, doing your pool API around threads will allow you to
> throw future per-thread function that do not involve run_command()
> at all at your API, and it will make it easy to adapt the current
> threaded parts of the system to the API.

Just a few random thoughts before going to bed and going offline for
the weekend...

Eventually, we would want to do "submodule update" of a top-level
project that has 500 submodules underneath, but obviously we would
not want to blindly spawn 500 threads, each of which runs "fetch",
all at the same time.  We'd want to limit the parallelism to a sane
limit (say, 16 or 32), stuff 500 work units to a queue, from which
that many number of worker bees grab work unit one by one to process
and then come back to ask for more work.

And we would eventually want to be able to do this even when these
500 submodules are spread across multiple levels of nested
submodules (e.g. top-level may have 8 submodules, and they have 16
nested subsubmodules each on average, each of which may have 4
nested subsubsubmodules on average).  Specifying -j16 at the top
level and apportioning the parallelism to recursive invoation of
"submodule update" in such a way that the overall process is
efficient and without waste would be a bit tricky.

In such a nested submodule case, we may want to instead try to
enumerate these 500 submodules upfront with unbounded parallelism
(e.g. the top-level will ask 4 worker bees to process immediate 8
submodules, and they each spawn 4 worker bees to process their
immediate 16 submodules, and so on---it is unbounded because we do
not know upfront how deep the nesting is).

Let's call that a recursive module_list.  You would want out of a
recursive module_list:

 - the path to the submodule (or "." for the top-level) to indicate
   where in the nested hierarchy the information came from;

 - the information the flat module_list gives for that location.

Since you already have module_list() function natively callable from
C and also it is available via "git submodule--helper module_list",
implementing a recursive module_list would be a good first proof of
concept exercise for your "thread pool" engine.  You can employ the
"dual implementation" trick to call

 - a version that tells the thread to run the native C version of
   module_list(),

 - another version that tells the thread to run_command()
   "submodule--helper module_list" in the top-level and nested
   submodules.

and collect and compare their results and performance.

That will not just be a good proof of concept for the pool
implementation.

Once you have such a recursive module_list, you can use it as a way
to easily obtain such a "unified view" list of all submodules.  That
can be used to stuff a flat work unit queue to implement reasonably
bounded parallelism.

Your recursive "submoule update" implementation could be

 - Run recursive module_list to stuff the work queue with these 500
   submodules (possibly spread across in top-level and in nested
   submodules, or all 500 in the flat top-level);

 - Start N worker bees, and tell them to pick from that work queue,
   each element of which tells them to process which submodule that
   resides in where (either in the top-level project or in a
   submodule).

And each work element would essentially be to run "git fetch" in
that submodule directory.

Hmm...
