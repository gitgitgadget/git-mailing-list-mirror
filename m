From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] diff-highlight: exit when a pipe is broken
Date: Tue, 4 Nov 2014 14:43:56 -0500
Message-ID: <CAEBDL5XUhEgbrGZHqrVu3d8QuhX_B9KT_h8pUW4LK_MWr-7KUQ@mail.gmail.com>
References: <1414753444-68653-1-git-send-email-john@szakmeister.net>
	<20141101040443.GB8307@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlk1L-0007Hi-6L
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 20:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbaKDTn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 14:43:59 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50966 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbaKDTn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 14:43:57 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so1578648lbg.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 11:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VkKlyJQzGyJNdLYdD5c0pwWwcSNlXxisiW7DPxk2cHM=;
        b=GDavK0dBZvHFiBW8Xm5urWj02gOSHx5DC0sITPNqUryqbAka9MQXHGNEq9T5TQE0PU
         CjV1M+1T/GAuXY67hHjIUTkZWMDEGKSThLfd24DoOf/e6hZAefcAoQtUsGJuEMkzug+q
         Qiy0Do15I/OkdzLrwth8PaajmVFraqf7O3o9f1XUVTqbhkvJlgcKmlCpTWbNMbMKUDvA
         6i9tJXOgDS6KykoK1eVUn5/iwAwphh5WDBiyQjPmY7K3wfaIpNvQMkcrCJpmmMAnGdrm
         75QKrRdUGrATQD73VVS6VfGDdHunDT0PRoSh7+cLQzubHzfpzSLRNPYB7otN2NJZWGGf
         OgRg==
X-Received: by 10.112.137.234 with SMTP id ql10mr24002705lbb.91.1415130236250;
 Tue, 04 Nov 2014 11:43:56 -0800 (PST)
Received: by 10.25.166.20 with HTTP; Tue, 4 Nov 2014 11:43:56 -0800 (PST)
In-Reply-To: <20141101040443.GB8307@peff.net>
X-Google-Sender-Auth: PEV5KouuqW4QUAilXT32b3VgJik
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 1, 2014 at 12:04 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 31, 2014 at 07:04:04AM -0400, John Szakmeister wrote:
>
>> While using diff-highlight with other tools, I have discovered that Python
>> ignores SIGPIPE by default.  Unfortunately, this also means that tools
>> attempting to launch a pager under Python--and don't realize this is
>> happening--means that the subprocess inherits this setting.  In this case, it
>> means diff-highlight will be launched with SIGPIPE being ignored.  Let's work
>> with those broken scripts by explicitly setting up a SIGPIPE handler and exiting
>> the process.
>
> My first thought was that this should be handled already by 7559a1b
> (unblock and unignore SIGPIPE, 2014-09-18), but after re-reading your
> message, it sounds like you are using diff-highlight with non-git
> programs?

Yes, that's correct.  It's useful, so with a few tools that use diffs,
I like to run the output through diff-highlight.

>> +# Some scripts may not realize that SIGPIPE is being ignored when launching the
>> +# pager--for instance scripts written in Python.  Setting $SIG{PIPE} = 'DEFAULT'
>> +# doesn't work in these instances, so we install our own signal handler instead.
>
> Why doesn't $SIG{PIPE} = 'DEFAULT' work? I did some limited testing and
> it seemed to work fine for me. Though I simulated the condition with:
>
>   (
>     trap '' PIPE
>     perl -e '$|=1; print "foo\n"; print STDERR "bar\n"'
>   ) | true
>
> which should not ever print "bar".

Hehe, now that I see you right it out, I realize my mistake: I didn't
capitalize 'default'.  Trying it out again, it does appear that does
the trick.

[snip]
> Can we exit 141 here? If we are part of a pipeline to a pager, it should
> not matter either way, but I'd rather not lose the exit code if we can
> avoid it (in case of running the script standalone).
>
>> +$SIG{PIPE} = \&pipe_handler;
>
> A minor nit, but would:
>
>   $SIG{PIPE} = sub { ... };
>
> be nicer to avoid polluting the function namespace?

Sorry, my Perl-fu is kind of low these days.  I used to use it all the
time but switched away from it quite a while ago.  Given that
'DEFAULT' does the trick, I'll just re-roll my patch to use that.
Does that sound fair?

-John

PS  Sorry for the late response, I've been traveling.
