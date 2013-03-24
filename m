From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sun, 24 Mar 2013 14:29:40 -0700
Message-ID: <CAJDDKr7Uz44TQ8y2jpjhNadWUCD5Mo=GLdaLLh99eENARQSwcw@mail.gmail.com>
References: <cover.1363980749.git.john@keeping.me.uk>
	<cover.1364045138.git.john@keeping.me.uk>
	<e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
	<7vd2up4bo7.fsf@alter.siamese.dyndns.org>
	<20130324123620.GA2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsUU-0002JI-7K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab3CXV3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:29:42 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:40630 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab3CXV3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:29:41 -0400
Received: by mail-we0-f177.google.com with SMTP id d7so4569436wer.36
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=je0YABhbqrb6X9Frs2sad7Q0jakkSeR0vQhhgLa3HEo=;
        b=wb/teLw4khqjCmupaEBNUXD7GRZtp4E1gRG6V/epVVRUxSYZxNg1XD7StbdTH7fcs0
         59djJzMkkZNOL09V/zpx0ejeymJ/2bU6hA4HzS/YnrSg+nuL/hoKd+9Zh6DLLvJ22lTn
         oVe02jwg5CUaaJpdKtPIo/2LQfPiN7o/zdfpZZl1BKOo249qJnoA88myZkReBl7nTjSm
         OjwSiohnS8ZdDlyyUE2ECOqUewJxIIrgC1XO9PjCBuJqNKeqEqu9p2ktFW8RnsyuJg7f
         IJ95HaTr6+FafJO+kbeSo1KhDy6Ek0Au6I1gm4zdP/Je1dwD0ofr9f7ZbTaXtjrQSBBs
         L3Sg==
X-Received: by 10.180.185.204 with SMTP id fe12mr13722211wic.2.1364160580471;
 Sun, 24 Mar 2013 14:29:40 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Sun, 24 Mar 2013 14:29:40 -0700 (PDT)
In-Reply-To: <20130324123620.GA2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218999>

On Sun, Mar 24, 2013 at 5:36 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sat, Mar 23, 2013 at 10:19:36PM -0700, Junio C Hamano wrote:
>> > In the longer term, difftool probably needs to learn to warn the user
>> > instead of overwrite any changes that have been made to the working tree
>> > file.
>>
>> Questionable.
>>
>> Admittedly I do not use difftool myself, and I have long assumed
>> that difftool users are using the tools to _view_ the changes, but
>> apparently some of the tools let the user muck with what is shown,
>> and also apparently people seem to like the fact that they can make
>> changes.  So I've led to believe the "update in difftool, take the
>> change back to working tree, either by making symbolic links or
>> copying them back" behaviour was a _feature_.
>
> Yes it is.  I think my explanation wasn't clear enough here.
>
> What currently happens is that after the user's tool has finished
> running the working tree file and temporary file are compared and if
> they are different then the temporary file is copied over the working
> tree file.
>
> This is good if the user has edited the temporary file, but what if they
> edit they working tree file while using the tool to examine the
> differences?  I think we need to at the very least look at the mtime of
> the files and refuse to copy over the temporary file if that of the
> working tree file is newer.
>
> Obviously none of this matters if we can use symlinks, but in the
> non-symlink case I think a user might find it surprising if the
> (unmodified) file used by their diff tool were suddenly copied over the
> working tree wiping out the changes they have just made.

Thanks, this adds a little more safety to the operation, which is good.
The downside is that it's a performance hit since we end up running
an additional hash-object on every worktree file.
I would definitely choose safety/correctness in this situation.

This makes me wonder whether the modifiable mode should be made
more explicit, either in the documentation or via a flag.

Imagine if --dir-diff also honored --edit and --no-edit flags.

Right now --edit is the default.  If we had foreseen these various
edge cases and unintended copy-backs then we may have initially
chosen --no-edit as the default, but that's not really my point.

What I'm thinking is that it might be good for the tool to
learn --edit/--no-edit so that the symlink/copy-back heuristic
can be documented alongside that option.  Users can then know
what to expect when using this mode.  --no-edit would also be
faster since it can avoid all these extra steps.

It could also learn "difftool.dirDiffEditable" to control the
default, which would eliminate the pain in needing to supply
the flag on every invocation.

What do you think about officially supporting a read-only mode?
-- 
David
