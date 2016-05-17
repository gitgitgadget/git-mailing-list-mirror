From: Eric Wong <e@80x24.org>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Tue, 17 May 2016 12:08:15 +0000
Message-ID: <20160517120815.GA15546@dcvr.yhbt.net>
References: <20160517032247.25092-1-sbeller@google.com>
 <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 17 14:08:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2dnW-0002zZ-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 14:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbcEQMIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 08:08:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55364 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754897AbcEQMIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 08:08:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197E01FCB0;
	Tue, 17 May 2016 12:08:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294864>

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 16, 2016 at 11:22 PM, Stefan Beller <sbeller@google.com> wrote:
> > When using automated tools to find memory leaks, it is hard to distinguish
> > between actual leaks and intentional non-cleanups at the end of the program,
> > such that the actual leaks hide in the noise.
> 
> Considering the signal-to-noise ratio mentioned above, the goal seems
> reasonable, but why pollute the code with #ifdef's all over the place
> by making the cleanup conditional? If you're going though the effort
> of plugging all these leaks, it probably makes sense to do them
> unconditionally.

I haven't checked for git, but I suspect we get speedups by not
calling free().  I've never needed to profile git, but free() at
exit has been a measurable bottleneck in other projects I've
worked on.  Often, free() was more expensive than *alloc().

In any case, I like constant conditionals in C or inline wrappers
macros over CPP #ifdefs littered inside functions:

/* in git-compat-util.h */
#ifdef FREE_ALL_MEMORY
static inline void optional_free(void *ptr) {}
#else
#  define FREE_ALL_MEMORY (0)
#  define optional_free(ptr) free(ptr)
#endif

/* inside any function: */
	if (FREE_ALL_MEMORY)
		big_function_which_calls_multiple_frees();


Also Valgrind has suppression files, so code modifications may
not be necessary at all.
